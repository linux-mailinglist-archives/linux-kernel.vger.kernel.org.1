Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E22E28744B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgJHMdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730031AbgJHMdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:33:02 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AADC061755;
        Thu,  8 Oct 2020 05:33:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v19so5639189edx.9;
        Thu, 08 Oct 2020 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wutsq0w67FFOmYL9AjxDGdsGlmIL42b8TT5TUqNaum4=;
        b=G2PrL0zqW68mvLQQIF+2g2b5Gvqi/3aiYkzMzmtKqKJ6psVXhOlnI03I3OH3oDfLDy
         u6gVUJvpQDOtM720gDyHL/GD2NSMD9LE51VFEzKqcgjvHx3kHtygcwPY73bXtJB6sGZD
         s57IC7voC/U144mYaT9lBw1b9AodOsgUC08wt8+nRWUkEdgdr06aIjvpYNoH2Vyw9gky
         WY6kSs2nKEnX/PUawQGNH7+YlEpogDBzKOhvGKufDNjsIptIKVYqDtgMY3xZNwkm9/WG
         baRunNdPKfSHfKOs7aXGzdCoPWhd80kMkJPQPM1m3Af6htPlhpJDLutdfclvGqhw1KmQ
         eSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wutsq0w67FFOmYL9AjxDGdsGlmIL42b8TT5TUqNaum4=;
        b=YAVPFGjxMsyejVKur8e4R/l7YqW15/AXOgMaDrntYmtFuUq4M2bdM50c3j/a8eJr9R
         69l04JC4wpq8yLI47AtMOPTx3QpCpvtkiULQ0WKiq56pDTWNka6+a2/uVC5u1AZn8dBn
         i/nKPXTxvvCEo0nZrGnjvMFIHaQG0fflLVY5V8k21FmRkmRhm4oJG01uhaDTUgEs1Vkf
         aqNFCUBbP7MuHUNCHjgLtEPz9ZfBT8MUVsNK+aPx8Jvwf/p19XMZzrNyyZWp4s8X3P3S
         aEgMjN/CJd0oogJwIHGtJU9zFmOeJFsXzOd957tuw9NnjDkj8iPy4wZ9D1ERsJhz4mZb
         3+Hg==
X-Gm-Message-State: AOAM532fSXVns/gN7fys9QWRFFpLNxTKSDGuJ/p5BY/5mF+m1Rlj2PlR
        EPly2Mgk71xvbcc/ZJsbZ1ESzXfAxpk=
X-Google-Smtp-Source: ABdhPJxT5mu5d0/sXPIX3aoQ7Q5Ewb/BjAnmp8srAGZm0HBfwEOVMQiv/bf33MCB4knjFf8W7jpnXg==
X-Received: by 2002:aa7:da05:: with SMTP id r5mr2433549eds.184.1602160380403;
        Thu, 08 Oct 2020 05:33:00 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9e4.dip0.t-ipconnect.de. [217.229.169.228])
        by smtp.gmail.com with ESMTPSA id d20sm3847873edt.32.2020.10.08.05.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 05:32:59 -0700 (PDT)
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
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <deb1c682-5843-61b1-173b-a70ef51e85f2@gmail.com>
Date:   Thu, 8 Oct 2020 14:32:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a82e3aff-801d-d116-bbf4-91f3981f713b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 1:44 PM, Hans de Goede wrote:
> Hi Maximilian,
> 
> On 10/5/20 6:03 PM, Maximilian Luz wrote:
>> As has come up in the discussion around
>>
>>    [RFC PATCH] Add support for Microsoft Surface System Aggregator Module
>>
>> it may make sense to add a Microsoft Surface specific platform
>> subdirectory. Andy has suggested drivers/platform/surface for that.
>> This series follows said suggestion and creates that subdirectory, as
>> well as moves Microsoft Surface related drivers over to it and updates
>> their MAINTAINERS entries (if available) accordingly.
>>
>> This series does not modify any existing driver code, symbols, or help
>> text.
> 
> In case you do not know I'm taking over from any as
> drivers/platform/x86 maintainer.
> 
> I'm fine with the concept of this series, but who is going to maintain
> this new drivers/platform/surface directory ?
> 
> Ah I see that the first patch answers that question and the plan
> is to keep this part of the pdx86 maintainership.
> 
> I would prefer for the new dir to have its own
> MAINTAINERS entry if I'm honest, I would like to try and
> split maintainership for the surface stuff as follows:
> 
> 1. Who will review (and add their Reviewed-by or ask for improvements
>     or nack) patches to files in this dir?
> 
> 2. Who will gather approved patches apply them to a for-next branch
>     and send them out to Linus during the merge Window?
> 
> I can pick up 2. but I could really use some help with 1. So I
> was thinking having a separate MAINTAINERS entry for the new
> dir with you (Maximilian) (and me and Mark Gross) listed as
> MAINTAINERS; and then I'm hoping that you can do the review
> of surface related patches. At least those which you have not
> written yourself.
> 
> How does that sound ?

Sounds good, I'd be happy to help review and approve any Surface related
patches. However, I think it would be beneficial if you and Mark still
have a final look (and say) over the ones I've reviewed and accepted (if
that's not already a given). I feel like I may lack a bit of experience
for this job and might miss some things.

I'll add the MAINTAINERS entry and send a v3 later today, if that's OK.

Regards,
Max
