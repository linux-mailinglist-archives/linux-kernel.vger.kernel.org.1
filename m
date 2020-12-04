Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7F42CF4A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 20:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgLDTUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 14:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgLDTUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 14:20:04 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6176C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 11:19:23 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id p7so3855565vsf.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 11:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KqRxlp4ymFV7eELgxbmICwI9khqw89fZ3DtdOgfu2M4=;
        b=jkUk52hMNItWKAWxCgCRVI3i+teHMglvgmmuS5AX0tcXiXUyyXeB7ZxTY73ibWfP9q
         hk5rl0A2Trlq4uoTYByE3ekxisIyqnHHRrQihwNHc6etm6eZfnu5heLQpoRFkNLaYoxN
         DQhao6/g5QjMJuA8ul8oUb6DeyaPr0WDHlCXjGDNsNHU4SggM8syXboOMgz/ZeQc9XQ3
         kCa0zbhL9n8ccJMyLegFCHUinSig875fNqHpAgZkLuYAF/kvz+EXL3rK6Vhm7yZIiO+A
         VnQ7OjFOt3UltY5mq7KArugKuy2rdpY0dZlHNkwmu3ET4+hgL4Y9sg/pcGWv7KkpKv7M
         Mx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqRxlp4ymFV7eELgxbmICwI9khqw89fZ3DtdOgfu2M4=;
        b=JGgHZRnJcwyirgOHrxiJqYtxfXpCpkgo+xvLDIkGSH17Wb2TrTJW97APP/Fv5qQdkc
         m0C/4g6wc//0GoQXIUxUT1gApZhGFZwi4KRhlWGIK8P7QQQE3cuSbXp2ONfEw8rMmXPV
         /sdP5ynfBsTsNzisNZcqErmQ3Sg69tNpmvDACFh568hIiXKXmQRDASLqNCSOZj+hvEAS
         yz4qqBrL9fSgDPDYtqFkH1NA9BKKigxLSyrV+W0Vnl93IAN9GfjHJ0JWpu6CP81JsB6Y
         h7IVkuFJFMfcdG75BIygBkoLk2pzhXFORXoap+McYukWgxrK2jH/9ipHThgJN4ClRfBU
         5vNQ==
X-Gm-Message-State: AOAM531DYqK8h1nLuBn5tk4HuQmQ+hr5WP1yDWACtI3YJPBDByqI0EjE
        JrP21WYMjZWfu+QFH9dBU8wD9tMNAIAVMUFORlw=
X-Google-Smtp-Source: ABdhPJyYuCBckq8jaCT6ZFG+ViXeufSWTVBmL7saCfLwWfz/eOE7mDkAcujuNGc+euIdxuUWzPJmcvzXYeUKGCdVomM=
X-Received: by 2002:a67:e217:: with SMTP id g23mr5593894vsa.15.1607109562688;
 Fri, 04 Dec 2020 11:19:22 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
 <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
 <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com> <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com>
 <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com> <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com>
 <A88317FA-52CC-41D3-B11A-BFAD36C35AE4@goldelico.com> <CAGngYiUPaR=_1NKZSjUQRK9+zUw3ztUpro7NV-O=sGAC2eOzUw@mail.gmail.com>
 <7702A943-FCC5-416B-B53A-3B0427458915@goldelico.com>
In-Reply-To: <7702A943-FCC5-416B-B53A-3B0427458915@goldelico.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 4 Dec 2020 14:19:11 -0500
Message-ID: <CAGngYiXWKgu+RKvbUWCSy2pDktc8Uj6+PtWi0oc8tAgiDgoUFw@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lukas Wunner <lukas@wunner.de>,
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

On Fri, Dec 4, 2020 at 11:52 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> >> Anyways it is debatable if this is a bug at all. It is just a definition.
> >
> > I respectfully disagree. Prior to the fix, your panel's active-low chip select
> > needed to be described in the devicetree with 'spi-cs-high'. That sounds
> > very much like a bug to me.
>
> It could have been described by ACTIVE_LOW without spi-cs-high but that did
> emit a nasty and not helpful warning on each boot.

That will not work, try it out. You will see that without the bugfix, your chip
select is consistently inverted, no matter how you formulate it in the
devicetree.

>
> I'd prefer if you or maybe Linus could submit such a patch and I am happy to review it.

I cannot help you with that, I'm sorry.
