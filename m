Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447462A4F45
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgKCSqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:46:19 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:49774 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgKCSqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:46:19 -0500
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.10])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ka1Jn-0001Zx-HT; Tue, 03 Nov 2020 18:46:07 +0000
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
To:     Cyril.Jean@microchip.com, atishp@atishpatra.org
Cc:     devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        Daire.McNamara@microchip.com, anup.patel@wdc.com,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        robh+dt@kernel.org, alistair.francis@wdc.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, Padmarao.Begari@microchip.com
References: <20201028232759.1928479-1-atish.patra@wdc.com>
 <20201028232759.1928479-3-atish.patra@wdc.com>
 <41f1248b-78c6-bac1-410b-9e222368c5f6@codethink.co.uk>
 <CAOnJCUJhQ=Zv0S4iCK4CDzQr_dfkw3J6ycdM=p6=5B2_sL1Ekg@mail.gmail.com>
 <2d7cc829-5df6-6b94-4c8f-9bae6080444e@codethink.co.uk>
 <CAOnJCULejyF9xyLk5M0TXqW_=nn0KM5aE8nhK+1h0Xayd2pKUg@mail.gmail.com>
 <fbe404b5-3bb1-dd00-e558-e4a55960b767@microchip.com>
 <fe079b4a-5410-5cc8-3f5e-8a95b573078a@codethink.co.uk>
 <21ded848-5dcb-ccbb-acd5-391bff667a53@microchip.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <0eb43b3e-e5dc-4d97-895e-b872ac1fcf05@codethink.co.uk>
Date:   Tue, 3 Nov 2020 18:46:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <21ded848-5dcb-ccbb-acd5-391bff667a53@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2020 18:40, Cyril.Jean@microchip.com wrote:
> On 11/3/20 6:28 PM, Ben Dooks wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
>> the content is safe
>>
>> On 03/11/2020 18:10, Cyril.Jean@microchip.com wrote:
>>> On 11/3/20 3:07 PM, Atish Patra wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>> know the content is safe
>>>>
>>>> On Fri, Oct 30, 2020 at 2:20 PM Ben Dooks
>>>> <ben.dooks@codethink.co.uk> wrote:
>>
>> ,snip[
>>
>>>>>> @Cyril : Can we enable both eMMC & sdcard at the same time ?
>>>>> I would put /both/ in but only enable the one in use for the moment.
>>>>> Our boards are booting of eMMC as supplied, so this isn't going to
>>>>> work
>>>>> as well. The eMMC is 8bit wide, and thus is only delivering 11MB/sec
>>>>> instead of 22MB/sec. This performance is still not great, but losing
>>>>> half the data-rate is just not good.
>>>>>
>>>> I am not sure what should be enabled by default. Updating sdcard is
>>>> much
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
> Currently, you need to program a different FPGA bitstream on  the board
> to boot from SD-card. The different bitstream configures muxes on the
> board to connect the SD slot to the FPGA and the HSS included in the bit
> stream configures the FPGA IOs correctly.
> 
> Links to the programming files are found in this document:
> https://github.com/polarfire-soc/polarfire-soc-documentation/blob/master/boards/mpfs-icicle-kit-es/updating-icicle-kit/updating-icicle-kit-design-and-linux.md

Thanks, but i've no way of remotely re-writing the bitstream
of the FPGA since the tools are x86 only and we're using a Pi3
to connect the boards we have to the network.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
