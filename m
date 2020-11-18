Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F09A2B7CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgKRLi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:38:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55972 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgKRLi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:38:59 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AIBceQe046222;
        Wed, 18 Nov 2020 05:38:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605699521;
        bh=4YucAyhX/ELbMr/rm1+j/T5/nZFqAzSL3QRJp308EJI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aMIba3Hiatz7deLZvxRcLo9qNfLYEU6VL3N/CerqRcoqc2/pkvsAccIoG7v0oxQuS
         29IwUCVzwyG1l6j74x/fMGt5BMb58XflGRBT/36xmcAwQ7KTupD/YpFrYTMlX++bGU
         YePfK2ltvQX/GMVqsE1ywwcIzObV60d8T1ZJhckg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AIBcekd026378
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 05:38:40 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 18
 Nov 2020 05:38:40 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 18 Nov 2020 05:38:40 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AIBccQp026067;
        Wed, 18 Nov 2020 05:38:38 -0600
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3: squelch warnings regarding no
 #address-cells for interrupt-controller
To:     Sekhar Nori <nsekhar@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Andre Przywara <andre.przywara@arm.com>
References: <20201117161942.38754-1-nsekhar@ti.com>
 <20201117161942.38754-3-nsekhar@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <ab9658ef-c8a7-155b-acb1-effa872132ca@ti.com>
Date:   Wed, 18 Nov 2020 13:38:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117161942.38754-3-nsekhar@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 17/11/2020 18:19, Sekhar Nori wrote:
> With dtc 1.6.0, building TI device-tree files with W=2 results in warnings
> like below for all interrupt controllers.
> 
> /bus@100000/bus@30000000/interrupt-controller1: Missing #address-cells in interrupt provider
> 
> Fix these by adding #address-cells = <0>; for all interrupt controllers in
> TI device-tree files. Any other #address-cells value is really only needed
> if interrupt-map property is being used (which is not the case for existing
> TI device-tree files)
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi              |  5 +++++
>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi            |  2 ++
>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts        |  1 +
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi             |  3 +++
>   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi       |  1 +
>   arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts |  1 +
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi             | 11 +++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi       |  3 +++
>   8 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index aa8725db0187..55aaa1404d7d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -440,6 +440,7 @@
>   		interrupt-controller;
>   		interrupt-parent = <&gic500>;
>   		#interrupt-cells = <1>;
> +		#address-cells = <0>;
Does it really required or mandatory to have #address-cells = <0>; defined for interrupt-controller DT nodes which
do not have child nodes and no "interrupt-map"?

-- 
Best regards,
grygorii
