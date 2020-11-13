Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0782B21C4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKMRPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:15:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45412 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgKMRPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:15:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADHFcxD127934;
        Fri, 13 Nov 2020 11:15:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605287738;
        bh=gBb8CrJsx5928mCSkbAA9gnC9Wr73FmMSmBAA/1lWWs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jUzLocW1L3vTUgvQ9irOnS4mAmIFNLs7EBxM/eEXebWk1EltjJksac3N8VpLGEgAp
         7ZmIt7cAzq0kt+NDJASAnCfz2EwSp61/uK8o/O0ZspB9292boiBB4GPV6/eu0vqQE6
         wGgHWZSByMNE9PaX8kwUmTXcrSwhTUafeOwMtEJ0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADHFcpY008119
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 11:15:38 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 11:15:38 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 11:15:37 -0600
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADHFYrF033418;
        Fri, 13 Nov 2020 11:15:35 -0600
Subject: Re: [PATCH v3] arm64: defconfig: Enable GPIO and I2C configs for TI's
 J721e platform
To:     Nishanth Menon <nm@ti.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>
References: <20201113154905.40095-1-nsekhar@ti.com>
 <20201113170441.2hvvqcnscpd7hos7@enigmatic>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <f0f2056e-a386-40d6-5824-f7657860d41f@ti.com>
Date:   Fri, 13 Nov 2020 22:45:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201113170441.2hvvqcnscpd7hos7@enigmatic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/20 10:34 PM, Nishanth Menon wrote:
> On 21:19-20201113, Sekhar Nori wrote:
>> From: Faiz Abbas <faiz_abbas@ti.com>
>>
>> Add configs to help enable regulators that supply power to the SD card
>> on TI's J721e platform. These regulators are controlled by either
>> SoC gpios or gpios over i2c expander.
>>
>> vmlinux size before and after patch follow:
>>
> Sekhar,
> 
>> Before:
>>    text	   data	    bss	    dec	    hex	filename
>> 19755448	10376346	 535572	30667366	1d3f266	vmlinux
>>
>> After:
>>    text	   data	    bss	    dec	    hex	filename
>> 19769232	10381390	 536212	30686834	1d43e72	vmlinux
>>
>> difference is 19,468 (dec)
>>
>> Acked-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>> changes in v3:
>> - add size delta as requested by Nishanth Menon
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git/commit/?h=ti-k3-config-next&id=6b133f475a97a0839f02e3c0b937886b9adc2933
> 
> https://lore.kernel.org/linux-arm-kernel/20201103190821.30937-1-faiz_abbas@ti.com/
> 
> 
> Is this a duplicate patch?

Looks like, please discard. For some reason, Faiz's v3 did not show-up
in my inbox and v2 applied cleanly to linux-next/master. So I assume it
was not refreshed.

Thanks,
Sekhar
