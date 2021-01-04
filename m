Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E7A2E946D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbhADL6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:58:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbhADL6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609761443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qKepDTp4R0zcC407CreBxuHjBt5Mqx/wA9MwAN6PMg=;
        b=OlrM41gdQXc+9CYlplGwU49n+ZDNL9hyEdaxzhjV7YEQ90cuEA38KgbZDnqBSv5CwGxAm+
        Ce8a3qtBLQeaD4rlKC9fwjBP+MO9+EVbFy7s0gWFEVGGqBiLq2h+VowSwB4NL3RB3yRwit
        0vc8LtWIxg1rKi+6MqB///pp4bq/3Nw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-QfZ0-vqYOMe_c-l7nUIvAA-1; Mon, 04 Jan 2021 06:57:22 -0500
X-MC-Unique: QfZ0-vqYOMe_c-l7nUIvAA-1
Received: by mail-ej1-f72.google.com with SMTP id dv25so6904954ejb.15
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 03:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8qKepDTp4R0zcC407CreBxuHjBt5Mqx/wA9MwAN6PMg=;
        b=lHnevrrKOzP4nap8Oe/1EmPF2bkobXwGSAaDsnsCEjIElKKMJKwimM5+NtorGbrsbE
         Ev/z2sfwtw12YtOv/G1BUiaNxo1VuYbgWGpPX9ssbwMEVgnEbCgzvBtA2LZD948TCGNr
         dwhIqCYxPmLG+ZV5TdDi2XLCL2K6FVUjGzaUjeOzruSQ0CRZon+HIfOeevblirolHuoU
         qOK/Ys8c5dKoP/7RBGuFoXidiqOd6Wx9xDWr0j2X9gNn0z5RkePncY8HTD3TGxkDOMkG
         PUebmB0igpRPoY9KzOIWymHbUMnEY87xMXOb0QX+H0UYbQ2Wz8XFo3Sy5nMv8Kbgfq7U
         b0fQ==
X-Gm-Message-State: AOAM530cHl7hPiiUBo5ZVSO0Ao1DAHIeibzsFDFkC82Qt7R7qXufwj4o
        7bwOk6bCFwIP8g3/nGZFdAUOuB8bSr/KsZfwjDOASpPvcw3pP6McirvCuu8DIQewQeRPUZCiq6G
        HnKbYrLJcpFJ0IBTk7hPoO0IzVHPJUOBDhd7Hqg047Qxfi9DeOjZ0xB7wjmh/Fu1wasVZmZTl/z
        Z6
X-Received: by 2002:a05:6402:158:: with SMTP id s24mr72674266edu.19.1609761440661;
        Mon, 04 Jan 2021 03:57:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyA5M+UosSLQuLFMOGX8p0BZQ35y3OLuyJeU+Zh98OioAWClTUkzC2I7QHGS6+yxPq/L16gEA==
X-Received: by 2002:a05:6402:158:: with SMTP id s24mr72674248edu.19.1609761440516;
        Mon, 04 Jan 2021 03:57:20 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id x20sm23357764ejv.66.2021.01.04.03.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 03:57:20 -0800 (PST)
Subject: Re: tools/power/x86/intel-speed-select: Fixes for regression
From:   Hans de Goede <hdegoede@redhat.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201221071859.2783957-1-srinivas.pandruvada@linux.intel.com>
 <489cb4bb-28b5-e7c8-829e-3d58f047f514@redhat.com>
Message-ID: <a290b74e-4b04-7eb9-196e-381a45f0a2db@redhat.com>
Date:   Mon, 4 Jan 2021 12:57:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <489cb4bb-28b5-e7c8-829e-3d58f047f514@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/4/21 12:56 PM, Hans de Goede wrote:
> Hi,
> 
> On 12/21/20 8:18 AM, Srinivas Pandruvada wrote:
>> One side-effect of fixing the scaling frequency limits using the
>> commit eacc9c5a927e ("cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max()
>> for turbo disabled") causes stale HWP_CAP.GUARANTEED to be used as max.
>> Without processing HWP interrupts, user space needs to be able to update
>> a new max while Intel SST is in use. This is not a problem as the
>> change of guaranteed is caused by user space action, so user space knows
>> that guarantee will change.
>>
>> This series causes user space to trigger scaling_max_freq update with
>> the new base_frequency.
>>
>>
>> Srinivas Pandruvada (2):
>>   tools/power/x86/intel-speed-select: Set scaling_max_freq to
>>     base_frequency
>>   tools/power/x86/intel-speed-select: Set higher of cpuinfo_max_freq or
>>     base_frequency
> 
> Thank you for your patch-series, I've applied the series to my
> review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.

Note this is a templated reply, I will also cherry-pick these into the
fixes branch in this case.

Regards,

Hans

