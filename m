Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AD52FE1E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbhAUFlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbhAUFf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:35:26 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0626C0613D3;
        Wed, 20 Jan 2021 21:34:44 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id h22so649800qkk.4;
        Wed, 20 Jan 2021 21:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gQVFfVvma1z5X8pQnAbNza/fOSYO869uPVc/iFuxovM=;
        b=L01oEmqHg0moBNzbx4H/Kgk6kCi18ZoekK+GGHUP/Tx9SRQ5GNYkck2mVQNfv9Qq7a
         GtPddfnvJnni5bgaT702xbzi9V47hbUE4eEv6E/h+6MwLJt9WFx7mmWXBirx55F4tcTl
         1MKGfxeplp8AZZShQ78VDW58veHrlB7HIB0yQ0m35gNkq/uZNUsAj3F9A1JLLwZ9lWks
         +1f/gR4/WBhQmeovW7ovB5t/3vgOzmiHi7IDyN2A8Ob43c/Q6b+tgA64ASzDg+kGtkMg
         FE1X//iawZfIBE3uG3e4h2oRfI60moRRwqKB9D+5dZcz+HEiifKpd9Xg6w3VegH7kbtJ
         yrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQVFfVvma1z5X8pQnAbNza/fOSYO869uPVc/iFuxovM=;
        b=IaHu9KsJzLTqU4YLqaYUZxuJNfpSinbkMrg3zOnIhvRryp9Yq997/q9hdqOJTKjfXF
         LaHK1xU7CRTiJFV4yBnc2QKTlGemowthB4TaaJ8nhvPn3XAZ59v5dP7GGSQmtgutPXZD
         ldTXocWFAa/E/JvBa/rUM0LhfMXMpcQC3WlTMF1NuOvjV4iAcqhSAZPq4vxXSyGaU6px
         FI0Td2beQLGS1RgIF7qxJoUQ0u7j6OT7R/xSSJ/JomhlJcKCYzsE2BT9649JVFndTVbZ
         9fgEAncLtWarIUiE62o5bhacqEMVeMaUEBDByCP9mJPIZ/JZfjJhxRJEMecWjAMFMU/i
         /xJQ==
X-Gm-Message-State: AOAM533F6/3JwdmXNLmii0PctaQUMDMsSn/KnF7MOxv+RDgVIfMnF+2D
        ZljGEIYQr/G3hPnR7L4iM6E=
X-Google-Smtp-Source: ABdhPJxSFfmq/o67k71McYqF2mvCRWGvfTGo5AV23E79ZtQh0N3D7mH6Pyn+L91gG75eFeqNSCjPtA==
X-Received: by 2002:a05:620a:2227:: with SMTP id n7mr12525913qkh.153.1611207283904;
        Wed, 20 Jan 2021 21:34:43 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id z26sm2995192qki.40.2021.01.20.21.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 21:34:43 -0800 (PST)
Subject: Re: [PATCH V5 5/5] of: unittest: Statically apply overlays using
 fdtoverlay
From:   Frank Rowand <frowand.list@gmail.com>
To:     David Gibson <david@gibson.dropbear.id.au>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
 <20210121005145.GF5174@yekko.fritz.box>
 <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
