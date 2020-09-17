Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D9626DFEB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgIQPmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:42:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37186 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgIQPQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:16:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08HFFXRu101141;
        Thu, 17 Sep 2020 10:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600355733;
        bh=zJUvUPlDG3fjTS6W6hFpNIPLT9BdATy27+PbP+vGrPs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BeCOCdSyBx881M4VX9eLbF/b3wotePX5ouLGLCmPnRF1IEbV4bxpZrJdGfR/FHZ7V
         wjyNgtTgNVK1fFFL2wjQSVXP87c0bIbKLNy5ogG3Gl7zGB+bUH4vonwcM91+kWfH2M
         y8V/6HIYDzMWzK74m9gaHS5hE9C9Rh+7WETtmg50=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HFFXSS120076;
        Thu, 17 Sep 2020 10:15:33 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 10:15:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 10:15:33 -0500
Received: from [10.250.32.129] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HFFWuJ008246;
        Thu, 17 Sep 2020 10:15:32 -0500
Subject: Re: [PATCH 5/6] dt-bindings: tlv320adcx140: Add slot programming
 property
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <camel.guo@axis.com>
References: <20200915190606.1744-1-dmurphy@ti.com>
 <20200915190606.1744-5-dmurphy@ti.com> <20200917130236.GA2954@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f4a83c01-58e2-1b7a-677e-44d5bde7b175@ti.com>
Date:   Thu, 17 Sep 2020 10:15:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917130236.GA2954@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 9/17/20 8:02 AM, Mark Brown wrote:
> On Tue, Sep 15, 2020 at 02:06:05PM -0500, Dan Murphy wrote:
>
>> +  ti,slot-mapping:
>> +    type: boolean
>> +    description: |
>> +      Each channel can be assigned a specific TDM slot for either a left or
>> +      right channel. The left channel values are from 0-31d and the right
>> +      channel values are from 32-63d. If the right channel value is 32 then the
>> +      right channel slot will be slot 31.
>> +      The array index is sequential audio channel to be set.
>> +      [ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8]
>> +      If the channel is not to be used then the channel should be set to it's
>> +      default value.
> This is something I'd expect to be done by the machine driver rather
> than in the CODEC specific DT bindings, and apart from anything else
> everything involved in the DAI will need to agree on the mapping so this
> doesn't look like something that should be done in a device specific
> binding.

Here is the use case from our customers

Customers need the ability to not transmit on a TDM slot, since another 
device could be using the slot.
For example, the customer has an amp and dig microphone sharing one TDM 
bus. The amp uses slot 0 while dig microphone use slots 1-3.
In another example, customers use 2 dig microphones. One device 
transmits on slots 0-3, the second device transmits on slots 4-7.
In a third example, customers use 4 dig microphones. Device 1 uses Slots 
0-3, Device 2 uses Slots 4-7, Device 3 uses Slots 8-11, and Device 4 
uses Slots 12-15.

The dai-tdm-slot-num would be a good candidate to add to the sound card 
to define the slot number but it's definition is "Number of slots in 
use." So it is not really setting the needed slot.
I am not finding any good way to assign specific slots to specific channels.

I can add DAI slot numbering parameter for specific codecs.

Dan
