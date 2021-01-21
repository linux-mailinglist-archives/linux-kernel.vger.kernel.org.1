Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B72FE74A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbhAUKPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbhAUKOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:14:23 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949CBC061575;
        Thu, 21 Jan 2021 02:13:39 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EBF8522FAD;
        Thu, 21 Jan 2021 11:13:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611224018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I4dLSkqJXtXHKLU0U+8YrniJxd+5nWGvaigg4fV1hAc=;
        b=SaKNVZKxfgcGcg2JHt7BBiGpOI/zUgMnud/Si+cf7OFIUUWbsZUaKmESPwdKR2Iu8A+krE
        fKxfc4D4j84vWKYeiLatvNJ9GKYzRrN6GKvGjXGiWZvHvB2TYRW4dnJi1NkwCOR9Nd2zNX
        H/6+PYgGfZ0RWFUsxIdOsdRXDzHXckc=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 21 Jan 2021 11:13:37 +0100
From:   Michael Walle <michael@walle.cc>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Subject: Re: [PATCH 0/3] add Ebang EBAZ4205 support
In-Reply-To: <0a1c6ebf-1d5b-4f06-56db-f04e87d2ae9a@xilinx.com>
References: <20210120194033.26970-1-michael@walle.cc>
 <fff420d1-fc9a-23ce-0d07-58a3c6f10c4d@xilinx.com>
 <aa96fcaa362181d4b6fef9f1de0aa914@walle.cc>
 <0a1c6ebf-1d5b-4f06-56db-f04e87d2ae9a@xilinx.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <bd86194a13882ce472764d0c91029e33@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-01-21 10:57, schrieb Michal Simek:
> Hi,
> 
> On 1/21/21 10:35 AM, Michael Walle wrote:
>> Hi Michal,
>> 
>> Am 2021-01-21 10:25, schrieb Michal Simek:
>>> On 1/20/21 8:40 PM, Michael Walle wrote:
>>>> Add support for the Ebang EBAZ4205 board. This board was once used 
>>>> as a
>>>> control board for a bitcoin mining device. Nowawdays it is sold as a
>>>> cheap
>>>> Zynq-7000 eval board.
>>>> 
>>>> Michael Walle (3):
>>>>   dt-bindings: add ebang vendor prefix
>>>>   dt-bindings: arm: add Ebang EBAZ4205 board
>>>>   ARM: dts: add Ebang EBAZ4205 device tree
>>>> 
>>>>  .../devicetree/bindings/arm/xilinx.yaml       |   1 +
>>>>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>>>>  arch/arm/boot/dts/Makefile                    |   1 +
>>>>  arch/arm/boot/dts/zynq-ebaz4205.dts           | 109 
>>>> ++++++++++++++++++
>>>>  4 files changed, 113 insertions(+)
>>>>  create mode 100644 arch/arm/boot/dts/zynq-ebaz4205.dts
>>>> 
>>> 
>>> any link with schematics?
>> 
>> https://github.com/xjtuecho/EBAZ4205, looks like these are
>> reverse engineered (from a layout file?) though.
> 
> Interesting but at least something.
> 
>> 
>>> I will let dt guys to comment 1/3 but series look good to me.
>>> The board doesn't look interesting from description point of view 
>>> that's
>>> why all the time thinking if makes sense to add it to kernel.
>> 
>> What do you want to tell me? That for the time being, it didn't
>> appear to you to add the board yourself - or do you thing it
>> doesn't make sense at all. If its the latter, what would be
>> actual reason to have a board in mainline?
> 
> I have bad experience with for example Avnet boards which people add 
> and
> none is really updating them and they are in the same state for years.

Wouldn't it be better then to pull the plug at some time and remove 
these
boards.

TBH I was a bit disappointed by your statement. It sounded like "nah
this board isn't worth it". Esp. because it is just one (small) file.
But more below.

> Long time ago we agreed that doesn't make sense to describe PL in
> upstream projects and we only describe PS part. It means you likely 
> miss
> several things which are useful and the reason for using these SoCs is 
> PL.
> 
> As you likely know Xilinx has Versal device and I didn't push any 
> device
> tree to any upstream project and thinking not to add any description 
> for
> boards and stay in sort of space that "virtual" description for SoC
> should be enough. Maybe just versal.dtsi and one kitchen sink DT should
> be added but not description for all boards.
> 
> The same is if make sense to push all DTs for all standard xilinx 
> zynqmp
> evaluation boards. If there is something interesting/new I thought it
> makes sense to add it as pattern to follow. But for boards which looks
> very similar from PS point of view I don't think there is real value to
> add and invest time for maintaining.
> 
> Back to your case. Board is cheap which is not all the time case for 
> any
> xilinx board but you have only uart, sd and partially described 
> ethernet
> which doesn't work without PL. Is it worth to have this described?

I got your point. But it is at least a jump start for the users if that
board boots out of the box. And yes, its unfortunate, that ethernet
just works if the PL is configured. This is already done by the
bootloader, because there I do have the same problem.

> Especially when it is visible that you need to describe custom PL and 
> DT
> overlays are not solid yet.
> 
> Thanks,
> Michal

-- 
-michael
