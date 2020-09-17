Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B3326E09B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgIQQZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgIQQW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:22:59 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FA6C061352
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:05:51 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ef16so1227804qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G210apeCNpVx1Fda3n7RCtQBe6IK97se+SFhsL5BXoo=;
        b=E3OxeQqryLoYkxqhWf5gQOAaYdTgtUXhaVuGFqVzXhFHZOrGqoUtqXeJ45+xkAE2zZ
         ZRDJiioarBB/mTTLy8ebhTWNjog2YXKuP1QU5EsGpGwtvTdd3h5jrdtYDomoN2wwCMFu
         fr0zUx7uBAJ0EDYy0fvT+Obm3lyYsaJm74yCUtHMTpB1ym08PoQxo+yT3bQdT+YFQeFN
         Bxbe5e7rngStxT6GC1dhYbwNOnkbeCTXJkkyHfSKzIoS8wq1OSMvvFSu3G3XVtQCMwFq
         KYl7QHd0xw94/cANWaO6kaHzsm+LYSk0LoaCycXCB+Y0Yfy4Q4V6BCCF2VV67wTa8weG
         1J3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=G210apeCNpVx1Fda3n7RCtQBe6IK97se+SFhsL5BXoo=;
        b=ovKWkmi0zs82uHzYnRa/2ppEZ7ynzgHEbnBjuoSWsrSGpeu8lbu2xezc9Kv3mcf2o9
         PWDhZxDNgWwNx1Joz1wi+eQy/S47c0TDIAHgIgmA47WQLy3Z9sk+adDVlXK3vkUqdNjn
         Ja4iwwr0+cpFwKHx+SEqYs2gvylNaCmeIeLKy75+oNtDvZditTLPSx9sihANQewWVo6b
         smRJfW/Selobw6RJZQZIYh+kbD9W7nL6hQM11ko7pTuDi04kSvC+VKZaM9fEAe5ppNg6
         hk/6Xa2w59QUzwQ5vYJ270LQp3touk6yWuoAM3p9+z31aQv1fdILVWlJtwlj7fwnn0uQ
         fe2w==
X-Gm-Message-State: AOAM532yu4rjeoevCf+BLuN7Mj3R1qYJnx1jXh64cr/A5TvdBaFjXLng
        ulvLSMkKS50LDTqiQiIVO44=
X-Google-Smtp-Source: ABdhPJyznzL0h0CYnKwNFeLJ2m5GOOg5p1tVzXKRPiLqvlCDc5ORFdKZmz6WIGmfSx8/Bg/JQwIAPg==
X-Received: by 2002:ad4:4b30:: with SMTP id s16mr28425902qvw.8.1600358750900;
        Thu, 17 Sep 2020 09:05:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z37sm78369qtz.67.2020.09.17.09.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 09:05:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 17 Sep 2020 12:05:48 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cmdline: Disable instrumentation of cmdline
 unconditionally
Message-ID: <20200917160548.GA1877352@rani.riverdale.lan>
References: <20200906154637.1618112-1-nivedita@alum.mit.edu>
 <20200917094055.GF31960@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917094055.GF31960@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:40:55AM +0200, Borislav Petkov wrote:
> On Sun, Sep 06, 2020 at 11:46:37AM -0400, Arvind Sankar wrote:
> > On 32-bit, cmdline_find_option_bool() is used before paging is enabled,
> > from check_loader_disabled_bsp() in the early microcode loader.
> > Instrumentation options that insert accesses to global data will likely
> > crash or corrupt memory at this point.
> 
> What is the use case here, can you trigger an actual crash?
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Hm this is a bit embarassing.

I did have a crash and this patch fixed it, but it seems it was on a
branch where I was making changes to cmdline.c, which triggered clang to
use a jump table for cmdline_find_option_bool(). That was the cause of
the crash, and the reason this patch fixed it was because it enabled
-fno-jump-tables, rather than because it disabled instrumentation.

The instrumentation code does write data to random addresses, but
apparently that doesn't necessarily crash the system. This patch would
also be insufficient to fix it, since load_ucode_bsp() itself can have
instrumentation code in it.

Eg with GCOV_PROFILE_ALL enabled, the start of the function is:

	c2a7706a <load_ucode_bsp>:
	c2a7706a:       55                      push   %ebp
	c2a7706b:       83 05 c0 4d ba c2 01    addl   $0x1,0xc2ba4dc0
	c2a77072:       83 15 c4 4d ba c2 00    adcl   $0x0,0xc2ba4dc4
	c2a77079:       89 e5                   mov    %esp,%ebp

but when it's called from arch/x86/kernel/head_32.S, paging is disabled
and the code is executing out of physical addresses, so it's going to
read/write data from garbage addresses.

Anyway, please ignore this patch and sorry for the noise.

Thanks.
