Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922D628D630
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 23:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgJMVXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 17:23:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:20432 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgJMVXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 17:23:13 -0400
IronPort-SDR: g4dwexpgf/L3gRoBfGyReQ/wnCUXSCJ7XOVi8b/hQA7n6y+/4c0vSHZkUoDw5SwyCw3nvEki9y
 54e0hHjstngQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="162523978"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="162523978"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 14:23:12 -0700
IronPort-SDR: iWPnDm+fFzds12QJNey0u/3YL/GyTt67TjS3rsaEulip8CrFM3n1Wick9b+jgyL7/advnr5f3x
 ZitcLEOzWA9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="299731631"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 13 Oct 2020 14:23:12 -0700
Received: from [10.249.229.194] (abudanko-mobl.ccr.corp.intel.com [10.249.229.194])
        by linux.intel.com (Postfix) with ESMTP id AA91358084F;
        Tue, 13 Oct 2020 14:23:06 -0700 (PDT)
Subject: Re: [PATCH v1 02/15] perf report: output trace file name in raw trace
 dump
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <87e2050b-37e6-8ed8-e1e0-cfa074b030fa@linux.intel.com>
 <20201013195454.GA1305928@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b49c86a5-c114-efa7-97b1-c172215b6f5d@linux.intel.com>
Date:   Wed, 14 Oct 2020 00:23:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201013195454.GA1305928@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13.10.2020 22:54, Jiri Olsa wrote:
> On Mon, Oct 12, 2020 at 11:54:24AM +0300, Alexey Budankov wrote:
>>
>> Output path of a trace file into raw dump (-D) <file_offset>@<path/file>.
>> Print offset of PERF_RECORD_COMPRESSED record instead of zero for
>> decompressed records:
>>   0x2226a@perf.data [0x30]: event: 9
>> or
>>   0x15cc36@perf.data/data.7 [0x30]: event: 9
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> 
> hi,
> I'm getting:
> 
>   CC       builtin-inject.o
> builtin-inject.c: In function ‘cmd_inject’:
> builtin-inject.c:850:18: error: initialization of ‘int (*)(struct perf_session *, union perf_event *, u64,  const char *)’ {aka ‘int (*)(struct perf_session *, union perf_event *, long unsigned int,  const char *)’} from incompatible pointer type ‘int (*)(struct perf_session *, union perf_event *, u64)’ {aka ‘int (*)(struct perf_session *, union perf_event *, long unsigned int)’} [-Werror=incompatible-pointer-types]
>   850 |    .compressed = perf_event__repipe_op4_synth,
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> builtin-inject.c:850:18: note: (near initialization for ‘inject.tool.compressed’)
> 
> it's probably recent build id changes 

Looks like that's it. Fix is in v2 and follows:

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f3f965157d69..35c005b8da7f 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -106,7 +106,8 @@ static int perf_event__repipe_op2_synth(struct perf_session *session,
 
 static int perf_event__repipe_op4_synth(struct perf_session *session,
 					union perf_event *event,
-					u64 data __maybe_unused)
+					u64 data __maybe_unused,
+					const char *str __maybe_unused)
 {
 	return perf_event__repipe_synth(session->tool, event);
 }

Thanks!
Alexei
