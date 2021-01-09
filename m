Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E2F2F033B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 20:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbhAITvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 14:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbhAITvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 14:51:07 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A480C061786;
        Sat,  9 Jan 2021 11:50:26 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o17so31324094lfg.4;
        Sat, 09 Jan 2021 11:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90h6u6NEXoAjvBz5SiuDv5lzfMQsyI/BMoucq4nIbBY=;
        b=jhPa+fvv0wDng1qLoWJY+dCaeWTjIbiYV4BTiFJqSe8o3OVXk69fZ4AWZKbbpy0fPt
         nv2Eody+/0vyFVKBsWrCS35Z889VLlFnp4xXX2JYX5MhEFth8x4qLDWZ6HsBteT8n4yq
         cFgnuup6zYixWZlLnCoN5ltV906CIEXbb80S4eO2p6s4qqol0aVrq/I6w8iY5hntkc+i
         ZW1QeVJYrMY9HAqtrQSzrE0DpKBsuFiYHieztupeEgDQfaoPqoziy51tQLLwj5VUgj8z
         dT/zfpJsEl+13VFpBiyE+lSoDBXnQ2rIra3MVH70GieSunkssOyKe/zjdker9/bfjplD
         LQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90h6u6NEXoAjvBz5SiuDv5lzfMQsyI/BMoucq4nIbBY=;
        b=l2pWDrJdPN/sRFNOyHDvkBw3olEGs6Ycn+c2OD64g3a47JYj/KGk18sknsPAp/gy8u
         d3DTEvbYDb9ilQry/kTbcshiM+cLiH/scTRWkbxEBKnYOIiA1pMA2ij9tUF+a+6iUJjr
         D98ERdVchycRNH6Q5icY9MidoOSnvgpFq9Wmt4Y7ZdOCwRP3LpjdTKL+ztu6/fTMbxBj
         nHQeOK1/2tbFhgK5QQ5xeD6Gzyo0s2RSi2p7DfcQTZ4GQHX2wlkJ0SBJakBka6Tm3tfN
         58XMYUfysidhQnpAOkk6h/WUPkQqB+B1eHc6Yhj8SklMe6Ye4H+3dfVsnADswORhcwhp
         yZSQ==
X-Gm-Message-State: AOAM530xvulBqmVUlDIxzngRByA3IF2fxQqChOoGen7P3AAWeWg15Q34
        fE0oo/ikAcJnY5RHXrJX5RVTzGPC8YwhXtQWNKo=
X-Google-Smtp-Source: ABdhPJy44C/80af2LtzqZG0g+xoxXGIdcDk8aAzJ5odXqXmiautkoBndMShpev6WNngDNFkh/sn77MsGYogn/Bmpi48=
X-Received: by 2002:a2e:8750:: with SMTP id q16mr4335062ljj.53.1610221824894;
 Sat, 09 Jan 2021 11:50:24 -0800 (PST)
MIME-Version: 1.0
References: <1610144511-19018-1-git-send-email-oliver.graute@gmail.com> <1610144511-19018-2-git-send-email-oliver.graute@gmail.com>
In-Reply-To: <1610144511-19018-2-git-send-email-oliver.graute@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 9 Jan 2021 16:50:13 -0300
Message-ID: <CAOMZO5Aj2wTEadNNhJi4h4RcubpLP08_0p9L-crY0+cV_W9GVQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] ARM: dts: imx6ul: Add Variscite DART-6UL SoM support
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>, parthitce@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Fri, Jan 8, 2021 at 7:22 PM Oliver Graute <oliver.graute@gmail.com> wrote:

> +&fec1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_enet1>;
> +       phy-mode = "rmii";
> +       phy-handle = <&ethphy0>;
> +       phy-reset-gpios=<&gpio5 10 1>;
> +       phy-reset-duration=<100>;

These properties are obsolete. Please describe the Ethernet PHY reset
inside the ethernet-phy nodes as per:
Documentation/devicetree/bindings/net/ethernet-phy.yaml

> +       phy-reset-on-resume;

This property does not exist.
