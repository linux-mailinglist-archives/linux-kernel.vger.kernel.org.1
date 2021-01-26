Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E7A303AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404682AbhAZK4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbhAZDWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 22:22:01 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB785C061573;
        Mon, 25 Jan 2021 19:21:21 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 2so7284025qvd.0;
        Mon, 25 Jan 2021 19:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2wHnwS9SZNgCIf5ck4iEid/Mkc8aA2uXGBi/FbgsGP0=;
        b=Zl2czyXrcJIjcP8FMabAH+8cQjgnObVpzGB6lt71MMqHO3UGdhFlP2y8670cXdAh23
         lbv3r9f9TAiav5vV7aqONY2l7gpOWO+Qw6cHs8nkQft1jam+0vUoC/nayHDIKgEK2o+h
         1P6NzNAPsnl4hfHY6etO4ehxmV2cyN7Jz/Te37ojKsywrfT2IcF3I21jO8icchlJo/i+
         vwQ+tdSOzdLR1vUiBvJLAzOyfVwpu+lZsatthGuW+1Zvc0nhJvLRaQcwRDSz9vVFlhG7
         yNOdFF+NpAHVJS5T7Ynyyvyx/ieCk+ZIzYmmUZ/I86qR1D5yzx7RWnlr3uHTBLs3mMaa
         ycCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2wHnwS9SZNgCIf5ck4iEid/Mkc8aA2uXGBi/FbgsGP0=;
        b=TZjVkTFTTY6ykUAbvtJIV0t/nunNS28Ffje/9wrP2AyM6Czl+ZhucFw5AWtnp3+qzp
         m0jc9Mg5NU2gH8pCa5PmtAU1ur6bjfQkx/YjCw7xFeGFnZWyXKT1XVYXZaHU29/fzhBI
         lxYV8GnNCmU3v3+87mE7I/S9PDFtQ8bm40G416fm3Juieg9O+PPwKaBTwX9t4MQvRnla
         msH9u6/xEp8EIvYqWxfiR2kHrPsU3BT3HlQgQCu9Hy1baVLFpbOdlq2NC9A3jtAu29hW
         +PyJsulaO3Etv+sL0sD8arVpzophTSKDUz67VG0Mp/ZhR2QdUAIy0ymH8Q1vt5qIKD2f
         8jrg==
X-Gm-Message-State: AOAM531vkY364HzgH4VLJVd+C0ci3sszxKXgYoKpJ8Yw5Y3Js/LKB7RC
        7BCeNzL9Z7CkjNbv2yuq23g=
X-Google-Smtp-Source: ABdhPJw7ZQw4kvRQbnsJkBxRSKz1SIOZ1dO8seob51rVuqhqiNs/o4tsLeg4pMx1kdVZcV8SrOsIjQ==
X-Received: by 2002:a0c:a8e0:: with SMTP id h32mr3872481qvc.30.1611631281120;
        Mon, 25 Jan 2021 19:21:21 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id e5sm12618694qtp.86.2021.01.25.19.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 19:21:20 -0800 (PST)
Subject: Re: [PATCH V6 6/6] of: unittest: Statically apply overlays using
 fdtoverlay
From:   Frank Rowand <frowand.list@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
References: <cover.1611312122.git.viresh.kumar@linaro.org>
 <58e8523e1489b70b76211fb94a9229ae12c33cad.1611312122.git.viresh.kumar@linaro.org>
 <68370651-4706-308e-db18-fc3642116b8a@gmail.com>
