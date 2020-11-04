Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A115B2A5F1D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgKDIHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgKDIHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:07:05 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD70223BD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604477224;
        bh=7VyqtWHJeZ+40fVThxDMretRiB8PwKZnq3E4EmKuzWY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mjvHb3jUBnA2Q51Tbs90/HuPPB84+55xUFwd0J1l55eyB/mmt0S6S2JBTlKfy1YUP
         vhYA9ZZdZbjoWRlPmDF15LbZQWzzHjWbKlZ7aSuPk+nEElJVmg4/m313+kDaRHpKnH
         an8BEUYHFDYC89BWGoRc5dRsWkwXzuqIdBVdQYYI=
Received: by mail-ej1-f48.google.com with SMTP id cw8so14899409ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 00:07:04 -0800 (PST)
X-Gm-Message-State: AOAM531R/JxDf/PTaRSOsV3qLt6IOtx1/97M4iHyE/rHbFkiOp+CeOTF
        yi1eRevUKaWQGcMBCuDHr+b6NY55+u7wE3py2oU=
X-Google-Smtp-Source: ABdhPJzDXEV14pE+349c1ryqIOkjjNPeB8I0zUN563CFTNOP3RKSdwcDqL92v3V9zYOis1XIvQm3cqpl7scrC73Epl4=
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr23258203ejx.215.1604477222748;
 Wed, 04 Nov 2020 00:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20201104030645.12931-1-alice.guo@nxp.com> <20201104030645.12931-4-alice.guo@nxp.com>
In-Reply-To: <20201104030645.12931-4-alice.guo@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Nov 2020 09:06:50 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdP0=XW0c8briEoCoa3QG19esinycZhORR=M986fTCU0A@mail.gmail.com>
Message-ID: <CAJKOXPdP0=XW0c8briEoCoa3QG19esinycZhORR=M986fTCU0A@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] LF-2571-3 arm64: dts: imx8m: add nvmem-cell
 related stuff
To:     Alice Guo <alice.guo@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, peng.fan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 at 04:12, Alice Guo <alice.guo@nxp.com> wrote:
>
> Add nvmem-cell related stuff for the soc unique ID.

Subject and commit msg: please do not add "stuff" but describe what
are you adding and why (what is the purpose, feature, benefit).
"Stuff" is too generic.

>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 ++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 6 ++++++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
>  4 files changed, 24 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index ec71a5e8a062..b45dfe133ec7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -261,6 +261,8 @@
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges = <0x0 0x0 0x0 0x3e000000>;
> +               nvmem-cells = <&imx8mm_uid>;
> +               nvmem-cell-names = "soc_unique_id";
>
>                 aips1: bus@30000000 {
>                         compatible = "fsl,aips-bus", "simple-bus";
> @@ -475,6 +477,10 @@
>                                 #address-cells = <1>;
>                                 #size-cells = <1>;
>
> +                               imx8mm_uid: unique_id@410 {
> +                                       reg = <4 8>;

Register addresses and sizes are by convention in hex.

Best regards,
Krzysztof
