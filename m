Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B12AB1E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgKIHs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:48:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48898 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgKIHs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:48:56 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A97mh32029713;
        Mon, 9 Nov 2020 01:48:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604908123;
        bh=/XF0EGf1HmpAsphmVE5gnDEws49RwGsRwfQ6uNTI+4I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=te3K6raBCO2X5Om0xvSQrZV3ZYHQx5+OmzBLHhwBI6pmhWyGHUM3rUFDvuu00x0xg
         xR3bagdK4Qcvt7uJ4T7CQf1ZWLDGcylAbfPeGtiL7+9B+jkj50XX8flv1faKKdmBxV
         g8OI5H9CsB0vBL6sGjxuVpfg0nv5OsNmap1vtTqw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A97mhYn084647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Nov 2020 01:48:43 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 01:48:43 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 9 Nov 2020 01:48:43 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A97mesc128217;
        Mon, 9 Nov 2020 01:48:41 -0600
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
 <37b4b284-0da5-c602-82a2-2b672f89891f@ti.com>
 <20201106214638.amgltswy6dygnyee@tubular>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <400a464f-8d5b-9979-fb77-d939ac3bc994@ti.com>
Date:   Mon, 9 Nov 2020 09:49:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106214638.amgltswy6dygnyee@tubular>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/11/2020 23.46, Nishanth Menon wrote:
> On 13:32-20201106, Peter Ujfalusi wrote:
> [...]
>>>
>>>>
>>>>> default power management functionality etc
>>>>
>>>> Right, so how does that helps with devices present in the SoC, but no
>>>> node at all? First thing which comes to mind is AASRC, we don't have
>>>> Linux driver for it (and no DT binding document), but that does not mean
>>>> that it is not present. How PM would take that into account?
>>>
>>> I think we are mixing topics here -> I was stating the motivation why
>>> devicetree chose such as default.
>>
>> I don't question the fact that 'okay' is the default status if it is not
>> explicitly present. There is no better default than that.
> 
> ^^ -> Alright, that is all we are trying to do here: defaults in the
> SoC.dtsi and specific cleanups (firmware reserved / board unused
> disables) be done in a common board.dtsi (for now, there is no such
> specific need, I guess).

The default is what it is: default choice which suits most of the nodes.

If the node is not complete in it's present form then it is not in it's
default state. imho.

>>> Alright - what do we suggest we do?
>>
>> Not sure, I'm 'whatever' after [1] makes it to mainline or next.
> [....]
>> [1]
>> https://lore.kernel.org/alsa-devel/20201106072551.689-1-peter.ujfalusi@ti.com/
> 
> 
> I don't see the relationship between the series.. I think this series
> brings no change in dtb, hence with OR without your driver cleanup
> series, there is no practical regressions.

This series opens up the possibility of nodes leaking to dtb with known
broken state and the driver should have a better strategy than 'works by
luck' to handle it ;)

>>
>>> Tony, Rob - I need some guidance here.
>>
>> I'm fine whatever way we take, but I think it is up to you to make the
>> call as the maintainer of the TI dts files... ;)
> 
> Yep - I have'nt seen a reason yet that must cause us to change from the
> Device tree default approach in our debates.

Imho 'disabled' is the default for nodes like McASP as it is:
"Indicates that the device is not presently operational, but it might
become operational in the future" (for example, needed properties added
to the node).

>>>> There is no such a tag, but:
>>>> whatever-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>
>>> OK - I have no idea how B4 or patchworks pick that one as :D
>>
>> If we take this road, than I'm okay with it, but I'm going to take
>> silent protest (not sending acked-by or revired-by).
>> That should not stop you doing what you believe is best for the future!
> 
> OK - thanks for your review and the discussions, always appreciate
> getting our views out there.
> 
> if there are no other comments, I will try and post a v2 over the
> weekend.

OK

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
