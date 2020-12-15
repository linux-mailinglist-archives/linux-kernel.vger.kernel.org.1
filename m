Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F042DB42B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgLOTAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731764AbgLOS7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:59:52 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEE0C061282
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:59:12 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id w18so7687632iot.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=xRj/mOaFoEo9MOuo2TtzraoXsL0t9sn69debK9wpzTg=;
        b=fpX9UTQ3nZP3DUZ4YtdPDi4ST4vPCmj0ViAycBq1SgM2mFujpAA2aoYBAyyeBkpuME
         nACverDmzBWN4S19g0p1wwek0ciDNAsoSHg38STRfqzTafvvK9X5FM/YG8O3/TKio+cG
         BOfb//FiJDfBUyNve89qhhTLBY4jydZ3qh1AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=xRj/mOaFoEo9MOuo2TtzraoXsL0t9sn69debK9wpzTg=;
        b=Ad5eineERZiKYCgCZSoAilvILR36NGCj1G1jmnIHa2okPZQhZBSiDpFeNH95xafvwn
         94DMIyfDXNeLH8NWekOkj32FuPJVV675b6U2E1DOB0Yy3MBEa+E+fI+tzHiZLGb2pAVQ
         sMTK0Ey8rY6UctMLEmDPyX+EUFdey3SWOWSeJfEfgUSCPZvW4BUPwcCXc3FBcAaVuYrp
         bLK6+W2YCutVJVV8UGKEyYPaCCcjRvYBoGgzaN8eQnEdy9Wla67bk/1ZKFv1JjmB9JP5
         jgSbc35531R4Cg4MG5vcc3LkOU1VqLHEFE7UuAx3sRimCeR4czA3nfpMyTtupjDbBuMR
         qt5g==
X-Gm-Message-State: AOAM5330AAGn3/nLJwF9G06dYtNO2yLu0zMTBl/WEW6nWeij/7F8UQcI
        jT3RxZIMEZ9pCYaTI13ZJUjO87Dmvk00sA==
X-Google-Smtp-Source: ABdhPJyvNjjulGvfsDY6oyhvQgUpfYmIc26avTIJSt4/zWgESmpu4L/5OtpUJiZybv2o27UN1AwGNA==
X-Received: by 2002:a5e:8344:: with SMTP id y4mr38781968iom.116.1608058751862;
        Tue, 15 Dec 2020 10:59:11 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l6sm14440517ili.78.2020.12.15.10.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 10:59:10 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.11-rc1
Message-ID: <bd9a480f-80f9-5beb-2f1f-dbc28a7af80c@linuxfoundation.org>
Date:   Tue, 15 Dec 2020 11:59:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2F37C74BE26B0E1B10880709"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2F37C74BE26B0E1B10880709
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull this Kselftest fixes update for Linux 5.11-rc1.

This Kselftest fixes update for Linux 5.11-rc1 consists of build error
fixes for clone3 and rseq tests.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

   Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-fixes-5.11-rc1

for you to fetch changes up to 88f4ede44c585b24674dd99841040b2a1a856a76:

   selftests/clone3: Fix build error (2020-12-07 14:34:55 -0700)

----------------------------------------------------------------
linux-kselftest-fixes-5.11-rc1

This Kselftest fixes update for Linux 5.11-rc1 consists of build error
fixes for clone3 and rseq tests.

----------------------------------------------------------------
Xingxing Su (2):
       rseq/selftests: Fix MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ build 
error under other arch.
       selftests/clone3: Fix build error

  tools/testing/selftests/clone3/Makefile   | 2 +-
  tools/testing/selftests/rseq/param_test.c | 4 ++--
  2 files changed, 3 insertions(+), 3 deletions(-)
----------------------------------------------------------------



--------------2F37C74BE26B0E1B10880709
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.11-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.11-rc1.diff"

diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
index ef7564cb7abe..79b19a2863a0 100644
--- a/tools/testing/selftests/clone3/Makefile
+++ b/tools/testing/selftests/clone3/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -g -I../../../../usr/include/
+CFLAGS += -g -std=gnu99 -I../../../../usr/include/
 LDLIBS += -lcap
 
 TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 384589095864..699ad5f93c34 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -1133,6 +1133,8 @@ static int set_signal_handler(void)
 	return ret;
 }
 
+/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
+#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
 struct test_membarrier_thread_args {
 	int stop;
 	intptr_t percpu_list_ptr;
@@ -1286,8 +1288,6 @@ void *test_membarrier_manager_thread(void *arg)
 	return NULL;
 }
 
-/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
-#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
 void test_membarrier(void)
 {
 	const int num_threads = opt_threads;

--------------2F37C74BE26B0E1B10880709--
