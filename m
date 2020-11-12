Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B462B026A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgKLJ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKLJ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:59:37 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9CAC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:59:37 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 33so5317689wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z6o4otuykNC9/C3KTZCciJXXT+2NvX7xA0BxKQVg7mk=;
        b=Oclf/2QY8XtrBvgQSi8hSWvHmdHZE9EhWox7tuzsSEsulQR4BJI39yY1GtZSh1RSJS
         eImQIcHCNV1XdqokFcVvA/ZnliHUVdTSehOTh0aPmKo0hvXlYhFTHvZXLVkU1ieBhLd+
         ISvZo8OIB+8A2XDr+EtrZQtCXafeNcB+ke2jDKH9+yh/gLr+Bh3HgNXCkhGMwrA13OcN
         UO/kJ24A5HyItsmzx3iCbn9OkigXsxgVv0qCmEem4DyBYD52WoO0G1aNOoXhCudfJs6a
         y8XJ97gVjecOkLjuqOT8heZA/D22sLOiu7C2sjr9/+4s1ImZQW2a5fo6BeilWr4Tlf1P
         9QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z6o4otuykNC9/C3KTZCciJXXT+2NvX7xA0BxKQVg7mk=;
        b=JAxRnS/wqpMp6m9L39HIyTUbviE4NnY1JNjvAv8sNbBL2vtw1ldt5BMl0pSW9jhqkU
         HbHomk3gChdh6xqoOUMJg9pbR2OK19dGF2jmyk7uYl+pODH3Lp2TDm0UUGci4NKJBECR
         eRsEUusxocLkR2Efl+zrv//6Ei3jOBIXo7z3LhnN50+Z5Jn4gYxdLt0TN+9QUYL/qAci
         nh0SHlwCTA/VGEqp65fpLHesUhBh5Vx8gdnCVMN20zqNITS2KQNIO22c5o2SYwUQyS9K
         a2DWpDLXRpX1hnZM0yjcgilNu+AGK/miFzf/DRPnpjjxxe5Ad4C730dAE3Qb+kJ8aosp
         nmLg==
X-Gm-Message-State: AOAM533dS3Gj3mMGI4dPTKLR8rUquCclZTT5ZLl4LHa20aNezsAGmPAB
        ED78UNou+0PPBJxjUs6tuB4tLE+5cWGOHQ==
X-Google-Smtp-Source: ABdhPJyOyMmiU4/8UUKLH8zJBL/wCfiyG+9n4+0XrdAaTXh3Y2u4oMUMYiIeIvqrDjeLzADQWEhj5g==
X-Received: by 2002:adf:fa88:: with SMTP id h8mr8677697wrr.410.1605175175733;
        Thu, 12 Nov 2020 01:59:35 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id g131sm6144429wma.35.2020.11.12.01.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 01:59:35 -0800 (PST)
Subject: Re: [PATCH V2] clocksource/drivers/cadence_ttc: fix memory leak in
 ttc_setup_clockevent()
To:     Yu Kuai <yukuai3@huawei.com>, michal.simek@xilinx.com,
        tglx@linutronix.de, soren.brinkmann@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
References: <b3170c38-086a-5d6d-80dd-5424c53ed336@xilinx.com>
 <20201111011652.328500-1-yukuai3@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cd03869c-6ad1-1463-d7da-c8500adb32c8@linaro.org>
Date:   Thu, 12 Nov 2020 10:59:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111011652.328500-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2020 02:16, Yu Kuai wrote:
> If clk_notifier_register() failed, ttc_setup_clockevent() will return
> without freeing 'ttcce', which will leak memory.
> 
> Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/clocksource/timer-cadence-ttc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
> index 80e960602030..32b9560ce408 100644
> --- a/drivers/clocksource/timer-cadence-ttc.c
> +++ b/drivers/clocksource/timer-cadence-ttc.c
> @@ -426,6 +426,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
>  				    &ttcce->ttc.clk_rate_change_nb);
>  	if (err) {
>  		pr_warn("Unable to register clock notifier.\n");
> +		kfree(ttcce);
>  		return err;
>  	}

Please fix the error path by adding a label (eg. out_kfree) and jump to
it in case of error everywhere in the function.

out_kfree:
	kfree(ttcce);

	return err;


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
