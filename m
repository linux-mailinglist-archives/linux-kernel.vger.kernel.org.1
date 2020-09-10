Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105A926539D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgIJVhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 17:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730821AbgIJNdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599744760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4qA3qviw6m2U5bouThH9BshQDOJ+dWQbRHt8FhhG/I=;
        b=DrAKXqivoB7+qssZLRActQm7l92dVHgi6WrJbyaIt0048wZlnGN9oZTA/6uH7pbhJfM4tb
        EWxO7WjlGDn2DMURKYt9EDfLFXxjgiyp4g48vDLYl4ntXZytMJzkIPicKM8ePc8RstujBA
        XZSra5i/JtCYwwNpR17gXucc3ghkWOQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-NL2UZqZVOWCwqTe4R3y8BQ-1; Thu, 10 Sep 2020 09:32:38 -0400
X-MC-Unique: NL2UZqZVOWCwqTe4R3y8BQ-1
Received: by mail-qk1-f200.google.com with SMTP id w64so3581145qkc.14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F4qA3qviw6m2U5bouThH9BshQDOJ+dWQbRHt8FhhG/I=;
        b=WNPi6AOkUnBKCyZRjN+XT5bBD5DqMxg4xWs1SsUEGku2iRj3/mg9AsG5GqrQ9iF2R3
         uFh7rEw3BlURDDQlpDEPMcp09/99MURXH8ZGVYSWk5xqakR9+usykSFIxgSPloWtxJYc
         BmXeUBmJ1G84YUbI7DltKcoUyUiPnZz0TgKsz3+u4sw3Yi51Gb9kkZcXQiS3bXgmpTZ5
         W2WLRtG9s5Nh7SoNOeT77Q8SQbCCzcC2xvJeuebfx9zJ8sBv9b/QT66rkJhEHeJPdVu7
         GF1KoFhguvgU+Anp7agDHzYH8yXhuawugf667f/NA2guJNwZz9/1XoV2ogyOtST/DJem
         Vdog==
X-Gm-Message-State: AOAM530fgPBze5Bnjh1nipvs8O9ZudUxB35WwW1HCd5gaINKUcfVRH4d
        peYf4PRgx6T2Urwihb0ab+Ttv80Z4REYXqcE1RrizSkmeqUJodHw0NzN2wdr40a1Kl1nFWg0KVJ
        UUqDbM38VlYaH0KnCv/WF8iK2
X-Received: by 2002:a05:620a:211c:: with SMTP id l28mr7583806qkl.395.1599744758388;
        Thu, 10 Sep 2020 06:32:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBV7Ulx+mj0dlREn3NNIDAGe2qZipF1FAEAN8uT1JX7RkZ6JX1bJbKzHE5pqTU+xaACTCxoQ==
X-Received: by 2002:a05:620a:211c:: with SMTP id l28mr7583779qkl.395.1599744758095;
        Thu, 10 Sep 2020 06:32:38 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b199sm6426926qkg.116.2020.09.10.06.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 06:32:37 -0700 (PDT)
Subject: Re: [PATCH 1/3] fpga: dfl: move dfl_device_id to mod_devicetable.h
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
 <1599544129-17594-2-git-send-email-yilun.xu@intel.com>
 <aaa2d9a5-f5ae-d026-91c9-730403f04050@redhat.com>
 <20200910084106.GB16318@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ad9ba1cf-e02f-c09e-f639-2df60f080e5f@redhat.com>
Date:   Thu, 10 Sep 2020 06:32:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200910084106.GB16318@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/10/20 1:41 AM, Xu Yilun wrote:
> On Wed, Sep 09, 2020 at 05:55:33AM -0700, Tom Rix wrote:
>> On 9/7/20 10:48 PM, Xu Yilun wrote:
>>> In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
>>> patch moves struct dfl_device_id to mod_devicetable.h
>>>
>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>> Signed-off-by: Wu Hao <hao.wu@intel.com>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>> ---
>>>  drivers/fpga/dfl.h              | 13 +------------
>>>  include/linux/mod_devicetable.h | 12 ++++++++++++
>>>  2 files changed, 13 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
>>> index 5dc758f..d5b0760 100644
>>> --- a/drivers/fpga/dfl.h
>>> +++ b/drivers/fpga/dfl.h
>>> @@ -26,6 +26,7 @@
>>>  #include <linux/slab.h>
>>>  #include <linux/uuid.h>
>>>  #include <linux/fpga/fpga-region.h>
>>> +#include <linux/mod_devicetable.h>
>>>  
>>>  /* maximum supported number of ports */
>>>  #define MAX_DFL_FPGA_PORT_NUM 4
>>> @@ -526,18 +527,6 @@ enum dfl_id_type {
>>>  };
>>>  
>>>  /**
>>> - * struct dfl_device_id -  dfl device identifier
>>> - * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
>>> - * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
>>> - * @driver_data: driver specific data.
>>> - */
>>> -struct dfl_device_id {
>>> -	u8 type;
>>> -	u16 feature_id;
>>> -	unsigned long driver_data;
>>> -};
>>> -
>>> -/**
>>>   * struct dfl_device - represent an dfl device on dfl bus
>>>   *
>>>   * @dev: generic device interface.
>>> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
>>> index 5b08a47..407d8dc 100644
>>> --- a/include/linux/mod_devicetable.h
>>> +++ b/include/linux/mod_devicetable.h
>>> @@ -838,4 +838,16 @@ struct mhi_device_id {
>>>  	kernel_ulong_t driver_data;
>>>  };
>>>  
>>> +/**
>>> + * struct dfl_device_id -  dfl device identifier
>>> + * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
>>> + * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
>>> + * @driver_data: driver specific data.
>>> + */
>>> +struct dfl_device_id {
>>> +	__u8 type;
>>> +	__u16 feature_id;
>> I thought i saw feature id's going to 64 bit, does this type need to expand ?
> Feature id is a 12bit field in DFL spec. Previously we define it u64
> cause we are considering it may expand sometime. But now seems GUID will
> be used in future design.
>
> And the header file will be used by modpost, which is not supporting u64
> now. So it is not necessary we use u64 for extra work. A patch is
> already applied for this change - "change data type of feature id to u16"
>
> Thanks,
> Yilun

Thanks for the explanation.

Reviewed-by: Tom Rix <trix@redhat.com>

>
>> TomÃ‚Â 
>>
>>> +	kernel_ulong_t driver_data;
>>> +};
>>> +
>>>  #endif /* LINUX_MOD_DEVICETABLE_H */

