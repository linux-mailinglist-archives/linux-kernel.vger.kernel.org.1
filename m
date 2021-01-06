Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C352EC400
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 20:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbhAFTfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 14:35:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726703AbhAFTft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 14:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609961663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Of+syXHD3qkkkFpUiohxwPsHN2cOLpKYdOBIorA+8sU=;
        b=S4P9ZuGqjs2+QivHOrhE9a81LEhx2WBlBzvGrqzZZZ7CNLrBcQ66dpD9oRp1wvGScjiG6P
        /hn4dWpL7vAuHaDylFd8sPnNujuCK0g9Z0uFSMgaKlw5EaeV2bTer5ffEku4M+Rptn5RDF
        sYMpAeWCO7iVtwWt5HnCsaOK0Y5PdsE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-8QGkQ4ljOLel1BaG_smQLg-1; Wed, 06 Jan 2021 14:34:21 -0500
X-MC-Unique: 8QGkQ4ljOLel1BaG_smQLg-1
Received: by mail-pf1-f198.google.com with SMTP id 15so2316379pfu.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 11:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Of+syXHD3qkkkFpUiohxwPsHN2cOLpKYdOBIorA+8sU=;
        b=JIkslL2QJS42UQSupKCUX3BFPUCFlkiEGBp5tS1fW5yCH2Gviz44MHGCsLPZ7xdorx
         I9TKJyeL/Bt0wu4il5M68qPGmwmGxioBaWJPehl/vRwmmgyLQ5YaFItp2p/TctagKvqG
         hhPnHPj8htpEf7t5C6BnD/pagPEf5zRwFZNSBDJmiRE2p4/bjYzNvSFTzGeSF3TTkp3t
         /DnNeHQ6zrlHXbNtxKeK9fWyvbbsL6OLsBlvNXYeb0kjnK3wGdKGhieGO54RmMiZ8T4k
         BQ6GqOomenD4UZ3OhsuKQZhd2nPtYCF/SEeQU/VvbrK7DmN39NKmdHgXZuThJL3hLy8+
         0LfA==
X-Gm-Message-State: AOAM530x+/BP+uTibNehcvfyTgcBFAY77of2Pe5R9z7xveG81rLuAnPd
        xi234hgUblbdlPFyCdXGwk45YXp7CqgKhtJdAcX3dz7YtL56GbIOITFiMqwXXwkPmuyHfYoKh/n
        JY4VeWunI6TsHQqSsrsAHNuDW
X-Received: by 2002:a63:cc05:: with SMTP id x5mr6086075pgf.254.1609961660348;
        Wed, 06 Jan 2021 11:34:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiWChMXqMyXSYSOzNqmwVrTxQW2CYsxpolR5McobjhIzVaIHQEPKhQ/mVUU9ebadAYqzEQpg==
X-Received: by 2002:a63:cc05:: with SMTP id x5mr6086058pgf.254.1609961660080;
        Wed, 06 Jan 2021 11:34:20 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y16sm3422874pfb.83.2021.01.06.11.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 11:34:19 -0800 (PST)
Subject: Re: [PATCH] rxrpc: fix handling of an unsupported token type in
 rxrpc_read()
To:     David Howells <dhowells@redhat.com>
Cc:     davem@davemloft.net, kuba@kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <548097.1609952225@warthog.procyon.org.uk>
 <c2cc898d-171a-25da-c565-48f57d407777@redhat.com>
 <20201229173916.1459499-1-trix@redhat.com>
 <259549.1609764646@warthog.procyon.org.uk>
 <675150.1609954812@warthog.procyon.org.uk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f02bdada-355c-97cd-bc32-f84516ddd93f@redhat.com>
Date:   Wed, 6 Jan 2021 11:34:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <675150.1609954812@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/21 9:40 AM, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
>
>> How about this?
>> ...
>>     Fix the second loop so that it doesn't encode the size and type of an
>>     unsupported token, but rather just ignore it as does the first loop.
> Actually, a better way is probably just to error out in this case.  This
> should only happen if a new token type is incompletely implemented.
>
> David
> ---
> commit e68ef16f59aa57564761b21e5ecb2ebbd72d1c57
> Author: David Howells <dhowells@redhat.com>
> Date:   Wed Jan 6 16:21:40 2021 +0000
>
>     rxrpc: Fix handling of an unsupported token type in rxrpc_read()
>     
>     Clang static analysis reports the following:
>     
>     net/rxrpc/key.c:657:11: warning: Assigned value is garbage or undefined
>                     toksize = toksizes[tok++];
>                             ^ ~~~~~~~~~~~~~~~
>     
>     rxrpc_read() contains two consecutive loops.  The first loop calculates the
>     token sizes and stores the results in toksizes[] and the second one uses
>     the array.  When there is an error in identifying the token in the first
>     loop, the token is skipped, no change is made to the toksizes[] array.
>     When the same error happens in the second loop, the token is not skipped.
>     This will cause the toksizes[] array to be out of step and will overrun
>     past the calculated sizes.
>     
>     Fix this by making both loops log a message and return an error in this
>     case.  This should only happen if a new token type is incompletely
>     implemented, so it should normally be impossible to trigger this.
>     
>     Fixes: 9a059cd5ca7d ("rxrpc: Downgrade the BUG() for unsupported token type in rxrpc_read()")
>     Reported-by: Tom Rix <trix@redhat.com>
>     Signed-off-by: David Howells <dhowells@redhat.com>
>
> diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
> index 9631aa8543b5..8d2073e0e3da 100644
> --- a/net/rxrpc/key.c
> +++ b/net/rxrpc/key.c
> @@ -598,7 +598,7 @@ static long rxrpc_read(const struct key *key,
>  		default: /* we have a ticket we can't encode */
>  			pr_err("Unsupported key token type (%u)\n",
>  			       token->security_index);
> -			continue;
> +			return -ENOPKG;
>  		}

These two loops iterate over the same data, i believe returning here is all that is needed.

Tom

>  
>  		_debug("token[%u]: toksize=%u", ntoks, toksize);
> @@ -674,7 +674,9 @@ static long rxrpc_read(const struct key *key,
>  			break;
>  
>  		default:
> -			break;
> +			pr_err("Unsupported key token type (%u)\n",
> +			       token->security_index);
> +			return -ENOPKG;
>  		}
>  
>  		ASSERTCMP((unsigned long)xdr - (unsigned long)oldxdr, ==,
>

