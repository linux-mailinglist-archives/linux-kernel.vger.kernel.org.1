Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3D3293E62
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407930AbgJTONk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407926AbgJTONj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603203218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R16EbEDXYLBuqh4nIdDbRp7O0oRY2wnv3lXnFRIbqKI=;
        b=XFRswQp4/zXOXJyqNLYjXAGHiIgOZ6vHdBYyP5Y7Xw8h+xFOwyu0r88s5v1vqhrvyd21Z5
        wjBbqCL+z/0uA1TZdfbX9NtaSrVYi1ND2PKpYKPeo+iZQDR3OvrAPFZUgTUmbNI3dRo5bf
        ernnHQ0I/8pavyxjrjlPviwJb2dCtnE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-FHT61r7qPqKo-a9wwil6ow-1; Tue, 20 Oct 2020 10:13:35 -0400
X-MC-Unique: FHT61r7qPqKo-a9wwil6ow-1
Received: by mail-qv1-f70.google.com with SMTP id t13so1438297qvm.14
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 07:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R16EbEDXYLBuqh4nIdDbRp7O0oRY2wnv3lXnFRIbqKI=;
        b=MeL9aLTTX4BNewr4rd9E/zmv/1TIO8GFI0LMy+2AuDTZUN5nfS5SA3ADWqNIL6SaQ1
         q7yjSYzMkjfA4TjIYVb4xw363Z7gsUD7hPu/85yndJymGgVWBCb1PLPLQ9IYcWsd9ISV
         TohRlIO6EPGz6PshALMBgqVS5CUOes73KGeEZD9y7yhsqh3V8tgrxFyeMtL7bsomNdjJ
         8s17EMKVMg7ZwrM77QETEKz3nIC0F0rRmbIb3aPeDM0JxLnArM3JsEG8rHm8pVCYN1H4
         F64efyMR4v01gCsZNjIE1JDHzRq+g7LOSsN1bmC6gvwFNmywky7urE4J39+OwYeVS3dN
         FC6g==
X-Gm-Message-State: AOAM533dBalpAmUn5KM/OYgV8n8/5votTnprCbiyhvnfsdWG42+XbJOa
        4wEEOYtLcePHCjmMAVhzhFSe00OYmQcmS7HYWLFkEW08LH5P7V6/AEJcRLz+5MK5kx2dnutExbQ
        cyrfbnQat/21SeN6ojsDySMkp
X-Received: by 2002:a37:4244:: with SMTP id p65mr994615qka.141.1603203214566;
        Tue, 20 Oct 2020 07:13:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+u0NYgPuykSbBGly8cM+QOe6I8vZ8CSK1Vl+thq2i8Y9RMNBefXkQTQxBeCh/pM8txDvIng==
X-Received: by 2002:a37:4244:: with SMTP id p65mr994602qka.141.1603203214330;
        Tue, 20 Oct 2020 07:13:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e19sm806862qkl.94.2020.10.20.07.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 07:13:33 -0700 (PDT)
Subject: Re: [PATCH 1/2] fpga: dfl: add driver_override support
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
 <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
 <20201019040612.GA16172@yilunxu-OptiPlex-7050>
 <f767b9a0-1db8-7ced-6bd9-5ee1f58d40da@redhat.com>
 <20201020071158.GC28746@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <48cc1b5f-4bb1-260d-7b8b-9484d3f0a6ba@redhat.com>
Date:   Tue, 20 Oct 2020 07:13:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201020071158.GC28746@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/20/20 12:11 AM, Xu Yilun wrote:
>>>>>  int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
>>>>>  {
>>>>> -	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
>>>>> +	if (!dfl_drv || !dfl_drv->probe)
>>>> id_table is still needed for the normal case.
>>>>
>>>> Instead of removing this check, could you add something like
>>>>
>>>> || (!dfl_drv->is_override && !dfl_drv->id_table)
>>> I don't think it is needed. Seems is_override and !id_table are duplicated
>>> conditions for this implementation. And it may make confusing, e.g. could
>>> a driver been force matched when is_override is not set?
>>>
>>> I think we could make it simple, if the dfl driver didn't provide the
>>> id_table, normally it could not match any device. I think it could be
>>> easily understood by dfl driver developers.
>>>
>> Then an ASSERT should be added in dfl_bus_match() for id_entry.
> I didn't get your idea. What Assertion should be added for id_entry?
> BUG_ON(id_entry == NULL)? Then dfl-uio-pdev can't be inserted before
> driver_override is set.
>
> I think it is normal case that a driver is successfully registered but
> doesn't match any device because it provides no id_table.

Ok, i see your point.

Thanks for the explanation.

Tom


>
> Thanks,
> Yilun.
>

