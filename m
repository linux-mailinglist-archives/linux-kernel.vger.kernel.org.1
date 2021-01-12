Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8AD2F257A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbhALBXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 20:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbhALBX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:23:29 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E98C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 17:22:48 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id h3so1339705ils.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 17:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X5i4D9jR11SBYz3y55+E1w1NYwNaVL+6Wk6o8NeIFEs=;
        b=lSBCzUpfxCGa7fHd/UTfeQPT5ga5DbG8DzTHKak7OA+UatUuHUbB8sWSZgG6BlfOQp
         35+y3AGXVvtmMpi1QuOmtjAMayUhpUxfUcawtw9WJdpp2EBcZg76jpFlro8esxgGCKcD
         IKj+KZoDavhTfoTP5U7neLXHShCvo4R8uu9GcSNVmxwfPaxEqxNLo9sGzgdOfpAq48da
         TlQyH7JlWOoE1FwVkm91+OJ24bqPhcwqc5fSCtkpvh7Ku1BH4n/zNN0/LcVIFP8PM9kc
         hDqg5oFes7iiWsvZAWUovEYWT1hsHQcMNFL10QXNqcl/lO1hQT+ZWuDcL7bkviv+mZYb
         7Epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X5i4D9jR11SBYz3y55+E1w1NYwNaVL+6Wk6o8NeIFEs=;
        b=BCoXX5N44lXhxSgIM8ja0ciZN/bFgvjHoBOJ6sZwdBov/MOuotwC4korxOKodNP5iJ
         BgqBsIGYlIPeJ10S/yh5Ztu4/TAUPoYARqgKjwVTob6g3ITUyTF/mpbIGQpY40auZlWZ
         tTE84JPrakVFX828FwRMe3pGuQjkER9aICOVx86QMlLPF83gUsIloabAAqZ7DQaNuqbm
         XOV7uY5F6RunJ3Rna0EPDHobMm1WBAS2JmkyvhZTKXQz5kmiHuGpo7DuWADNJdmJLtGj
         mT82zjhUeE0LLSL47W9mZ+Vk6lN4m7VCUaGxpCkuKCNpl+IekYzSHcZVwgg4jaCdtO8C
         ossw==
X-Gm-Message-State: AOAM5315FV7agGprd8xlw5g5ugNCo9WMev3kGv5r9IrakY7HPFVUKoky
        rUI/Xlbum8Z+13RRWVVxLlpz9MnqeMuTkx4s
X-Google-Smtp-Source: ABdhPJwGv4lqU6ZTGrC1I+ginL4JReSOkj1daCH+crR/WVqjpyr2z335yZXgwOyeWEWDiLcFlmQBWw==
X-Received: by 2002:a05:6e02:1806:: with SMTP id a6mr1758251ilv.8.1610414568079;
        Mon, 11 Jan 2021 17:22:48 -0800 (PST)
Received: from ?IPv6:2601:144:4100:fd1:12bf:48ff:fed7:9537? ([2601:144:4100:fd1:12bf:48ff:fed7:9537])
        by smtp.gmail.com with ESMTPSA id b6sm1021405ilv.79.2021.01.11.17.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 17:22:47 -0800 (PST)
Subject: Re: [PATCH] of: unittest: Statically apply overlays using fdtoverlay
To:     Frank Rowand <frowand.list@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        anmar.oueja@linaro.org, Masahiro Yamada <masahiroy@kernel.org>
References: <be5cb12a68d9ac2c35ad9dd50d6b168f7cad6837.1609996381.git.viresh.kumar@linaro.org>
 <1e42183ccafa1afba33b3e79a4e3efd3329fd133.1610095159.git.viresh.kumar@linaro.org>
 <23e16d20-36eb-87d9-4473-142504ad8a95@gmail.com>
