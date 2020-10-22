Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34709295561
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 02:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507374AbgJVAAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 20:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507367AbgJVAAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 20:00:10 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F0DC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 17:00:09 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l2so5409289lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 17:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VIh3TuwJJ9Jaaqf99SgJSQYuun5wyPpxsSyTdnHSMRY=;
        b=lT/X0ZYCbsPdE0xWou7nupQ41GqXTCw4JhNJTVayGWINpPJ+sDCRcEJaNIAW0c/P9T
         fjxDI1ziNsqr7/t5WIfdz7kNkqDnMaMAUuT3OIKyOmNEQzlg2z19skPHoTlwmsxblwK8
         Yj68sBKuFly0OzC+dV8jayBesEOPmnoVXx0SLTWpbDmHamJg+PEFUZHGhNX66dFkaBDp
         eG4mHt+lNrg+HHCLY3IFs5ww8wLnvJyhzXXWTGWxuDgKttzwD22qD+vAn+40c8Ce3BIh
         ZRJBhTQrK93ulDhrn0mSH+FnnbtxtSIsuwTuco2/fkykPv3SqLP+/3Qv4XfZzF6jTI5S
         UF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VIh3TuwJJ9Jaaqf99SgJSQYuun5wyPpxsSyTdnHSMRY=;
        b=pVVjHqJlSavaOdoHftXhMjYjYDlRzakroAuYLJU39zAv/0bv94QibjpX5mqBaw+jVx
         Y375NDGqaJ6kLxlRsrTaKDka4PIsNnvJzX9jbVr2dnkwE24PwNkkV9jhq7JjTihVRxY0
         R5FKetf4TQLgVlXXlCB638ORXnSG3lop9KhgjeVeHmUHYLh1LRs+/qjnuwBnbX60luFH
         5YOTuBT65DM7YtG+UXt724gJxkmf5DJ4QpIKNBYjhM2T9dx9jwENwyzMkAHf0+FBIXf5
         kKnceRnCL2RoRECNO7+DcbXZSG1Fm4zxlM4lxVLuIbyvvo7YTqLWgq+zz0w09F3C88P/
         J2Ew==
X-Gm-Message-State: AOAM533wKM0cw3DoKXn84ScB8Qy1ydK2C/Rg+au8L0N545Zd93rdlL5b
        0d9GjwTvktKqCXtCNc9CFLc=
X-Google-Smtp-Source: ABdhPJwHdEi/h41lXu2wOXoV4gWJKF+/ISwRSHTQjaNwuQPebHM5TiSkmm+m+Ob+qMYpO6TCRkPWcw==
X-Received: by 2002:a19:60f:: with SMTP id 15mr2104046lfg.163.1603324808081;
        Wed, 21 Oct 2020 17:00:08 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id b12sm633663lfo.177.2020.10.21.17.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 17:00:07 -0700 (PDT)
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
To:     Kees Cook <keescook@chromium.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20201021225737.739-1-digetx@gmail.com>
 <202010211637.7CFD8435@keescook>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
Date:   Thu, 22 Oct 2020 03:00:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202010211637.7CFD8435@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.10.2020 02:40, Kees Cook пишет:
> On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenko wrote:
>> The vfp_kmode_exception() function now is unreachable using relative
>> branching in THUMB2 kernel configuration, resulting in a "relocation
>> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_kmode_exception'"
>> linker error. Let's use long jump in order to fix the issue.
> 
> Eek. Is this with gcc or clang?

GCC 9.3.0

>> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input sections")
> 
> Are you sure it wasn't 512dd2eebe55 ("arm/build: Add missing sections") ?
> That commit may have implicitly moved the location of .vfp11_veneer,
> though I thought I had chosen the correct position.

I re-checked that the fixes tag is correct.

>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/vfp/vfphw.S | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
>> index 4fcff9f59947..6e2b29f0c48d 100644
>> --- a/arch/arm/vfp/vfphw.S
>> +++ b/arch/arm/vfp/vfphw.S
>> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
>>  	ldr	r3, [sp, #S_PSR]	@ Neither lazy restore nor FP exceptions
>>  	and	r3, r3, #MODE_MASK	@ are supported in kernel mode
>>  	teq	r3, #USR_MODE
>> -	bne	vfp_kmode_exception	@ Returns through lr
>> +	ldr	r1, =vfp_kmode_exception
>> +	bxne	r1			@ Returns through lr
>>  
>>  	VFPFMRX	r1, FPEXC		@ Is the VFP enabled?
>>  	DBGSTR1	"fpexc %08x", r1
> 
> This seems like a workaround though? I suspect the vfp11_veneer needs
> moving?
> 

I don't know where it needs to be moved. Please feel free to make a
patch if you have a better idea, I'll be glad to test it.
