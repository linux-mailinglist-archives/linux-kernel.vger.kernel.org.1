Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CCC276F43
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIXLFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:05:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35442 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgIXLFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:05:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08OB4rEq038002;
        Thu, 24 Sep 2020 06:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600945493;
        bh=wFNALUU6tb3M4+yGl6TrhXcK85iwrsucm5gvVxqM7cs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sQxNgIAqMzx/dm+Viw4iPHoMfWZWTNNygBPmdbJpfp8MCDrsE1llespgh6zsmTRXJ
         91UxqL2onWMuxC8OGf0e3QHGi4lXfTkbBj//ndrxBMNnLy/1AOjPXFGnyBVLlJLCye
         LrUTDxy9EeZUyzzqu4N3b47wZ2MKWGTb73KlX+9Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08OB4rrg083125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 06:04:53 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 06:04:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 06:04:53 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OB4nEh082512;
        Thu, 24 Sep 2020 06:04:50 -0500
Subject: Re: [PATCH v4 0/6] arm64: dts: ti: Add USB support for J7200 EVM
To:     Roger Quadros <rogerq@ti.com>, <peda@axentia.se>, <nm@ti.com>
CC:     <devicetree@vger.kernel.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <kishon@ti.com>, <t-kristo@ti.com>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20200921143941.13905-1-rogerq@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <ce4f5b9e-f30f-cb47-5d26-08375ccfd484@ti.com>
Date:   Thu, 24 Sep 2020 16:34:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921143941.13905-1-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/20 8:09 PM, Roger Quadros wrote:
> Hi Tero/Nishanth,
> 
> This series adds USB2.0 support for the J7200 EVM.

[...]


> Kishon Vijay Abraham I (1):
>   arm64: dts: ti: k3-j7200-common-proc-board: Configure the SERDES lane
>     function
> 
> Roger Quadros (5):
>   dt-bindings: ti-serdes-mux: Add defines for J7200 SoC
>   arm64: dts: ti: k3-j7200-main: Add SERDES lane control mux
>   arm64: dts: ti: k3-j7200-main.dtsi: Add USB to SERDES lane MUX
>   arm64: dts: ti: k3-j7200-main: Add USB controller
>   arm64: dts: ti: k3-j7200-common-proc-board: Add USB support
> 
>  .../dts/ti/k3-j7200-common-proc-board.dts     | 28 ++++++++++
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 51 +++++++++++++++++++
>  include/dt-bindings/mux/ti-serdes.h           | 22 ++++++++
>  3 files changed, 101 insertions(+)
> 

For the series:

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
