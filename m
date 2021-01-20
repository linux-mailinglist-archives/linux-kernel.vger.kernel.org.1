Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2732FCFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbhATLoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732958AbhATL1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:27:24 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E8CC061786
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 03:26:42 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id i17so499076ljn.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 03:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rA6bdLKAlmIoLWUk8dCMAvfvN7Iy5mLs9O7w+8do8z8=;
        b=hUIiRPlnMeeaTktx9TiA8UFdRaSKm6zh4+y0j9kDeNHP8TdZPrstvxTNIJydx3b3rk
         laCm9uscm9uZlNF+jgD9LxV234ABWDAqEJwDD3sYViomVYIACHg5ywtJBI2OOLJvja5V
         5ZQj1utqaWnS+NOXIbmT0DGsJ7HgKMLkiZlTG9xVwLg6a8dUgChg6WGgTR/sGcPf3cwf
         Clv4SaBcGsAmSQ9zVOKQY0v5ZMbPeMnTvpzmVAXJAwuEJwGmL+kmqqK7n0ySEuuvvmK6
         k7W1CfEpdhfGc8BNtERIX75nlK0Yu/vY54bSxpx7JrQntZIiDyMbNBbsve/ZKNsRxDeh
         Sx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rA6bdLKAlmIoLWUk8dCMAvfvN7Iy5mLs9O7w+8do8z8=;
        b=hdkOAmTYIxicjMR7o6HvbUryvLtYHShEc5LVDxLCCdChlg2bkD86f7upF0gFPybuUr
         Z7OBmZAGy5SCYHzqIuekSk+pXtcD3R9KjIiIdyBs77p3j9748VN16wOckZTLj9Bnro5t
         bw0KlOoWU3vWdltELlRQGJ6BwNZDWekm528aovFRyptKjzb3+hjus5KmFZMBX9tS2ufI
         G+x2RgdwmBdxaaoZiSux8Zq4lJBVbS8uwXU9gAcm9P2gyH6SsZH/iYl7Lk1V46yfAdHe
         G9m+rSDEFIhb0mTcib/ulj3K5GUB/BaLHPPZEWLJFJzT/XoQEUV2nxhKHT++25ynOD6n
         nQeQ==
X-Gm-Message-State: AOAM532gCLS7Cx1s2iipy/kHqNjUJnc1ep6+VQVrxe5dfCVYavGPxAEg
        1cvntiRNJwNwCQuUZkApRJm4eQ==
X-Google-Smtp-Source: ABdhPJxhSDtqieNXSqt+r98ESGwXZDp29cFZUijUj0JQjcXu+YxvmLdbP1QZ+D1O4a2eK82VnJ/DbA==
X-Received: by 2002:a2e:b1d2:: with SMTP id e18mr4163694lja.101.1611142001496;
        Wed, 20 Jan 2021 03:26:41 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 189sm172195lfj.192.2021.01.20.03.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 03:26:40 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4462C101448; Wed, 20 Jan 2021 14:26:43 +0300 (+03)
Date:   Wed, 20 Jan 2021 14:26:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <20210120112643.ozlsru67yuur323i@box>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
 <YAH6r3lak/F2wndp@rani.riverdale.lan>
 <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
 <20210118202409.GG30090@zn.tnic>
 <YAYAvBARSRSg8z8G@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAYAvBARSRSg8z8G@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 04:42:20PM -0500, Arvind Sankar wrote:
> AFAICT, MODULES_END is only relevant as being something that happens to
> be in the top 512GiB, and -1ul would be clearer.

I think you are right. But -1UL is not very self-descriptive. :/

-- 
 Kirill A. Shutemov
