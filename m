Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FF02A4F11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgKCSjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:39:22 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:49586 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728621AbgKCSjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:39:22 -0500
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.10])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ka1D4-0001Og-J3; Tue, 03 Nov 2020 18:39:10 +0000
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Cyril.Jean@microchip.com, devicetree@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daire McNamara <Daire.McNamara@microchip.com>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Padmarao Begari <Padmarao.Begari@microchip.com>
References: <20201028232759.1928479-1-atish.patra@wdc.com>
 <20201028232759.1928479-3-atish.patra@wdc.com>
 <41f1248b-78c6-bac1-410b-9e222368c5f6@codethink.co.uk>
 <CAOnJCUJhQ=Zv0S4iCK4CDzQr_dfkw3J6ycdM=p6=5B2_sL1Ekg@mail.gmail.com>
 <2d7cc829-5df6-6b94-4c8f-9bae6080444e@codethink.co.uk>
 <CAOnJCULejyF9xyLk5M0TXqW_=nn0KM5aE8nhK+1h0Xayd2pKUg@mail.gmail.com>
 <fbe404b5-3bb1-dd00-e558-e4a55960b767@microchip.com>
 <fe079b4a-5410-5cc8-3f5e-8a95b573078a@codethink.co.uk>
 <CAOnJCUKH77XDymG+jAUYHP+5TC2aabTR4f8jF6s6FqqQNR=_CQ@mail.gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <22800ecc-a91b-ee3c-4717-4ee8802f31a2@codethink.co.uk>
Date:   Tue, 3 Nov 2020 18:39:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAOnJCUKH77XDymG+jAUYHP+5TC2aabTR4f8jF6s6FqqQNR=_CQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2020 18:36, Atish Patra wrote:
> On Tue, Nov 3, 2020 at 10:28 AM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>
>> On 03/11/2020 18:10, Cyril.Jean@microchip.com wrote:
>>> On 11/3/20 3:07 PM, Atish Patra wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> On Fri, Oct 30, 2020 at 2:20 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>
>> ,snip[
>>
>>>>>> @Cyril : Can we enable both eMMC & sdcard at the same time ?
>>>>> I would put /both/ in but only enable the one in use for the moment.
>>>>> Our boards are booting of eMMC as supplied, so this isn't going to work
>>>>> as well. The eMMC is 8bit wide, and thus is only delivering 11MB/sec
>>>>> instead of 22MB/sec. This performance is still not great, but losing
>>>>> half the data-rate is just not good.
>>>>>
>>>> I am not sure what should be enabled by default. Updating sdcard is much
>>>> easier than eMMC card and we use that approach.
>>>>
>>>> @Cyril: Is there a way that we can enable both ?
>>>>
>>> Yes, we can enable both but this requires a modification to the FPGA
>>> design. One of the guys prototyped this while I was away. We will move
>>> this along. This will require reprogramming the FPGA with a new design
>>> and HSS version.
>>>
>>> Regards,
>>>
>>> Cyril.
>>
>> I either missed or couldn't find a way of forcing the boot mode to be
>> from the SD slot. Have I missed something? At the moment we'd like to
>> have more storage available as the ~7G free on the eMMC is not enough.
>>
> 
> I use tftpboot to load the kernel & DT from the network. SD card is
> enabled in this DT and Linux
> kernel uses SD slot instead of eMMC.
> 
> To summarize, eMMC is used for HSS & U-Boot while SD card is used for
> Linux which makes
> more storage available to Linux.
> 
> IMO, we should enable the sdcard for Linux DT until updated FPGA
> design & HSS is available.

Interesting as for me the default is for Linux to use the eMMC as
well. I can't see any way for forcing the selection lines in the
DT to say eMMC vs SD.

If there is a way of controlling the selection lines then it might
be possible to have both cards enabled with a bus selection MUX in
software.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
