Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9908A2FDC55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 23:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbhATWU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 17:20:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731463AbhATVwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611179414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tREhvIowpuNt34h8cXw35P3uhjLTE4JeSLhACvuKEJQ=;
        b=BXurlk89FL2+n/lZ08QQEmrLzmvj5Zff6V/9udIdnPfHOBSDTrYG+JBDZrydsb8NBkHGbe
        w34/lefzZRi6CWiDCldb2ODorzioBpZ2iVoyFaW7xF3zwdNJhVxhZPzKhKU+PZ3S9A5Kfx
        CdzsSMMU7jUhSquwr+OTEUIeDuoVip4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-88BXdPz0Pcicl3JAOSqdHw-1; Wed, 20 Jan 2021 16:50:09 -0500
X-MC-Unique: 88BXdPz0Pcicl3JAOSqdHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACC18E743;
        Wed, 20 Jan 2021 21:50:07 +0000 (UTC)
Received: from krava (unknown [10.40.194.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6EB9A19CB1;
        Wed, 20 Jan 2021 21:50:05 +0000 (UTC)
Date:   Wed, 20 Jan 2021 22:50:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf script: Fix overrun issue for
 dynamically-allocated pmu type number
Message-ID: <20210120215004.GD1798087@krava>
References: <20201209005828.21302-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209005828.21302-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 08:58:28AM +0800, Jin Yao wrote:
> When unpacking the event which is from dynamic pmu, the array
> output[OUTPUT_TYPE_MAX] may be overrun. For example, type number of
> SKL uncore_imc is 10, but OUTPUT_TYPE_MAX is 7 now (OUTPUT_TYPE_MAX =
> PERF_TYPE_MAX + 1).
> 
> /* In builtin-script.c */
> process_event()
> {
>         unsigned int type = output_type(attr->type);
> 
>         if (output[type].fields == 0)
>                 return;
> }
> 
> output[10] is overrun.
> 
> Create a type OUTPUT_TYPE_OTHER for dynamic pmu events, then
> output_type(attr->type) will return OUTPUT_TYPE_OTHER here.
> 
> Note that if PERF_TYPE_MAX ever changed, then there would be a conflict
> between old perf.data files that had a dynamicaliy allocated PMU number
> that would then be the same as a fixed PERF_TYPE.
> 
> Example:
> 
> perf record --switch-events -C 0 -e "{cpu-clock,uncore_imc/data_reads/,uncore_imc/data_writes/}:SD" -a -- sleep 1
> perf script
> 
> Before:
>          swapper     0 [000] 1479253.987551:     277766               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.987797:     246709               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.988127:     329883               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.988273:     146393               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.988523:     249977               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.988877:     354090               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.989023:     145940               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.989383:     359856               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.989523:     140082               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
> 
> After:
>          swapper     0 [000] 1397040.402011:     272384               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1397040.402011:       5396  uncore_imc/data_reads/:
>          swapper     0 [000] 1397040.402011:        967 uncore_imc/data_writes/:
>          swapper     0 [000] 1397040.402259:     249153               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1397040.402259:       7231  uncore_imc/data_reads/:
>          swapper     0 [000] 1397040.402259:       1297 uncore_imc/data_writes/:
>          swapper     0 [000] 1397040.402508:     249108               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1397040.402508:       5333  uncore_imc/data_reads/:
>          swapper     0 [000] 1397040.402508:       1008 uncore_imc/data_writes/:
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
> v2:
>   Remove Fixes tag because this issue has always been here, not caused by
>   1405720d4f26 ("perf script: Add 'synth' event type for synthesized events").
>   No functional change in v2. 

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

