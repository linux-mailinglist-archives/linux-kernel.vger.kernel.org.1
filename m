Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD97F25F633
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 11:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgIGJTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 05:19:33 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44456 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgIGJTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:19:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0879JQYN065338;
        Mon, 7 Sep 2020 04:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599470366;
        bh=0RqFeHM/lNOKqWc0wF2Z2GZrqPS9GVJEXQpgT51Xbhs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nN3Q4/ZmWeEff58ufBoeqbBh8swZIbVqdy0EusPEg0q55JGAAO76xzb77MATVihzP
         fCx1DCZEcmhQTZyM6dZnWiL4V4gVsXwUz9RwdsvNWFKkZsagpZWi8F1hNYIeLUXnYh
         heU4CgoujMp/p3+5nClNjrQf0ombXHTace0enzNc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0879JQC2127733
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 04:19:26 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 04:19:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 04:19:25 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0879JNqT025498;
        Mon, 7 Sep 2020 04:19:23 -0500
Subject: Re: [PATCH 0/4] arm64: dts: ti: k3-j7200: add dma and mcu cpsw
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>, Suman Anna <s-anna@ti.com>
References: <20200904233830.11370-1-grygorii.strashko@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <a45c476b-ea58-49dc-e08a-f4f0f0594470@ti.com>
Date:   Mon, 7 Sep 2020 12:21:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200904233830.11370-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grygorii,

On 05/09/2020 2.38, Grygorii Strashko wrote:
> Hi All,
>=20
> arm64: dts: ti: k3-j7200: add dma and mcu cpsw nodes
>=20
> This series adds DT nodes for TI J7200 SoC
> - INTR/INTA, Ringacc and UDMA nodes for Main and MCU NAVSS, which are c=
ompatible
>   with J721E Soc, to enable DMA support
> - MCU CPSW2g DT nodes to enable networking
>=20
> This series depends on:
>  - [PATCH v2 0/4] arm64: Initial support for Texas Instrument's J7200 P=
latform [1]
>    from: Lokesh Vutla <lokeshvutla@ti.com>
>  - [PATCH] soc: ti: k3-socinfo: Add entry for J7200 [2]
>    from: Peter Ujfalusi <peter.ujfalusi@ti.com>

you also need to pick:
[PATCH] dmaengine: ti: k3-udma: Use soc_device_match() for SoC dependent =
parameters [3]

>=20
> [1] https://lore.kernel.org/linux-arm-kernel/20200827065144.17683-1-lok=
eshvutla@ti.com/T/#m141ae4d0dd818518c00c81806d689983d6e832e6
> [2] https://lore.kernel.org/patchwork/patch/1283230/

[3] https://lore.kernel.org/lkml/20200904120009.30941-1-peter.ujfalusi@ti=
=2Ecom/

>=20
> Grygorii Strashko (3):
>   arm64: dts: ti: k3-j7200-main: add main navss cpts node
>   arm64: dts: ti: k3-j7200-mcu: add mcu cpsw nuss node
>   arm64: dts: ti: k3-j7200-common-proc-board: add mcu cpsw nuss pinmux
>     and phy defs
>=20
> Peter Ujfalusi (1):
>   arm64: dts: ti: k3-j7200: add DMA support
>=20
>  .../dts/ti/k3-j7200-common-proc-board.dts     |  45 +++++++
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  73 +++++++++++
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 118 ++++++++++++++++++=

>  3 files changed, 236 insertions(+)
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/=
Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

