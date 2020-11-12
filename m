Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71E82B0416
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgKLLln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgKLLk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:40:57 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE414C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:40:56 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p1so5627922wrf.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hiH9YFvFj7u18VTdjYlvXbTm7Y6vPC/QKgUkjRYPlj0=;
        b=G3iMxfPdcSlq2kqWuNRyA9VaTuD6kH1gafYeQTw0/GJmXm8nu84CdTkmgl+t+wc3r5
         Y94u72Lu4HTssWwQaKnT4PeHhaqIYZd6M7NGNGIcRhtirha3BVAw72dMUXPamn8zgP+N
         lK6H1l6W0CdQBcxBobq9M1tB9Ds3P85FcNyrYybJqJxy5cy4PZd/42FrTFRFr26/aAA8
         rAbWOAPdrk3IHvuvHxsvd3KxHYXbpwdcDIniGACLpY2hF+SKY2oH+alvlBwfNjaPuomu
         3ZxDQo9Q9TK+GLus5qpsK9JB3jsGtQWiH3UV9bkTlxIEtDDv1vJ8HHiVTmA08ZY871sc
         Js0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hiH9YFvFj7u18VTdjYlvXbTm7Y6vPC/QKgUkjRYPlj0=;
        b=Gq0ljLYeOHTrRSTOhOPEgKliBLTs6yuG1hEmPnDHaA/JU0vhn2/njdxQDOCV8sgIgs
         w6XzjBa9uzHuX4OT9RjMeLxQ58Dj6wlO8SkI78b0U39mila/kYAlwZoVCEMoxnwNPvlu
         YHJeVU4ux0wvrkihUBF2OWJkhgY/0M0mQrQWjV+KVAVMGxRgGBBimknw6l4uW18ggPsx
         gtPdqGz4G1NZcksLtPZDJRDypsShOIC2lKsV0TAbNxV22lLhI/TYbQqGnTg/XFUbo7CX
         mUgIShN5HyLI/G+DIj3u8wQ0+aF+xcqpJ3X60ibU7WlXD/unEYudvDudOdkpueGOCH6H
         yitQ==
X-Gm-Message-State: AOAM532cvxb5dNU0gbEqfrwRe4auLfQH+yyQxW+93Kau+90nL1CFV8XF
        FSChFefRzOf0b2N7Wa4dk/e+LRVtEsxnSA==
X-Google-Smtp-Source: ABdhPJyYnJvDHJTFtxxktHznzaXTPpIA0hl6/kGsg1GUlsBx6odch4HOXNEy7ilq+yAmu9wUWTR5lg==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr33909986wrs.377.1605181255351;
        Thu, 12 Nov 2020 03:40:55 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id z3sm5815106wrw.87.2020.11.12.03.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 03:40:54 -0800 (PST)
Subject: Re: [PATCH v2 05/17] clocksource/hyperv: use MSR-based access if
 running as root
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-6-wei.liu@kernel.org>
 <3527e98a-faab-2360-f521-aa04bbe92edf@linaro.org>
 <20201112112437.lt3g5bhpjym3evu5@liuwe-devbox-debian-v2>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2c5101fb-f3de-7b0c-ee76-e5a0e6b32098@linaro.org>
Date:   Thu, 12 Nov 2020 12:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112112437.lt3g5bhpjym3evu5@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2020 12:24, Wei Liu wrote:
> On Thu, Nov 12, 2020 at 10:56:17AM +0100, Daniel Lezcano wrote:
>> On 05/11/2020 17:58, Wei Liu wrote:
>>> Signed-off-by: Wei Liu <wei.liu@kernel.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>>> ---
>>
>> I would like to apply this patch but the changelog is too short (one line).
>>
>> Please add a small paragraph (no need to resend just answer here, I will
>> amend the log myself.
> 
> Please don't apply this to your tree. It is dependent on a previous
> patch. I expect this series to go through the hyperv tree.
> 
> I will add in this small paragraph in a later version:
> 
>     When Linux runs as the root partition, the setup required for TSC page
>     is different. Luckily Linux also has access to the MSR based
>     clocksource. We can just disable the TSC page clocksource if Linux is
>     the root partition.
> 
> If you're happy with the description, I would love to have an ack from
> you. I will funnel the patch via the hyperv tree.
> 
> Wei.
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
