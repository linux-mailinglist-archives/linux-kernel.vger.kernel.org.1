Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5B11FD9F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 01:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFQX6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 19:58:22 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:38650 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726763AbgFQX6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:58:22 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id D897430D81D;
        Wed, 17 Jun 2020 16:58:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com D897430D81D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1592438300;
        bh=MDbwOv/n/PjcbExKhgCfJsNvpgg8GqIQ00OSvsMrBO0=;
        h=From:To:Cc:Subject:Date:From;
        b=oA+imnl5pndLVvXvkjMdmUndxBg8m7nUe+ml+6CCyBHK7tvwKwVv1HnzcZduX5wyp
         IrlnyMirbBkkypJeUFt+jIby2nzdCF8NsOH3T33oBYj1pkOfklYWWEDvZu9JmYKaZ6
         OgrY1ORsS+07QUu8NH5KMfE3sa0WPZtbWjlEGPLg=
Received: from lbrmn-mmayer.ric.broadcom.net (lbrmn-mmayer.ric.broadcom.net [10.136.28.150])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 26BED14008B;
        Wed, 17 Jun 2020 16:58:20 -0700 (PDT)
From:   Markus Mayer <markus.mayer@broadcom.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Brian Norris <computersforpeace@gmail.com>
Cc:     Markus Mayer <markus.mayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tools/thermal: tmon: include pthread and time headers in tmon.h
Date:   Wed, 17 Jun 2020 16:58:08 -0700
Message-Id: <20200617235809.6817-1-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include sys/time.h and pthread.h in tmon.h, so that types
"pthread_mutex_t" and "struct timeval tv" are known when tmon.h
references them.

Without these headers, compiling tmon against musl-libc will fail with
these errors:

In file included from sysfs.c:31:0:
tmon.h:47:8: error: unknown type name 'pthread_mutex_t'
 extern pthread_mutex_t input_lock;
        ^~~~~~~~~~~~~~~
make[3]: *** [<builtin>: sysfs.o] Error 1
make[3]: *** Waiting for unfinished jobs....
In file included from tui.c:31:0:
tmon.h:54:17: error: field 'tv' has incomplete type
  struct timeval tv;
                 ^~
make[3]: *** [<builtin>: tui.o] Error 1
make[2]: *** [Makefile:83: tmon] Error 2

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---

The issue was discovered cross-compiling tmon for aarch64 with musl-libc.
The build succeeds with glibc, because the required headers are included
implicitly. This is not the case with musl-libc.

 tools/thermal/tmon/tmon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
index c9066ec104dd..44d16d778f04 100644
--- a/tools/thermal/tmon/tmon.h
+++ b/tools/thermal/tmon/tmon.h
@@ -27,6 +27,9 @@
 #define NR_LINES_TZDATA 1
 #define TMON_LOG_FILE "/var/tmp/tmon.log"
 
+#include <sys/time.h>
+#include <pthread.h>
+
 extern unsigned long ticktime;
 extern double time_elapsed;
 extern unsigned long target_temp_user;
-- 
2.17.1

