Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BF62723A4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgIUMTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:19:21 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:47061 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726644AbgIUMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:19:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 21C79C26;
        Mon, 21 Sep 2020 08:19:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 21 Sep 2020 08:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=R
        WGB3kQwS4UVvzWHdDn8Ci1w6Q77eoO4fhwFkpqB4wM=; b=bY6GHXUiOjBynVHuY
        2IoDn2xZPx55HzvghGQmjJeIwAo/4OJw/0IUUTZroCbzXToszaNScpcvSf1ILKlq
        NeQCfMDQ1nTt/fKO76y3PL1ziylc5jUK8Ed+mG+lG3EpsLidvl1fx4RVSoNPiwbY
        pKr03w2K0s0K6RiYz4i6r/DIs6kNaQIAyNvDH7bcVB99w7fiBB0hJoSqYaJHRDEG
        f7KPIo0cPgfDmqBgfUejLJQRfXu6b9QD3lpEM/KeBBvWOoOvm3KP/GhOXHhbPe3e
        NDwhsOxAShPk9rStRAqg3v8x441WCglqoMXe4LMx4it8X9exCE40VzkHsN6B/Kw+
        Ymi8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=RWGB3kQwS4UVvzWHdDn8Ci1w6Q77eoO4fhwFkpqB4
        wM=; b=JVp/bfw39wLOtqFQJ2/eeho4Nn2oKPOOwrh/xxPjI4egNEsPgyVKKRK2s
        5O+R6CLPKmMqoASKBzMbCiLvZJnI4LuMIywYFp/YkP3SVB27nqc+R2xZTPSIM20p
        GZwsmQ3QG6hseoKOh+tReFiG1VP1tgmx1i9v5qQ3NV15iiAAzhmotEAZFm4AzSFa
        Rn7ntSQD5PasoxxiQldUAXl4KbeG66m9GbIqeU17kgLYOLPUCZCgWhQps0Xu+RSw
        sAqE0O9u/1L4mh9rMw0AUJjSUMRVl/sqW/18B1Oanfg0c0DgePVJk2zPhpazp8wz
        /E2ocF0RYnwGVbH16spIjocvPzdPQ==
X-ME-Sender: <xms:R5poX2FcLyFjDSFctxKmoOZM29DHBSPLEuRHdnworXN0AALVywP0uw>
    <xme:R5poX3WXiz2awy4Of4SkoObSZtLZSOwGrWCG9ph26jMI72dwFcH0-faRO1opoZCct
    dsz5LnqOMLNspuety8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfejtedtjefggfffvdetuedthedtheegheeuteekfeeghfdtteejkeeludeg
    vddunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:R5poXwLzvquoCEO2jL3FZnOvNSd0kiGlL60EzWo-qYF9NM_XITz5dw>
    <xmx:R5poXwGwXLVtfAfVV714ZXiNVIzRg3ctqT1p75JrG-tuRbX--zn_zg>
    <xmx:R5poX8Wax9mD2FUKJZa48E0O74RrdmXTLziU8A5rONbW313VA1zR3A>
    <xmx:R5poX3davxxYuVpqJeE16kKeoqAX2M8CPJfUIRio6Cd5oZcc0Fo-pQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DABC03280064;
        Mon, 21 Sep 2020 08:19:18 -0400 (EDT)
Date:   Mon, 21 Sep 2020 14:19:17 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2] documentation: arm: sunxi: Allwinner H2+/H3 update
Message-ID: <20200921121917.7heubzzlj3m3fjbl@gilmour.lan>
References: <20200914041945.GA3500@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200914041945.GA3500@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 06:19:45AM +0200, Wilken Gottwalt wrote:
> Updated information about H2+ and H3 differences and added a link to a
> slightly newer datasheet.
>=20
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
> ---
> Changes in v2:
>         - addressed comments/proposals from Maxime
> ---
>  Documentation/arm/sunxi.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/arm/sunxi.rst b/Documentation/arm/sunxi.rst
> index b037428aee98..19d78eea31a9 100644
> --- a/Documentation/arm/sunxi.rst
> +++ b/Documentation/arm/sunxi.rst
> @@ -103,12 +103,14 @@ SunXi family
> =20
>          * No document available now, but is known to be working properly=
 with
>            H3 drivers and memory map.
> +        * The changes compared to a H3 are a downgraded GMAC to a 100MBi=
t MAC
> +          and the display engine (DE) not having support for 4k.

Like I said in the previous review, the point of that file isn't really
to list the differences between SoCs.

Maxime
