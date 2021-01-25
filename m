Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA6302E62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbhAYVxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732754AbhAYVwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:52:51 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE13C061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:52:11 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q1so29727363ion.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pk74GqvQTiSPW+FUOPYddOeICtN378ZPpEFtCJXJbA0=;
        b=c8bTmMXHBkJkpvbtDu2gGdS/MLwzA/mLVak69r3cJB4nQ9liPWEhnWRM8z/7tHOVGm
         5ET6+3GE5xFEL4ZKQbtmSf40Avz5Xy5pJWX6GBKQa9hhb+//XUSC8zX5bctDATrwaESE
         8Inl9/OmtfU6HbIOWAlBlkPMUlFLVI4ZrYgEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pk74GqvQTiSPW+FUOPYddOeICtN378ZPpEFtCJXJbA0=;
        b=lix1S1kmn+0dsYUXRq79A6X4GbsEHIvjTu1orqLCo8SEO1TIJ5uaWYgDwGaFD0sSqi
         bvP3wxwVyQAspOaL3pCgOhxf2Vi532vpu/0cD5vPYqu43ePI6s4mgJazx2K75zZitfD1
         IEbe5k+9KVBdugjDq7++5nnJpfBvwVpHgumGA1KPoCgzmL89WPgifd/Z7JcPfJe46Rb4
         qMP2+WQ/xurHGrjFbQxVwuB0WMqYa/NBYtQSLuKfgxGJP9OfW+6Ln9BraITlp8re/URQ
         6FM5EtDVUeyT+iPYNqiJyKcLdNxl9HPg3EATU0AtZ4IwfRJc2M/Xzwtx4SLHqsAWPAdH
         9BSg==
X-Gm-Message-State: AOAM5332TbraHvqV+VR3a5K+sxfm/8JXRiqjecbC9GmdYQrt9UupiV/Q
        nYcfnLSnOd0NrrpNmG0NV/6OFHAPuESo6w==
X-Google-Smtp-Source: ABdhPJxrxMSykjQyNqpzoOxI6zZcomBgjvqfIb1fsbR1F7KMwv92Lb1GGY51zj8UiRCsSTpDiJxDUg==
X-Received: by 2002:a5e:d603:: with SMTP id w3mr1944765iom.65.1611611530498;
        Mon, 25 Jan 2021 13:52:10 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e25sm11463984iom.40.2021.01.25.13.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 13:52:09 -0800 (PST)
Subject: Re: [PATCH v4 00/17] Miscellaneous fixes for resctrl selftests
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        David Binderman <dcb314@hotmail.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
 <YA8uZYiGFzee+UHD@otcwcpicx3.sc.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1d4c6c2c-55a7-d55d-e859-c2eccee25383@linuxfoundation.org>
Date:   Mon, 25 Jan 2021 14:52:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YA8uZYiGFzee+UHD@otcwcpicx3.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 1:47 PM, Fenghua Yu wrote:
> Hi, Shuah,
> 
> On Mon, Nov 30, 2020 at 08:19:53PM +0000, Fenghua Yu wrote:
>> This patch set has several miscellaneous fixes to resctrl selftest tool
>> that are easily visible to user. V1 had fixes to CAT test and CMT test
>> but they were dropped in V2 because having them here made the patchset
>> humongous. So, changes to CAT test and CMT test will be posted in another
>> patchset.
>>
>> Change Log:
>> v4:
>> - Address various comments from Shuah Khan:
>>    1. Combine a few patches e.g. a couple of fixing typos patches into one
>>       and a couple of unmounting patches into one etc.
> 
> Just a friendly reminder. Will you push this series to the upstream?
> Maybe I miss something but I don't see this series in the linux-kselftest
> tree yet.
> 

Sorry I am a bit behind on reviews. I will pull these fixes in this
week for 5.12-rc1 and will let you know if I would like changes.

thanks,
-- Shuah

