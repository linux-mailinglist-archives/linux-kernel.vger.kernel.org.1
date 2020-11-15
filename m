Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1456F2B3332
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 10:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgKOJW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 04:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgKOJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 04:22:21 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C37C0613D1;
        Sun, 15 Nov 2020 01:22:21 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id 7so20068905ejm.0;
        Sun, 15 Nov 2020 01:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ErxNsuDkpd1W/DgWEjOvUcqQZYKwNOZCjLfy5r+fMW4=;
        b=EiRQv+5WibDnUbF1YEgtIVVn9/cZsIfofXuGl9oIzWePfmtK8bWFCJR4TkWuUfuS+w
         E0uYr+CrVEX85JHkcRN1idUF45nSjh+gHru31LaQ8dN9WiSoI64HvfMufvJ8f7kkkfu+
         CHfjek6MtyQHtl1lwKE8CAq0220jL2woE6SXZg1rrE2SPPhb3u7Su1B8aP1JOjUZFrmr
         qaTTSMfmwV5HTA6n2E41b7nRLzl9I8S3TT974jah7fq9xkxDKZhKV/7iK2fucT4SUg95
         TbOsG43zvqu+EGTg6PxyZFh0whCPzCdDeGgySDyB/EQaGOhL72jH5jEjYaubgx0x+Wia
         IbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErxNsuDkpd1W/DgWEjOvUcqQZYKwNOZCjLfy5r+fMW4=;
        b=O9F0E1QkVbUEjr2FDZ0NVWKMFC4ZEcbAK3WugqfX75eSfLZIuuuhFLOW9fKFpm/sUF
         Uk5i6ncBhZrolwe42V6vesb8jHteKEXc7+RyYikcgi+k1npP9CO1Bbrc4SF6c9UeIqVL
         gGmLYZDXxdQMdeC03Ta+P6zDGmzeANgD25+Hd/uSVU82xY6K1RrvJK26uC1VjCsxP1d5
         O17JXQCHp7QAQv7stRQH9GWftdZvEuk4q1CN3CL2GqCL3Da8817Y6PQGrGX/RtyQBUKS
         rD0rGdL4hgtAwqczauqxjh5P3+Jr3lj7GE6HueCNYcDw17tm35IlFeYiFAETUFpkUPgP
         Oo2g==
X-Gm-Message-State: AOAM5304+qSBaJ0iwBugtSfT0DdEWuLm1nZ79CeLoPwBCJz9oWYU6UX2
        JO9Kyv6sMWl2kThp6qbDlytFRWP3FYQff0e1rCQ=
X-Google-Smtp-Source: ABdhPJwBuH2TYudRTSq4x2ACk4w4Jv5QBQFB7KtV8gD0oxBNII0XyQUEUWfGeLMsNcLBmzBTRATH3faB9L1T+PSsmuo=
X-Received: by 2002:a17:906:3d1:: with SMTP id c17mr9576167eja.187.1605432137878;
 Sun, 15 Nov 2020 01:22:17 -0800 (PST)
MIME-Version: 1.0
References: <20201114200104.4148283-1-martin.blumenstingl@googlemail.com>
 <20201114200104.4148283-2-martin.blumenstingl@googlemail.com> <20201114223250.GI1480543@lunn.ch>
In-Reply-To: <20201114223250.GI1480543@lunn.ch>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 15 Nov 2020 10:22:06 +0100
Message-ID: <CAFBinCAmExHsCpP8hh_K6M6pg8SjoF1WNNj9fwSKR3dhgBGJdA@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/4] dt-bindings: net: dwmac-meson: use picoseconds
 for the RGMII RX delay
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sat, Nov 14, 2020 at 11:32 PM Andrew Lunn <andrew@lunn.ch> wrote:
[...]
> > +        amlogic,rgmii-rx-delay-ps:
> > +          default: 0
> >            description:
> >              The internal RGMII RX clock delay (provided by this IP block) in
> > -            nanoseconds. When phy-mode is set to "rgmii" then the RX delay
> > +            picoseconds. When phy-mode is set to "rgmii" then the RX delay
> >              should be explicitly configured. When the phy-mode is set to
> >              either "rgmii-id" or "rgmii-rxid" the RX clock delay is already
> >              provided by the PHY. Any configuration is ignored when the
> >              phy-mode is set to "rmii".
>
> Hi Martin
>
> I don't think the wording matches what the driver is actually doing:
>
>         if (dwmac->rx_delay_ns == 2)
>                 rx_dly_config = PRG_ETH0_ADJ_ENABLE | PRG_ETH0_ADJ_SETUP;
>         else
>                 rx_dly_config = 0;
>
>         switch (dwmac->phy_mode) {
>         case PHY_INTERFACE_MODE_RGMII:
>                 delay_config = tx_dly_config | rx_dly_config;
>                 break;
>         case PHY_INTERFACE_MODE_RGMII_RXID:
>                 delay_config = tx_dly_config;
>                 break;
>         case PHY_INTERFACE_MODE_RGMII_TXID:
>                 delay_config = rx_dly_config;
>                 break;
>         case PHY_INTERFACE_MODE_RGMII_ID:
>         case PHY_INTERFACE_MODE_RMII:
>                 delay_config = 0;
>                 break;
>
> So rx_delay is used for both rgmii and rgmii-txid. The binding says
> nothing about rgmii-txid.
interesting point here. it's been like this before this patch. still I
would like to understand what the proper way to fix it is so I can
also include a fix for it:
1. should rgmii-txid not add any RX delay on the MAC side? that would
mean for my board I will switch to phy-mode rgmii so the MAC applies
both the RX and TX delays
2. update the documentation to clarify that rgmii-txid would also add
the RX delay on the MAC side

> And while i'm looking at the code, i wonder about this:
>
>        if (rx_dly_config & PRG_ETH0_ADJ_ENABLE) {
>                 if (!dwmac->timing_adj_clk) {
>                         dev_err(dwmac->dev,
>                                 "The timing-adjustment clock is mandatory for the RX delay re-timing\n");
>                         return -EINVAL;
>                 }
>
>                 /* The timing adjustment logic is driven by a separate clock */
>                 ret = meson8b_devm_clk_prepare_enable(dwmac,
>                                                       dwmac->timing_adj_clk);
>                 if (ret) {
>                         dev_err(dwmac->dev,
>                                 "Failed to enable the timing-adjustment clock\n");
>                         return ret;
>                 }
>         }
>
> It looks like it can be that rx_dly_config & PRG_ETH0_ADJ_ENABLE is
> true, so the clock is enabled, but delay_config does not contain
> rx_delay_config, so it is pointless turning it on.
that is a good point and also a bug with one of the previous patches
I'll include a patch fixing this in v2


Best regards,
Martin
