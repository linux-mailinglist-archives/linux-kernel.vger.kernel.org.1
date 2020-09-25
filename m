Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09122794E2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgIYXpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgIYXph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:45:37 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6FEC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:45:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fa1so283125pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f1jwHVzfZHrVmqikaqf6fuMg9CXwRG2rrwLcl0E/Pb4=;
        b=D3Cu1hB1m1lprTGmLAyG6xV6ny/FBHq9zXv9pEvu7WhFaxncAb+SrVuCLTeD4Zf3xq
         FbfynQPNXe70ufCEMGMqt7qt0AlHlEW0BauITWLILYYQKogCVBUPBhCjQUy9cYCksHOS
         Os/7DZ9Ovw3UDeMuB1PlKY42Dpa8mwL4kVRCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f1jwHVzfZHrVmqikaqf6fuMg9CXwRG2rrwLcl0E/Pb4=;
        b=S9JVgimTs8Y3F2dha5Z1Tb6jO6WPfy9CEbt3WJyD5c0GjNVtTCXmlmF528K7FG5PqR
         5yVKkPm5QH++qUDoKdE2QPv/KDASuyatHRsaKXlAt72KPZHj0Wr0CdBn6gMaet/8Ead4
         81MrRXHQuieKAk4aXP3bAlieZcfxVYS7OH49k1eCztqn+at62gGoa1FzP8+BHeBsQfTM
         w5TaRkAH/xwpF5RXyMFF8YiNR5kpwztKiEuTL9ejINa0VGVsNt2AXg8gEeVSbjzLQvWW
         OXckoXSK9fPfhLFTGmHHvvSObFuyn2MdL+ynDM4doZPaYoPmXCreNNyMak5mk/cGi/cR
         hshA==
X-Gm-Message-State: AOAM5305VZmWsLrFhEUnnivCDyzXbMB4wX4ZceN70f020Rs2dQq5bSQp
        3fp2JCncQ2PXP++JhExVpc0IBNmCTPjPmiaN
X-Google-Smtp-Source: ABdhPJzRvAfa55DSVx0WFW/fZb8aSLunHIeiClcmR33X4CbdS1acmEeXw4jf2Xi4RN85U3OCU4C2vg==
X-Received: by 2002:a17:90b:f83:: with SMTP id ft3mr17057pjb.234.1601077537186;
        Fri, 25 Sep 2020 16:45:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c20sm3660942pfc.209.2020.09.25.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:45:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tim.Bird@sony.com, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/run_kselftest.sh: Make each test individually selectable
Date:   Fri, 25 Sep 2020 16:45:27 -0700
Message-Id: <20200925234527.1885234-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925234527.1885234-1-keescook@chromium.org>
References: <20200925234527.1885234-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently with run_kselftest.sh there is no way to choose which test
we could run. All the tests listed in kselftest-list.txt are all run
every time. This patch enhanced the run_kselftest.sh to make the test
collections (or tests) individually selectable. e.g.:

$ ./run_kselftest.sh -c seccomp -t timers:posix_timers -t timers:nanosleep

Additionally adds a way to list all known tests with "-l", usage
with "-h", and perform a dry run without running tests with "-n".

Co-developed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/run_kselftest.sh | 77 ++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index e07344be28ae..c08089f80e28 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -4,21 +4,86 @@ cd $BASE_DIR
 TESTS="$BASE_DIR"/kselftest-list.txt
 if [ ! -r "$TESTS" ] ; then
 	echo "$0: Could not find list of tests to run ($TESTS)" >&2
-	exit 1
+	available=""
+else
+	available="$(cat "$TESTS")"
 fi
-available="$(cat "$TESTS")"
 
 . ./kselftest/runner.sh
 ROOT=$PWD
 
-if [ "$1" = "--summary" ] ; then
-	logfile="$BASE_DIR"/output.log
-	cat /dev/null > $logfile
+usage()
+{
+	cat <<EOF
+Usage: $0 [OPTIONS]
+  -s | --summary		Print summary with detailed log in output.log
+  -t | --test COLLECTION:TEST	Run TEST from COLLECTION
+  -c | --collection COLLECTION	Run all tests from COLLECTION
+  -l | --list			List the available collection:test entries
+  -d | --dry-run		Don't actually run any tests
+  -h | --help			Show this usage info
+EOF
+	exit $1
+}
+
+COLLECTIONS=""
+TESTS=""
+dryrun=""
+while true; do
+	case "$1" in
+		-s | --summary)
+			logfile="$BASE_DIR"/output.log
+			cat /dev/null > $logfile
+			shift ;;
+		-t | --test)
+			TESTS="$TESTS $2"
+			shift 2 ;;
+		-c | --collection)
+			COLLECTIONS="$COLLECTIONS $2"
+			shift 2 ;;
+		-l | --list)
+			echo "$available"
+			exit 0 ;;
+		-n | --dry-run)
+			dryrun="echo"
+			shift ;;
+		-h | --help)
+			usage 0 ;;
+		"")
+			break ;;
+		*)
+			usage 1 ;;
+	esac
+done
+
+# Add all selected collections to the explicit test list.
+if [ -n "$COLLECTIONS" ]; then
+	for collection in $COLLECTIONS ; do
+		found="$(echo "$available" | grep "^$collection:")"
+		if [ -z "$found" ] ; then
+			echo "No such collection '$collection'" >&2
+			exit 1
+		fi
+		TESTS="$TESTS $found"
+	done
+fi
+# Replace available test list with explicitly selected tests.
+if [ -n "$TESTS" ]; then
+	valid=""
+	for test in $TESTS ; do
+		found="$(echo "$available" | grep "^${test}$")"
+		if [ -z "$found" ] ; then
+			echo "No such test '$test'" >&2
+			exit 1
+		fi
+		valid="$valid $found"
+	done
+	available="$(echo "$valid" | sed -e 's/ /\n/g')"
 fi
 
 collections=$(echo "$available" | cut -d: -f1 | uniq)
 for collection in $collections ; do
 	[ -w /dev/kmsg ] && echo "kselftest: Running tests in $collection" >> /dev/kmsg
 	tests=$(echo "$available" | grep "^$collection:" | cut -d: -f2)
-	(cd "$collection" && run_many $tests)
+	($dryrun cd "$collection" && $dryrun run_many $tests)
 done
-- 
2.25.1

