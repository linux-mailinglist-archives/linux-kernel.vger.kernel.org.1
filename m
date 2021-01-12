Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65BC2F3CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437520AbhALVe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436920AbhALU2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:28:32 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F6AC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:27:51 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id p18so2191956pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+1M3GesbgTSmOd2h7c4OH51TFpiZEy46zgQiOOCDaG8=;
        b=UUnF4LkMhWNZELMiMXlsNEOijuryuhnZoC6pF/VoVBc72vRes6Rvhjl2R/8nUE0HBD
         VUMHE8cTN3oAC99mUOcH3O1lEsrUrcFMwfWtEfmyR/7Vk5h4A0TEufghlh75rUhI3ny7
         Ek+jkSRiGyGUYJpnksD/WbLA3UDkzNDeAeHDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+1M3GesbgTSmOd2h7c4OH51TFpiZEy46zgQiOOCDaG8=;
        b=S8/kBR2+CDiAjml6uNWz9xWVMrBouPq413IwcLJovFQ8f5rSL+B3xABL9AQQqY8CIv
         ISU6Mt6v9hNrggsCAahBj9mngBXFdRgmwKUo9fOU5dnjTyG8sPhYi3G4Mx5JeDi3fMKt
         KsELnfI7oPgmSI2Mc0DKQoq2zaarizq36be+MnY2tZa5MjSj3jbRTbG4XmGOg4cxEoqM
         df4jHbKV5ffn4nd2oe0vOFMZzl/AyLjcfOStBjsYhjMRNO7aQ4K4XuNqnz1lniMVCuL3
         mquewy2b/yjkQv+jAXmhJwDIakbFOU2gtPh18JpseDK3vTQrtGaHBpzSIZdk82eXY3Sl
         Si8w==
X-Gm-Message-State: AOAM531Ehwp/mYJ3JmAYPDG8dr6KIVMrgkBNfBhIZwMbvx6SSag74mtr
        mgtm8WNeRTpMEc5beB92s4HKjg==
X-Google-Smtp-Source: ABdhPJy9YmRGBxfvvgvUymkpFG+zoygKea02X2kwbSpCsfLveKRHblB3sCeYdtAMiOGgZ/S1ph8yvQ==
X-Received: by 2002:a62:4e95:0:b029:1a3:a372:8b3c with SMTP id c143-20020a624e950000b02901a3a3728b3cmr1009973pfb.28.1610483271533;
        Tue, 12 Jan 2021 12:27:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d10sm4096844pfn.218.2021.01.12.12.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:27:50 -0800 (PST)
Date:   Tue, 12 Jan 2021 12:27:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ARM: fix link warning with XIP + frame-pointer
Message-ID: <202101121227.446CE291@keescook>
References: <20210112154658.850192-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112154658.850192-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 04:46:40PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When frame pointers are used instead of the ARM unwinder,
> and the kernel is built using clang with an external assembler
> and CONFIG_XIP_KERNEL, every file produces two warnings
> like:
> 
> arm-linux-gnueabi-ld: warning: orphan section `.ARM.extab' from `net/mac802154/util.o' being placed in section `.ARM.extab'
> arm-linux-gnueabi-ld: warning: orphan section `.ARM.exidx' from `net/mac802154/util.o' being placed in section `.ARM.exidx'
> 
> The same fix was already merged for the normal (non-XIP)
> linker script, with a longer description.
> 
> Fixes: c39866f268f8 ("arm/build: Always handle .ARM.exidx and .ARM.extab sections")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
