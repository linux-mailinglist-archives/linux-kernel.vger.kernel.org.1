Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D886724F842
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 11:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgHXJ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 05:28:49 -0400
Received: from foss.arm.com ([217.140.110.172]:57364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729716AbgHXJ2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:28:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CADD1063;
        Mon, 24 Aug 2020 02:28:36 -0700 (PDT)
Received: from [10.57.5.66] (unknown [10.57.5.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C34483F71F;
        Mon, 24 Aug 2020 02:28:35 -0700 (PDT)
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, acme@redhat.com
From:   Al Grant <al.grant@foss.arm.com>
Subject: [PATCH] perf: correct SNOOPX field offset
Message-ID: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
Date:   Mon, 24 Aug 2020 10:28:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_event.h has macros that define the field offsets in the
data_src bitmask in perf records. The SNOOPX and REMOTE offsets
were both 37. These are distinct fields, and the bitfield layout
in perf_mem_data_src confirms that SNOOPX should be at offset 38.

From: Al Grant <al.grant@arm.com>

  include/uapi/linux/perf_event.h       | 2 +-
  tools/include/uapi/linux/perf_event.h | 2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/tools/include/uapi/linux/perf_event.h 
b/tools/include/uapi/linux/perf_event.h
index 077e7ee69e3d..3e5dcdd48a49 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1196,7 +1196,7 @@ union perf_mem_data_src {

  #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
  /* 1 free */
-#define PERF_MEM_SNOOPX_SHIFT  37
+#define PERF_MEM_SNOOPX_SHIFT  38

  /* locked instruction */
  #define PERF_MEM_LOCK_NA       0x01 /* not available */
