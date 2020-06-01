Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647321EA6DF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 17:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgFAP1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 11:27:21 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:46869 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgFAP1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:27:21 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49bJvB3qCLz1qsbn;
        Mon,  1 Jun 2020 17:27:18 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49bJvB2lqLz1qwwt;
        Mon,  1 Jun 2020 17:27:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Tk2Q1sOJb94O; Mon,  1 Jun 2020 17:27:16 +0200 (CEST)
X-Auth-Info: sKADeJvFw4sbGw3Y43zNwmVJbc0px7CZAK0qfBJnTJ4=
Received: from [127.0.0.1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  1 Jun 2020 17:27:16 +0200 (CEST)
Subject: Re: [PATCH v3 0/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, mbrugger@suse.com,
        u-boot@lists.denx.de, bmeng.cn@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl
References: <20200505162607.334-1-nsaenzjulienne@suse.de>
 <2a8f0190c9d418cee89451c7dc3a227b9d0b5f45.camel@suse.de>
 <bf73b73e-c251-7ac8-c245-a3b3d2be2420@denx.de>
 <9aea19124817a3d9fa004ec495ea6d1036d2dc8d.camel@suse.de>
 <c32541a5-2dce-1fb2-7f3d-dfe03bcfb52c@denx.de>
 <c29968027d3a555de89eae7599dcfd513744076f.camel@suse.de>
From:   Marek Vasut <marex@denx.de>
Message-ID: <ec76c8bb-63c1-8ccc-c1d5-5878bc01343b@denx.de>
Date:   Mon, 1 Jun 2020 17:27:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c29968027d3a555de89eae7599dcfd513744076f.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/20 4:41 PM, Nicolas Saenz Julienne wrote:
> On Mon, 2020-06-01 at 13:12 +0200, Marek Vasut wrote:
>> On 6/1/20 1:09 PM, Nicolas Saenz Julienne wrote:
>>> On Mon, 2020-06-01 at 12:53 +0200, Marek Vasut wrote:
>>>> On 6/1/20 12:47 PM, Nicolas Saenz Julienne wrote:
>>>>> On Tue, 2020-05-05 at 18:26 +0200, Nicolas Saenz Julienne wrote:
>>>>>> Newer revisions of the RPi4 need their xHCI chip, VL805, firmware to
>>>>>> be
>>>>>> loaded explicitly. Earlier versions didn't need that as they where
>>>>>> using
>>>>>> an EEPROM for that purpose. This series takes care of setting up the
>>>>>> relevant infrastructure and run the firmware loading routine at the
>>>>>> right moment.
>>>>>>
>>>>>> Note that this builds on top of Sylwester Nawrocki's "USB host support
>>>>>> for Raspberry Pi 4 board" series.
>>>>>>
>>>>>> ---
>>>>>
>>>>> Please don't forget about this series. The new 8GB RPi4 contains this HW
>>>>> design
>>>>> change and USB will not work without it. See this discussion on the
>>>>> downstream
>>>>> kernel github, where other OS/bootloaders are hitting the issue:
>>>>>
>>>>> https://github.com/raspberrypi/firmware/issues/1402
>>>>>
>>>>> Otherwise, the Linux version of this is already in linux-next:
>>>>>
>>>>>
>>>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/host/pci-quirks.c?h=next-20200529&id=c65822fef4adc0ba40c37a47337376ce75f7a7bc
>>>> We're already at 2020.07-rc3 , so unless this is a bugfix (does not look
>>>> that way), this will have to wait for next release cycle.
>>>
>>> Of course. As long as it eventually gets in I'm happy (not implying this
>>> specific series is flawless, but the overall mechanism). I'm just worried
>>> this
>>> gets lost.
>>>
>>>> Also, it seems
>>>> there was a lengthy ongoing discussion, is that already sorted out ?
>>>
>>> Well, there was some discussion on how to incorporate the platform specific
>>> callback into XCHI's code. Which this revision of the series addresses. But,
>>> IIRC, that's pretty much it as far as discussion is concerned.
>>
>> Oh, right, since the firmware loading hook looks like a reset hook, why
>> isn't that implemented via reset controller API instead ?
> 
> That could be pretty clean, I hadn't though about it that way. Some questions:
> 
> - Being a PCIe device the XHCI controller doesn't show up in the device-tree. I
>   guess it could be added as a child node of pcie-brcmstb, but is that even
>   acceptable?

Yes, there are other such DTs .

> - Same goes for xhci-pci being a consumer of the reset controller. Given the
>   reset scheme is board specific (the chip can be found all over the place, but
>   the firmware loading scheme is 100% RPi specific), to what extent we can
>   introduce that as a binding?

I'm not sure what you're asking me here, you'll just have some reset
controller in a DT and a phandle from the xhci-controller to this reset
controller.
