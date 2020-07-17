Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D22235EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 09:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGQHaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 03:30:39 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41760 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgGQHaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:30:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06H7UZHx090921;
        Fri, 17 Jul 2020 02:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594971035;
        bh=slMzXhUP249mzmZbpOwr8uOld3NxBNL4t6lPVDC4ux0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=w0B5ewzoG6MGoi8yAq+YzsJeRRpeh64XX6voRVEvP48LzNqFBChe7EWw+ti5vaqD6
         7eDx46ls34f2FfaqhYj6RYFiMwA8bLIfkiVzd5TP/pWfDjSFl2wivSYviID6b3Cl6c
         zhG2I6bYxku56tHxX1ToDHvxJ7NGqO/VYuD8lZos=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06H7UZHh100384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 02:30:35 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 02:30:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 02:30:35 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06H7UWl1078878;
        Fri, 17 Jul 2020 02:30:33 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am65/j721e-main: rename gic-its node
 to msi-controller
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>
References: <20200626183437.23330-1-grygorii.strashko@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <816e1def-1b52-1220-d5be-787458296d70@ti.com>
Date:   Fri, 17 Jul 2020 10:30:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626183437.23330-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2020 21:34, Grygorii Strashko wrote:
> The preferable name for gic-its is msi-controller, so rename it to fix
> dtbs_check warning:
> 
> k3-j721e-common-proc-board.dt.yaml: interrupt-controller@1800000:
> gic-its@1820000: False schema does not allow {'compatible':
> ['arm,gic-v3-its'], 'reg': [[0, 25296896, 0, 65536]],
> 'socionext,synquacer-pre-its': [[16777216, 4194304]], 'msi-controller':
> True, '#msi-cells': [[1]]}
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Queued up for 5.9, thanks.

-Tero

> ---
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi  | 2 +-
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 61815228e230..d14e0c65d266 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -42,7 +42,7 @@
>   		 */
>   		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>   
> -		gic_its: gic-its@1820000 {
> +		gic_its: msi-controller@1820000 {
>   			compatible = "arm,gic-v3-its";
>   			reg = <0x00 0x01820000 0x00 0x10000>;
>   			socionext,synquacer-pre-its = <0x1000000 0x400000>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 96c929da639d..5d82de4097bb 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -31,7 +31,7 @@
>   		/* vcpumntirq: virtual CPU interface maintenance interrupt */
>   		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>   
> -		gic_its: gic-its@1820000 {
> +		gic_its: msi-controller@1820000 {
>   			compatible = "arm,gic-v3-its";
>   			reg = <0x00 0x01820000 0x00 0x10000>;
>   			socionext,synquacer-pre-its = <0x1000000 0x400000>;
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
