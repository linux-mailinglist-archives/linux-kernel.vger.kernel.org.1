Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6E2733CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 22:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgIUUql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 16:46:41 -0400
Received: from foss.arm.com ([217.140.110.172]:55448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgIUUqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 16:46:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5049D147A;
        Mon, 21 Sep 2020 13:46:40 -0700 (PDT)
Received: from [10.57.47.88] (unknown [10.57.47.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D8403F718;
        Mon, 21 Sep 2020 13:46:38 -0700 (PDT)
From:   Al Grant <al.grant@foss.arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] perf: correct SNOOPX field offset
Message-ID: <4ac9f5cc-4388-b34a-9999-418a4099415d@foss.arm.com>
Date:   Mon, 21 Sep 2020 21:46:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_event.h has macros that define the field offsets in the
data_src bitmask in perf records. The SNOOPX and REMOTE offsets
were both 37. These are distinct fields, and the bitfield layout
in perf_mem_data_src confirms that SNOOPX should be at offset 38.

Fixes: 52839e653b5629bd ("perf tools: Add support for printing new 
mem_info encodings")
Signed-off-by: Al Grant <al.grant@foss.arm.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
  include/uapi/linux/perf_event.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h 
b/include/uapi/linux/perf_event.h
index 077e7ee69e3d..3e5dcdd48a49 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1196,7 +1196,7 @@ union perf_mem_data_src {

  #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
  /* 1 free */
-#define PERF_MEM_SNOOPX_SHIFT  37
+#define PERF_MEM_SNOOPX_SHIFT  38

  /* locked instruction */
  #define PERF_MEM_LOCK_NA       0x01 /* not available */
