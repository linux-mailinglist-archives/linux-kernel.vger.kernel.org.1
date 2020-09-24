Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB23277077
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgIXL6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:58:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50490 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgIXL6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:58:23 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08OBwJBA063493;
        Thu, 24 Sep 2020 06:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600948699;
        bh=Kx975IonNS5fdPzc1CvdbkZGQbbLSeWnCwzcvYSifOo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cu7lCmqN1zvQtRJpCtyBoCWMzNDmcIIRDpvl3nJv2Hv0YrZkmLha2figDgEE0iyoo
         jvaVBlGNnLnpvvxGPXT2Z4fJr8fU8P6abLa4zRd50xM8S7eeSDISu88sp3VEqHHeBC
         AwbRaUBukOSD+SbXhEtObxmYOSrRu6Lza5ORtPnQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08OBwJTB027044
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 06:58:19 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 06:58:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 06:58:18 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OBwFsk088303;
        Thu, 24 Sep 2020 06:58:16 -0500
Subject: Re: [PATCH v2 0/2] Add support for MMC/SD on j7200-evm
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <nm@ti.com>, <t-kristo@ti.com>, <robh+dt@kernel.org>
References: <20200924112644.11076-1-faiz_abbas@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <f4444de5-cde4-9f08-d8d7-1ecdbf071258@ti.com>
Date:   Thu, 24 Sep 2020 17:28:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924112644.11076-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/20 4:56 PM, Faiz Abbas wrote:
> The following patches add dt support for MMC/SD on TI's j7200-evm.
> 
> Currently, eMMC support upto HS200 speed and SD card supports upto high
> speed speed mode.
> 
> v2:
> Fixed node names to use mmc@* format
> Fixed reg address format to align with others in the file
> 
> Faiz Abbas (2):
>   arm64: dts: ti: k3-j7200-main: Add support for MMC/SD controller nodes
>   arm64: dts: ti: k3-j7200-common-proc-board: Add support for eMMC and
>     SD card
> 
>  .../dts/ti/k3-j7200-common-proc-board.dts     | 28 ++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 37 +++++++++++++++++++
>  2 files changed, 65 insertions(+)
> 
For the series:

Tested-by: Vignesh Raghavendra <vigneshr@ti.com>


[    1.678263] mmc0: Command Queue Engine enabled
[    1.682727] mmc0: new HS200 MMC card at address 0001
[    1.688193] mmcblk0: mmc0:0001 S0J56X 14.8 GiB
[    1.692971] mmcblk0boot0: mmc0:0001 S0J56X partition 1 31.5 MiB
[    1.699138] mmcblk0boot1: mmc0:0001 S0J56X partition 2 31.5 MiB
[    1.705268] mmcblk0rpmb: mmc0:0001 S0J56X partition 3 4.00 MiB, ch
ardev (240:0)
[    1.789527] mmc1: new high speed SDHC card at address aaaa
[    1.795621] mmcblk1: mmc1:aaaa SC16G 14.8 GiB
[    1.810074]  mmcblk1: p1 p2


SD hot plug works fine too..
Full log: https://pastebin.ubuntu.com/p/5hcCQDjhtW/
