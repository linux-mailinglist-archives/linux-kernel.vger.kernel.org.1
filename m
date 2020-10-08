Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8728759C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgJHOFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbgJHOFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:05:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87407C061755;
        Thu,  8 Oct 2020 07:05:40 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id h24so8278567ejg.9;
        Thu, 08 Oct 2020 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kPpNp7HQz7UHlrpDvLUJLo4PAvXZ3Nb4CdHDpoCaGGg=;
        b=Gg5S4v6W4SNBKOtE0DRe00bJbqQKBlNkL1AiFmnshg453TbDlkl3jzDB665kpyeCn+
         GQde6shP6e4dmLgIvaW58HJE9WcgRTyUrmACYz9aM/T3whDoe3yFAQh++ryuNRKmZS3f
         a5uwIvwZHQc8e55VcQGzyOORcNfP7n0VKv8c6FHxrcskh+hx0SXqoZTCIJQ+PJxEntC9
         ftdrQoVFr89KiD7ZiuvZeMRmhKqYJPxdN7syMGKxITiMa3TsSUi05nyzH5P7tc+zA5nh
         E9jS1YG26FrfeBX0yzbsfRUPqL83H4uqTk4L//J/Q6qNrUA9HOhs7YYltmA+Xf1l6CrX
         u4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kPpNp7HQz7UHlrpDvLUJLo4PAvXZ3Nb4CdHDpoCaGGg=;
        b=ArRcc0vOC0rVXPrzqfMgUHlLkJjj43/8Ydtl03RR2idIYp/sB9A69DkRPDDrJoexYi
         FbKEsfj94oxo3tTdaYW10TGSnEbspoeuk/xP3wcZkaKwIFsHTX/Yw0VMNqFiTjMhbcG2
         PT5fs1qAcX0z42Ds4OJ7LkaIAAjcE/y6FHYsJ8UPmaou0fnJb/IDh0+Q9QbucEV3SDnT
         BmOH4hzYf2KOqYD4xvAFfP1kpaiDOan+2/mWb+FzfibRVQ8NeUPSdkm4JrrGI+lKFtWE
         FnmjaQ9KARXMH4SiAGP0HEZAvyv5gc22oGeZkUDfiKHPBoL/TkPs2ZWK1xFzg4k1bqyx
         n2Pg==
X-Gm-Message-State: AOAM5319SF9Labuu7lyof1w/+djx34O5u6gS2Fal3SXuiNv/mXMPrBCg
        CTU3sqV+XV1lOW4TCDF86qSyHImytSo=
X-Google-Smtp-Source: ABdhPJzm3xf5HqWAQ69Q+Cim+f5cHME6E0emdTSV4HCZqqohLnM6ELLVXPpVSfWC3El6jKNnIhyFBQ==
X-Received: by 2002:a17:906:7e47:: with SMTP id z7mr8771478ejr.418.1602165938706;
        Thu, 08 Oct 2020 07:05:38 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9e4.dip0.t-ipconnect.de. [217.229.169.228])
        by smtp.gmail.com with ESMTPSA id f4sm3995848edm.76.2020.10.08.07.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 07:05:37 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] platform/surface: Create a platform subdirectory
 for Microsoft Surface devices
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
References: <20201005160307.39201-1-luzmaximilian@gmail.com>
 <a82e3aff-801d-d116-bbf4-91f3981f713b@redhat.com>
 <deb1c682-5843-61b1-173b-a70ef51e85f2@gmail.com>
 <389f3a38-83ca-dfcd-476a-61b1d33751bb@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <9c9b1122-ca6c-6c90-8bb8-d0bdb792d04f@gmail.com>
Date:   Thu, 8 Oct 2020 16:05:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <389f3a38-83ca-dfcd-476a-61b1d33751bb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 3:38 PM, Hans de Goede wrote:
> Hi,
> 
> On 10/8/20 2:32 PM, Maximilian Luz wrote:
>> On 10/8/20 1:44 PM, Hans de Goede wrote:
>>> Hi Maximilian,
>>>
>>> On 10/5/20 6:03 PM, Maximilian Luz wrote:
>>>> As has come up in the discussion around
>>>>
>>>>    [RFC PATCH] Add support for Microsoft Surface System Aggregator Module
>>>>
>>>> it may make sense to add a Microsoft Surface specific platform
>>>> subdirectory. Andy has suggested drivers/platform/surface for that.
>>>> This series follows said suggestion and creates that subdirectory, as
>>>> well as moves Microsoft Surface related drivers over to it and updates
>>>> their MAINTAINERS entries (if available) accordingly.
>>>>
>>>> This series does not modify any existing driver code, symbols, or help
>>>> text.
>>>
>>> In case you do not know I'm taking over from any as
>>> drivers/platform/x86 maintainer.
>>>
>>> I'm fine with the concept of this series, but who is going to maintain
>>> this new drivers/platform/surface directory ?
>>>
>>> Ah I see that the first patch answers that question and the plan
>>> is to keep this part of the pdx86 maintainership.
>>>
>>> I would prefer for the new dir to have its own
>>> MAINTAINERS entry if I'm honest, I would like to try and
>>> split maintainership for the surface stuff as follows:
>>>
>>> 1. Who will review (and add their Reviewed-by or ask for improvements
>>>     or nack) patches to files in this dir?
>>>
>>> 2. Who will gather approved patches apply them to a for-next branch
>>>     and send them out to Linus during the merge Window?
>>>
>>> I can pick up 2. but I could really use some help with 1. So I
>>> was thinking having a separate MAINTAINERS entry for the new
>>> dir with you (Maximilian) (and me and Mark Gross) listed as
>>> MAINTAINERS; and then I'm hoping that you can do the review
>>> of surface related patches. At least those which you have not
>>> written yourself.
>>>
>>> How does that sound ?
>>
>> Sounds good, I'd be happy to help review and approve any Surface related
>> patches. However, I think it would be beneficial if you and Mark still
>> have a final look (and say) over the ones I've reviewed and accepted (if
>> that's not already a given). I feel like I may lack a bit of experience
>> for this job and might miss some things.
> 
> Since Mark or I will be merging the patches we will indeed still take
> a look at them, but it helps if someone else has already done a review
> first.

Perfect, thank you! I'll take on 1) then.

Regards,
Max
