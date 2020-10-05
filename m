Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B513D2832C0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJEJGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:06:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34266 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEJGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:06:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09596Mj1118638;
        Mon, 5 Oct 2020 04:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601888782;
        bh=HoTeAQPf8XqcdWmvOwmB3iZVaJnUmk44g2g1ZMAPtVY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vJwZODdhwdw2Vh4ZzjibgvDbs/kkmswHguHeosMamERJElsMYASHN+FbwLDcZViaD
         WNZ4B3mbg1lLIqgqHGXl+beBI8xU+E1HyxYxtaF4vQ2ayjT4ve44ycS+B+JWvCb44C
         3L7WVNYLxHi2cV+h3B8CI7h2aHBT2EgXdmITpNV4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09596M5t007304
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Oct 2020 04:06:22 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 5 Oct
 2020 04:06:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 5 Oct 2020 04:06:21 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09596IY2110551;
        Mon, 5 Oct 2020 04:06:19 -0500
Subject: Re: [PATCH] mtd: spi-nor: Prefer asynchronous probe
To:     Michael Walle <michael@walle.cc>,
        Doug Anderson <dianders@chromium.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <tudor.ambarus@microchip.com>
References: <20200902160002.1.I658d1c0db9adfeb9a59bc55e96a19e192c959e55@changeid>
 <20201003150633.23416-1-michael@walle.cc>
 <CAD=FV=VB-ML0=kmN-yAH7sD-sMiX9Cq1_9B9QwVL=Ed5ZrGnbg@mail.gmail.com>
 <b376b3f2e41662237d50d589e3696b06@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <ccf3c162-4f2b-914f-725d-d15eb10819a4@ti.com>
Date:   Mon, 5 Oct 2020 14:36:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b376b3f2e41662237d50d589e3696b06@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 10/3/20 10:24 PM, Michael Walle wrote:
> Hi Douglas,
> 
> Am 2020-10-03 18:27, schrieb Doug Anderson:
>> Hi,
>>
>> On Sat, Oct 3, 2020 at 8:22 AM Michael Walle <michael@walle.cc> wrote:
>>>
>>> Hi Douglas,
>>>
>>> > On my system the spi_nor_probe() took ~6 ms at bootup.  That's not a
>>> > lot, but every little bit adds up to a slow bootup.  While we can get
>>> > this out of the boot path by making it a module, there are times where
>>> > it is convenient (or even required) for this to be builtin the kernel.
>>> > Let's set that we prefer async probe so that we don't block other
>>> > drivers from probing while we are probing.
>>> >
>>> > This is a tiny little change that is almost guaranteed to be safe for
>>> > anything that is able to run as a module, which SPI_NOR is.
>>> > Specifically modules are already probed asynchronously.  Also: since
>>> > other things in the system may have enabled asynchronous probe the
>>> > system may already be doing other things during our probe.
>>> >
>>> > There is a small possibility that some other driver that was a client
>>> > of SPI_NOR didn't handle -EPROBE_DEFER and was relying on probe
>>> > ordering and only worked when the SPI_NOR and the SPI bus were
>>> > builtin.  In that case the other driver has a bug that's waiting to
>>> > hit and the other driver should be fixed.
>>>
>>> linux-next now triggers the following warning in kernel/kmod.c:136 on my
>>> board. I've bisected this to this patch.
>>>
[...]
>>
>> Thanks for your report!  My vote would be to revert my patch and then
>> this would need to be resolved before it could be added back in.
>> Without doing tons of research, maybe the right answer here is that
>> mtd_device_parse_register() should be moved into a separate task so
>> it's not blocking probe?  I probably won't try to tackle this
>> immediately, but the eventual goal is that async is default, so I
>> think this would need to be resolved before then.
> 
> Ok. Vignesh, will you take care of that?

Thanks for the report! I have posted a patch reverting this commit. Will
merge into spi-nor/next shortly

Regards
Vignesh
