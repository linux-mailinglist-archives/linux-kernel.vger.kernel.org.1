Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4712A748D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbgKEBId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:08:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbgKEBId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:08:33 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9362620867;
        Thu,  5 Nov 2020 01:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604538512;
        bh=F44ZtY18hsnG66Zem9ryB3BNhKhU5/IfeUedU0qYqEY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=amBd6YyF4Eamh1TVZzJTg6BYrqidEHdWRiOLkqL5eyBq+wsNYPHmO4EUhlY3osp1q
         eEPn+HxKINCJFMwluV+HKzHltlVl/006j9fOUvnIqcztB+ZJXco/sZI1KOdLr9o9YL
         pXVhaoHg1yKxHX+FlAUSRbbVg8Ncf9NWBQpJJ8EM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1604402306-5348-10-git-send-email-abel.vesa@nxp.com>
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com> <1604402306-5348-10-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH v5 09/14] Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Adam Ford <aford173@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Wed, 04 Nov 2020 17:08:31 -0800
Message-ID: <160453851108.3965362.14457504906781672799@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2020-11-03 03:18:21)
> Document the i.MX BLK_CTL with its devicetree properties.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

> diff --git a/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctl.yaml=
 b/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctl.yaml
> new file mode 100644
> index 00000000..5e9eb40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctl.yaml
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mp-clock.h>

Is this include to make sure this file exists?

> +
> +    audio_blk_ctl: clock-controller@30e20000 {
> +       compatible =3D "fsl,imx8mp-audio-blk-ctl", "syscon";
> +       reg =3D <0x30e20000 0x10000>;
> +       power-domains =3D <&audiomix_pd>;
> +
> +       #clock-cells =3D <1>;
