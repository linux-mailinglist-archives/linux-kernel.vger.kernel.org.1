Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FE92FA3EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393166AbhARPAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393064AbhARPAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:00:10 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639FFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:59:29 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id b5so7650456ejv.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSBE4jHyV0yiGAPlv7yUlmbeiPPVBYbZTBnxyeVqKhc=;
        b=WimftGn8DrHzzSkaIaeyHp4Rf5wrkFzQejolh5k7FrvTM1X4tQJfL6BPb0pntGz5jU
         rtis3d7qLkXwTnZ5Tx904Tmlx9JxRGOiLxQfHo9Xwf3G6ebDePuOuAbmEudqlWIgpKH3
         wAaDjsOriul24e2cFyWZJa1xIFzJ5Tu2vWnjXgx8gqcU3GlCpQ3CwbO6ka7jUCCoTj9S
         naNB+8tAa2C/krD+3BFO+Ri5/sPlH+nxGyXWmMo9A1D6Sj8LFoMEmXyp76OSZkPloVe8
         ZVRWa+2RG6siOwJdiU3Qh9JpKK2Mx30aqtBYekBA70fIzUkvnuudh6Vdtw5WNHXS8Nxv
         ETJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSBE4jHyV0yiGAPlv7yUlmbeiPPVBYbZTBnxyeVqKhc=;
        b=mXeHV6BP3CVfC5hXhKkHom539vmHgKfQ+EKDgUO2eTXOvknwzeMD8qDnkwTH9NzfwZ
         r8HRxLgw2Pt7LPSvrF6iIzKGbcw0z43oOgFWM8omR7/mkZgJ9u8mXMDEFg54H3DRmHuC
         1WOsluCpCofovokBkhvrarTteiCiL1Su+RJUmgJ4Yq5oBgZlSEBw0ivUbNTRsNOG58Fl
         058N+k40Cw3PcQncMjgcuspQWb+UaEbfuUyaM4j6EXTtC5F7kGyACTMMjEyDW1eUeXWH
         v70LeJCQOSN4ssfc3OjEmg1X2jZIq0Q0D0p4a8BVPwj+bCN+3+SHNQyMtEkqFyGWzxiW
         tiuw==
X-Gm-Message-State: AOAM532Zi1RQFuQQauidLgl/czj5J054agFw798UQW4PshmjSU0FXIT0
        3zQYIqixZLlJ4uL6B4A1XdJ2gatAslhRl/sH0ruMNA==
X-Google-Smtp-Source: ABdhPJwI73VNVTnVNFqoeKDEdVqoH328eZPX4L/8TfI3OnSMbLTmqOtJyvigmGCGUUyH0NQs8m/gMD5eGsq/Db7OWWY=
X-Received: by 2002:a17:906:388b:: with SMTP id q11mr46695ejd.421.1610981968099;
 Mon, 18 Jan 2021 06:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com> <20210114131622.8951-5-chiawei_wang@aspeedtech.com>
In-Reply-To: <20210114131622.8951-5-chiawei_wang@aspeedtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jan 2021 15:59:16 +0100
Message-ID: <CACRpkdbqJuKHH+sR3LfWV72kM7TEhimFVi1viuQGkP8DWOODow@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] pinctrl: aspeed-g5: Adapt to new LPC device tree layout
To:     "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Corey Minyard <minyard@acm.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        BMC-SW@aspeedtech.com, haiyue.wang@linux.intel.com,
        cyrilbur@gmail.com, Robert Lippert <rlippert@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 2:17 PM Chia-Wei, Wang
<chiawei_wang@aspeedtech.com> wrote:

> Add check against LPC device v2 compatible string to
> ensure that the fixed device tree layout is adopted.
> The LPC register offsets are also fixed accordingly.
>
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I suppose the patches need to go in together. Tell me if you
need me to apply this one patch to the pinctrl tree.

Yours,
Linus Walleij
