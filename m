Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A627273ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIVJs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIVJs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:48:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01297C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:48:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so16309556wrw.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pIqBqr25RTew7nCCSy59m+1K+uSBvvx4TjwvpiWNlNM=;
        b=mCHXNAC578mbIrSvVDZAtSj66PHCgNxNthSZVhHioeeGhwCeeEAgYU3zvw7Nus+jy4
         XkQLO5ldB+3ZCqEtkGVYPfahzIxrQHAF13Sb3EqL8TAU7fHiv5MR5VDba5L1sMulASuX
         2X/itDb+tIJd2MUatMnzCm/qiJl7DfFOYNThiR/ytT0ZupZ6R/l0mr4XwSodTvsye7ZW
         9ZnVGDFkrBJqYe7xUqBOCQD2QOwWOu9d6UNQPYTrpDPq7DE6CdLfjKqt5FKsxe53Atq+
         lfzEsO6PWzcU9JxdMbzUMqKTs9QPnUZxjI7ao4pDtAI7hn58onFChONX0YvPfFuLDYIe
         qFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pIqBqr25RTew7nCCSy59m+1K+uSBvvx4TjwvpiWNlNM=;
        b=i1SiADrohR1Et9xZ6N9RKB0glsiBcgRGWaafNvpR0I79WF4+5FztMoKXstMCiSFjuN
         fiNFzpdVM0jkvz/h7D9FAzKvCQD76YZqqxhGarDwHVns/ClwpKMXlPHbWOfBbu0CoZO9
         lHTLsyzZ464ZZOj+G1bTna4rrY/9jqFk/afGZIzbcJYjJQeeNYPVIX9dRoI6VtkW9nSX
         /0Xxlnf1Pt0tOks22zHwZ+utfg54QmUF/g2CigL5EG+CYEwR4M1yuQ0DGYCOHYKQo7oR
         BOv1wjSAWZxoDiPc7NXa0uLnqUeFuApTnfVWM2P1lrCB5s8xexzjej7wutLakmRoeiQt
         w+eQ==
X-Gm-Message-State: AOAM5307xYZ4UpdnfgrCksU1a0Gw4dFl4LSZs/SJwUu0ibSn+T7E4cfg
        5GnMAJj92gORjeimE7qKR82GcQ==
X-Google-Smtp-Source: ABdhPJy/uYI1z/NjmcbXrIO5SvnwhctmERw7OJ5m4MyWHV/2hTVUxTI2trfCUVJSrn1JFsOtGhCMlg==
X-Received: by 2002:a5d:470f:: with SMTP id y15mr4296842wrq.420.1600768104666;
        Tue, 22 Sep 2020 02:48:24 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id o16sm23650673wrp.52.2020.09.22.02.48.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 02:48:24 -0700 (PDT)
Subject: Re: [PATCH 0/3] nvmem: add ONIE NVMEM cells provider
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20200915124116.7196-1-vadym.kochan@plvision.eu>
 <20200921235641.GI31031@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f7f47794-2641-514a-8905-3f4c800f199d@linaro.org>
Date:   Tue, 22 Sep 2020 10:48:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200921235641.GI31031@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/09/2020 00:56, Vadym Kochan wrote:
> Hi Srinivas,
> 
> On Tue, Sep 15, 2020 at 03:41:13PM +0300, Vadym Kochan wrote:
>> This series adds cells parser for the ONIE TLV attributes which are
>> stored on NVMEM device. It adds possibility to read the mac address (and
>> other info) by other drivers.
>>
>> Because ONIE stores info in TLV format it should be parsed first and
>> then register the cells. Current NVMEM API allows to register cell
>> table with known cell's offset which is not guaranteed in case of TLV.
>>
>> To make it properly handled the NVMEM parser object is introduced. The
>> parser needs to be registered before target NVMEM device is registered.
>> During the registration of NVMEM device the parser is called to parse
>> the device's cells and reister the cell table.
>>
>> Vadym Kochan (3):
>>    nvmem: core: introduce cells parser
>>    nvmem: add ONIE nvmem cells parser
>>    dt-bindings: nvmem: add description for ONIE cells parser
>>
>>   .../bindings/nvmem/onie,nvmem-cells.txt       |  11 +
>>   drivers/nvmem/Kconfig                         |   9 +
>>   drivers/nvmem/Makefile                        |   3 +
>>   drivers/nvmem/core.c                          |  80 ++++
>>   drivers/nvmem/onie-cells.c                    | 370 ++++++++++++++++++
>>   include/linux/nvmem-provider.h                |  30 ++
>>   6 files changed, 503 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/onie,nvmem-cells.txt
>>   create mode 100644 drivers/nvmem/onie-cells.c
>>
>> -- 
>> 2.17.1
>>

Hi Vdaym,

Am totally confused with this patchset, There is no versioning in any of 
your patches, you always send it with PATCH, please add version so that 
I know which one should I review!

This makes my mailbox totally confused with all the patches with same 
subject prefix!

Please note that maintenance is not my full time job, so please be 
patient and I can try shift gears as an when possible!

> 
> I sent a newer version than this one which actually registers nvmem provider
> and does not require changes in the core.c
This is a NO-NO as onie is not a real provider here, at24 is the actual 
nvmem provider in your case.

Why do you keep changing the total approach here! what is the reasoning 
to do so!
As I said in my last review we were okay with this parser approach!

I don't mind having changes in core as long as it done properly!


thanks,
srini




> 
> Thanks,
> Vadym Kochan
> 