Message-ID: <746b63ca-74a0-1b20-9e80-931918f74493@gmail.com>
Date:   Mon, 25 Jan 2021 21:21:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <68370651-4706-308e-db18-fc3642116b8a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 9:15 PM, Frank Rowand wrote:
> On 1/22/21 4:50 AM, Viresh Kumar wrote:
>> Now that fdtoverlay is part of the kernel build, start using it to test
>> the unitest overlays we have by applying them statically. Create a new
>> base file static_base.dts which includes other .dtsi files.
>>
>> Some unittest overlays deliberately contain errors that unittest checks
>> for. These overlays will cause fdtoverlay to fail, and are thus not
>> included in the static_test.dtb.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/of/unittest-data/Makefile        | 51 ++++++++++++++++++++++++
>>  drivers/of/unittest-data/static_base.dts |  5 +++
>>  2 files changed, 56 insertions(+)
>>  create mode 100644 drivers/of/unittest-data/static_base.dts
>>
>> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
>> index 009f4045c8e4..586fa8cda916 100644
>> --- a/drivers/of/unittest-data/Makefile
>> +++ b/drivers/of/unittest-data/Makefile
>> @@ -34,7 +34,58 @@ DTC_FLAGS_overlay += -@
>>  DTC_FLAGS_overlay_bad_phandle += -@
>>  DTC_FLAGS_overlay_bad_symbol += -@
>>  DTC_FLAGS_overlay_base += -@
>> +DTC_FLAGS_static_base += -@
>>  DTC_FLAGS_testcases += -@
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
>> +# The overlays are applied on top of static_base.dtb to create static_test.dtb
>> +# If fdtoverlay detects an error than the kernel build will fail.
>> +# static_test.dtb is not consumed by unittest.
>> +#
>> +# Some unittest overlays deliberately contain errors that unittest checks for.
>> +# These overlays will cause fdtoverlay to fail, and are thus not included
>> +# in the static test:
>> +#			overlay_bad_add_dup_node.dtb \
>> +#			overlay_bad_add_dup_prop.dtb \
>> +#			overlay_bad_phandle.dtb \
>> +#			overlay_bad_symbol.dtb \
>> +#			overlay_base.dtb \
>> +
>> +apply_static_overlay := overlay.dtb \
> 
> rename apply_static_overlay to apply_static_overlay_2:
> 
>    apply_static_overlay_2 := overlay.dtb
> 
> Then the remainder of apply_static_overlay becomes apply_static_overlay_1:
> 
>    apply_static_overlay_1 :=
>> +			overlay_0.dtb \
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
> 
> 
>> +$(obj)/static_test.dtb: $(obj)/static_base.dtb $(addprefix $(obj)/,$(apply_static_overlay))
>> +	$(call if_changed,fdtoverlay)
> 
> Split the static_test.dtb into _1 and _2:
> 
>> +$(obj)/static_test_1.dtb: $(obj)/static_base_1.dtb $(addprefix $(obj)/,$(apply_static_overlay_1))
>> +	$(call if_changed,fdtoverlay)
> 
>> +$(obj)/static_test_2.dtb: $(obj)/static_base_2.dtb $(addprefix $(obj)/,$(apply_static_overlay_2))
>> +	$(call if_changed,fdtoverlay)
> 
> 
>> +
>> +always-$(CONFIG_OF_OVERLAY) += static_test.dtb

and of source the config line becomes static_test_1.dtb and static_test_2.dtb

Hopefully I haven't missed any other details...

-Frank

> 
> 
>> diff --git a/drivers/of/unittest-data/static_base.dts b/drivers/of/unittest-data/static_base.dts
>> new file mode 100644
>> index 000000000000..3c9af4aefb96
>> --- /dev/null
>> +++ b/drivers/of/unittest-data/static_base.dt> @@ -0,0 +1,5 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/dts-v1/;
>> +
>> +#include "overlay_common.dtsi"
>> +#include "testcases_common.dtsi"
>>
> 
> Split static_base.dts into static_base_1.dts and static_base_2.dts:
> 
> static_base_1.dts:
> 
>> +// SPDX-License-Identifier: GPL-2.0
>> +/dts-v1/;
>> +
>> +#include "testcases_common.dtsi"
> 
> 
> static_base_2.dts:
> 
>> +// SPDX-License-Identifier: GPL-2.0
>> +/dts-v1/;
>> +
>> +#include "overlay_common.dtsi"

