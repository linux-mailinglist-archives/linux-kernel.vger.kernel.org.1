Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BE12E0A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgLVN00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgLVN0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:26:25 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1CBC0613D3;
        Tue, 22 Dec 2020 05:25:45 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x20so31860268lfe.12;
        Tue, 22 Dec 2020 05:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCkfsLtgF20+UjWXYeRABeA5CudYBgLQkf9EDb+O2tU=;
        b=Omjr5BH1sBV2wzA9JhFuTPsUkfIbgz+KDCeYKpEodOcWiXQa4hF5Le244PFScYpnsH
         6IVR6fVAHtFoDCHDlFMGsILHjTh3PzBUwvw5Oxw3MByJpNVdVVt3VVzolPXO+kmGeges
         LJ+BA3twF6yNuCVvdTSypNZlyQe7jf6xcbO5bMjkPTuJpvp2q+9AcP5iFczo2CChHg78
         09ITbKxdouXyzZ96L69KgyLr2yXUpoP9vdZ6e8scmIZJMjaZwnnJr3sZCToiOBrp99Mo
         WDx3d0l+D9l/5ya0QjZjQoVw/WefnSKnlsoWQBh3icw9yiHlYhxuzWOBzDiKoSVPjSi+
         cvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCkfsLtgF20+UjWXYeRABeA5CudYBgLQkf9EDb+O2tU=;
        b=hXsupSoS7kuRE33RnZUT/+S8T9e+xnmzyHEoAi5wZNN4K20eF4aQERCoMPcx8S99wJ
         Lz8dwDus0D6g8HcG9a3v0j7rxvJ6mfdpLFRX2dcCDgxtfu2jtk+73SEKut/xyg+x6g/w
         CjKbsWAk/lls9YZWcC//G+/tDRMlooV7WS62n/m0RCIZBocZTHvdAOijkZt8L9Ck0Q17
         ePCAbIj28sFl/dJP2XYJvccEDxAk8gUh4CyGZcwgsUTBTGbm9P6kHxIci9EVOeUAHtBt
         f11VZZ3zhZBYIShyFflqBaVkeoFLsI9KJ3WDn9bw8uYzOQ3mtH7G1kCHjQdJ1dwREHGi
         Gqkg==
X-Gm-Message-State: AOAM533CeuOp6Nfzseg3bZrU70o/5JNfxTmsrhFeZ5e9FWLd+VHAnDtO
        YOVpxnpumoWn9gdF4p/8OL+rvDjGhLZYy7Pc2xs=
X-Google-Smtp-Source: ABdhPJwSDDz4TE6sadCDI/RecsWsWwtUR1aurcIP7xOgVOCztaHDjYL3sBqGPY1fgydumKDd9nc51zG5zXHB/E95oHw=
X-Received: by 2002:a05:6512:1102:: with SMTP id l2mr8472685lfg.500.1608643543723;
 Tue, 22 Dec 2020 05:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20201222081057.26401-1-alice.guo@oss.nxp.com> <20201222081057.26401-4-alice.guo@oss.nxp.com>
In-Reply-To: <20201222081057.26401-4-alice.guo@oss.nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 22 Dec 2020 10:25:32 -0300
Message-ID: <CAOMZO5C2L1R1YrnoHL19ztCA5kzOLYQHC2OY2LFi2Lh8sbv24Q@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] soc: imx8m: change to use platform driver
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alice,

On Tue, Dec 22, 2020 at 5:11 AM Alice Guo (OSS) <alice.guo@oss.nxp.com> wrote:

> -       soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> -       soc_uid <<= 32;
> -       soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
> +       if (dev) {
> +               int ret = 0;

No need to initialize ret to 0.

> -       imx8mm_soc_uid();
> +       if (dev) {
> +               int ret = 0;

Ditto.


> +/* Retain device_initcall is for backward compatibility with DTS. */
> +static int __init imx8_soc_init(void)
> +{
> +       int ret = 0;

Ditto.

> +
> +       if (of_find_matching_node_and_match(NULL, imx8_soc_match, NULL))
> +               return 0;
> +
> +       ret = imx8_soc_info(NULL);
> +       return ret;

Or you could even get rid of 'ret' and return imx8_soc_info() directly.