Message-ID: <a6b5e6ac-90ec-9571-4fce-de7344bfcee9@gmail.com>
Date:   Wed, 20 Jan 2021 23:34:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 1/20/21 11:14 PM, Frank Rowand wrote:
> Hi David,
> 
> On 1/20/21 6:51 PM, David Gibson wrote:
>> On Wed, Jan 20, 2021 at 12:36:47PM +0530, Viresh Kumar wrote:
>>> Now that fdtoverlay is part of the kernel build, start using it to test
>>> the unitest overlays we have by applying them statically.
>>>
>>> Some unittest overlays deliberately contain errors that unittest checks
>>> for. These overlays will cause fdtoverlay to fail, and are thus not
>>> included in the static_test.dtb.
>>>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>  drivers/of/unittest-data/Makefile | 50 +++++++++++++++++++++++++++++++
>>>  1 file changed, 50 insertions(+)
>>>
>>> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
>>> index 009f4045c8e4..ece7dfd5cafa 100644
>>> --- a/drivers/of/unittest-data/Makefile
>>> +++ b/drivers/of/unittest-data/Makefile
>>> @@ -38,3 +38,53 @@ DTC_FLAGS_testcases += -@
>>>  
>>>  # suppress warnings about intentional errors
>>>  DTC_FLAGS_testcases += -Wno-interrupts_property
>>> +
>>> +# Apply overlays statically with fdtoverlay.  This is a build time test that
>>> +# the overlays can be applied successfully by fdtoverlay.  This does not
>>> +# guarantee that the overlays can be applied successfully at run time by
>>> +# unittest, but it provides a bit of build time test coverage for those
>>> +# who do not execute unittest.
>>> +#
>>> +# The overlays are applied on top of testcases.dtb to create static_test.dtb
>>> +# If fdtoverlay detects an error than the kernel build will fail.
>>> +# static_test.dtb is not consumed by unittest.
>>> +#
>>> +# Some unittest overlays deliberately contain errors that unittest checks for.
>>> +# These overlays will cause fdtoverlay to fail, and are thus not included
>>> +# in the static test:
>>> +#			overlay.dtb \
>>> +#			overlay_bad_add_dup_node.dtb \
>>> +#			overlay_bad_add_dup_prop.dtb \
>>> +#			overlay_bad_phandle.dtb \
>>> +#			overlay_bad_symbol.dtb \
>>> +#			overlay_base.dtb \
>>> +
>>> +apply_static_overlay := overlay_0.dtb \
>>> +			overlay_1.dtb \
>>> +			overlay_2.dtb \
>>> +			overlay_3.dtb \
>>> +			overlay_4.dtb \
>>> +			overlay_5.dtb \
>>> +			overlay_6.dtb \
>>> +			overlay_7.dtb \
>>> +			overlay_8.dtb \
>>> +			overlay_9.dtb \
>>> +			overlay_10.dtb \
>>> +			overlay_11.dtb \
>>> +			overlay_12.dtb \
>>> +			overlay_13.dtb \
>>> +			overlay_15.dtb \
>>> +			overlay_gpio_01.dtb \
>>> +			overlay_gpio_02a.dtb \
>>> +			overlay_gpio_02b.dtb \
>>> +			overlay_gpio_03.dtb \
>>> +			overlay_gpio_04a.dtb \
>>> +			overlay_gpio_04b.dtb
>>> +
>>> +quiet_cmd_fdtoverlay = FDTOVERLAY $@
>>> +      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $^
>>> +
>>> +$(obj)/static_test.dtb: $(obj)/testcases.dtb $(addprefix $(obj)/,$(apply_static_overlay))
>>> +	$(call if_changed,fdtoverlay)
>>> +
>>> +always-$(CONFIG_OF_OVERLAY) += static_test.dtb
>>
>> The fact that testcases.dts includes /plugin/ still seems completely
>> wrong, if it's being used as the base tree.
>>
> 
> Yes, the build rule for static_test.dtb is using testcases.dtb as the base FDT.
> It is a convenient FDT to use because it provides the frame that the overlays
> require to be applied.  It is fortunate that fdtoverlay does not reject the use
> of an FDT with overlay metadata as the base blob.
> 
> If Viresh wants to test a more realistic data set then he could create a build
> rule that copies testcases.dts into (for example) testcases_base.dts, strip
> out the '/plugin/;" then compile that into testcases_base.dtb and use that for
> fdtoverlay.
> 
>    pseudo makefile rule for testcases_base.dts:
>        sed -e 's|/plugin/;||' > testcases_base.dts
> 
>    add testcases_base.dtb to the list of objects to build
> 
>    change the rule for static_test.dtb to use testcases_base.dtb instead of
>    testcases.dtb
> 
> This is probably a good idea instead of depending on the leniency of fdtoverlay.

It should be possible to apply this same concept to copying overlay_base.dts
to overlay_base_base.dts, removing the "/plugin/;" from overlay_base_base.dts
and using an additional rule to use fdtoverlay to apply overlay.dtb on top
of overlay_base_base.dtb.

Yes, overlay_base_base is a terrible name.  Just used to illustrate the point.

I tried this by hand and am failing miserably.  But I am not using the proper
environment (just a quick hack to see if the method might work).  So I would
have to set things up properly to really test this.

If this does work, it would remove my objections to you trying to transform
the existing unittest .dts test data files (because you would not have to
actually modify the existing .dts files).

> 
> -Frank
> 

