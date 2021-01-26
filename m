Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FA2303CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404631AbhAZKyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbhAZDP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 22:15:57 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F9EC061573;
        Mon, 25 Jan 2021 19:15:17 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z6so11401996qtn.0;
        Mon, 25 Jan 2021 19:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GlDwSv5vGV0NrH+Gyfq0mpa+FzrKZ7rYP/44E0uNm8E=;
        b=nE4OjwWqEa9kjkCEW9mtf4C2Yhc1uRfT1jWrO1Xhh7Ef1tWeSv+LaedzncSPHCDAx+
         aKOkJ+UzfoxeyBR3mnVjm566Ncnj4JQtf78rBNdVlegIwPihC7ld03rVTTswrvvqG3Ra
         Zh8PYkyxTCDjpP/DStHkhLa9zMoJ6TBbBuR7FUb4uommfJMoZ466NKYLAYRwHwY4hua5
         S1zS8DSX6SLN8+uM/xspF6jfzXfg8HJexf9BE5KBq5kOu/qCuJQNWKptG9nxsIzWJtYc
         lbZCKcjRPQrx53Cyk5GyE2mM2GUXRbhnW9VtlunFnBDUPMP1BV+NkIIKUMiLU731znWM
         bY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GlDwSv5vGV0NrH+Gyfq0mpa+FzrKZ7rYP/44E0uNm8E=;
        b=oTcis8gJqskjZtToiHD46QJ/ZS6YCMiM4j4n/EbweC6Tuo92wGGghpiF58MwEoaaYN
         67v97j2o599ZHQwPxY8E5N7JRTXXy8unXudQKtusrQrK1yxFpknlQvjYqlSSOk0BsIKw
         gW89bcJzVQzEiXsoz2YVtIfHJx1W13uDeTHQmsyOBvdKYAQRomsJetwEhxpO9ygaG8hV
         Ny5rqyjONnLIHQM0AELmlimOpXhohOgi0QzUc/h8hq9bwDUsXwRXSnkz4x2UbCIkoxJ1
         VFtPNDNWw7xqpAKi8HksQskXiILgxqf8Q1lJE389sWDCVfESaZgkcjbNbyJk7wZSCLgh
         0Ljw==
X-Gm-Message-State: AOAM530Au6YiDjOrnzX8kAnAFA6PJ8LioeSfDtVQ+5ppdKxw3USzCLo+
        sOe9Pz1dhfb/d/qEGAYWJnjqLNP6A4L2tA==
X-Google-Smtp-Source: ABdhPJy7qOnLDPS0st6kvGxS5L3IGtIvIRp9hSb16G/I8JRLnNBKNOhAysd44XpR5XP4HFBbGW166A==
X-Received: by 2002:ac8:6f07:: with SMTP id g7mr3523701qtv.54.1611630916512;
        Mon, 25 Jan 2021 19:15:16 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id s23sm9818672qtq.56.2021.01.25.19.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 19:15:16 -0800 (PST)
