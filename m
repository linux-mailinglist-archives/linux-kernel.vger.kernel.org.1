Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D02B0803
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgKLPBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:01:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39310 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgKLPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:01:12 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACF0jmv116692;
        Thu, 12 Nov 2020 09:00:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605193245;
        bh=+tTVYURRzxOUGW+xP6M4A5fIquJPbhAwZ7hMh22bcRU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=blBCd5cCC/9YhzHjQIaiE+jMy19WaNeFk2+g75XroXjK+yAzo8RUSyueHGjBD/yo4
         PDVwYai+e4lrEs2v7W1LmNM4aVl3fgoB0uIkXVL3aFHdUQY1YvpwZWUX0xFISLFBoh
         kTBkQyPMXEt2eroird2DtBKjiSAx/W6EvXpnfvfI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACF0jWv130951
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 09:00:45 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 09:00:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 09:00:45 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACF0gmG023890;
        Thu, 12 Nov 2020 09:00:43 -0600
Subject: Re: drivers/mtd/maps/physmap-bt1-rom.c:78:18: sparse: sparse: cast
 removes address space '__iomem' of expression
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
CC:     <linux-mtd@lists.infradead.org>, <kbuild-all@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <202011021254.XC70BaQT-lkp@intel.com>
 <20201110113827.hl5i27cpl6exo3md@mobilestation>
 <20201110163556.3e3423f6@xps13>
 <20201111192259.ovdyjcuue7fx2bqa@mobilestation>
 <20201112092715.7e466405@xps13>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <8cdc6166-7183-c8a9-5c27-93a511e6471a@ti.com>
Date:   Thu, 12 Nov 2020 20:30:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112092715.7e466405@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/20 1:57 PM, Miquel Raynal wrote:
> Hi Sergey,
> 
> Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote on Wed, 11 Nov
> 2020 22:22:59 +0300:
> 
>> On Tue, Nov 10, 2020 at 04:35:56PM +0100, Miquel Raynal wrote:
>>> Hi Serge,
>>>
>>> Serge Semin <Sergey.Semin@baikalelectronics.ru> wrote on Tue, 10 Nov
>>> 2020 14:38:27 +0300:
>>>   
>>>> Hello Miquel,
>>>>
>>>> A situation noted by the warning below won't cause any problem because
>>>> the casting is done to a non-dereferenced variable. It is utilized
>>>> as a pointer bias later in that function. Shall we just ignore the
>>>> warning or still fix it somehow?  
>>>   
>>
>>> Do you think the cast to a !__iomem value is mandatory here?  
>>
>> It's not mandatory to have the casting with no __iomem, but wouldn't
>> doing like this:
>> + 	shift = (ssize_t __iomem)src & 0x3;
>> be looking weird? Really, is there a good way to somehow extract the first
>> two bits of a __iomem pointer without getting the sparse warning?
> 
> I asked around me, what about trying uintptr_t?
> 

One more way is to use __force to tell sparse that this casting is
intentional:

       shift = (__force ssize_t)src & 0x3;


> Thanks,
> Miquèl
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
