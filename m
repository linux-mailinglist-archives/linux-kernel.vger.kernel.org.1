Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD32FEE7E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbhAUNZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:25:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731824AbhAUNVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611235202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fe58BLIexty2xmujDnCbY+8Tf1cyecAvfRgThTe/JUs=;
        b=HSodnuvOH/0WnwpSGIK/LVybD810QiCBSgDrCcMsomOUDHDAGrY1LtLCAgteb61NgvMpjA
        4m03m/XcKkgVNZ4qzzPGplzy+fYfEXgxuYkl8wMrdiXqFg3iv69mT6pLBl7IjY1olJxjS1
        7mdVtxWILvFtR3EnE5HhlJHFqHJB1u4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-oWmflDnQOcqlAhkWQFdBTA-1; Thu, 21 Jan 2021 08:20:00 -0500
X-MC-Unique: oWmflDnQOcqlAhkWQFdBTA-1
Received: by mail-qk1-f198.google.com with SMTP id q7so1540887qki.16
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fe58BLIexty2xmujDnCbY+8Tf1cyecAvfRgThTe/JUs=;
        b=XIpa9rCDV4aAw8HUHVLb5ovWleliao8xzSqYK9vy3EjUtbvrYUWgFZdwmiAwQpJ4L4
         ZjRr9V4U3dI+zTKyUEXjXGIUc6JBb38kG8LKoqEqai/aQwm+abx/7lHww0zLoPQC5szJ
         FdZkmmsfpPrE7MN2ywSv9GrLBnb8foEwMlEYGdbbwgeJaHlednxHFsiRc9HfUI4X8T/B
         Iuh3S6xPASHewK+m+bwwHnNT2DNacAASc6xm/QzdpvMFVY+ZYPziEtrTMZjGpgwtydNk
         r2T5Q3AZX7f8ikBHWo5086dFRlCxYSO4xDHynMoGhSmApbKQDEX7IBTHN7w4zRPlqIW1
         VVWg==
X-Gm-Message-State: AOAM532W/aalAlBHmuYob/T4yu/RycNBkvoSTNSzHv8Mb/rBQ2PKGhfD
        cIBeleIzp/uwTvk7/sd3FTxelBfWeZaaSSs4bCfx1JBCd60fZ3rPkTQuUoFFvA6HRgoeyjq6pCq
        bHqwG0bsXdLIopSOqSFuwjXhi
X-Received: by 2002:a0c:a789:: with SMTP id v9mr13886263qva.41.1611235199849;
        Thu, 21 Jan 2021 05:19:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDVKdP23zxA0pQ4Mkr+NkAMW0WFN8qDK9CFSoW7BvF1AzVctv3tUVf8v9yUR8XGBkHI0dStg==
X-Received: by 2002:a0c:a789:: with SMTP id v9mr13886245qva.41.1611235199654;
        Thu, 21 Jan 2021 05:19:59 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d71sm2145543qkc.75.2021.01.21.05.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 05:19:58 -0800 (PST)
Subject: Re: [PATCH 2/2] mfd: intel-m10-bmc: add access table configuration to
 the regmap
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1611110081-10056-1-git-send-email-yilun.xu@intel.com>
 <1611110081-10056-2-git-send-email-yilun.xu@intel.com>
 <0f17f8a7-d2f5-e88e-b3dc-0a75ea7f5ada@redhat.com>
 <20210121080554.GA1943@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <82884394-f8aa-4957-04c3-285381e13d57@redhat.com>
Date:   Thu, 21 Jan 2021 05:19:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210121080554.GA1943@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/21/21 12:05 AM, Xu Yilun wrote:
> On Wed, Jan 20, 2021 at 07:32:53AM -0800, Tom Rix wrote:
>> On 1/19/21 6:34 PM, Xu Yilun wrote:
>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>
>>> This patch adds access tables to the MAX 10 BMC regmap. This prevents
>>> the host from accessing the unwanted I/O space. It also filters out the
>>> invalid outputs when reading the regmap debugfs interface.
>>>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>> ---
>>>  drivers/mfd/intel-m10-bmc.c       | 14 ++++++++++++++
>>>  include/linux/mfd/intel-m10-bmc.h |  5 ++++-
>>>  2 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
>>> index b84579b..0ae3053 100644
>>> --- a/drivers/mfd/intel-m10-bmc.c
>>> +++ b/drivers/mfd/intel-m10-bmc.c
>>> @@ -23,10 +23,24 @@ static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
>>>  	{ .name = "n3000bmc-secure" },
>>>  };
>>>  
>>> +static const struct regmap_range m10bmc_regmap_range[] = {
>>> +	regmap_reg_range(M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER,
>>> +			 M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER),
>> If this is the only value in the legacy map to be accessed, could it have its own #define ?
>>
>> Something like
>>
>> #define M10BMC_LEGACY_BUILD_VER ?
> Yes, it could be more clear. I'll change it.
>
>>> +	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
>>> +	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END),
>>> +};
>>> +
>>> +static const struct regmap_access_table m10bmc_access_table = {
>>> +	.yes_ranges	= m10bmc_regmap_range,
>>> +	.n_yes_ranges	= ARRAY_SIZE(m10bmc_regmap_range),
>>> +};
>>> +
>>>  static struct regmap_config intel_m10bmc_regmap_config = {
>>>  	.reg_bits = 32,
>>>  	.val_bits = 32,
>>>  	.reg_stride = 4,
>>> +	.wr_table = &m10bmc_access_table,
>>> +	.rd_table = &m10bmc_access_table,
>> The legacy build ver should only be read, so shouldn't these tables be different ?
> I'm not sure if a register could be regarded as writable if hardware
> ensures writing it has no effect but makes no harm. Usually these
> registers are marked as RO in spec.
>
> I think it could be quite common case in hardware design. But it could
> be trivial if we pick every such register out of wr_table. I just want
> to define the valid reg range.
>
> So could I keep the current implementation?

I mean that the write table would not have first element the read table has because it has the single ro entry.

The other ranges i am sure have ro's and are not worth breaking apart.

If something like

.wr_table = &m10bmc_access_table[1] doesn't work or looks to hacky, i don't mind leaving it as-is.

Tom

>
> Thanks,
> Yilun
>

