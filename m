Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215D6302642
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 15:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbhAYOW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 09:22:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45122 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbhAYOPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:15:06 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10PEDR4k032858;
        Mon, 25 Jan 2021 08:13:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611584007;
        bh=uJsEC5aKASjqF3Bw/VgHBg+jWZArLzwgittfEQERjAY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hw8k8boKChptdNSdjxsmvrySmiPSzW633nM0cSBPejBuX34Mpcy8mxyWFfDt1CY1s
         GFTd6XDDnDx/IKSOLXUlwC3/ZrihT8BeO0wxWcZUh7HbbNLnZ4jfuNBQfMukGu/owL
         qVJEmAit3Xg3yod9kz8qvh+bI/kgltmuYboXHrw0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10PEDRkL103830
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jan 2021 08:13:27 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 25
 Jan 2021 08:13:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 25 Jan 2021 08:13:27 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10PEDNxQ075325;
        Mon, 25 Jan 2021 08:13:24 -0600
Subject: Re: [PATCH 0/2] mmc: J7200: Add support for higher speed modes in
 MMCSD subsystems
To:     Nishanth Menon <nm@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210122162403.20700-1-a-govindraju@ti.com>
 <20210122180629.3j3aoueiwiib4gso@cavalier>
 <5341eeb2-e637-424f-3328-60dbddee1376@ti.com>
 <20210125135112.gvddr4uv7vx7kfrq@triangle>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <fd7ac744-a6dc-9f1f-c13f-96faca14d75b@ti.com>
Date:   Mon, 25 Jan 2021 19:43:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125135112.gvddr4uv7vx7kfrq@triangle>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 25/01/21 7:21 pm, Nishanth Menon wrote:
> On 19:12-20210125, Aswath Govindraju wrote:
>> Hi Nishanth,
>>
>> On 22/01/21 11:36 pm, Nishanth Menon wrote:
>>> On 21:54-20210122, Aswath Govindraju wrote:
>>>> The following series of patches
>>>> - adds support for HS200 and HS400 speed modes in MMCSD0 subsystem
>>>> - adds support for UHS-I speed modes in MMCSD1 subsystem 
>>>>
>>>> Aswath Govindraju (2):
>>>>   arm64: dts: ti: k3-j7200-main: Add support for HS200 and HS400 modes
>>>>     in MMCSD0 subsystem
>>>>   arm64: dts: ti: k3-j7200-main: Add support for UHS-I modes in MMCSD1
>>>>     subsystem
>>>
>>>
>>> Just a curious couple of questions:
>>> Does squashing both the patches create a problem for understanding or a
>>> later bisect? I kind of thought these mostly go hand in hand between the
>>> instances, am I mistaken?
>>>
>>
>> Yes, they can be squashed. I post a respin doing this.
> 
> Thanks.
> 
>>
>>> Are there any otap delay params update needed or the defaults are good
>>> to go?
>>>
>>
>> The otap values are already up-to-date with the data sheet and don't
>> need updation.
> 
> Thanks for the clarification.
> 
>>
>>> Will also help to provide some verification log along with this.
>>>
>>
>> May I know what sort of logs would be best to provide. Would enumeration
>> logs during boot suffice ?
>>
>> Like this,
>> https://pastebin.ubuntu.com/p/v9NRV7GwMw/ ?
> 
> That just says we detected the cards, no?
> I thought we had tests around this? Something including /sys/kernel/debug/mmc*/ios
> 
> Something that demonstrates that this actually runs at the claimed
> speeds? That would be nice on linux-next, if possible as well..
> 

Yes there are tests which confirm that claimed speeds are functional. I
will add them in the respin.

Thanks,
Aswath
