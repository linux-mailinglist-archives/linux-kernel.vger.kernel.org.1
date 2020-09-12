Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A1C267B59
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 18:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgILQPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 12:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgILQPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 12:15:44 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A45C0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 09:15:43 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id q8so8995190lfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mfFSLJ2aT99PDQEJLg63CY2EfFTeT2UQOOCsNtG5XQ=;
        b=ik2OaDdzUHuVOMNMLsgvQOnL4fvUvEqien4NjpuI5VfIclMzHKWaow1odpvd5sDPJU
         +LXHDLiPBxR8ThB4sl5aU07BCGyBsQ0CUT5VU6uQyRjR0z/eVMBKV/EafigpOJM2w6fx
         tUF49I4gg9jJzUNcM/EjXzreHBPpIlb/n4r5NT5TvcdPcNldy6x3TCHdfhOof7EJKQ/u
         kLZH5q/yNZIk9TzYMtUHe6cNExS56wCEroXgH0iLeRteyVneoKhJ3FbCUEVL5W4iG82t
         Hyl6zxvpxVVMdWTF4rS9E+pNohfmkBfFjwohofeLq61gNe4dH/KzLBRCSgspSF7nutvm
         ByUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mfFSLJ2aT99PDQEJLg63CY2EfFTeT2UQOOCsNtG5XQ=;
        b=cI6ge6jC/zuokD/DQhssHowEIis2E6pZoGHdhI97+540dswEkS8fzl4txQUeXrCIi1
         o4khoZxqCygs+9/s3RNuEmzjQr0BEhaDKQcQeRKV9g+4UMZNU+8nZAy2Pr/8q4+mNW92
         oBouuOCGn2jytkG6wZJhR+MjtPHINrdE6cjKl8E1JQKXNS4oWnO+Ktsw325TLM5W1RWE
         dotpMeUNdXVLyYfVZrN982P/K+m7ZBTJ98WfYdCsU6R2Wum2KTZk0XYPyDHOojbWvMlH
         rAbkPbnZN0aWdB9jQcFFZ+SRtob/USAw4RgTLKVj0c64EheNh0jhjroIg9lVlNakzxDs
         pkqA==
X-Gm-Message-State: AOAM532cvPnLkt1Qz0b5+FnKCWr8A2WFb3ImuSp/fAFzMu6BaKvVpBL6
        HhdT1uOsLk9Ly+W6NzHl/f4FibZWG8hRDd5KAY2wBw==
X-Google-Smtp-Source: ABdhPJwzk5Ff3ZAWzHOFqk2anJO10WsYhRwbjNzmrZfdwXqXvmayMoWnkftiDhcCyLXCuPFXWkcBZk4GHcnDyvYoRF0=
X-Received: by 2002:a05:6512:370b:: with SMTP id z11mr1756518lfr.571.1599927340316;
 Sat, 12 Sep 2020 09:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200907211712.9697-1-chris.packham@alliedtelesis.co.nz> <20200907211712.9697-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200907211712.9697-2-chris.packham@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Sep 2020 18:15:29 +0200
Message-ID: <CACRpkdZbo6zN+F0K6oHyWRTWN3raRGVNzps4VCB+QuSzsyq9Ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] pinctrl: mvebu: Fix i2c sda definition for 98DX3236
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 11:17 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> Per the datasheet the i2c functions use MPP_Sel=0x1. They are documented
> as using MPP_Sel=0x4 as well but mixing 0x1 and 0x4 is clearly wrong. On
> the board tested 0x4 resulted in a non-functioning i2c bus so stick with
> 0x1 which works.
>
> Fixes: d7ae8f8dee7f ("pinctrl: mvebu: pinctrl driver for 98DX3236 SoC")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

This patch 1/3 applied for pin control fixes.

Patches 2 & 3 should go via the SoC tree.

Yours,
Linus Walleij
