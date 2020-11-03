Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E522A495D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgKCPUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:20:46 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:42836 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728386AbgKCPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:19:20 -0500
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.10])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kZy5T-0003Yi-Uc; Tue, 03 Nov 2020 15:19:07 +0000
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
To:     Atish Patra <atishp@atishpatra.org>
Cc:     devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Padmarao Begari <padmarao.begari@microchip.com>
References: <20201028232759.1928479-1-atish.patra@wdc.com>
 <20201028232759.1928479-3-atish.patra@wdc.com>
 <41f1248b-78c6-bac1-410b-9e222368c5f6@codethink.co.uk>
 <CAOnJCUJhQ=Zv0S4iCK4CDzQr_dfkw3J6ycdM=p6=5B2_sL1Ekg@mail.gmail.com>
 <2d7cc829-5df6-6b94-4c8f-9bae6080444e@codethink.co.uk>
 <CAOnJCULejyF9xyLk5M0TXqW_=nn0KM5aE8nhK+1h0Xayd2pKUg@mail.gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <fc07251a-5339-781b-f12a-abfda5d5d2a2@codethink.co.uk>
Date:   Tue, 3 Nov 2020 15:19:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAOnJCULejyF9xyLk5M0TXqW_=nn0KM5aE8nhK+1h0Xayd2pKUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2020 15:07, Atish Patra wrote:
>>> We could just modify the reg size but to allow more memory. I tried
>>> that for Linux but it didn't boot.
>>> Probably, DDR init code in HSS only initialized 1GB of memory.
>> Yes, it is only looking at the low window which is 1GiB max.
>> If it used the upper window it would get the 16GiB.
>>
>> I don't know how no-one noticed this issue before shipping a board
>> out with this. I have updated the firmware on my second board but
>> this only seems to currently fix a reboot issue with the eMMC.
>>
> We can't update the DT for Linux until there is a public release of
> the updated firmware
> with 2GB enabled.

Yeah, it is really annoying the boards turned up with a number of
issues including the half memory.

I assume there will be a new release of HSS and U-boot which at
worse can insert new memory nodes into the device tree.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
