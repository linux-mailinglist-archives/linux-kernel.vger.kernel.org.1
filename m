Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D6927FE28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 13:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgJALMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 07:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731134AbgJALMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:12:35 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3FCC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 04:12:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p15so7417533ejm.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 04:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4t04I8s6sB1Yrmu3g5e0Wt6p/EcT6Np/z3tPoVxvegA=;
        b=lMS+gLJRFrpu0uymz/ALbIgsRWpc042XICYRF3F9JpH/cZsJNlna7mLiV8jCBzIwzu
         YnccZoL1L1pLCNq9fER5P4M81OOiHze69+37oTRgVZAzqmZtz1Mlp3vAlC94tTTEN9mC
         TlHROUslwqYp1R36JpW7DIxwa7zAZuo6C90pKRSeFT3PC1CkHpY3/NfYKtCGGt7PDyq2
         KWN40PKadNPJu/LaDQKfz8lCrGgwng7ljlAHS9j7UQIgq6D/YjwhfD+UgRbpqKp2JTBa
         UU0dS5aXhkm8+xoDsvJdTgUxgmIvXqy+fJhCx9Q2Am/cecfxJEDkdW1oykMbklvCv2Ci
         0fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4t04I8s6sB1Yrmu3g5e0Wt6p/EcT6Np/z3tPoVxvegA=;
        b=TbXE+Ogm4DZYykHAfBdV3GzMrRZzs+ldEBMepkWkAWCIbpNlLIj/LscsYu6JmePglR
         DBSGuoPmuWMO0FVj8cWpCyDwtZ5oi1rpKZEngY86gPNv33iFk8tPHilbfaJARz44cBwr
         PQh542oA4EBMJSuetLqhIwKiCxpWZUr5btlSToZpiAo1pZnqQSvw6cixphVpdUuwML/0
         P+XnIxVISBPV//k5+IGdcRui8ON6UPpoyrUsofktXOleL9U4+ulVcQz+e79O8xHQBIUP
         llKNxusgXkg7Kz7Btbz3nvJBLOSMxlzWHyj9/xD1IqgLAU0ZU4d2ce6S75/pGwYBPVY/
         QkwA==
X-Gm-Message-State: AOAM532qAyV2g3iXwA5aYu+rzAJaFJ48I+sWH+zH/VJl3m2NgV6bpDio
        kfbxk8+FXDljYuMNPvdlnSsfqKmA3aEJdZ9i
X-Google-Smtp-Source: ABdhPJwEzMnLajQjNK3iwkOQZhRiKx70lQQ0BSGy5SL+0BDManYw0CQU0M+mHVVdx347zWIcwQ7p6Q==
X-Received: by 2002:a17:906:e24d:: with SMTP id gq13mr7263019ejb.152.1601550754102;
        Thu, 01 Oct 2020 04:12:34 -0700 (PDT)
Received: from felia ([2001:16b8:2d4d:ba00:2c39:a8cb:1b2a:4845])
        by smtp.gmail.com with ESMTPSA id bk9sm3890193ejb.122.2020.10.01.04.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 04:12:33 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Thu, 1 Oct 2020 13:12:32 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com
Subject: Re: [PATCH RFC] checkpatch: fix multi-statement macro checks
In-Reply-To: <20201001103314.136645-1-dwaipayanray1@gmail.com>
Message-ID: <alpine.DEB.2.21.2010011309220.24571@felia>
References: <20201001103314.136645-1-dwaipayanray1@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Oct 2020, Dwaipayan Ray wrote:

> Checkpatch.pl doesn't have a check for excluding while (...) {...}
> blocks from MULTISTATEMENT_MACRO_USE_DO_WHILE error.
> 
> For example, running checkpatch.pl on the file mm/access.c in the
> kernel generates the following error:
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> +#define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
> +	while (len >= sizeof(type)) {					\
> +		__get_kernel_nofault(dst, src, type, err_label);	\
> +		dst += sizeof(type);					\
> +		src += sizeof(type);					\
> +		len -= sizeof(type);					\
> +	}
> 
> The error is misleading for this case. Enclosing it in parantheses

s/parantheses/parentheses/

In my previous review, I already pointed that spelling mistake; was there 
a mess-up with sending out the new patch?

I will start running a quick evaluation...

> doesn't make any sense.
> 
> Checkpatch already has an exception list for such common macro types.
> Added a new exception for while (...) {...} style blocks to the same.
> This effectively fixed the wrong error message.
> 
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 72c4072307ea..c2c211374662 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5342,6 +5342,7 @@ sub process {
>  			    $dstat !~ /^\.$Ident\s*=/ &&				# .foo =
>  			    $dstat !~ /^(?:\#\s*$Ident|\#\s*$Constant)\s*$/ &&		# stringification #foo
>  			    $dstat !~ /^do\s*$Constant\s*while\s*$Constant;?$/ &&	# do {...} while (...); // do {...} while (...)
> +			    $dstat !~ /^while\s*$Constant\s*$Constant\s*$/ &&		# while (...) {...}
>  			    $dstat !~ /^for\s*$Constant$/ &&				# for (...)
>  			    $dstat !~ /^for\s*$Constant\s+(?:$Ident|-?$Constant)$/ &&	# for (...) bar()
>  			    $dstat !~ /^do\s*{/ &&					# do {...
> -- 
> 2.27.0
> 
> 
