Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5DD27A97E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgI1I0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:26:08 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60617 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbgI1I0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:26:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 40A43580337;
        Mon, 28 Sep 2020 04:20:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 04:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=bixeI4z/Tx3lM/3t0n5bNHbdn38
        15ed3FVCipXmzsAU=; b=Rgce63ZKkJ/T3RrowNF4L4Q3kmxBOOZfuK+JaybTVRT
        s8qklFUBkrmiKyxKCd4FxOwnXw15cQ/7f7CwlheHLtRwzSygn+p06iVZeTSNEFWf
        uNw86PQqnLPlTR4s72NAoUkDXE4O79sj3mjUK72IQVuYo2spXKQz44GYJSRdM/Y6
        a4DcG2moWyt6CLVvLYnWhaHZlaVQ443Ibkt5FpEjYTpQFAwwCHUQPv0fZ8aL9wke
        ViqY4IQGL4ctJUeKRh026DWMwEcVTW2OJtnkhhllreFq17J6lk6e3yJOFo159Zqv
        OAOYV/QCZbyOwT5TNFDxZr0uwO5FVm9Caahu7NldE0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=bixeI4
        z/Tx3lM/3t0n5bNHbdn3815ed3FVCipXmzsAU=; b=POCJp1WNMFUWDYGWrH5XK4
        d7qgz1s+jPfWhBF/QtQS/28LpIAyeHNDfo/o1xtBE60qpuLGyrQIDBnAnEVWa2Pg
        Ujz/GwQcCb2qYIYTdfp3cqM3qcKaVvNYq89KY0OYZRU6ltNlJw2lTAHe+695ATvU
        NaNBeWcKrrytuuTwx1+OV5MbP5cUZdHvCx+jRz+HCuVbxgGyUWtVS39apm03Gose
        kHy2wuJO4ea6phva4wa/3TjuMUXZReC0014aLrH8PZETIpBMqPlTZGndIy7HwHVE
        w5DOczx3+a6fCSel7zK48rJYtxbZ6+BNxnd/OgpYVHo6tiKxxSqntoUdqnaIiTcA
        ==
X-ME-Sender: <xms:z5xxX4eCtpu7lzZrInOCWR9NNTl8qj_DDrQvSddNQ1aP8VNvR6REUw>
    <xme:z5xxX6P5ZPQbuNWZNVaaqs6INu7A6tQC8GxfU132mROz4dTXokbnk2gbu2vknsyIG
    qk-neYGb6p8p8B36j0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeffteetveeijeetuefhffegkeetgffhieelheehtdduudethffhjedtvddtudel
    vdenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:z5xxX5gU6zoJpQcNvA1Hgfcw5B4DMWnkj2HfMZNqp_WHL9GYLKBa3g>
    <xmx:z5xxX9_Am1vsbnU0E4mfUeEU5yY06ALMlazOEt_be6ZpJsKPZAawCA>
    <xmx:z5xxX0s9cVxozOzr451vgxUPEIsvuFgUXpGlsHHBr1X2T_V6wObCRA>
    <xmx:0JxxXyBTaFhMvV_e1Wyki_Ywby_11yekfsQu5JaLy9mJa8oF5biB3Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B7F7306467E;
        Mon, 28 Sep 2020 04:20:31 -0400 (EDT)
Date:   Mon, 28 Sep 2020 10:20:29 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC v7 5/6] dt-bindings: display: add Unisoc's mipi
 dsi&dphy bindings
Message-ID: <20200928082029.cohvqu5zf3uiqz4a@gilmour.lan>
References: <1601274460-7866-1-git-send-email-kevin3.tang@gmail.com>
 <1601274460-7866-6-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7d5qhqeqot6eoq5f"
Content-Disposition: inline
In-Reply-To: <1601274460-7866-6-git-send-email-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7d5qhqeqot6eoq5f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon, Sep 28, 2020 at 02:27:39PM +0800, Kevin Tang wrote:
> From: Kevin Tang <kevin.tang@unisoc.com>
>=20
> Adds MIPI DSI Master and MIPI DSI-PHY (D-PHY)
> support for Unisoc's display subsystem.
>=20
> RFC v7:
>   - Fix DTC unit name warnings
>   - Fix the problem of maintainers
>=20
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  .../display/sprd/sprd,sharkl3-dsi-host.yaml        | 98 ++++++++++++++++=
++++++
>  .../display/sprd/sprd,sharkl3-dsi-phy.yaml         | 75 +++++++++++++++++
>  2 files changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,s=
harkl3-dsi-host.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,s=
harkl3-dsi-phy.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-=
dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3=
-dsi-host.yaml
> new file mode 100644
> index 0000000..b6bbf67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-hos=
t.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dsi-host.ya=
ml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc MIPI DSI Controller
> +
> +maintainers:
> +  - Kevin Tang <kevin.tang@unisoc.com>
> +
> +properties:
> +  compatible:
> +    const: sprd,sharkl3-dsi-host
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      Physical base address and length of the registers set for the devi=
ce.
> +
> +  interrupts:
> +    maxItems: 2
> +    description:
> +      Should contain DSI interrupt.
> +
> +  clocks:
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: clk_src_96m
> +
> +  power-domains:
> +    maxItems: 1
> +    description: A phandle to DSIM power domain node
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  port@0:
> +    type: object
> +    description:
> +      A port node with endpoint definitions as defined in
> +      Documentation/devicetree/bindings/media/video-interfaces.txt.
> +      That port should be the input endpoint, usually coming from
> +      the associated DPU.
> +  port@1:
> +    type: object
> +    description:
> +      A port node with endpoint definitions as defined in
> +      Documentation/devicetree/bindings/media/video-interfaces.txt.
> +      That port should be the output endpoint, usually output to
> +      the associated DPHY.

Is there a specific reason you don't follow the OF-graph and have a
ports subnode with your two port@X in there?

Maxime

--7d5qhqeqot6eoq5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3GczQAKCRDj7w1vZxhR
xaEhAPoDwZxD/133V+O4UvvxlCA2w7GoDA0azjp49ZAg91P0cAD/bsePZrvlU2gX
NCA1N4MmNff7GhGySuL7p74K0xGS2Q8=
=5iWP
-----END PGP SIGNATURE-----

--7d5qhqeqot6eoq5f--
