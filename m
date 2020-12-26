Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2271D2E2DA3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 08:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgLZHws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 02:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgLZHwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 02:52:47 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8747DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 23:52:07 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v1so3380213pjr.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 23:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iCbGK8pR7Lx+7BhFwDHvHLS7dEP9reTsuL6ZDzX42g4=;
        b=qTTU8vYRzo+3tMyDLnK4Isa0wGDG/PnnJ0xmqFBIjGBXwANwqW/HjBZU7BU+lTY2jL
         IIwNQV4HUIG3ZgntRMe8afu9iDZannrE7byR2j8PBfu5Eb2rTNBAkDXCqeVdi88PABIE
         nw9/avvyq2Ne0GnBlUwOGU7eNnPNqrjepe6ePg94TiiJVbkVGRO5iMaL3uOFNTrI7A3G
         GkFCZT1dU9A53ICpaX3hVMdiYKxaJEy6edixU5cG5G1mJ2R7ZMfZsOUeDCMBTg2uwSuq
         WzEtIOlOMnBaw0hMgW5EVNBFqyCTyiMCZG28o/9NK/nNnqMYxK8aPxnIHCzITL4oQ8AD
         8P4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iCbGK8pR7Lx+7BhFwDHvHLS7dEP9reTsuL6ZDzX42g4=;
        b=TAc8w1aTsRplX6yBCXGY3yqi+Yqtlf6kcOMBXSdnKn3oelzBzqcp682DeRg3fyuTLd
         AMb/0ZQzn1brA9jPxXmKlDF0hcfk09eH9eLuSQ82BFFzDSyoS5Hb/uXP8jjKpwQhsCDM
         NOM51t1EHEmb3ECOyo8X78UgMPphlSjN7v/RYAlK/WuXcDHEVdfl1o64YnpQqIpultU7
         xChgpApG3+Fmk4eDKaVi7tbi+2l+XU1Glh68vFqsQvH5HASHI24wvryRf/0jXyoI7Q7J
         LK4BNYZ97qRhkHTtkD8IlkIYau1p/InBdIOL8eSccRzO5AdqwloFaVk6Eyss1FfR8j4V
         d5tQ==
X-Gm-Message-State: AOAM531SWEHq/W9tnRMzNWHd/1Jd9oPufFR7Nkm0lXjBMy8gaSNkxgH3
        uyqBJkd4uUWu8+IWpQeNjP4=
X-Google-Smtp-Source: ABdhPJyDPBOS3HSHY1R+4NnCDZnV0W/e/oJzxORruZo+og79/Usc3n8E7JPSHr+uqlLnM3/wM1bJ4w==
X-Received: by 2002:a17:90a:3cc6:: with SMTP id k6mr11727910pjd.204.1608969126927;
        Fri, 25 Dec 2020 23:52:06 -0800 (PST)
Received: from macbook.local (ae142046.dynamic.ppp.asahi-net.or.jp. [14.3.142.46])
        by smtp.gmail.com with ESMTPSA id s1sm29753063pfb.103.2020.12.25.23.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Dec 2020 23:52:06 -0800 (PST)
Subject: Re: [PATCH] arch/x86: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)
To:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        John Millikin <john@john-millikin.com>
References: <cceb074c-861c-d716-5e19-834a8492f245@gmail.com>
 <37DE7046-5096-4C0C-A96D-FD168A849DFD@zytor.com>
From:   John Millikin <jmillikin@gmail.com>
Message-ID: <6008226d-3655-df9c-6842-8161de365ff7@gmail.com>
Date:   Sat, 26 Dec 2020 16:52:03 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <37DE7046-5096-4C0C-A96D-FD168A849DFD@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/20 16:35, hpa@zytor.com wrote:
> Why is CLANG_FLAGS non-null when unused? It would be better to centralize that.
CLANG_FLAGS normally propagates through inclusion in the default KBUILD_CFLAGS and KBUILD_AFLAGS, set in `/Makefile':

    # Makefile
    KBUILD_CFLAGS += $(CLANG_FLAGS)
    KBUILD_AFLAGS += $(CLANG_FLAGS)
    export CLANG_FLAGS

This default can be overridden by explicit assignment, as is done in some of the arch/x86 makefiles:

    # arch/x86/realmode/rm/Makefile
    KBUILD_CFLAGS    := $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
               -I$(srctree)/arch/x86/boot
    KBUILD_AFLAGS    := $(KBUILD_CFLAGS) -D__ASSEMBLY__
    KBUILD_CFLAGS    += -fno-asynchronous-unwind-tables

Since REALMODE_CFLAGS is being built up from a plain assignment, the Clang flags get lost. As a result Clang fails to compile the real-mode code when cross-compiling for an x86 target.

    arch/x86/realmode/rm/header.S:36:1: error: unknown directive
    .type real_mode_header STT_OBJECT ; .size real_mode_header, .-real_mode_header
    ^
    arch/x86/realmode/rm/header.S:36:37: error: unknown directive
    .type real_mode_header STT_OBJECT ; .size real_mode_header, .-real_mode_header
                                        ^
    arch/x86/realmode/rm/header.S:41:62: error: unknown directive
    .globl end_signature ; ; end_signature: ; .long 0x65a22c82 ; .type end_signature STT_OBJECT ; .size end_signature, .-end_signature
                                                                 ^
    arch/x86/realmode/rm/header.S:41:95: error: unknown directive
    .globl end_signature ; ; end_signature: ; .long 0x65a22c82 ; .type end_signature STT_OBJECT ; .size end_signature, .-end_signature
                                                                                                ^

This patch allows the Clang-specific flags to propagate through the REALMODE_CFLAGS variable set in `arch/x86/Makefile' and consumed by certain arch/x86 targets, which fixes cross-compilation of x86 kernels.
