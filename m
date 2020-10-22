Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2E2961F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368841AbgJVP5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368833AbgJVP5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:57:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D04C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:57:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i2so2499933ljg.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UrWFAE2bCbAtFNlroR+37KO0Bliy0cvb7DkMi9MpqP8=;
        b=BsTc8UYaFwf19h0QIoijGfeykofu5wPFHs8BLdYkwoHGtKwCb03zfTdjyfXm4KDguv
         kh4nG3H4+zqtsooHHJ1ZfE1rCtgIZLHLosxXLx4rr/xiOeZb0Dgp4AprOlXNv6JZd8NO
         +Mqfzfxu6WWWno+SUJNVc7TcEDQzwy1IA7jHVB+tSEjz5moOSV2hLJlsdPhRQ3wX7nyz
         nPs8T8EuOwcg+tNC4azw+I5GbJcLezhn9T3Hz2ridAwCX7daFhS81u1NSjcBi1JrP2bk
         ZlC9NHS/XCLzDowTNvIT5WIDpLJNzlVYVeY8WfcW3+ejgoDtyJ7WZLvCF6DuzdDLy8Xn
         OtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UrWFAE2bCbAtFNlroR+37KO0Bliy0cvb7DkMi9MpqP8=;
        b=slzUJpyK+j6c8bHs7YfV+e0esE2UilLnCatfLNk7zp7GS7uR98nLc++2gYDqg2BWlj
         wo35sKVQbOTJVvyqcWd4QZzDGaeFrCgKcoJ7/7VXjOUKFKhwt+9hM1B1j89NzFiCaM2y
         cQ1fhr43Ny/2NFL6NyOYxhFPhgp5aH2wqFU2vhxRYwcrdW/LEKggmR3XLZQuKLDNy94z
         tUPu9JxwoRh6Ghej1Ii+kvtXngfOqUlziRW7M+cIKKSnpJoI052W11ERqAvLOi9WWQKx
         U1bgBDFxvoZyUxSVPzvDYi3tp5ej2hRv2KebkwX94BYEEgi9z27hJqiEWqhbVkMpoqWb
         dFdQ==
X-Gm-Message-State: AOAM531L67j8DNsleB7pFWQlGVq3uGVYcghG4y4xwjHhpi4CRgApO0H2
        UPBujM1K5iKE19B9h/DoR4Q=
X-Google-Smtp-Source: ABdhPJwKW6D43EzEswsoHT6H8jneKNlsCGgAdHc75TmkCsLrvMlOjvdVfDJdSZzyQVSeIPs8tHp8Xw==
X-Received: by 2002:a2e:9955:: with SMTP id r21mr1204620ljj.124.1603382220068;
        Thu, 22 Oct 2020 08:57:00 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id x14sm377602ljm.126.2020.10.22.08.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 08:56:59 -0700 (PDT)
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
References: <20201021225737.739-1-digetx@gmail.com>
 <20201022145734.GO1551@shell.armlinux.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0174c738-633e-1fa8-b45f-fdf03b9c2105@gmail.com>
Date:   Thu, 22 Oct 2020 18:56:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201022145734.GO1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.10.2020 17:57, Russell King - ARM Linux admin пишет:
> On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenko wrote:
>> The vfp_kmode_exception() function now is unreachable using relative
>> branching in THUMB2 kernel configuration, resulting in a "relocation
>> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_kmode_exception'"
>> linker error. Let's use long jump in order to fix the issue.
>>
>> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input sections")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> I guess the problem is that vfp_support_entry is in .text which tends
> to be at the beginning of the text section, but vfp_kmode_exception
> is in something like .text.vfp_kmode_exception ?

Indeed, vfp_support_entry is at beginning of .text, while
vfp_kmode_exception is near the end.

> Would it be an idea just to change the section name that stuff like
> vfp_support_entry ends up in, rather than making the code less
> efficient?
> 

This works:

diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 4fcff9f59947..65f0a2ef3613 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -65,6 +65,7 @@
 #endif
 	.endm

+	.pushsection .vfp11_veneer, "ax"

 @ VFP hardware support entry point.
 @
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 8c9e7f9f0277..30b83b191174 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -642,7 +642,7 @@ static int vfp_starting_cpu(unsigned int unused)
 	return 0;
 }

-void vfp_kmode_exception(void)
+void __section(".vfp11_veneer") vfp_kmode_exception(void)
 {
 	/*
 	 * If we reach this point, a floating point exception has been raised