From:   Bill Mills <bill.mills@linaro.org>
Message-ID: <31611390-eded-d290-36a7-0b1e8465f71e@linaro.org>
Date:   Mon, 11 Jan 2021 20:22:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <23e16d20-36eb-87d9-4473-142504ad8a95@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/21 5:06 PM, Frank Rowand wrote:
> On 1/8/21 2:41 AM, Viresh Kumar wrote:
>> Now that fdtoverlay is part of the kernel build, start using it to test
>> the unitest overlays we have by applying them statically.
>>
>> The file overlay_base.dtb have symbols of its own and we need to apply
>> overlay.dtb to overlay_base.dtb alone first to make it work, which gives
>> us intermediate-overlay.dtb file.
>>
>> The intermediate-overlay.dtb file along with all other overlays is them
>> applied to testcases.dtb to generate the master.dtb file.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> NACK to this specific patch, in its current form.
> 
> There are restrictions on applying an overlay at runtime that do not apply
> to applying an overlay to an FDT that will be loaded by the kernel during
> early boot.  Thus the unittest overlays _must_ be applied using the kernel
> overlay loading methods to test the kernel runtime overlay loading feature.
> 
> I agree that testing fdtoverlay is a good idea.  I have not looked at the
> parent project to see how much testing of fdtoverlay occurs there, but I
> would prefer that fdtoverlay tests reside in the parent project if practical
> and reasonable.  If there is some reason that some fdtoverlay tests are
> more practical in the Linux kernel repository then I am open to adding
> them to the Linux kernel tree.
> 

Frank,

I thought we were aligned that any new overlays into the kernel today 
would only be for boot loader applied case.  Applying overlays at kernel 
runtime was out of scope at your request.

Rob had requested that the overlays be test applied at build time.  I 
don't think there is any way to test the kernel runtime method at build 
time correct?

Please clarify your concern and your suggested way forward.

Thanks,
Bill

> -Frank
> 
> 
>>
>> ---
>> Depends on:
>>
>> https://lore.kernel.org/lkml/be5cb12a68d9ac2c35ad9dd50d6b168f7cad6837.1609996381.git.viresh.kumar@linaro.org/
>>
>> I have kept the .dtb naming for overlays for now, lets see how we do it
>> eventually.
>>
>> Rob/Frank, this doesn't work properly right now. Maybe I missed how
>> these overlays must be applied or there is a bug in fdtoverlay.
>>
>> The master.dtb doesn't include any nodes from overlay_base.dtb or
>> overlay.dtb probably because 'testcase-data-2' node isn't present in
>> testcases.dtb and fdtoverlay doesn't allow applying new nodes to the
>> root node, i.e. allows new sub-nodes once it gets phandle to the parent
>> but nothing can be added to the root node itself. Though I get a feel
>> that it works while applying the nodes dynamically and it is expected to
>> work here as well.
>>
>> (And yeah, this is my first serious attempt at updating Makefiles, I am
>> sure there is a scope of improvement here :))
>>
>> ---
>>   drivers/of/unittest-data/Makefile | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
>> index 009f4045c8e4..f17bce85f65f 100644
>> --- a/drivers/of/unittest-data/Makefile
>> +++ b/drivers/of/unittest-data/Makefile
>> @@ -38,3 +38,26 @@ DTC_FLAGS_testcases += -@
>>   
>>   # suppress warnings about intentional errors
>>   DTC_FLAGS_testcases += -Wno-interrupts_property
>> +
>> +# Apply overlays statically with fdtoverlay
>> +intermediate-overlay	:= overlay.dtb
>> +master			:= overlay_0.dtb overlay_1.dtb overlay_2.dtb \
>> +			   overlay_3.dtb overlay_4.dtb overlay_5.dtb \
>> +			   overlay_6.dtb overlay_7.dtb overlay_8.dtb \
>> +			   overlay_9.dtb overlay_10.dtb overlay_11.dtb \
>> +			   overlay_12.dtb overlay_13.dtb overlay_15.dtb \
>> +			   overlay_gpio_01.dtb overlay_gpio_02a.dtb \
>> +			   overlay_gpio_02b.dtb overlay_gpio_03.dtb \
>> +			   overlay_gpio_04a.dtb overlay_gpio_04b.dtb \
>> +			   intermediate-overlay.dtb
>> +
>> +quiet_cmd_fdtoverlay = fdtoverlay $@
>> +      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $^
>> +
>> +$(obj)/intermediate-overlay.dtb: $(obj)/overlay_base.dtb $(addprefix $(obj)/,$(intermediate-overlay))
>> +	$(call if_changed,fdtoverlay)
>> +
>> +$(obj)/master.dtb: $(obj)/testcases.dtb $(addprefix $(obj)/,$(master))
>> +	$(call if_changed,fdtoverlay)
>> +
>> +always-$(CONFIG_OF_OVERLAY) += intermediate-overlay.dtb master.dtb
>>
> 

-- 
Bill Mills
Principal Technical Consultant, Linaro
+1-240-643-0836
TZ: US Eastern
Work Schedule:  Tues/Wed/Thur
