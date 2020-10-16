Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7D7290B16
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390954AbgJPSGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:06:24 -0400
Received: from m12-15.163.com ([220.181.12.15]:57122 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390875AbgJPSGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=RovIU
        axSqKFgfpyDiUzgwGNlUaBZAMLYqKHdp8WLGUg=; b=KX+k/9CyMBbcsFUS0Srry
        3Ig2A/mGjGGWDEeyd97h8q+aQ4FD5QezKCIfJHQf95AexsQ9uVFcb/+2oXAH+Sa1
        kexXrWj3DmWwVlvHGuayIBUpo5/DqIekqaKpOUL0aOsns0F3w6mL1xHT929F36YV
        kBGFMXB3Z4PImlzvWwMKI4=
Received: from localhost (unknown [101.86.214.18])
        by smtp11 (Coremail) with SMTP id D8CowACnERDn4IlfIO7HDA--.21546S2;
        Sat, 17 Oct 2020 02:05:27 +0800 (CST)
Date:   Sat, 17 Oct 2020 02:05:27 +0800
From:   Hui Su <sh_def@163.com>
To:     davidriley@chromium.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, sh_def@163.com
Subject: [PATCH] tools/time: access /sys/kernel/debug/udelay_test before test.
Message-ID: <20201016180527.GA422291@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: D8CowACnERDn4IlfIO7HDA--.21546S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWfJrW5Wr1kArWDGF48Zwb_yoW5Xw1UpF
        y5Gr1FyFWqgrnxAr4xJan7uFnxA3ykJ3WUZ340yw1rur1aqwn8JF12qryUXrW8Xr4a9a4j
        ka1q9F1rK3WIqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgVy3UUUUU=
X-Originating-IP: [101.86.214.18]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiMQe-X1UMV97IDgAAsA
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

Signed-off-by: Hui Su <sh_def@163.com>
---
 tools/time/udelay_test.sh | 51 +++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/tools/time/udelay_test.sh b/tools/time/udelay_test.sh
index 6779d7e55d85..853ba04e4149 100755
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
 
@@ -31,29 +32,43 @@ cleanup()
 	if [ -f $tmp_file ]; then
 		rm $tmp_file
 	fi
-	/sbin/modprobe -q -r $MODULE_NAME
+	/sbin/modprobe -r $MODULE_NAME
+}
+
+debug_file_exist()
+{
+	if [ ! -d "$UDELAY_PATH" ]; then
+		return 1
+	fi
+	return 0
 }
 
 trap cleanup EXIT
 setup
+debug_file_exist
 
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
+if [ $? -eq 1 ]; then
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


