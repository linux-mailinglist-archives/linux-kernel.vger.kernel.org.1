Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5BD2EB1B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 18:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbhAERpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 12:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbhAERpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 12:45:43 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1BAC061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 09:45:02 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id a6so158474vkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 09:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2poEGmb5do8w/L6iPewO1Yp5f3/JnzeKXCH38sWzZXQ=;
        b=P43/otfzyF8OEXWYSnLBvAtrZ8jU3DHL6R45ivbEW8I5pdnDwPh8ALa5giu9uAZCK/
         ERGWMImbG89Mm1Wt1Lx6Z/5EjiCTz1zarkfuQ49MExOHD15U2cp/XDQpbED0Bspnh5ZB
         Uh+WDCyai/MDfxDcbNdgi8FxHwP9AtULTe8Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2poEGmb5do8w/L6iPewO1Yp5f3/JnzeKXCH38sWzZXQ=;
        b=U96qh+oPfB225+i+SfXh7JAvzxj/7abqk3Il8tPwBjxhRX968oby9XjTNCMXw/n+WN
         ytiz5skONjZgizkudAF1OnsZDSp/PArxhfJfY2rJKHOYB7m+OFhZ0OWevWBbzlHcLEti
         4MOQqW7ShIJyzh3T0vfBSEaaA97ak//wRnCmhLFfEG9HyhtoiEdDweJPJlXiLhni0JJX
         HNSIYdOgYm6H8uF9VLsHJ9OSg2dEwkHdofDpbzG+VJoDZ/nvbqhwY69nyE85s4eQk/sq
         SeeRFpVx6Ujjm+A9mBcAvpS7B7UFaYhn75W35aNY8PLA4JxI5mFKo/la1PIJAS5cL3sA
         MNLw==
X-Gm-Message-State: AOAM533/pymMb+QLvEWp1itn47NTlnHX8uA7bhJEVfcobV76iV3Jtpzu
        yAVBZZv5frrhitzMYzDfhwm1fyJXM73DZQ==
X-Google-Smtp-Source: ABdhPJyr2Ow5IpZmBCzfI3dvCr65b1919NUjgD9tkrqvTNLGXT80pW2qO/8vnLIorqHyHULZ56Nazg==
X-Received: by 2002:a1f:acc9:: with SMTP id v192mr865623vke.2.1609868701334;
        Tue, 05 Jan 2021 09:45:01 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id r79sm8702vkr.42.2021.01.05.09.44.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 09:45:01 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id r24so344788vsg.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 09:44:59 -0800 (PST)
X-Received: by 2002:a05:6102:21c4:: with SMTP id r4mr461281vsg.37.1609868699223;
 Tue, 05 Jan 2021 09:44:59 -0800 (PST)
MIME-Version: 1.0
References: <20201203202737.7c4wrifqafszyd5y@google.com> <20201208054646.2913063-1-maskray@google.com>
In-Reply-To: <20201208054646.2913063-1-maskray@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Jan 2021 09:44:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WWSniXCaC+vAKRa1fCZB4_dbaejwq+NCF56aZFYE-Xsg@mail.gmail.com>
Message-ID: <CAD=FV=WWSniXCaC+vAKRa1fCZB4_dbaejwq+NCF56aZFYE-Xsg@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: Align .builtin_fw to 8
To:     Fangrui Song <maskray@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 7, 2020 at 9:49 PM Fangrui Song <maskray@google.com> wrote:
>
> arm64 references the start address of .builtin_fw (__start_builtin_fw)
> with a pair of R_AARCH64_ADR_PREL_PG_HI21/R_AARCH64_LDST64_ABS_LO12_NC
> relocations. The compiler is allowed to emit the
> R_AARCH64_LDST64_ABS_LO12_NC relocation because struct builtin_fw in
> include/linux/firmware.h is 8-byte aligned.
>
> The R_AARCH64_LDST64_ABS_LO12_NC relocation requires the address to be a
> multiple of 8, which may not be the case if .builtin_fw is empty.
> Unconditionally align .builtin_fw to fix the linker error. 32-bit
> architectures could use ALIGN(4) but that would add unnecessary
> complexity, so just use ALIGN(8).
>
> Fixes: 5658c76 ("firmware: allow firmware files to be built into kernel image")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1204
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> ---
> Change in v2:
> * Use output section alignment instead of inappropriate ALIGN_FUNCTION()
> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Douglas Anderson <dianders@chromium.org>

For whatever reason this is hitting developers on Chrome OS a whole
lot suddenly.  Any chance it could be landed?  Which tree should it go
through?

-Doug
