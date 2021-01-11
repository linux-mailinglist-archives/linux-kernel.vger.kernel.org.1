Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649F72F17B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbhAKOKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:10:15 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58802 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388519AbhAKOIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:08:07 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10BE7I8O088545;
        Mon, 11 Jan 2021 08:07:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610374038;
        bh=7RWY48/tUpWEqY4GidUmapKfzCd7L56DR4cjQkEk2nc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WMejYgD4mZx/tC1qrm8nn+gTr3+poEY/gZbtJkaNshcfyWFm5+mMiciFLVpNXxFT4
         3KQX4I0A0zG1PezYE5bCZQDgwzA4kl2LIpNbN+y23sdEXMMC35KFvV1LDPqC2YFX6U
         S87ZdaZfXe7lv2EDH9IpOwhCEHu0RDXvne79AewQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10BE7I8F029853
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 08:07:18 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 11
 Jan 2021 08:07:18 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 11 Jan 2021 08:07:18 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10BE7FEt120809;
        Mon, 11 Jan 2021 08:07:16 -0600
Subject: Re: [PATCH v4 0/6] PCI: J7200/J721E PCIe bindings
To:     Kishon Vijay Abraham I <kishon@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210105151421.23237-1-kishon@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <42c2be5b-6747-6c60-d46f-3748fca70dcf@ti.com>
Date:   Mon, 11 Jan 2021 19:37:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210105151421.23237-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/5/21 8:44 PM, Kishon Vijay Abraham I wrote:
> Patch series adds DT nodes in order to get PCIe working in J7200.
> Also includes couple of fixes for J721e.
[...]
> 
> Kishon Vijay Abraham I (6):
>   arm64: dts: ti: k3-j721e-main: Fix supported max outbound regions
>   arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for
>     pcieX_ctrl
>   arm64: dts: ti: k3-j7200-main: Add SERDES and WIZ device tree node
>   arm64: dts: ti: k3-j7200-main: Add PCIe device tree node
>   arm64: dts: ti: k3-j7200-common-proc-board: Enable SERDES0
>   arm64: dts: ti: k3-j7200-common-proc-board: Enable PCIe
> 
>  .../dts/ti/k3-j7200-common-proc-board.dts     |  38 ++++++
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 111 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  52 ++------
>  3 files changed, 157 insertions(+), 44 deletions(-)
> 


For the series:

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh
