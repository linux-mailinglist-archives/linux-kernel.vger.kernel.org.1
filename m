Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C33B2DD082
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 12:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgLQLiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 06:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgLQLix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 06:38:53 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64725C061794;
        Thu, 17 Dec 2020 03:38:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id h205so13007676lfd.5;
        Thu, 17 Dec 2020 03:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RZrFgFox88GscJTzprvpE24EKAbg6Vl9s4wji6xqGr8=;
        b=kmnrCqqnXaiD+iili8Eg1WIT7TbWInxvWY5G6wV7xNW7f8Tjp1/lFuVKVagoP8tuoG
         2Ml64aESf81U/v/Sj3w8REorf14EUry9+h+VgiDDeNsJvxNMXHrmnpaLKHU2t4GHsSqE
         2dlVxD4EN2aYW4eeagHqo4IsRnlXYiSP5Yu6R8Y3JMABJQ9Xbw7KEdN0Z0iNFouamu2q
         QAS5/AlFyQD3KEvu3fWxyBSmId9B9vFVw0U5wc6JNSh5uexP1Pfngy8Nc+bKrGX+3X25
         2w9ljAiKultGDKtvZA2wpmh0LzXCcZKeF4Jv1lsfh/7fK555VDEITf2STu1AVHDUNjMK
         Mc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RZrFgFox88GscJTzprvpE24EKAbg6Vl9s4wji6xqGr8=;
        b=Xt/VV+U1TzCNf+KQ9BpgpTdXsPIqrNXAdbA9rn6L3AbF61QxgY037f8Xm+/tQ+G9fU
         fNJxJy42BX1QTnWr+StrKTtH3ZD7vKoGQj+TGKoXUNOyPPRLdqcyx1SRyoXqVNTG6C3J
         GojbCIXrfrqJ/2A1EdOp/olS7CJQybju6NF6sMND3FfoHfqkR77VKOxtrLaY35X5oyHs
         E3mOZZT/jckv/NYUr11nmDjPORG4F1YhSV7R1+zELJ9zjxjCY27OgkSK886AAKygvBp+
         6/Ml5pao+jKCdaD8rjoGn3sihq5ReLQe2kztK/uHdWOibWceDBpsSd57z6LX3wrALG/e
         T5/Q==
X-Gm-Message-State: AOAM532Pi9cN124earSQphGxcnbTrKx07dyEqv3L8J1mJ/RHEdJ6LSCQ
        /kWUhQEn/92X56BItvkP0CKLDaXaAcRenNnndTE=
X-Google-Smtp-Source: ABdhPJwSojLD9W4YcmNB2NeQRlOUH49d3KXyRl/9UWmyxBpBfw4WNxQBGaKHB61MLYkW/CXj4KUKwxf9aI2roUXmJVw=
X-Received: by 2002:a2e:8416:: with SMTP id z22mr17240339ljg.347.1608205091903;
 Thu, 17 Dec 2020 03:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20201217104905.25369-1-sebastien.szymanski@armadeus.com>
In-Reply-To: <20201217104905.25369-1-sebastien.szymanski@armadeus.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 17 Dec 2020 08:38:00 -0300
Message-ID: <CAOMZO5Dc-i5GdCYB6YrNXUt5HsOoaUCXPiZT630JF8+9pQ9fXA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: opos6ul: add ksz8081 phy properties
To:     =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 7:49 AM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
>
> Set clock mode and the LED mode in the device tree instead of relying on
> the fixup in mach-imx6ul.
>
> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com=
>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
