Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67B294F80
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444007AbgJUPGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:06:45 -0400
Received: from m12-18.163.com ([220.181.12.18]:54398 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443805AbgJUPGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=1atr3
        BLVdaGJxWg6977cnjBb5WwJUusbaUuC1v5T6Ls=; b=VqQN1Xx9unlXBvjRKjEun
        YX+SqmB4iTYGj3lAgi+5NLhndgl+wrZCx9uH5vQolntMdGNPOSdcMiMySuCTcM6/
        oeIi62YY6KR3io6b+eArZ2QyrcDErwbEBAKcmfNEqQSszxw8JD9ppyZD9cG28LdO
        CSbvfexFVSHtErhrfC/kR4=
Received: from localhost (unknown [101.86.214.18])
        by smtp14 (Coremail) with SMTP id EsCowABn1aoaTpBfMsfWUQ--.1355S2;
        Wed, 21 Oct 2020 23:04:58 +0800 (CST)
Date:   Wed, 21 Oct 2020 23:04:58 +0800
From:   Hui Su <sh_def@163.com>
To:     davidriley@chromium.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, sh_def@163.com
Subject: [PATCH v2] tools/time: access /sys/kernel/debug/udelay_test before
 test
Message-ID: <20201021150458.GA139977@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EsCowABn1aoaTpBfMsfWUQ--.1355S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWfJrW5Wr1kArWDGF48Zwb_yoW5XF15pF
        y5Gr4SyFWqgrnxArWxJFs7uFnxA3ykJ3WUC3y0yw1rur4avwn8JF12qryUJrW8Xr4a9a4j
        ka1q9F1rK3WSva7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRqg4DUUUUU=
X-Originating-IP: [101.86.214.18]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBDhvEX1rbKvo2MwAAsa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

before(when i did not compile udelay_test.ko):
sh@ubuntu:~/workspace/compile/tools/time$ sudo ./udelay_test.sh
./udelay_test.sh: line 25: /sys/kernel/debug/udelay_test: Permission denied
./udelay_test.sh: line 26: /sys/kernel/debug/udelay_test: No such file or directory
./udelay_test.sh: line 25: /sys/kernel/debug/udelay_test: Permission denied
./udelay_test.sh: line 26: /sys/kernel/debug/udelay_test: No such file or directory
...
about two hundreds lines.

we access '/sys/kernel/debug/udelay_test' the before starting the
udelay_test.

now(when i did not compile udelay_test.ko):
sh@ubuntu:~/workspace/linux-stable/tools/time$ sudo ./udelay_test.sh
modprobe: FATAL: Module udelay_test not found in directory /lib/modules/5.4.44
ERROR, can not access /sys/kernel/debug/udelay_test.
modprobe: FATAL: Module udelay_test not found.

---
v1->v2: remove the debug_file_exist().

Signed-off-by: Hui Su <sh_def@163.com>
---
 tools/time/udelay_test.sh | 42 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/tools/time/udelay_test.sh b/tools/time/udelay_test.sh
index 6779d7e55d85..c8458d5b7fcd 100755
--- a/tools/time/udelay_test.sh
+++ b/tools/time/udelay_test.sh
@@ -12,10 +12,11 @@
 
 MODULE_NAME=udelay_test
 UDELAY_PATH=/sys/kernel/debug/udelay_test
+retcode=0
 
 setup()
 {
-	/sbin/modprobe -q $MODULE_NAME
+	/sbin/modprobe $MODULE_NAME
 	tmp_file=`mktemp`
 }
 
@@ -31,29 +32,34 @@ cleanup()
 	if [ -f $tmp_file ]; then
 		rm $tmp_file
 	fi
-	/sbin/modprobe -q -r $MODULE_NAME
+	/sbin/modprobe -r $MODULE_NAME
 }
 
 trap cleanup EXIT
 setup
 
-# Delay for a variety of times.
-# 1..200, 200..500 (by 10), 500..2000 (by 100)
-for (( delay = 1; delay < 200; delay += 1 )); do
-	test_one $delay
-done
-for (( delay = 200; delay < 500; delay += 10 )); do
-	test_one $delay
-done
-for (( delay = 500; delay <= 2000; delay += 100 )); do
-	test_one $delay
-done
-
-# Search for failures
-count=`grep -c FAIL $tmp_file`
-if [ $? -eq "0" ]; then
-	echo "ERROR: $count delays failed to delay long enough"
+if [ ! -d "$UDELAY_PATH" ]; then
 	retcode=1
+	echo "ERROR, can not access $UDELAY_PATH."
+else
+	# Delay for a variety of times.
+	# 1..200, 200..500 (by 10), 500..2000 (by 100)
+	for (( delay = 1; delay < 200; delay += 1 )); do
+		test_one $delay
+	done
+	for (( delay = 200; delay < 500; delay += 10 )); do
+		test_one $delay
+	done
+	for (( delay = 500; delay <= 2000; delay += 100 )); do
+		test_one $delay
+	done
+
+	# Search for failures
+	count=`grep -c FAIL $tmp_file`
+	if [ $? -eq "0" ]; then
+		echo "ERROR: $count delays failed to delay long enough"
+		retcode=1
+	fi
 fi
 
 exit $retcode
-- 
2.25.1


