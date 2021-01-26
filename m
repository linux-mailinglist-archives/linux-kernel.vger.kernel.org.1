Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1434303A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403838AbhAZKeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731937AbhAZBkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:40:55 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B5C061A2A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:03:24 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id g5so5080301uak.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vqg6bv6YX+UaRhVsv9trHQtX0ur2NbtvGMYILmAZAUM=;
        b=P1l4NPK1mg6P+cMqArKZZ6FOU2bUnkug0c0wiDxi8esJ1qNqlZ3Av8QbDtH3XtmBcH
         WWj2fRqK6jXXpp1LfZvMsxakWaQD2KL3193fxXG1tya7r5Ks1Cf+/sLSkxLCxuMGGHLw
         ZtmMx8T9UA0Fr/mvIqw0o3Yn6tUyNGjH4LTfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vqg6bv6YX+UaRhVsv9trHQtX0ur2NbtvGMYILmAZAUM=;
        b=gEUMoQGt0k11V5EQJTkip7MiPLkJ2ENJZLD374PBrr7AN10FfK2Vd0FDVBTHS5Mj96
         HvR0dq/HUZDQ6zRZf2kNK0FiFYIUFR30Ohkocik1XGZizZmq1rJEnYHQC57cdSHvHNT/
         sIBD6lhxRew0QR3kJDbnMYYGiW9XeOx3Z3VzBaZoT1AMxCZhMOcUOvHtbn6iGrA6+XXA
         F8rsoRgzyds07x9IBqb2ufY4SpZrkmMPc10bk9I6nX35J+TKBhYrs9fl0SQou1NUch+W
         lDkVOFtI4xNwxU2nsFdAuNXu2HiuDrXSFfExWgjc/btd5kmwpUenFl/Nnnf49X0mD68z
         VI4w==
X-Gm-Message-State: AOAM530jo9kI15ECYmnEgIg1uDYzDJ9lBdryny6ASj5Eg0vpWH3rDpMN
        uP9jP7bzbjexS8bRjj12jwSCyMXNO+FiAwTw2uw9pg==
X-Google-Smtp-Source: ABdhPJypAk1MRy9xAVulpTwXcpPdyH5UZC9neTdCesmTbQDgAfb7Ug9ZhO6Fi+/A0gtEIjD8oDzmrbw8YTyBtpr/oRs=
X-Received: by 2002:ab0:3043:: with SMTP id x3mr2487551ual.88.1611623002329;
 Mon, 25 Jan 2021 17:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20210113060703.3122661-1-drinkcat@chromium.org>
 <20210113140546.v10.2.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid> <20210125192658.GA806742@robh.at.kernel.org>
In-Reply-To: <20210125192658.GA806742@robh.at.kernel.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 26 Jan 2021 09:03:10 +0800
Message-ID: <CANMq1KCdCurhB0S_a4qRtNbOUWMZa9=ObZkz0VSGLgCnfV-k9Q@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] arm64: dts: mt8183: Add node for the Mali GPU
To:     Rob Herring <robh@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Fei Shao <fshao@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Kristian Kristensen <hoegsberg@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 3:27 AM Rob Herring <robh@kernel.org> wrote:
>
[...]
> > +&gpu {
> > +     supply-names = "mali", "sram";
>
> Not a documented property, nor should it be.
>
> Did you run this against dtbs_check with your schema changes?

I did not, for some reasons I hit a strange issue (kernel build system
wouldn't pick up dt-* tools from ~/.local/bin... solved with a bunch
of symlinks to ~/bin). Gave up too quickly ,-(

Anyway, v11 coming with clean make dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml.

>
> > +     mali-supply = <&mt6358_vgpu_reg>;
> > +     sram-supply = <&mt6358_vsram_gpu_reg>;
> > +};
> > +
> >  &i2c0 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&i2c_pins_0>;