Subject: Re: [PATCH V6 6/6] of: unittest: Statically apply overlays using
 fdtoverlay
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
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <68370651-4706-308e-db18-fc3642116b8a@gmail.com>
Date:   Mon, 25 Jan 2021 21:15:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <58e8523e1489b70b76211fb94a9229ae12c33cad.1611312122.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 4:50 AM, Viresh Kumar wrote:
> Now that fdtoverlay is part of the kernel build, start using it to test
> the unitest overlays we have by applying them statically. Create a new
> base file static_base.dts which includes other .dtsi files.
> 
> Some unittest overlays deliberately contain errors that unittest checks
> for. These overlays will cause fdtoverlay to fail, and are thus not
> included in the static_test.dtb.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/of/unittest-data/Makefile        | 51 ++++++++++++++++++++++++
>  drivers/of/unittest-data/static_base.dts |  5 +++
>  2 files changed, 56 insertions(+)
>  create mode 100644 drivers/of/unittest-data/static_base.dts
> 
> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
> index 009f4045c8e4..586fa8cda916 100644
> --- a/drivers/of/unittest-data/Makefile
> +++ b/drivers/of/unittest-data/Makefile
> @@ -34,7 +34,58 @@ DTC_FLAGS_overlay += -@
>  DTC_FLAGS_overlay_bad_phandle += -@
>  DTC_FLAGS_overlay_bad_symbol += -@
>  DTC_FLAGS_overlay_base += -@
> +DTC_FLAGS_static_base += -@
>  DTC_FLAGS_testcases += -@
>  
>  # suppress warnings about intentional errors
>  DTC_FLAGS_testcases += -Wno-interrupts_property
> +
> +# Apply overlays statically with fdtoverlay.  This is a build time test that
> +# the overlays can be applied successfully by fdtoverlay.  This does not
> +# guarantee that the overlays can be applied successfully at run time by
> +# unittest, but it provides a bit of build time test coverage for those
> +# who do not execute unittest.
> +#
> +# The overlays are applied on top of static_base.dtb to create static_test.dtb
> +# If fdtoverlay detects an error than the kernel build will fail.
> +# static_test.dtb is not consumed by unittest.
> +#
> +# Some unittest overlays deliberately contain errors that unittest checks for.
> +# These overlays will cause fdtoverlay to fail, and are thus not included
> +# in the static test:
> +#			overlay_bad_add_dup_node.dtb \
> +#			overlay_bad_add_dup_prop.dtb \
> +#			overlay_bad_phandle.dtb \
> +#			overlay_bad_symbol.dtb \
> +#			overlay_base.dtb \
> +
> +apply_static_overlay := overlay.dtb \

rename apply_static_overlay to apply_static_overlay_2:

   apply_static_overlay_2 := overlay.dtb

Then the remainder of apply_static_overlay becomes apply_static_overlay_1:

   apply_static_overlay_1 :=
> +			overlay_0.dtb \
> +			overlay_1.dtb \
> +			overlay_2.dtb \
> +			overlay_3.dtb \
> +			overlay_4.dtb \
> +			overlay_5.dtb \
> +			overlay_6.dtb \
> +			overlay_7.dtb \
> +			overlay_8.dtb \
> +			overlay_9.dtb \
> +			overlay_10.dtb \
> +			overlay_11.dtb \
> +			overlay_12.dtb \
> +			overlay_13.dtb \
> +			overlay_15.dtb \
> +			overlay_gpio_01.dtb \
> +			overlay_gpio_02a.dtb \
> +			overlay_gpio_02b.dtb \
> +			overlay_gpio_03.dtb \
> +			overlay_gpio_04a.dtb \
> +			overlay_gpio_04b.dtb
> +
> +quiet_cmd_fdtoverlay = FDTOVERLAY $@
> +      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $^
> +


> +$(obj)/static_test.dtb: $(obj)/static_base.dtb $(addprefix $(obj)/,$(apply_static_overlay))
> +	$(call if_changed,fdtoverlay)

Split the static_test.dtb into _1 and _2:

> +$(obj)/static_test_1.dtb: $(obj)/static_base_1.dtb $(addprefix $(obj)/,$(apply_static_overlay_1))
> +	$(call if_changed,fdtoverlay)

> +$(obj)/static_test_2.dtb: $(obj)/static_base_2.dtb $(addprefix $(obj)/,$(apply_static_overlay_2))
> +	$(call if_changed,fdtoverlay)


> +
> +always-$(CONFIG_OF_OVERLAY) += static_test.dtb


> diff --git a/drivers/of/unittest-data/static_base.dts b/drivers/of/unittest-data/static_base.dts
> new file mode 100644
> index 000000000000..3c9af4aefb96
> --- /dev/null
> +++ b/drivers/of/unittest-data/static_base.dt> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include "overlay_common.dtsi"
> +#include "testcases_common.dtsi"
> 

Split static_base.dts into static_base_1.dts and static_base_2.dts:

static_base_1.dts:

> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include "testcases_common.dtsi"


static_base_2.dts:

> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include "overlay_common.dtsi"
