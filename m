Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C472715A2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 18:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgITQQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgITQQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 12:16:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125DBC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 09:16:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id t138so12495517qka.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/C96D/c4iIB14ZPmIUheFcFLIlUZ3nkmg1zOuVbd2fU=;
        b=aFe2XdukaO4XWLAejv3n6+ezsPMXuImrKobbyJW+px09EQOmZv0Hqm436nDsdiSVFV
         utg4lT6KRuUXPIffkzVCcxiQB3M35DOViKylzg342XvALcBZa/pS/IfrjFr/DIuwB89L
         sxoHsXMY3LG+5Iwceo8x5KruBV9NbHk5IHBa8lqTkSppSUNllWJfUD3Z9OhHDyPkLyLa
         xPo4fvnJwvXnfX4APIHb4CW16RzwhYCwxM8Nhn8eIy9QUG2aemYkI6aLceH9KF+9hstq
         ESpUe8B2BACsY7ErXB4sLZN3v4nsUh6MsC87WqDNU/NHHp68avlqKMgG27RlKi3SfAvc
         UI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/C96D/c4iIB14ZPmIUheFcFLIlUZ3nkmg1zOuVbd2fU=;
        b=J/cw7SX6NXuI63bSgeoXR01I0UnXMufDP15UDYlNUoTlt4vcaf7pweo9cS3XncYf+T
         93Pst55w5dEE9XmdlUTEpJV01KhdH8NlkJvkGldMsc+/d0A6HCpZiL/a31r10P9gi1kx
         JhFNJ9h+oAW/jAFB4xylPsfEL2f9fOQDTmAqZPNgjyLkWPGYZh301HISK05H8osmo1sb
         ag/ArMGSByK8KlNxks0deJs1I3w83lDE4r9H0mnNycBMP64jyMBGD8Jur/IlFPWlaJVr
         CqBsfJa1ajxEdX8aqZ/srp7KKILlI9WH7cCB9xXTIx4Tq+ZxyYsjpgEGMxdilma3Ecxc
         rspg==
X-Gm-Message-State: AOAM531TJFlKJTQLvqmVEq4M81IRh7zK9HNfaqWKhVpApNZWdmc8DSGV
        GIUdmZB3+t9uZvfDLMNLVVhk0YNn9o8=
X-Google-Smtp-Source: ABdhPJwzN4yCD9prM3q27A2CgHXEm02tDOBxivJ7I0cpbfdf9wDVcuB+ffbtWJjFEXGVWniQap7wDQ==
X-Received: by 2002:a05:620a:1274:: with SMTP id b20mr41187910qkl.220.1600618591180;
        Sun, 20 Sep 2020 09:16:31 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z3sm6814429qkf.92.2020.09.20.09.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 09:16:30 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 20 Sep 2020 12:16:28 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] Use feature bit names in clearcpuid=
Message-ID: <20200920161628.GA3951950@rani.riverdale.lan>
References: <20200920154228.GB7473@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200920154228.GB7473@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 05:42:28PM +0200, Borislav Petkov wrote:
> Hi,
> 
> so tglx hates this clearcpuid= interface where you have to give the
> X86_FEATURE array indices in order to disable a feature bit for testing.
> Below is a first attempt (lightly tested in a VM only) to accept the bit
> names from /proc/cpuinfo too.
> 
> I say "too" because not all feature bits have names and we would still
> have to support the numbers. Yeah, yuck.
> 
> An exemplary cmdline would then be something like:
> 
> clearcpuid=de,440,smca,succory,bmi1,3dnow ("succory" is wrong on
> purpose).
> 
> and it says:
> 
> [    0.000000] Clearing CPUID bits: de 13:24 smca bmi1 3dnow
> 
> Also, I'm thinking we should taint the kernel when this option is used.
> 
> Thoughts?

I like it. Allowing 13:24 as input would be icing on the cake :)

Small comments below.

> @@ -273,21 +273,45 @@ static void __init fpu__init_parse_early_param(void)
>  		return;
>  
>  	pr_info("Clearing CPUID bits:");
> -	do {
> -		res = get_option(&argptr, &bit);
> -		if (res == 0 || res == 3)
> -			break;
> -
> -		/* If the argument was too long, the last bit may be cut off */
> -		if (res == 1 && arglen >= sizeof(arg))
> -			break;
> -
> -		if (bit >= 0 && bit < NCAPINTS * 32) {
> -			pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
> -			setup_clear_cpu_cap(bit);
> +
> +	while (argptr) {
> +		int i;
> +
> +		opt = (strsep(&argptr, ","));
> +		if (!opt)
> +			continue;

The !opt check is unnecessary: strsep() returns NULL iff argptr is NULL
on entry. The parentheses around strsep() also look odd.

> +
> +		if (!kstrtoint(opt, 10, &bit)) {

Could make bit unsigned and use kstrtouint().

> +			if (bit >= 0 && bit < NCAPINTS * 32) {
> +				if (!x86_cap_flag(bit))
> +					pr_cont(" " X86_CAP_FMT_BARE, x86_cap_flag_bare(bit));
> +				else
> +					pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
> +
> +				setup_clear_cpu_cap(bit);
> +				taint++;
> +				continue;
> +			}

Could always continue if it was a number, even if it was invalid, since
that shouldn't match a name in any case?

>  		}
> -	} while (res == 2);
> +
> +#ifdef CONFIG_X86_FEATURE_NAMES
> +		for (i = 0; i < 32 * NCAPINTS; i++) {
> +			if (!x86_cap_flags[i])
> +				continue;
> +
> +			if (strcmp(x86_cap_flags[i], opt))
> +				continue;
> +
> +			pr_cont(" %s", opt);
> +			setup_clear_cpu_cap(i);
> +			taint++;

We could break out of the loop here -- we can't have multiple bits with
the same name, right?

> +		}
> +#endif
> +	}
>  	pr_cont("\n");
> +
> +	if (taint)
> +		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
>  }
>  
>  /*
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
