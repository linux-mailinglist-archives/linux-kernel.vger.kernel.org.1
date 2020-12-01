Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918282CAAFC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbgLASo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgLASo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:44:28 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52405C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:43:48 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id u16so688371vkb.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r3hL0FxT3kr1B12Wfa8pjDUDtDl+UIxVthHhbEGvFAI=;
        b=ZGqsJcBPMUy85R83QtZpqfbvijT27Fv75eywOxhZSgN+Rbny6AxoE7fECRlbuooQc8
         cSv6JOcToYUnNE0XH+1HJpyMT3It6ZPt1jL+iJbT+59FwabkVS4nLQtdOAtMp24iAof5
         lx3hYd7/2HZLUF56UxjD/0i544YcVL75Qe7g3z+CWstxgO3owAmIvIA/UXU6hAc9mPoV
         LOD+tUmBxEtHU0nw7rmOIqCCYpduvwuu2bHbwuiDibkb/Mpzl44irQ8UKMA/3kZiQ6Rm
         zCfuobZk7un5YOG1d2JNBu6NKkcmjsx2h8Xoa6bkN2DYqn/ymg/N6g8zU1crmKP8kJrx
         7zbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r3hL0FxT3kr1B12Wfa8pjDUDtDl+UIxVthHhbEGvFAI=;
        b=NQyElVaTQ5fH0Lc+AWlIrYO7knHAGk8ClBXkB8ZVu0QBh9YZw/tPFlk75CfzRkWNDx
         aAbxPT+Wy/bFXYm9JUcwicd7i5bFomMIO21d0lNELJ9BWHg0x/inUse2IODjBf9+/s1d
         1Z87yd4MgOQorXnbWH8o3Qk20sX1QEvoZjV/9Hb/CxN9/Z3DE+P4uid20RGDdC/c33c1
         zMjrGdIzPMoZNrnH1hK2Vv4wmSWoEDcDuXe1qYLT+qcLodrIkAA8dTTyOnHKmjd2z1d/
         pBmfDBSyzZiWeDqQtkTCVobGwMH/sps6l6++mVEpcr30KuTTN9rSiFsO8V1RQbZh/xDT
         sSyg==
X-Gm-Message-State: AOAM532YFPvBakoWLiEeA5FgAs8l/fJ0DOwoHSWWVG8uScUuinkEfv2e
        F9qqaMwr/ppbCY1YMAbPG+h+MuiaRyb2X/DMR9o=
X-Google-Smtp-Source: ABdhPJyf92V3/GrURafYxewOJb8JNQBWli0GaoHMyk2co6NTd/N/7drz8memczC6PokKmrQRbO1Fo0n21vfsV2lsTXY=
X-Received: by 2002:a1f:9987:: with SMTP id b129mr4004774vke.5.1606848227425;
 Tue, 01 Dec 2020 10:43:47 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
 <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
 <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com> <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com>
 <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com>
In-Reply-To: <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 1 Dec 2020 13:43:36 -0500
Message-ID: <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

On Tue, Dec 1, 2020 at 12:13 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> > Am 01.12.2020 um 17:53 schrieb Sven Van Asbroeck <thesven73@gmail.com>:
> > On Tue, Dec 1, 2020 at 11:43 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >>
> >> You are right. It is active low.
> >>
> >
> > In that case, we have a very simple solution, just remove the spi-cs-high,
> > and things will work.
>
> We originally had it that way and because there was a change in gpiolib we had
> to introduce it.

The current rules re. spi chip-selects in devicetrees are here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib-of.c?h=v5.10-rc6#n191

This is the way I see things:
- according to the current rules, your devicetree describes a spi panel with
  an active-high chip select
- the actual chip select of your panel is active-low
- a spi/gpiod bug inverted the chip-select in many instances
- because of this bug, your devicetree happened to work before 766c6b63aa04
- 766c6b63aa04 ("spi: fix client driver breakages when using GPIO descriptors")
  fixes this chip-select polarity bug
- you now need to remove your devicetree work-around for this bug by reverting
  f1f028ff89cb0d3

>
> I am not sure if DT maintainers accept that we revert a DT change just to
> handle some change in a driver. Usually they insist on fixing a driver and
> live with the DT. DT is carved in stone or could be ROM...

This is above my paygrade, but I've always assumed that the devicetree ABI
is an in-kernel ABI, i.e. not a userspace ABI. Meaning that it is flexible and
there is no obligation to keep it 100% backwards compatible. Of course Rob
Herring may want to keep it as backwards-compatible as possible, but that's
an altogether different thing from having a userspace-type ABI.

>
> So you could try to submit a revert of f1f028ff89cb0d3 with a description
> why it is needed. And please make sure that it is also applied where your
> patch is backported to stable. So it should have some
>
> Fixes: 766c6b63aa04 ("spi: fix client driver breakages when using GPIO descriptors")

I have no insight in your devicetrees, and no hardware to test it out either.
As a user of these trees, you are best placed to make the change and test it
out. I invite you to submit a patch (revert of f1f028ff89cb0d3) to the
mailing list.

>
>
> So you mean you are just restoring the behaviour before
>
>         6953c57ab172
>
> was introduced?
>

That was based on my incorrect interpretation of the devicetree spi cs
rules, my apologies. I have linked to the correct rules in the link above.
