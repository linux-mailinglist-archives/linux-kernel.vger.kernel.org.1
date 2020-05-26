Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4251D2ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgENI4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 04:56:14 -0400
Received: from foss.arm.com ([217.140.110.172]:60846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENI4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:56:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DA6731B;
        Thu, 14 May 2020 01:56:13 -0700 (PDT)
Received: from nicgas01-03-arm-vm (nicgas01-03-arm-vm.shanghai.arm.com [10.169.138.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8CE43F71E;
        Thu, 14 May 2020 01:56:10 -0700 (PDT)
References: <20200427061520.24905-1-nick.gasson@arm.com>
 <20200427103505.GA1476763@krava>
User-agent: mu4e 1.4.4; emacs 27.0.91
From:   Nick Gasson <nick.gasson@arm.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/3] perf jvmti: Various fixes to JVMTI agent
In-reply-to: <20200427103505.GA1476763@krava>
Date:   Thu, 14 May 2020 16:56:07 +0800
Message-ID: <85lflu7v4o.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/20 18:35 pm, Jiri Olsa wrote:
>
> adding Stephane to the loop
>
> jirka
>
>> 
>> These three patches fix a couple of issues I ran into while using the
>> jitdump JVMTI agent to profile the SPECjbb benchmark.
>> 

Hi, any feedback on these patches?

Thanks,
Nick

>> 
>> 
>> Nick Gasson (3):
>>   perf jvmti: Fix jitdump for methods without debug info
>>   perf jvmti: Do not report error when missing debug information
>>   perf jvmti: Fix demangling Java symbols
>> 
>>  tools/perf/jvmti/libjvmti.c           | 24 +++++++--------
>>  tools/perf/tests/Build                |  1 +
>>  tools/perf/tests/builtin-test.c       |  4 +++
>>  tools/perf/tests/demangle-java-test.c | 42 +++++++++++++++++++++++++++
>>  tools/perf/tests/tests.h              |  1 +
>>  tools/perf/util/demangle-java.c       | 13 +++++----
>>  6 files changed, 66 insertions(+), 19 deletions(-)
>>  create mode 100644 tools/perf/tests/demangle-java-test.c
>> 
>> -- 
>> 2.26.1
>> 

