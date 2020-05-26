Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4CB1ABD2D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 11:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504178AbgDPJqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 05:46:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:55876 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503869AbgDPJp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:45:56 -0400
IronPort-SDR: Eo5fOFPIGvMFeDuS3Gz1W6ye7aB7nPF17nVDs4PGx9OMTyOYa6l+vhQo6xu7VlwvxjQrYlthh1
 OWasrlN0v4KQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 02:45:55 -0700
IronPort-SDR: uSQh+hX50YnRkloy/db7+gNn6Ed8ye9wELa15zrSDQYMwy8d+7rAXv/HmCEDBKA1fbb2S2kQ8l
 XXetNlZgM0Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="288839657"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 16 Apr 2020 02:45:55 -0700
Received: from [10.255.154.239] (vramuthx-MOBL1.gar.corp.intel.com [10.255.154.239])
        by linux.intel.com (Postfix) with ESMTP id 850725802A4;
        Thu, 16 Apr 2020 02:45:50 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        anders.roxell@linaro.org, andriy.shevchenko@intel.com,
        arnd@arndb.de, brendanhiggins@google.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, masonccyang@mxic.com.tw,
        miquel.raynal@bootlin.com, piotrs@cadence.com,
        qi-ming.wu@intel.com, richard@nod.at, robh+dt@kernel.org,
        tglx@linutronix.de, vigneshr@ti.com
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
 <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com>
 <20200416113822.2ef326cb@collabora.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <18568cf6-2955-472e-7b68-eb35e654a906@linux.intel.com>
Date:   Thu, 16 Apr 2020 17:45:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416113822.2ef326cb@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

     Thank you for prompt reply...

On 16/4/2020 5:38 pm, Boris Brezillon wrote:
> On Thu, 16 Apr 2020 17:35:26 +0800
> "Ramuthevar, Vadivel MuruganX"
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
>> Hi Martin,
>>
>>       Thank you so much for review comments and your time...
>>
>> On 16/4/2020 6:05 am, Martin Blumenstingl wrote:
>>> Hi,
>>>
>>> first of all: thank you for working on upstreaming this.
>>> Especially since you are going to use the new exec_op style in v2 as
>>> Boris suggested.
>>>   
>>>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>>
>>>> This patch adds the new IP of Nand Flash Controller(NFC) support
>>>> on Intel's Lightning Mountain(LGM) SoC.
>>>>
>>>> DMA is used for burst data transfer operation, also DMA HW supports
>>>> aligned 32bit memory address and aligned data access by default.
>>>> DMA burst of 8 supported. Data register used to support the read/write
>>>> operation from/to device.
>>> I am wondering how this new hardware is different from the Lantiq NAND
>>> controller IP - for which there is already a driver in mainline (it's
>>> in drivers/mtd/nand/raw/xway_nand.c).
>>> The CON and WAIT registers look suspiciously similar.
>>>
>>> As far as I understand the "old" SoCs (VRX200 and earlier) don't have
>>> a built-in ECC engine. This seems to have changed with ARX300 though
>>> (again, AFAIK).
>>>
>>> A bit of lineage on these SoCs (initially these were developed by
>>> Infineon. Lantiq then started as an Infineon spin-off in 2009 and
>>> was then acquired by Intel in 2015):
>>> - Danube
>>> - ARX100 from 2008/2009
>>> - VRX200 from 2009/2010
>>> - ARX300 from 2014
>>> - GRX350 from 2015/2016
>>> - GRX550 from 2017
>>> - and now finally: LGM from 2020 (est.)
>>>
>>> The existing xway_nand driver supports the Danube, ARX100 and VRX200
>>> SoCs.
>> Lantiq upstreamed a driver for an older version of this IP core 8 years
>> ago, see here:
>> https://elixir.bootlin.com/linux/v5.5.6/source/drivers/mtd/nand/raw/xway_nand.c
>> It does not support DMA and ECC.
> Then let's just extend this driver to support the new features. Plus,
We do not have the platform to test also it's very old legacy driver .
> we'll be happy to have one more of the existing driver converted to
> ->exec_op() ;-).

I have completely adapted to ->exec_op() hook up to replace the legacy 
call-back.

Regards
Vadivel
>
>> This upstream driver works with the xrx200, I do not know how well it
>> works with other SoCs.
>>
>> Regards
>> Vadivel
>>>
>>> Best regards,
>>> Martin
