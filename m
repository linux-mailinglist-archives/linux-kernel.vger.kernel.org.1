Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03E2E9466
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbhADL56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:57:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbhADL55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609761390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PPO3p8wH39HQHRuJNW2ZsM7qvp7F52JwkVCYJQCC+mA=;
        b=cw7Hq7tfjnDWZrJKtBaPxp/x/qx4F+3WV1En4LIEHyGOM7A3J0j9GQz1tIaXNxHAlw4S0S
        hdmZ2VSQ38OYErmp8/5SZTSyB5vhn27dEnKgHWCtGBPongOeHnIZTVe7tVJLhAc8csh89I
        HNR+rXWNjMZ7q3tOWV68zozNGgqgwjI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-kglm7hF9OCiAedp7EaIMSA-1; Mon, 04 Jan 2021 06:56:29 -0500
X-MC-Unique: kglm7hF9OCiAedp7EaIMSA-1
Received: by mail-ed1-f71.google.com with SMTP id bf13so12012646edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 03:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PPO3p8wH39HQHRuJNW2ZsM7qvp7F52JwkVCYJQCC+mA=;
        b=Vh5rANcMJ5P1+jwx4TGzRCKqV1fs4t5oxlgZFlO2ovQaEzTXH1y3oG+7NpWt8cKbCe
         hQOUzYYwbPq6q6HITrUbSORvgvXxMdV3KneJlTdanUPWVxjdkT1cGzJ+XpR/6N1RCsto
         L3xTjv0IitUjtSjqarDRIjocx1ax6qR3v1JYXQBdmfqYyn77aGr2DUaCyC8ApP3QtUeU
         cYggtgKrAJoDjkTudlnF6JsN/rXUHzOOuypVELRkLfmRh9YbQ3B8Mzj8mthr+AvMlzEf
         NhoPdbKB5XEA0AJ24SFcy3bFEf3WYxrV3BbphFfzTL5KhlLQ8CXFCuBy7K00D7gvyLmb
         vesA==
X-Gm-Message-State: AOAM530GOPELVc+7oSu2glRbJ8JJZn+fkwwVymk0FtO0EMZSTxMF3jUL
        Cikbu6NStqr4Fl6C7ZRcOjZV4RAkZKa+68HTym7DbHXEnBRWRMCVZCdBWfhnxN6rmnfUs0eU2uh
        7YWLGbQ8mHeWqD8sOrehB5LeMAESD/2JTRbH5BeTQtkIeX9UTliW6t86Y+qKfcPGi1ZCn8NGsYt
        d5
X-Received: by 2002:a50:d888:: with SMTP id p8mr18605657edj.147.1609761388108;
        Mon, 04 Jan 2021 03:56:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRZNrGB86jkAjlLuv6/cPOD1ZlILuv5+EvaZXPZUh2JMyn1lszo6k7gefX0uW1jPs87KfL+Q==
X-Received: by 2002:a50:d888:: with SMTP id p8mr18605641edj.147.1609761387942;
        Mon, 04 Jan 2021 03:56:27 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id j20sm23409841ejy.124.2021.01.04.03.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 03:56:27 -0800 (PST)
Subject: Re: tools/power/x86/intel-speed-select: Fixes for regression
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201221071859.2783957-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <489cb4bb-28b5-e7c8-829e-3d58f047f514@redhat.com>
Date:   Mon, 4 Jan 2021 12:56:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201221071859.2783957-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/21/20 8:18 AM, Srinivas Pandruvada wrote:
> One side-effect of fixing the scaling frequency limits using the
> commit eacc9c5a927e ("cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max()
> for turbo disabled") causes stale HWP_CAP.GUARANTEED to be used as max.
> Without processing HWP interrupts, user space needs to be able to update
> a new max while Intel SST is in use. This is not a problem as the
> change of guaranteed is caused by user space action, so user space knows
> that guarantee will change.
> 
> This series causes user space to trigger scaling_max_freq update with
> the new base_frequency.
> 
> 
> Srinivas Pandruvada (2):
>   tools/power/x86/intel-speed-select: Set scaling_max_freq to
>     base_frequency
>   tools/power/x86/intel-speed-select: Set higher of cpuinfo_max_freq or
>     base_frequency

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

