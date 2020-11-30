Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2006C2C8155
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgK3Jp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgK3Jp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:45:58 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC5FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:45:12 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b6so10045821pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4hXlOHiUGB8Erw3bFDxPZbhc0EiZXLXRk8mF5Y0gpNA=;
        b=QU6dr425vlwunMB8BIlO60w5RYCztvwPEnzfkfKRb4fq9p31d40c7XEdiHzwvSzGJH
         60chsTKcneLwgWwyiwQeZB/rZFofU4uWAhZnCYha46V82trRG1czhPMJxuge1OBOjMF6
         bIpZAuoVefwGAiDUk+UB1vn+GljCAF9fdb46IH6yx6opNLfw1hbdPQapMbEBjlWob1tn
         maMxg8NjZfEuIfHZkPldyWK8OVbAkfbFP1lJ9kdmCgqo9OSLMqluM8Vk4rgzCIVlVVO5
         D4IJf3XkUi8s9SK20PP2orApXhk5nPGHMZM+BTGdDI+d4faePVc+9yDkrH6n+Hv/eLye
         Ethw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4hXlOHiUGB8Erw3bFDxPZbhc0EiZXLXRk8mF5Y0gpNA=;
        b=ndLLCWm76sPnL+umdPc+9u79yYl8M0j+5JNdxsm1N/edUeaO31EOQYyikdEYv36Bjg
         AhVsm27QNPHXqi1IVgRE4dMIRpD8+40dlzoAqAx7sr8eQR+yDnu+I8LMYsXdBrzTTFaa
         qMNu7E1kc3DdID6PQOvm9C8QrImTQfXEbNLo7+QHxqb4KHJrbzlMKT37dmgeLBpwfC6/
         r8rfkijbnp/a3v+6aBNDXVxD/L1wbLdnJvtNNiPOlbGCdn2JXWqPwX64b1+XuC7hq9Ba
         7iNAFL7ksRVyBb+iYhHltTZWwbSrIkqifzuLbde1SZQrbA0xSQI444vggXrIFRv9JEoe
         juwA==
X-Gm-Message-State: AOAM532zxcxGLAv5X2E8oU8XkNfUcbVM8Rk1jKwMApxIeiyyGISrHxuj
        tvrtNEF3FCIpRIyAvka6hgI=
X-Google-Smtp-Source: ABdhPJyDQ+p9uM1TEV1XzEeDGROVjTuDPYfnfvQucucH3IGDXy+u7pEd4aZ/3B527aKUns7PpuQYbg==
X-Received: by 2002:aa7:9087:0:b029:197:daff:a9a8 with SMTP id i7-20020aa790870000b0290197daffa9a8mr17827668pfa.26.1606729511997;
        Mon, 30 Nov 2020 01:45:11 -0800 (PST)
Received: from ?IPv6:2402:3a80:419:6b90:c59c:7043:caf9:832d? ([2402:3a80:419:6b90:c59c:7043:caf9:832d])
        by smtp.gmail.com with ESMTPSA id t36sm14871328pfg.55.2020.11.30.01.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 01:45:11 -0800 (PST)
Subject: Re: [PATCH v3] checkpatch: add fix option for MISSING_SIGN_OFF
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20201130091042.14987-1-yashsri421@gmail.com>
 <20201130091545.15585-1-yashsri421@gmail.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <e049e52a-4b33-ac23-bf33-241f5cc5ea12@gmail.com>
Date:   Mon, 30 Nov 2020 15:15:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201130091545.15585-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/20 2:45 pm, Aditya Srivastava wrote:
> Currently checkpatch warns us if there is no 'Signed-off-by' line for
> the patch.
> 
> E.g., running checkpatch on commit 9ac060a708e0 ("leaking_addresses:
> Completely remove --version flag") reports this error:
> 
> ERROR: Missing Signed-off-by: line(s)
> 
> Provide a fix by adding a Signed-off-by line corresponding to the author
> of the patch before the patch separator line.
> 
> Also, avoid this fix with the Non-standard signature warning, as the
> missing sign off is most likely because of typo.
> 
> E.g. for commit 8cde5d5f7361 ("bus: ti-sysc: Detect omap4 type timers
> for quirk") we get missing sign off as well as bad sign off warnings for:
> 
> Siganed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Here it is probably best to fix the typo with BAD_SIGN_OFF warning and
> avoid adding an additional signoff.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> applies over next-20201120 and my last changes at:https://lore.kernel.org/linux-kernel-mentees/db1195235752685fc85fb52ecb1b1af3f35b5394.camel@perches.com/T/#u
> 
> Changes in v2:
>   Add space after 'if'
>   Add check for $patch_separator_linenr to be greater than 0
> 
> Changes in v3:
>   Give MISSING_SIGN_OFF warning irrespective of the value of $non_standard_signature, add check with fix option instead
>   Modify commit message accordingly
> 
>  scripts/checkpatch.pl | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4a026926139f..3abf34bb9b00 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2462,6 +2462,8 @@ sub process {
>  
>  	my $last_blank_line = 0;
>  	my $last_coalesced_string_linenr = -1;
> +	my $patch_separator_linenr = 0;
> +	my $non_standard_signature = 0;
>  
>  	our @report = ();
>  	our $cnt_lines = 0;
> @@ -2813,6 +2815,10 @@ sub process {
>  		if ($line =~ /^---$/) {
>  			$has_patch_separator = 1;
>  			$in_commit_log = 0;
> +			# to add missing signed-off-by line before diff(s)
> +			if ($patch_separator_linenr == 0) {
> +				$patch_separator_linenr = $linenr;
> +			}
>  		}
>  
>  # Check if MAINTAINERS is being updated.  If so, there's probably no need to
> @@ -2842,6 +2848,7 @@ sub process {
>  						$fixed[$fixlinenr] =~ s/$sign_off/$suggested_signature/;
>  					}
>  				}
> +				$non_standard_signature = 1;
>  			}
>  			if (defined $space_before && $space_before ne "") {
>  				if (WARN("BAD_SIGN_OFF",
> @@ -7188,8 +7195,11 @@ sub process {
>  	}
>  	if ($is_patch && $has_commit_log && $chk_signoff) {
>  		if ($signoff == 0) {
> -			ERROR("MISSING_SIGN_OFF",
> -			      "Missing Signed-off-by: line(s)\n");
> +			if (ERROR("MISSING_SIGN_OFF",
> +				  "Missing Signed-off-by: line(s)\n") &&
> +			    $fix && !$non_standard_signature && $patch_separator_linenr > 0) {
> +				fix_insert_line($patch_separator_linenr - 1, "Signed-off-by: $author");
> +			}
>  		} elsif ($authorsignoff != 1) {
>  			# authorsignoff values:
>  			# 0 -> missing sign off
> 

In reply to:
https://lore.kernel.org/linux-kernel-mentees/f21acc492ab37acc42390abffb61aed370a22118.camel@perches.com/

Thanks
Aditya
