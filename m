Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142AC2F8D08
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 11:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbhAPKtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 05:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbhAPKte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 05:49:34 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583D2C0613D3;
        Sat, 16 Jan 2021 02:48:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d22so1323492edy.1;
        Sat, 16 Jan 2021 02:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vVAV2XePHMAp0s7Yiv5q7kWKLxtjn7m103v0Dwam/q0=;
        b=PXQibds5sD1CCdc4gIqjYdPWi5W6bJIhw2Z2rqHG3ZNTP/w8WVMh/niocweCDhPXUt
         297ttTnFnfvc/Y/ptFAaSaNoaV7ZlNuV20gpKSvRURDp3NjTETmzTXnq107DgUzYwiRd
         w2e/74v8iDq6ggfewPCJrGyi5rZcaHRI8IdQXtHp5lUS61roZ/VnJJ4y/4CWgMuy/l46
         1ESiw10slrCF3YNgKYKLkINoBGP3IncCW5GP4OXbdtIUrkChRa8R7suziWm3IOi/AmeS
         tGi6QqvMiKeBEX2u6jweVVJFLH+/Xgx7vLDtentUEcfRT/4IrmR6ZziPjWHeIq8RnB1a
         rwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vVAV2XePHMAp0s7Yiv5q7kWKLxtjn7m103v0Dwam/q0=;
        b=j4bMvV+I/UKkK71pCBo8G3bycSAE3UlKhwtymwjfsjnLEMW5Qhx94D3AI8bfQcZASv
         aCAbsDVG6+oAthmOuA8YAfjj90AvgIKEURM6NuLZ9spTbaX5HUMcWXcX+ulqZhl6K2lq
         YMrd5s+uCgD0FsmveqoKVKTejab9UCfIFvdLiT5/za7nIbgXlxiGq+ffzlAoQkUzl4Cw
         adovIco4Ood0H21FxpVics1jvJ5lTVous1OZuydZNGCpeXL2ABTWg6MwgbEoqeX+yuDl
         dFcbpfbWuQlSQ327nZ66rsBqtfgRuFX7aaZkRKeP4t5gXLrE5SI67IuB3mD+RHcNruKJ
         KYvw==
X-Gm-Message-State: AOAM531+b0+/bgytbK/QdM8ivW2WHfX0SOCZfSQh0p9knNK0X9bUc75B
        oWRYu9oKK6Y/do00FNNFgQ83N2dYOlh7S/baobXIIcSB
X-Google-Smtp-Source: ABdhPJyHetLu4LjHwKz2j3RCZb8dr8+ti1xAh1NeVZtXZWDhrpElDnTM7mwDEAh0ENQrKYdyBvowhOn/No/eTrKWLVg=
X-Received: by 2002:a05:6402:1a2f:: with SMTP id be15mr13085277edb.209.1610794133117;
 Sat, 16 Jan 2021 02:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20210115210124.507282-1-adrien.grassein@gmail.com>
 <20210115210124.507282-3-adrien.grassein@gmail.com> <20210116083122.GA3704@kozik-lap>
In-Reply-To: <20210116083122.GA3704@kozik-lap>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Sat, 16 Jan 2021 11:48:42 +0100
Message-ID: <CABkfQAFz2LatEF6S5QXjreTiYy6RWC77ONYEZbOJreegx4yGHA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm64: dts: imx: Add i.mx8mm nitrogen8mm basic dts support
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam. 16 janv. 2021 =C3=A0 09:31, Krzysztof Kozlowski <krzk@kernel.org> a=
 =C3=A9crit :
>
> On Fri, Jan 15, 2021 at 10:01:23PM +0100, Adrien Grassein wrote:
> > Tested with a basic Build Root configuration booting from sdcard.
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 415 ++++++++++++++++++
> >  2 files changed, 416 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_re=
v2.dts
>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Best regards,
> Krzysztof

What is the next step? Should I regenerate the patch set with your review t=
ag?
Thanks a lot for your reviews.

Best regards,
Adrien
