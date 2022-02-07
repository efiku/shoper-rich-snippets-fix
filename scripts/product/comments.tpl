{if false != $product_comments && 1 == $skin_settings->productdetails->comments}
<div class="box row tab" id="box_productcomments">
    <div class="boxhead tab-head">
        <h3>
            <img src="{baseDir}/libraries/images/1px.gif" alt="" class="px1">
            {translate key="Product reviews"} ({$product_comments|count})
        </h3>
    </div>

    <div class="innerbox tab-content tab-comments">
        <div itemprop="aggregateRating" itemscope itemtype="https://schema.org/AggregateRating">
            <meta itemprop="worstRating" content="0">
            <meta itemprop="bestRating"  content="5">
            <meta itemprop="ratingValue" content="{$product->vote->rate|escape}">
            <meta itemprop="reviewCount" content="{$product_comments|count}">
        </div>
        {foreach from=$product_comments item=comment name=list}
        <div class="productcomment" itemscope itemprop="review" itemtype="https://schema.org/Review" id="comment-{$comment->getIdentifier()}">
            <div class="floatfix row">
                <h5 class="reviewer" itemprop="author" itemtype="https://schema.org/Person" itemscope>
                    <meta itemprop="name" content="{$comment->comment->user_name|escape}">
                    {$comment->comment->user_name|escape}</h5>
                <div class="date">
                    {date value=$comment->comment->date}
                </div>
            </div>
            <div itemprop="reviewRating" itemscope itemtype="https://schema.org/Rating">
                <meta itemprop="worstRating" content="0">
                <meta itemprop="bestRating" content="5">
                <meta itemprop="ratingValue" content="{$product->vote->rate|escape}">
            </div>
            <p class="description row" itemprop="description">{$comment->comment->content|escape}</p>
        </div>
        {/foreach}

        {if $can_comment}
        {if $data_error.user}
        <div>
            <div class="alert-error alert">
                <button type="button" class="close icon-remove">
                    <span>{translate key="close"}</span>
                    <img src="/libraries/images/1px.gif" alt class="px1">
                </button>
                <div class="row">
                    <p>{translate key="You have to fill name or nick field."}</p>
                </div>
            </div>
        </div>
        {/if}
        {if $data_error.comment}
        <div>
            <div class="alert-error alert">
                <button type="button" class="close icon-remove">
                    <span>{translate key="close"}</span>
                    <img src="/libraries/images/1px.gif" alt class="px1">
                </button>
                <div class="row">
                    <p>{translate key="You have to fill comment field."}</p>
                </div>
            </div>
        </div>
        {/if}
        <form action="{route key='productComment' productId=$product->getIdentifier()}" method="post" class="comment multirow" id="commentform">
            <fieldset>
                {include file='formantispam.tpl'}

                <label for="commentuser">{translate key="Name or nick"}:</label>
                <div class="f-row">
                    <input name="user" type="text" id="commentuser" value="{if $user_logged}{$user->user->getName()|escape}{else}{$data.user|escape}{/if}" size="30"  class="f-grid-12" >
                </div>
                {if $data_error.user}
                <ul class="input_error">
                    {foreach from=$data_error.user item=err_text}
                    <li>{$err_text|escape}</li>
                    {/foreach}
                </ul>
                {/if}

                <label for="comment">{translate key="Your review"}:</label>
                <div class="f-row">
                    <textarea name="comment" id="comment" rows="5" cols="30" class="f-grid-12">{$data.comment|escape}</textarea>
                </div>
                {if $data_error.comment}
                <ul class="input_error">
                    {foreach from=$data_error.comment item=err_text}
                    <li>{$err_text|escape}</li>
                    {/foreach}
                </ul>
                {/if}

                {$recaptcha}

                <button type="submit" class="btn">
                    <img src="{baseDir}/libraries/images/1px.gif" alt="" class="px1">
                    <span>{translate key="Send"}</span>
                </button>
            </fieldset>
        </form>
        {/if}
    </div>
</div>
{/if}