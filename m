Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0A21B073B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 13:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDTLSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 07:18:46 -0400
Received: from foss.arm.com ([217.140.110.172]:46664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgDTLSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:18:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C49371FB;
        Mon, 20 Apr 2020 04:18:45 -0700 (PDT)
Received: from [10.37.8.239] (unknown [10.37.8.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D67703F237;
        Mon, 20 Apr 2020 04:18:43 -0700 (PDT)
Subject: Re: [PATCH 15/15] tools headers: Synchronize linux/bits.h with the
 kernel sources
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
References: <20200414164854.26026-1-acme@kernel.org>
 <20200414164854.26026-16-acme@kernel.org>
 <7951882d-d13a-7b1e-36f4-73c188015161@arm.com>
 <20200416155404.GE2650@kernel.org>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <96ec5885-6f6a-288b-475d-99556113f95e@arm.com>
Date:   Mon, 20 Apr 2020 12:19:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200416155404.GE2650@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/20 4:54 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 15, 2020 at 10:14:06AM +0100, Vincenzo Frascino escreveu:
>> On 4/14/20 5:48 PM, Arnaldo Carvalho de Melo wrote:
>>> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>
>>> To pick up the changes in these csets:
>>>
>>>   295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
>>>   3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO")
>>>
>>> To address this tools/perf build warning:
>>>
>>>   Warning: Kernel ABI header at 'tools/include/linux/bits.h' differs from latest version at 'include/linux/bits.h'
>>>   diff -u tools/include/linux/bits.h include/linux/bits.h
>>>
>>> This clashes with usage of userspace's static_assert(), that, at least
>>> on glibc, is guarded by a ifnded/endif pair, do the same to our copy of
>>> build_bug.h and avoid that diff in check_headers.sh so that we continue
>>> checking for drifts with the kernel sources master copy.
>>>
>>> This will all be tested with the set of build containers that includes
>>> uCLibc, musl libc, lots of glibc versions in lots of distros and cross
>>> build environments.
>>>
>>> The tools/objtool, tools/bpf, etc were tested as well.
>>>
>>
>> Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com> # vDSO parts
> 
> Hey, thanks a lot for checking it! :-)
>

No issue :-) Thank you for updating the tools headers!

[...]

-- 
Regards,
Vincenzo
