Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA5E2B23C8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKMS3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:29:52 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:32968 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKMS3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:29:52 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADITkav023269;
        Fri, 13 Nov 2020 12:29:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605292186;
        bh=0vUD35pH0zhF62AhI+ZyzQ8mAewqNaA1dAl9KpnWAlw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MT+5T/LEmMlyBDPgkfmt5eJZGx8jFumBy8QHEJbViLkvV7LxBzCc0GTvzJH6NgZxH
         i0Qh9xOJVDVhd0S6x66bo4lSo0/pmHBm85javUqB/8RT+B1C1FMVpRKByzKNQvuzQS
         /feuhh8ux1oy9YOPD5lLckE7picbhWZ6/yv0SJ08=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADITkYX120444
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 12:29:46 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 12:29:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 12:29:46 -0600
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADITdDj128227;
        Fri, 13 Nov 2020 12:29:41 -0600
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j7200-main: Add gpio nodes in main
 domain
To:     Nishanth Menon <nm@ti.com>, Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>
References: <20201102191120.20380-1-faiz_abbas@ti.com>
 <20201102191120.20380-2-faiz_abbas@ti.com>
 <20201112163953.soia5cje4ry42ujf@kahuna>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <6ce6de4b-6e4d-1d2d-aa7a-570d1796d668@ti.com>
Date:   Fri, 13 Nov 2020 23:59:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201112163953.soia5cje4ry42ujf@kahuna>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 12/11/20 10:09 PM, Nishanth Menon wrote:
> On 00:41-20201103, Faiz Abbas wrote:
>> There are 4 instances of gpio modules in main domain:
>> 	gpio0, gpio2, gpio4 and gpio6
>>
>> Groups are created to provide protection between different processor virtual
>> worlds. Each of these modules I/O pins are muxed within the group. Exactly
>> one module can be selected to control the corresponding pin by selecting it
>> in the pad mux configuration registers.
> Could you check with checkpatch --strict please?
> 
> I see:
> 
> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> 
>>
>> This group pins out 69 lines (5 banks).
>>
>> Add DT modes for each module instance in the main domain.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 68 +++++++++++++++++++++++
> 
> dtbs_check: we added:
> arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@600000: Missing #address-cells in interrupt provider
> arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@610000: Missing #address-cells in interrupt provider
> arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@620000: Missing #address-cells in interrupt provider
> arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@630000: Missing #address-cells in interrupt provider

Hmm, running dtbs_check, I did not really see this. These are all the
warnings I see for TI platforms: https://pastebin.ubuntu.com/p/m2my62mjQq/

The tree I am testing is linux-next of 12th Nov + these three patches
applied.

Also, #address-cells for interrupt provider being compulsory does not
make full sense to me. Nothing in
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt or
Documentation/devicetree/bindings/gpio/gpio-davinci.txt suggests that as
well.

Existing GPIO nodes for AM654 or J721E does not have #address-cells as well.

Adding Grygorii as well, in case he knows more about this.

Thanks,
Sekhar
