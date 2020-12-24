Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2686A2E27E8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 16:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgLXPUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 10:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgLXPUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 10:20:42 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B54C061573
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 07:20:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y8so1407923plp.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 07:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ca4T5x2YBVwc3xGoJaMp1mpR1SgmL54F1JA2Sm/PSms=;
        b=UleZZf0Op+eYF5TErvSm7TLIikCFSdd1U+0OKwqHFteUOaOWRrU8KFt/A/5I+LCXex
         W32a3S96Zjt3NgC+f+7PhkdnaLGira988oA7Tybb7km20bd3qtFKGyb5Jdb73/Togh/F
         uInXoXfB7B5IfzairuKFTW3xhuZCz2BOvlI5tgcRBrfTcDiQBTHeyIzTAkXHSyD69uWL
         IK7q86HlpazS/qjfWbxcUnK3wzpRsOAFc/xAsOQgyWXUzfoq+gY0Dn8JOgKzwyZ40Qsd
         iPZ8+Y+1h+6AyzmjiWZlN57+GpAndcSpvw/OM/D4cUbIruMgrGwVFJLwUJSrNQtuZbJj
         vWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ca4T5x2YBVwc3xGoJaMp1mpR1SgmL54F1JA2Sm/PSms=;
        b=Byi6dsraOVZEg8hGMUsIwBS0olVnOasMf4rO34x9ywEF4mRcMOwhLwhJmgRW+7/kc5
         ZaB2usqg4s82aOi8EfidaQ7+zDjEHNkmLwe0t78w1T3edpX0XbJm3h09mqRuV0RxBb2H
         ArXLXwGce5f+Sk1qodRJd+AgkQ4VLntYXiiJYNhoeYqbsLBODuBLJB7Lp1koffqvb3rm
         airBmU7AKMl+gaYBIFHgJ6d7FkoP2F9J2kwx+9dsT54eI+1c0mweHgZyIFI/WkkDgLkO
         5ajwd7Hz79i2fpz8SFD+xBWyff+p5C/Oi68DaIy3HZ7meQ+x+t2BLsfWESnKKVjEq0wL
         YbOQ==
X-Gm-Message-State: AOAM533XMXboMeZGqywjlEEDs9Zd6NEQlErC/PhrSh8SJicr1wdFgaG2
        W3Ip+YLBDw54coG2iZF/SV9mrXHl6C1UTg==
X-Google-Smtp-Source: ABdhPJzYus71jdfVs9Y87XtUOcQyYwfKsxleTZcccosnwQi+iCxJFWbHQ/6pnAJarom+3UlSBGsGig==
X-Received: by 2002:a17:90a:708b:: with SMTP id g11mr4715049pjk.23.1608823201803;
        Thu, 24 Dec 2020 07:20:01 -0800 (PST)
Received: from ?IPv6:2402:3a80:40d:9f6c:f9de:b7a7:21af:4983? ([2402:3a80:40d:9f6c:f9de:b7a7:21af:4983])
        by smtp.gmail.com with ESMTPSA id q15sm15448974pgk.11.2020.12.24.07.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Dec 2020 07:20:01 -0800 (PST)
Subject: Re: [PATCH v2] checkpatch: fix false positive for
 COMMIT_LOG_LONG_LINE with URLs
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <1ce4502a-d75a-7e27-5844-f195607c4c99@gmail.com>
 <20201218121133.18614-1-yashsri421@gmail.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <84492ae9-7452-d296-49ab-4d37eed3b968@gmail.com>
Date:   Thu, 24 Dec 2020 20:49:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218121133.18614-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/20 5:41 pm, Aditya Srivastava wrote:
> Currently checkpatch warns for long line in commit messages even for
> URL lines.
> 
> An evaluation over v4.13..v5.8 showed that out of 11729 warnings for
> this class, around 299 are due to line starting with URL.
> 
> E.g., running checkpatch on commit 3cde818cd02b ("ASoC: topology:
> Consolidate how dtexts and dvalues are freed") reports this warning:
> 
> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html
> 
> Avoid giving users warning for character limit for such cases, instead
> suggest them to prefix the URLs with "Link:"
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> changes in v2:
> - Fix coding style ('} else {')
> - Make the URL check follow RFC 3986 style
> - Give warning only if the URL is first non-whitespace of the line
> - Set $commit_log_long_line only for else case
> - Fix the warning count with exact figures and according to first non-space char as URL
> 
>  scripts/checkpatch.pl | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index abd5a3d2e913..bf77bd0b22cf 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3032,9 +3032,14 @@ sub process {
>  		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
>  					# A Fixes: or Link: line or signature tag line
>  		      $commit_log_possible_stack_dump)) {
> -			WARN("COMMIT_LOG_LONG_LINE",
> -			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
> -			$commit_log_long_line = 1;
> +			if ($line =~ /^\s*\b[a-z][\w\.\+\-]*:\/\/\S+/i) {
> +				WARN("COMMIT_LOG_LONG_LINE",
> +				     "Consider prefixing the URL with 'Link:'\n" . $herecurr);
> +			} else {
> +				WARN("COMMIT_LOG_LONG_LINE",
> +				     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
> +				$commit_log_long_line = 1;
> +			}
>  		}
>  
>  # Reset possible stack dump if a blank line is found
> 

Hi Joe
You probably missed this patch. Please review :)

Thanks
Aditya
