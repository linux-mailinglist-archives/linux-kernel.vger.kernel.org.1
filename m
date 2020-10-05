Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF7E2841A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgJEUpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgJEUpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:45:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732BCC0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 13:45:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n136so1757144pfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMCvM/lVmSD+WoCXLV03EzHmNxDtsAkuJmb4ll+kKtw=;
        b=AIKmxUEZMVDxIcg4HDZZ+EWVJoorsD2ZAvAuSzmr2xiBCxBBInJKEqNLtgwRijVi1o
         NQDA1gGYhDFfByHmbEUT7KdTnwM+WC56xrdpnNaNeWxehBLmen+AolAiZtMbKSJKJDDL
         YCTrr8HUyH4yokR8Q6GoVT47D0p276zMrnMCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMCvM/lVmSD+WoCXLV03EzHmNxDtsAkuJmb4ll+kKtw=;
        b=m27FmcKQT3Iiscij02moI8MBgBTLfGG0QtE6rLSRIIoi4fB2up6cE0nWn1MB0hvnPn
         CbNbRuYC4UoXLttxWFxO1R5U/Q6i4vzIA4NWyCeCuJ724hJ1Pnqr8/fo/UYH+k6Y7nV0
         WPSCuuSh7HJNmrQNR9ul+X0r59EhdVuSdFTiWMl/fcT69OyicHUfBFhIW9twebqBMfpP
         PH3+bh30+LXANOh+HfRaKjS3ZRzApDKJ/tV2P8zk/pWHo+mfaBeG/Wzl+WTSf2fbdgPr
         10h8QaChgKRyfbFQQrisVOzMLFEROFbvWKJTPNQ3Qe7JQp6yI67zPUxryZKndfEZdqmL
         ztsw==
X-Gm-Message-State: AOAM533ycyvoqxsilBbJmwxkMTL1fNKmKjJTT3+XMWdMd/NaqE94GcFD
        WhSbHNXD7FiwU1UMWU9X+JWNFw==
X-Google-Smtp-Source: ABdhPJxGnRw0v6Z5EdICY7GvvnOsRaK8GQdlmuTPfJGHKAxCOIZBLjUIdSH/e7cTEU/ZnbdVPz/c/w==
X-Received: by 2002:aa7:9522:0:b029:142:2501:3986 with SMTP id c2-20020aa795220000b029014225013986mr1325575pfp.75.1601930721886;
        Mon, 05 Oct 2020 13:45:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s4sm800489pfu.107.2020.10.05.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 13:45:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: splice: Adjust for handler fallback removal
Date:   Mon,  5 Oct 2020 13:45:17 -0700
Message-Id: <20201005204517.2652730-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pseudo-filesystems do not have an explicit splice fops since adding
commit 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops"),
and now will reject attempts to use splice() in those filesystem paths.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Link: https://lore.kernel.org/lkml/202009181443.C2179FB@keescook/
Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../selftests/splice/short_splice_read.sh     | 119 ++++++++++++++----
 1 file changed, 98 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/splice/short_splice_read.sh b/tools/testing/selftests/splice/short_splice_read.sh
index 7810d3589d9a..22b6c8910b18 100755
--- a/tools/testing/selftests/splice/short_splice_read.sh
+++ b/tools/testing/selftests/splice/short_splice_read.sh
@@ -1,21 +1,87 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
+#
+# Test for mishandling of splice() on pseudofilesystems, which should catch
+# bugs like 11990a5bd7e5 ("module: Correctly truncate sysfs sections output")
+#
+# Since splice fallback was removed as part of the set_fs() rework, many of these
+# tests expect to fail now. See https://lore.kernel.org/lkml/202009181443.C2179FB@keescook/
 set -e
 
+DIR=$(dirname "$0")
+
 ret=0
 
