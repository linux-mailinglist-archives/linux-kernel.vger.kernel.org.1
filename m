Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8A626226C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 00:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgIHWJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 18:09:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48508 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbgIHWJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 18:09:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088M9JeA058562;
        Tue, 8 Sep 2020 17:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599602959;
        bh=c76Fh+YN+6Q0rzgsOkb/+idzlg929BikhIc1MZmA4rc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GQwzOH8JMhl/j1lMEkRPtQYbD+jZ5aZyBrTZkB4lDdrmehPuW9k5Dk5JdLLLSi9hd
         t52T0gS4Ry9bddlW2YLxD8YDT3re/+sg2sXD/lvgHttRfse0+d4HYzAJpwHfVP4MXi
         jBumuqYs+4cw+i1elF9S/O97qHUDVWMt23bmG54s=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 088M9J9t083780
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Sep 2020 17:09:19 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 17:09:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 17:09:18 -0500
Received: from [10.250.34.59] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088M9IBC007150;
        Tue, 8 Sep 2020 17:09:18 -0500
Subject: Re: [PATCH next v2 0/3] soc: ti: k3: ringacc: add am65x sr2.0 support
To:     <santosh.shilimkar@oracle.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200829184139.15547-1-grygorii.strashko@ti.com>
 <b9310d10-46c5-2c63-a921-88be23363d44@oracle.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <1661043e-15a3-b8de-b16c-ef6ff88f18e5@ti.com>
Date:   Tue, 8 Sep 2020 17:09:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b9310d10-46c5-2c63-a921-88be23363d44@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

On 8/31/20 1:34 PM, santosh.shilimkar@oracle.com wrote:
> On 8/29/20 11:41 AM, Grygorii Strashko wrote:
>> Hi Santosh,
>>
>> I've rebased on top of  linux-next and identified merge conflict of patch 3
>> with commit 6da45875fa17 ("arm64: dts: k3-am65: Update the RM resource types")
>> in -next.
>>
>> ---
>> This series adds support for the TI AM65x SR2.0 SoC Ringacc which has fixed
>> errata i2023 "RINGACC, UDMA: RINGACC and UDMA Ring State Interoperability
>> Issue after Channel Teardown". This errata also fixed for J271E SoC.
>> The SOC bus chipinfo data is used to identify the SoC and configure
>> i2023 errata W/A.
>>
>> This changes made "ti,dma-ring-reset-quirk" DT property obsolete, so it's
>> removed.
>>
>> Changes in v2:
>>   - no functional changes
>>   - rebased on top of linux-next
>>   - added ask from Rob Herring
>>
> Thanks. Can you please followup DT acks for PRUSS series so that I can
> apply PRUSS + $subject series.

PRUSS dt binding is acked now, so can you pick up the PRUSS v2 series for 5.10
merge window.

regards,
Suman

> 
>> v1:
>> https://urldefense.com/v3/__https://lore.kernel.org/patchwork/cover/1284233/__;!!GqivPVa7Brio!PCmZ-nZZ6YQak-0T43bPZYI0gHsYL9k6N7S2gZEFbIr8BRKtv2BK01VejQzlBPBBgcfvCQ$
>>
>>      Grygorii Strashko (3):
>>    soc: ti: k3: ringacc: add am65x sr2.0 support
>>    bindings: soc: ti: soc: ringacc: remove ti,dma-ring-reset-quirk
>>    arm64: dts: ti: k3-am65: ringacc: drop ti,dma-ring-reset-quirk
>>
>>   .../bindings/soc/ti/k3-ringacc.yaml           |  6 ----
>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  1 -
>>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  1 -
>>   drivers/soc/ti/k3-ringacc.c                   | 33 +++++++++++++++++--
>>   4 files changed, 30 insertions(+), 11 deletions(-)
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

