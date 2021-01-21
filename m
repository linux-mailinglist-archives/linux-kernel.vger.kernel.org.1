Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7802B2FE1AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbhAUFZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbhAUFOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:14:43 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D320AC061575;
        Wed, 20 Jan 2021 21:14:02 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id cu2so366531qvb.12;
        Wed, 20 Jan 2021 21:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1cHMbLnrXeEIP840nQzDCBoI4rzkiT+v0NawgLqGw4Y=;
        b=pTy5+p/H38zISjn5MW5nh9rtggK4ko27XNCfZt1965emLhgHkC+MweJTUBavu+/3/C
         Ot5s4Fnk0XFJDGP2C+NpIsJEPvS187AckhZSgsOqUJeZI2L0kvvy9WF8dLMHxZYiWr9e
         IP9yIDUORidaQ9qlr9+3m1nP7b5Igkas0ldWbLvyUzMXuhHFEKsrzZSFLj1OmI5AFpun
         u9vl1qNCWSPGRZqM2jb2LwZmSZKXO50gxMuNbQ6SOcIYp4YyeKBL/jkgVQ221A4pcPvK
         xodXY2qlFjv0DSlqw7eH741Q2Up2Mi8FDN4A8GkQf4t0//arnoVG4HnCJd8MpBI0AzjL
         +s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1cHMbLnrXeEIP840nQzDCBoI4rzkiT+v0NawgLqGw4Y=;
        b=GB7GOEG0+SPx0BmwTBCMcw9NTYeCiTYpLwwTXFUrQJbxhH65/D4HjbcZrRIOMsCMHQ
         WH3g6de46DPZbjKiojBwMZmP5Zy3QfutYa+CfxcRL1TiKSZ2mg0M57kh7f6IwJ+TrzF0
         G0/LMEaCfEauhe07leIEoRT2b1vuAT3uJTyKVn5Etcg5gutPwKMQEAToQI+fiIMMGUFm
         XHWzNJx1sDNk0vcbC/vIOW/wg86SEx6mute4HGpq6UnJOrBxK5VBvzwWfldoafuvzyU0
         p3RE5rcJXM3pIRS+Hbqo5+GIcSSY1fMjWhkJWftuHfw4bQum+ZDwFcykMw1lX71gZxIR
         egGA==
X-Gm-Message-State: AOAM530ssUNnsvI8l+GykqZWefGA+NABRZ2cHYV97/nZ0r+hgt14IJWV
        Nh3kr/ZOdQr46R+oP+qrjDo=
X-Google-Smtp-Source: ABdhPJyftl5ZaxgIvbeH3aO3xFJu3XQWQKgykmdtHbF6x0XoXf8T3N7RswWv4ISu9gAjwrCLHAVjew==
X-Received: by 2002:ad4:4108:: with SMTP id i8mr12626090qvp.49.1611206042105;
        Wed, 20 Jan 2021 21:14:02 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id q25sm1425071qkq.32.2021.01.20.21.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 21:14:01 -0800 (PST)
Subject: Re: [PATCH V5 5/5] of: unittest: Statically apply overlays using
 fdtoverlay
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
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
Date:   Wed, 20 Jan 2021 23:14:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121005145.GF5174@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 1/20/21 6:51 PM, David Gibson wrote:
> On Wed, Jan 20, 2021 at 12:36:47PM +0530, Viresh Kumar wrote:
>> Now that fdtoverlay is part of the kernel build, start using it to test
>> the unitest overlays we have by applying them statically.
>>
>> Some unittest overlays deliberately contain errors that unittest checks
>> for. These overlays will cause fdtoverlay to fail, and are thus not
>> included in the static_test.dtb.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/of/unittest-data/Makefile | 50 +++++++++++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>
>> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
>> index 009f4045c8e4..ece7dfd5cafa 100644
>> --- a/drivers/of/unittest-data/Makefile
>> +++ b/drivers/of/unittest-data/Makefile
>> @@ -38,3 +38,53 @@ DTC_FLAGS_testcases += -@
>>  
>>  # suppress warnings about intentional errors
>>  DTC_FLAGS_testcases += -Wno-interrupts_property
>> +
>> +# Apply overlays statically with fdtoverlay.  This is a build time test that
>> +# the overlays can be applied successfully by fdtoverlay.  This does not
>> +# guarantee that the overlays can be applied successfully at run time by
>> +# unittest, but it provides a bit of build time test coverage for those
>> +# who do not execute unittest.
>> +#
>> +# The overlays are applied on top of testcases.dtb to create static_test.dtb
>> +# If fdtoverlay detects an error than the kernel build will fail.
>> +# static_test.dtb is not consumed by unittest.
>> +#
>> +# Some unittest overlays deliberately contain errors that unittest checks for.
>> +# These overlays will cause fdtoverlay to fail, and are thus not included
>> +# in the static test:
>> +#			overlay.dtb \
>> +#			overlay_bad_add_dup_node.dtb \
>> +#			overlay_bad_add_dup_prop.dtb \
>> +#			overlay_bad_phandle.dtb \
>> +#			overlay_bad_symbol.dtb \
>> +#			overlay_base.dtb \
>> +
>> +apply_static_overlay := overlay_0.dtb \
>> +			overlay_1.dtb \
>> +			overlay_2.dtb \
>> +			overlay_3.dtb \
>> +			overlay_4.dtb \
>> +			overlay_5.dtb \
>> +			overlay_6.dtb \
>> +			overlay_7.dtb \
>> +			overlay_8.dtb \
>> +			overlay_9.dtb \
>> +			overlay_10.dtb \
>> +			overlay_11.dtb \
>> +			overlay_12.dtb \
>> +			overlay_13.dtb \
>> +			overlay_15.dtb \
>> +			overlay_gpio_01.dtb \
>> +			overlay_gpio_02a.dtb \
>> +			overlay_gpio_02b.dtb \
>> +			overlay_gpio_03.dtb \
>> +			overlay_gpio_04a.dtb \
>> +			overlay_gpio_04b.dtb
>> +
>> +quiet_cmd_fdtoverlay = FDTOVERLAY $@
>> +      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $^
>> +
>> +$(obj)/static_test.dtb: $(obj)/testcases.dtb $(addprefix $(obj)/,$(apply_static_overlay))
>> +	$(call if_changed,fdtoverlay)
>> +
>> +always-$(CONFIG_OF_OVERLAY) += static_test.dtb
> 
> The fact that testcases.dts includes /plugin/ still seems completely
> wrong, if it's being used as the base tree.
> 

Yes, the build rule for static_test.dtb is using testcases.dtb as the base FDT.
It is a convenient FDT to use because it provides the frame that the overlays
require to be applied.  It is fortunate that fdtoverlay does not reject the use
of an FDT with overlay metadata as the base blob.

If Viresh wants to test a more realistic data set then he could create a build
rule that copies testcases.dts into (for example) testcases_base.dts, strip
out the '/plugin/;" then compile that into testcases_base.dtb and use that for
fdtoverlay.

   pseudo makefile rule for testcases_base.dts:
       sed -e 's|/plugin/;||' > testcases_base.dts

   add testcases_base.dtb to the list of objects to build

   change the rule for static_test.dtb to use testcases_base.dtb instead of
   testcases.dtb

This is probably a good idea instead of depending on the leniency of fdtoverlay.

-Frank
