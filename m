Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C4026A586
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgIOMsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:48:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52834 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIOMkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:40:52 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FCedfi023944;
        Tue, 15 Sep 2020 07:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600173639;
        bh=kc5gJD2XSbkrOt0ijEQID10sxdvJzpVItuajwHffg7A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ex0NylpPryQPVESepbqo+s1HDCrxbpL4YlHf2wry/Sz0uBlN35FAvomGlWB/oA0uh
         YonDgxUKmx1ULJ7O/Uoo14dD4YWyvg18a93+Yuqt5sjMokl5P3od3f136NFTtseT/v
         sr6Gr+QSS82uERIr6mxG6/l3evtHrfrvW/LWCYRA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08FCece0002865
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 07:40:39 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 07:40:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 07:40:38 -0500
Received: from [10.250.232.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FCeZxX020487;
        Tue, 15 Sep 2020 07:40:36 -0500
Subject: Re: [PATCH v2 0/2] Add DT to get PCIe working in J721E SoC
To:     Nishanth Menon <nm@ti.com>
CC:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200914152115.1788-1-kishon@ti.com>
 <20200914161016.bil575y3ig5oz5dn@akan>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <96fcf62a-b528-0611-d683-000d8d5d165f@ti.com>
Date:   Tue, 15 Sep 2020 18:10:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914161016.bil575y3ig5oz5dn@akan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/09/20 9:40 pm, Nishanth Menon wrote:
> On 20:51-20200914, Kishon Vijay Abraham I wrote:
>> Now that J721E PCIe support is merged (including the YAML bindings),
>> add PCIe device tree nodes to get PCIe working in J721E SoC both in
>> RC mode and EP mode.
>>
>> Series has been rebased to:
>> git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux ti-k3-dts-next 
>>
>> Changes from v1:
>> 1) Renamed all syscon dt-nodes to "syscon" instead of pcieX-ctrl.
>> 2) Add TI specific compatible for "syscon" DT nodes
>> 3) Add information about appending "ranges" property to access all PCIe
>>    instances in commit log.
>>
>> Kishon Vijay Abraham I (2):
>>   arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes
>>   arm64: dts: ti: k3-j721e-common-proc-board: Configure the PCIe
>>     instances
>>
>>  .../dts/ti/k3-j721e-common-proc-board.dts     |  80 ++++++
>>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 232 +++++++++++++++++-
>>  arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   5 +-
>>  3 files changed, 315 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.17.1
>>
> 
> Thanks, yeah - the series is clean. If no one adds a tag in the next
> couple of days or so, I can pick it up.
> 

Thanks Nishanth!

Regards
Kishon
