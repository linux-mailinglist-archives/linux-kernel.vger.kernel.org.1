Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3752802AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbgJAPYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732346AbgJAPYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:24:08 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA2DC0613D0;
        Thu,  1 Oct 2020 08:24:07 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t76so5944259oif.7;
        Thu, 01 Oct 2020 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KJ0lcODlDXw8TFpUzIZHU1NHT1e5m+pkkR44QXUX9D8=;
        b=UpqkncCVYPBk6CEngOjcFt8TV1ZK9ulJhVAmhQvJnFNtjlcukqTAXXm2h1A4FRvCCE
         6FcRVuIH4PMTqkmUfWVs8GICsGHffaGS6A68OLWyT0NB0K8fUY9+3U9EmiCd3RTwZlaz
         6xsYenFK9PvKPTVyhd9/TsJFBW4Nvij2VmdfzOcRnbpo0H6dmO3Sq7xaO5kDQ8VvzHtS
         jHBbKwSNlsxg3E3keDVO5nU0EZKN1J0UO7Dxl3fez5IGXgAYnnsHiSCPLTDmhDX2BfIU
         bxpu4booygmdYXPpOkLgK2rnv/kQaPd9V8PtN6PB+dAnzkrCJ3PSAmtzFfxLb/nPIkiv
         luIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KJ0lcODlDXw8TFpUzIZHU1NHT1e5m+pkkR44QXUX9D8=;
        b=bKNNyJ50nNcl4jYvnll1L0UBetUzBgIRLtFvJ7GwCklXu2fRQlU5NZ8jqFHW+L6TUb
         EjH93AX+SxMU9i+CQm8LbprOZBjamwFxwEVCoOA8Rzepu4vmlVDaSwPwoEswzmb/slwX
         TP8pCxIDorBbEZk8f2+dwAgMVtePSNGAcooSej5pl0l6tXNB8W3xZ9ZJnm4SJFD4Qsz0
         0ThHd58g0dy05d3dVzt5cK+W39PwOSEzXR5zeY8ZNJ5tRwlSZQ+5YSe8QfAv0HGFzkRr
         Wx2s1p1s8Gf1p3aRKbad8QiOJeOzq2D46x9f/S7+iu4C7bQLJRHMAoUn1DiLC1HMQvFr
         6sJA==
X-Gm-Message-State: AOAM533YxCJL/QnBXpiLMWXCvXHg3PM2/bOLsdxvKg2xsX1/SMPkBJA4
        IQZwDyJlnqvecnJNdt++AXA=
X-Google-Smtp-Source: ABdhPJwrpGPqLMVfM2wcRhHnTEJGUs34nIG7oRnCQU6ATzSRekySaGpLjxWH4Uu/emYANCCDEtHBmg==
X-Received: by 2002:aca:dd42:: with SMTP id u63mr280800oig.135.1601565847127;
        Thu, 01 Oct 2020 08:24:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y24sm1373351ooq.38.2020.10.01.08.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 08:24:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 0/2] add Intel MAX 10 BMC MFD driver & hwmon sub driver
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     lee.jones@linaro.org, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com,
        mdf@kernel.org
References: <1600669071-26235-1-git-send-email-yilun.xu@intel.com>
 <20200930205249.GA241905@roeck-us.net>
 <20201001140834.GA5471@yilunxu-OptiPlex-7050>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <9f4ce33a-38b6-fc51-7632-27196b2947b3@roeck-us.net>
Date:   Thu, 1 Oct 2020 08:24:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001140834.GA5471@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 7:08 AM, Xu Yilun wrote:
> Hi Guenter,
> 
> On Wed, Sep 30, 2020 at 01:52:49PM -0700, Guenter Roeck wrote:
>> On Mon, Sep 21, 2020 at 02:17:49PM +0800, Xu Yilun wrote:
>>> I recently realized that maintainers may have trouble to apply patches to
>>> their trees if the patches depend on other being-reviewed patches. So I'm
>>> trying to wrapper the 2 patches into one patchset and let all the
>>> maintainers see the dependencies.
>>>
>>> But the patch version is then not aligned between the 2 patches. I'm not
>>> sure how to handle it. I just picked the smaller number on Subject, but
>>> you could still see their own version changes in commit message of each
>>> patch. Sorry if it makes confusing.
>>>
>>
>> If you started with separate patches, it would be much better to pick
>> the larger number, and add a note into the individual patch(es) stating
>> the reason for the gap. Everything else is highly confusing. I would not
>> be surprised if no one in the mfd world even looks at the mfd patch
>> since it went back from v6 (?) to v3 according to its subject line.
> 
> I got it. Thanks for your guide.
> 
> Fortunately, the mfd maintainer has replied and applied the mfd patch
> (the previous separate one). And I see you added a Reviewed-by for the hwmon
> patch, so I assume I don't have to do anything more, is it?
> 
Thanks for letting me know. I applied the hwmon driver.

Thanks,
Guenter

> I'll take care of the version number next time.
> 
> Thanks,
> Yilun
> 
>>
>> Thanks,
>> Guenter
>>
>>>
>>> Patch #1 implements the basic functions of the BMC chip for some Intel
>>> FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
>>> Intel MAX 10 CPLD.
>>>
>>> This BMC chip is connected to the FPGA by a SPI bus. To provide direct
>>> register access from the FPGA, the "SPI slave to Avalon Master Bridge"
>>> (spi-avmm) IP is integrated in the chip. It converts encoded streams of
>>> bytes from the host to the internal register read/write on the Avalon
>>> bus. So This driver uses the regmap-spi-avmm for register accessing.
>>>
>>> Patch #2 adds support for the hwmon sub device in Intel MAX 10 BMC
>>>
>>>
>>> Xu Yilun (2):
>>>   mfd: intel-m10-bmc: add Intel MAX 10 BMC chip support for Intel FPGA
>>>     PAC
>>>   hwmon: intel-m10-bmc-hwmon: add hwmon support for Intel MAX 10 BMC
>>>
>>>  .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 +
>>>  Documentation/hwmon/index.rst                      |   1 +
>>>  Documentation/hwmon/intel-m10-bmc-hwmon.rst        |  78 +++++
>>>  drivers/hwmon/Kconfig                              |  11 +
>>>  drivers/hwmon/Makefile                             |   1 +
>>>  drivers/hwmon/intel-m10-bmc-hwmon.c                | 334 +++++++++++++++++++++
>>>  drivers/mfd/Kconfig                                |  13 +
>>>  drivers/mfd/Makefile                               |   2 +
>>>  drivers/mfd/intel-m10-bmc.c                        | 164 ++++++++++
>>>  include/linux/mfd/intel-m10-bmc.h                  |  65 ++++
>>>  10 files changed, 684 insertions(+)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>>>  create mode 100644 Documentation/hwmon/intel-m10-bmc-hwmon.rst
>>>  create mode 100644 drivers/hwmon/intel-m10-bmc-hwmon.c
>>>  create mode 100644 drivers/mfd/intel-m10-bmc.c
>>>  create mode 100644 include/linux/mfd/intel-m10-bmc.h
>>>
>>> -- 
>>> 2.7.4
>>>

