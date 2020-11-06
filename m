Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58612A9575
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgKFLc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:32:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60414 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFLcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:32:22 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A6BWCra060273;
        Fri, 6 Nov 2020 05:32:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604662332;
        bh=0hZftWxeH3TzvYEWUo/ySNOeak8LFO/Ww1fttHmrXmE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lQh4Qr9kkuR702DjqT+Zg9Y3YScafuVj1fJvpNcf7hbsCsn5rRMMhYzqGcIiiTzfZ
         ToHU4N1TlHn7KupOiLT5DuhDBhnuGcudISQXblAzTJRIO9HlTk8LqBFXRRvzqS9a/9
         T4OWV+AdZoecpGatVbs9lDRrIkEhWZStCxfmOGnA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A6BWCU6005976
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Nov 2020 05:32:12 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 6 Nov
 2020 05:32:11 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 6 Nov 2020 05:32:11 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A6BW8Y7047332;
        Fri, 6 Nov 2020 05:32:09 -0600
Subject: Re: [PATCH 2/4] arm64: dts: ti: k3-j721e*: Cleanup disabled nodes at
 SoC dtsi level
To:     Nishanth Menon <nm@ti.com>
CC:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201104224356.18040-1-nm@ti.com>
 <20201104224356.18040-3-nm@ti.com>
 <d9324b76-5587-b583-97da-5cb52f294c31@ti.com>
 <20201105140806.326ubfppb4guexpi@cultural>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <37b4b284-0da5-c602-82a2-2b672f89891f@ti.com>
Date:   Fri, 6 Nov 2020 13:32:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105140806.326ubfppb4guexpi@cultural>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth,

On 05/11/2020 16.08, Nishanth Menon wrote:
> On 09:32-20201105, Peter Ujfalusi wrote:
>> Nishanth,
>>
>> On 05/11/2020 0.43, Nishanth Menon wrote:
>>> The device tree standard sets the default node behavior when status
>>> property as enabled.
>>
>> It should be:
>> When the status property is not present under a node, the "okay' value
>> is assumed.
> 
> Thanks.. will update.
> 
>>
>> Note: the device tree specification does not document default value as
>> such, see v0.3 (2.3.4, page 14).
>> Yes, the "okay" is used in case the status property is missing (by Linux
>> at least).
> 
> Maybe the spec update needs a formal release? Kumar's patch is merged:
> https://github.com/devicetree-org/devicetree-specification/pull/33
> 
> on that exact same section, which you can see
> https://github.com/devicetree-org/devicetree-specification/blob/master/source/chapter2-devicetree-basics.rst

I stand correct, I only checked the released version.

> Brings it to sync to:
> https://elinux.org/Device_Tree_Linux#status_property
> 
>>
>>> There are many reasons for doing the same, number
>>> of strings in device tree,
>>
>> with expense of loc and readability.
> 
> The "readability" part is subjective a bit.. enabled and disabled both
> have verbosity problem lets see how we can optimize as new boards come
> in.

I agree.

> 
>>
>>> default power management functionality etc
>>
>> Right, so how does that helps with devices present in the SoC, but no
>> node at all? First thing which comes to mind is AASRC, we don't have
>> Linux driver for it (and no DT binding document), but that does not mean
>> that it is not present. How PM would take that into account?
> 
> I think we are mixing topics here -> I was stating the motivation why
> devicetree chose such as default.

I don't question the fact that 'okay' is the default status if it is not
explicitly present. There is no better default than that.

> Do we have a suggestion to improve
> the description in the commit?

A bit later on that.

>>
>>> are few of the reasons.
>>>
>>> In general, after a few rounds of discussions [1] there are few
>>> options one could take when dealing with SoC dtsi and board dts
>>>
>>> a. SoC dtsi provide nodes as a super-set default (aka enabled) state and
>>>    to prevent messy board files, when more boards are added per SoC, we
>>>    optimize and disable commonly un-used nodes in board-common.dtsi
>>> b. SoC dtsi disables all hardware dependent nodes by default and board
>>>    dts files enable nodes based on a need basis.
>>> c. Subjectively pick and choose which nodes we will disable by default
>>>    in SoC dtsi and over the years we can optimize things and change
>>>    default state depending on the need.
>>
>> For the record: c was not really an option. There were no subjectivity,
>> the reason was pragmatic.
> 
> 
> (c) some examples where we did pick that option (fixes):
> https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-4-nm@ti.com/
> https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-5-nm@ti.com/

this is different, these patches just removing the "status = 'okay';"
lines where they are not needed and can be omitted to save few lines and
it does help on readablity.

>> The reason why we kept McASP nodes (and dss) disabled in the soc dtsi
>> file is that they are not operation in the form they present in there.
>> They _need_ additional properties to be operational and those properties
>> can only be added in the board dts file.
> 
> I dont think we are changing anything in the output dtb files,

Correct, the resulted dtb is identical. If the developer for upcoming
boards did check the schematics vs TRM vs dtsi and spot the things that
is not configured.
dtb check will complain when it is starting to check against the
documentation, but McASP is not yet converted to yaml and to be honest I
don't want to convert the current binding to be the binding. When it was
done it just moved pdata variables to DT and that was wrong.
This is off-topic a bit.

> we are
> just leaving the defaults as dt defaults and set the disable state in
> board dts OR common board dtsi.

Yes, we leave the non working/configured node 'okay' in dtsi and expect
that the board file author will know which node must be disabled because
it is incomplete.

>> This is not remotely a subjective view, this is the opposite of
>> subjectivity.
> 
> the usage of McASP was'nt meant as (c).. it is (b). is there a better way
> to describe this in a generic manner?

I had my saying on that ever since I have been taking care of audio on
TI SoCs ;)

I used similar analogy in a private thread around this, but imho it fits
the case neatly:
car == McASP

you don't put an 'okay' (as is ready, operational) stamp on the car in
the middle of the production line when the engine is not even installed.

>> As for things not owned by the OS we have the "reserved" status.
> Which is correct usage. I think your point with wkup_uart should be set as
> reserved? I might have missed doing that - am I correct?
> 
> [...]
>>>  
>>> -	status = "okay";
>>> +&mcasp11 {
>>> +	status = "disabled";
>>>  };
>>
>> Looks much better in this way.
>> ?
>>
>> I always wondered what is _not_ used by the board...
>> But it is not really about that, we need to disable these nodes as they
>> are incomplete in dtsi, they are not operational...
> 
> Alright - what do we suggest we do?

Not sure, I'm 'whatever' after [1] makes it to mainline or next.

> Tony, Rob - I need some guidance here.

I'm fine whatever way we take, but I think it is up to you to make the
call as the maintainer of the TI dts files... ;)

>>
>>>  &serdes0 {
> 	[...]
>>>  
>>>  	watchdog0: watchdog@2200000 {
>>>
>>
>> There is no such a tag, but:
>> whatever-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> OK - I have no idea how B4 or patchworks pick that one as :D

If we take this road, than I'm okay with it, but I'm going to take
silent protest (not sending acked-by or revired-by).
That should not stop you doing what you believe is best for the future!

fwiw, McASP will have sane handling for the variations of 'okay':
[1]
https://lore.kernel.org/alsa-devel/20201106072551.689-1-peter.ujfalusi@ti.com/

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