+expect_success()
+{
+	title="$1"
+	shift
+
+	echo "" >&2
+	echo "$title ..." >&2
+
+	set +e
+	"$@"
+	rc=$?
+	set -e
+
+	case "$rc" in
+	0)
+		echo "ok: $title succeeded" >&2
+		;;
+	1)
+		echo "FAIL: $title should work" >&2
+		ret=$(( ret + 1 ))
+		;;
+	*)
+		echo "FAIL: something else went wrong" >&2
+		ret=$(( ret + 1 ))
+		;;
+	esac
+}
+
+expect_failure()
+{
+	title="$1"
+	shift
+
+	echo "" >&2
+	echo "$title ..." >&2
+
+	set +e
+	"$@"
+	rc=$?
+	set -e
+
+	case "$rc" in
+	0)
+		echo "FAIL: $title unexpectedly worked" >&2
+		ret=$(( ret + 1 ))
+		;;
+	1)
+		echo "ok: $title correctly failed" >&2
+		;;
+	*)
+		echo "FAIL: something else went wrong" >&2
+		ret=$(( ret + 1 ))
+		;;
+	esac
+}
+
 do_splice()
 {
 	filename="$1"
 	bytes="$2"
 	expected="$3"
+	report="$4"
 
-	out=$(./splice_read "$filename" "$bytes" | cat)
+	out=$("$DIR"/splice_read "$filename" "$bytes" | cat)
 	if [ "$out" = "$expected" ] ; then
-		echo "ok: $filename $bytes"
+		echo "      matched $report" >&2
+		return 0
 	else
-		echo "FAIL: $filename $bytes"
-		ret=1
+		echo "      no match: '$out' vs $report" >&2
+		return 1
 	fi
 }
 
@@ -23,34 +89,45 @@ test_splice()
 {
 	filename="$1"
 
+	echo "  checking $filename ..." >&2
+
 	full=$(cat "$filename")
+	rc=$?
+	if [ $rc -ne 0 ] ; then
+		return 2
+	fi
+
 	two=$(echo "$full" | grep -m1 . | cut -c-2)
 
 	# Make sure full splice has the same contents as a standard read.
-	do_splice "$filename" 4096 "$full"
+	echo "    splicing 4096 bytes ..." >&2
+	if ! do_splice "$filename" 4096 "$full" "full read" ; then
+		return 1
+	fi
 
 	# Make sure a partial splice see the first two characters.
-	do_splice "$filename" 2 "$two"
+	echo "    splicing 2 bytes ..." >&2
+	if ! do_splice "$filename" 2 "$two" "'$two'" ; then
+		return 1
+	fi
+
+	return 0
 }
 
-# proc_single_open(), seq_read()
-test_splice /proc/$$/limits
-# special open, seq_read()
-test_splice /proc/$$/comm
+### /proc/$pid/ has no splice interface; these should all fail.
+expect_failure "proc_single_open(), seq_read() splice" test_splice /proc/$$/limits
+expect_failure "special open(), seq_read() splice" test_splice /proc/$$/comm
 
-# proc_handler, proc_dointvec_minmax
-test_splice /proc/sys/fs/nr_open
-# proc_handler, proc_dostring
-test_splice /proc/sys/kernel/modprobe
-# proc_handler, special read
-test_splice /proc/sys/kernel/version
+### /proc/sys/ has a splice interface; these should all succeed.
+expect_success "proc_handler: proc_dointvec_minmax() splice" test_splice /proc/sys/fs/nr_open
+expect_success "proc_handler: proc_dostring() splice" test_splice /proc/sys/kernel/modprobe
+expect_success "proc_handler: special read splice" test_splice /proc/sys/kernel/version
 
+### /sys/ has no splice interface; these should all fail.
 if ! [ -d /sys/module/test_module/sections ] ; then
-	modprobe test_module
+	expect_success "test_module kernel module load" modprobe test_module
 fi
-# kernfs, attr
-test_splice /sys/module/test_module/coresize
-# kernfs, binattr
-test_splice /sys/module/test_module/sections/.init.text
+expect_failure "kernfs attr splice" test_splice /sys/module/test_module/coresize
+expect_failure "kernfs binattr splice" test_splice /sys/module/test_module/sections/.init.text
 
 exit $ret
-- 
2.25.1

