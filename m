Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69122A9204
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgKFJC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgKFJC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:02:27 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B97DC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:02:27 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id v18so603984ljc.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGpm+hTgP3uSHc11kp/wC/9AQaj0Wxc5iwlyk0l4rxU=;
        b=wubGnpb1Wk3yX0c3VStUaEQWmvHsW7CyYe5k/5JpppMRaNKhSxvZwzi6+l+B17Toqx
         TxcuChm2PsWjT3wmCjLSFCqlc6GrWcbk+bCmyLTX7tt6q+SdmHh1KPErgv/j+hC5Zxbs
         MMkgs9gJhHT5Jc2Ga18UZ6Gmuv1m35fRv91zZcGI7saFibfT4JpZ40GHRLxIjtVdsGPP
         1HMdDGzc5mF0rmvewC0WKU6atzUIkS7ZInNX6yBSt8PfIfeHWDgjTbdiErWyFrk+EwaC
         szUyHdXneTpqcWQf2XlFQf42kLcHxSvS/9Qj8EQDSDi2bqba+X4gLNhK0vaCBG/Nfqos
         lHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGpm+hTgP3uSHc11kp/wC/9AQaj0Wxc5iwlyk0l4rxU=;
        b=f2U8d/PBsWEyrW7l+qA5H0wH0YTaii1JnXhZ8JV/8aF5AuApuTt0Ea8Wqfok/LBCPo
         bDq+btaSwfhQTNeuyQrN1kVRY5CFwKAEvSPSEBToNe9nIVVG3Wtp0xwp2rNdaIXT47ZH
         bdS53sN1hIUXaB3beTzHJoDQSgpFWBz//4/B/EjkAPrHAXMAQ+RZGB2AIwNF8BDjy1EP
         ZDJ23xoO9Hj9TAM4JHdSi9j9x973V2BcKZSUk/iDTvKD+ViiefZKP4m4yT97TawsTOrx
         TkQdloPTOqxM78WBXpZ9NqB9DQyXYKU46iHwbeGbo7EzLcP7XF8NLtpkq4tfPxmqPUVo
         yqZw==
X-Gm-Message-State: AOAM532LeL033vMTObAxQdCgerBMx42+9A7x75cD3BA986E3sNOXsP/S
        qv+swCogSAo7m3X2+vveKqUZMHjmAuy3AW3V2vqrIA==
X-Google-Smtp-Source: ABdhPJwpBGjD4hxUWe5IBanElpgpL/GBbicPDmJOUdpSaqy6eP8G9wyJ2i0EBTejTmRu+M3D7rzTZYnldm2CMLo7h9o=
X-Received: by 2002:a05:651c:1205:: with SMTP id i5mr409279lja.283.1604653345700;
 Fri, 06 Nov 2020 01:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20201030154519.1245983-1-arnd@kernel.org> <20201030154919.1246645-1-arnd@kernel.org>
 <20201030154919.1246645-2-arnd@kernel.org>
In-Reply-To: <20201030154919.1246645-2-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 6 Nov 2020 10:02:14 +0100
Message-ID: <CACRpkdZaQnG-mFs6q4DGtupRbcw50mhimsKmFz0FxOGLbSNO_w@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: traps: use get_kernel_nofault instead of set_fs()
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 4:49 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> ARM uses set_fs() and __get_user() to allow the stack dumping code to
> access possibly invalid pointers carefully. These can be changed to the
> simpler get_kernel_nofault(), and allow the eventual removal of set_fs().
>
> dump_instr() will print either kernel or user space pointers,
> depending on how it was called. For dump_mem(), I assume we are only
> interested in kernel pointers, and the only time that this is called
> with user_mode(regs)==true is when the regs themselves are unreliable
> as a result of the condition that caused the trap.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Not to mention the drastically improved readability of the code,
as ARM developers no more needs to cross-reference the
x86 FS segment register to figure out what this might be
doing.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
