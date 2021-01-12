Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1CD2F29F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405042AbhALIZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:25:06 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:61058 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbhALIZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:25:06 -0500
Received: from [192.168.1.91] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id F262F7802C2;
        Tue, 12 Jan 2021 09:23:38 +0100 (CET)
Subject: Re: Old platforms: bring out your dead
To:     Arnd Bergmann <arnd@kernel.org>, Mans Rullgard <mans@mansr.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <034ff035-9c58-336d-c8f5-80bf40ad2fc1@free.fr> <yw1xpn2bcrhe.fsf@mansr.com>
 <CAK8P3a3mPHbh9ScEsF=L9HTofM5k72OQP-tA920o_r9ru-naDg@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <2d643ebc-09af-a809-eb3f-2aec8ecee501@free.fr>
Date:   Tue, 12 Jan 2021 09:23:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3mPHbh9ScEsF=L9HTofM5k72OQP-tA920o_r9ru-naDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2021 22:50, Arnd Bergmann wrote:

> On Mon, Jan 11, 2021 at 6:29 PM Måns Rullgård wrote:
> 
>> Marc Gonzalez writes:
>>
>>> Waiting for his take on the matter.
>>>
>>> I can point out some device-specific drivers that would become
>>> useless if tango support were dropped.
>>
>> I have tango3 and tango4 boards.  Can't say I'm using them for anything,
>> though.  With the entire platform dead at the vendor level, removal
>> seems like a reasonable choice.
> 
> Ok, thanks for confirming.

It's not just the platform that's dead.

The whole company has been liquidated :(

(The Z-Wave stuff lives on inside Silicon Labs)

https://www.prnewswire.com/news-releases/sigma-designs-announces-plan-for-final-distribution-of-0-285-per-share-to-shareholders-in-connection-with-its-voluntary-plan-of-liquidation-and-dissolution-301099186.html


The following drivers are tango-specific, and it might make sense
to remove them along with the platform?

drivers/watchdog/tangox_wdt.c
drivers/media/rc/tango-ir.c
drivers/media/rc/keymaps/rc-tango.c
drivers/irqchip/irq-tango.c
drivers/clk/clk-tango4.c
drivers/pci/controller/pcie-tango.c
drivers/thermal/tango_thermal.c
drivers/mtd/nand/raw/tango_nand.c
drivers/cpufreq/tango-cpufreq.c
drivers/clocksource/timer-tango-xtal.c

Mans, do you agree?

Regards.
