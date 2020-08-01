Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7B9235301
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 17:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHAPlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 11:41:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57661 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725841AbgHAPlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 11:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596296458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nQui1ORnPAKsuI1fhd31BLzq3dhoYk8J7BrcrmIiQ7Y=;
        b=GMNOdfV8wCIFms44bMF7STXgCMj5updnvMr0KRIXqpXbrkbA+RGsrQ+RVUnb9sQRAAwYzC
        8/G8Oa1BJgSkSGp50QiJvaNeXrsQFXfu9tdHcvG7H8bt0bI/Dxhmc3XmGZg8Z+LaQ7ouF3
        yBhfkVY4ZSNYglLry+sHqBw+SI5XafI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-meO6xYLTN0e3kpPgj7YxEg-1; Sat, 01 Aug 2020 11:40:57 -0400
X-MC-Unique: meO6xYLTN0e3kpPgj7YxEg-1
Received: by mail-qv1-f70.google.com with SMTP id v5so17591006qvr.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 08:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nQui1ORnPAKsuI1fhd31BLzq3dhoYk8J7BrcrmIiQ7Y=;
        b=dDK5RqAPyJ6G22uv1A41HTKGikSNP1+/L8IoxFNCt0E14qsLPluOMJxCpZlWH/+eTp
         iB4yhue4+XxG458M8ThlCljIQ+nsXZtZfYuxbfeJeVwShCKZFeklTBJyeP8l+ByWFBKu
         8YjUM14iFJAYGCE1BVJcGDNPXPH6OqU7wen8hvUwpa45WtfT8UcXCvacwEvEkXniffSG
         4gczbnPxTr0hcMPFGJSld7t+4Wllzu0tLDukSKIdYT0c6zzCP8faTjk1LDZ01k7IsEuB
         zJKCeNSGJ+yV24utoDWFs0Lqn8zplcPUuh9ye+78NOW3BPg9O9pXU+/GsDYR3DYgfh4Q
         y3vw==
X-Gm-Message-State: AOAM532lac2VXTp4UX1ku7s4tRgWldjkqclzTAAV1RfojULMQRWQq6Pg
        H9ycVnmyaWc43R2CCXzeffMsK1jmcvQew2228n9vh/rdXFtIlQtTNbUK8FxeMAQDYnpR84Il2cB
        dd6bIJuuPulsaEzHft4zMlMIN
X-Received: by 2002:a05:620a:a51:: with SMTP id j17mr9138470qka.379.1596296456608;
        Sat, 01 Aug 2020 08:40:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwb1zEjOToEa8dixgiMVuQZBz7J4GbATGr24cHiHBsdvkUHNiNmIZRnp/ckNVWvs57xuyQI3w==
X-Received: by 2002:a05:620a:a51:: with SMTP id j17mr9138463qka.379.1596296456387;
        Sat, 01 Aug 2020 08:40:56 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j61sm13491860qtd.52.2020.08.01.08.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2020 08:40:55 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] fpga: dfl: change data type of feature id to u16
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com
References: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
 <1595556555-9903-2-git-send-email-yilun.xu@intel.com>
 <316f86d4-7bba-f0c7-3dde-794df80d32e7@redhat.com>
 <20200731074837.GE1781@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1d8198f3-10d6-118c-f767-cef88fa871c6@redhat.com>
Date:   Sat, 1 Aug 2020 08:40:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200731074837.GE1781@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/31/20 12:48 AM, Xu Yilun wrote:
> On Sat, Jul 25, 2020 at 06:29:53AM -0700, Tom Rix wrote:
>> It would be good if the variable or element for the feature id had a consistent name.
>>
>>
>>> @@ -197,7 +197,7 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
>>>   * @id: unique dfl private feature id.
>>>   */
>>>  struct dfl_feature_id {
>>> -	u64 id;
>>> +	u16 id;
>>>  };
>> Is this structure needed ?
>>
>> Here is how it could be changed to 
>>
>> struct dfl_feature_driver {
>>
>> -    const dfl_feature_id *
>>
>> +    const u16 *id_table;
> This structure is to represent an id type, which is used to match
> fme/port owned features. It could be extended if some feature drivers
> needs driver_data.
>
> Actually I see some example of device_ids with similar structure, like:
>
>   struct mips_cdmm_device_id {
>   	__u8	type;
>   };
>
>   struct tee_client_device_id {
> 	uuid_t uuid;
>   };
>
Ok.

Reviewed-by: Tom Rix <trix@redhat.com>

> Thanks,
> Yilun.
>
>> ...
>>
>> Tom
>>
>>
>>>  
>>>  /**
>>> @@ -240,7 +240,7 @@ struct dfl_feature_irq_ctx {
>>>   */
>>>  struct dfl_feature {
>>>  	struct platform_device *dev;
>>> -	u64 id;
>>> +	u16 id;
>>>  	int resource_index;
>>>  	void __iomem *ioaddr;
>>>  	struct dfl_feature_irq_ctx *irq_ctx;
>>> @@ -371,7 +371,7 @@ struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
>>>  	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
>>>  
>>>  static inline
>>> -struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
>>> +struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
>>>  {
>>>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
>>>  	struct dfl_feature *feature;
>>> @@ -384,7 +384,7 @@ struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
>>>  }
>>>  
>>>  static inline
>>> -void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
>>> +void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
>>>  {
>>>  	struct dfl_feature *feature = dfl_get_feature_by_id(dev, id);
>>>  
>>> @@ -395,7 +395,7 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
>>>  	return NULL;
>>>  }
>>>  
>>> -static inline bool is_dfl_feature_present(struct device *dev, u64 id)
>>> +static inline bool is_dfl_feature_present(struct device *dev, u16 id)
>>>  {
>>>  	return !!dfl_get_feature_ioaddr_by_id(dev, id);
>>>  }

