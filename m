Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8A92CDAC6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbgLCQFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgLCQFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:05:18 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D16AC09424C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:03:39 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 141so2314446qkh.18
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IMilI2Z6+aKwuOWDf3tm98A2hDsLcRMs3IV5SkkVoW4=;
        b=ODl5ipUqgCmdiomJnZEgAey6Nrfb6zLj72eClBJGt7MuFtRy5pI9S0EKEh6PzKF1uw
         K5pNTv6Fb+aHa650ISo858vH7GAnYZlQd2xkgSf3ijCPjxKQ2p/tfNrvvvIZFcsQrrOl
         iTCPOoZh5c3T88WCtUnaggkYgqxXXugDiIgY0T+I1V6yVFDBchhqVEW7rjxH0mjI/0qp
         yIMBBJgJ4E+uzCqkGfHst0vspHJLgXWWZwnqi/dr0LKEB60YHGIcJF0JGFZWV5ZAd3LJ
         Z6hV6S+MSsJHVSaUCt4FC/qaM19Jc2dg9rzgozKvvZe2sN3IcgpG/2ViAztRQYzn43bD
         1zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IMilI2Z6+aKwuOWDf3tm98A2hDsLcRMs3IV5SkkVoW4=;
        b=m7Fw+oCARVr42zfTWykMpvChA3m70iP1mCbGKP9/5oJvzHdzzolApWGgEh4utpYsC5
         iKTEsesjlws+m8/JJQmsvwzrPw93lHYc5Vs4wwH8O/5ZaYK6nAwsdhxj3s7qGez4CFAJ
         9X0kROzVZ8KOaagWsRNm6sofcivd5SeZMWOurVbnheeOw/yK6yYXRP62zW1yYZAVn2zF
         6Vik88/RsI7auzRrqISUPYTU2NdLl+2GVX7lWp8ozNfqpwu430dId2d5XL1O7TKdUXyE
         u32CiSFPLCE5Hg9wfcO1AtyhJxdguHSbPjF/Zq2UMRyYjJ+ufvQqpl6q8T4pfal9MYOX
         ANzg==
X-Gm-Message-State: AOAM531JtbDlpTPi8BAdbC2Dk4UkEhcAuTStKXHc4CTli2luF2QCw5TA
        LHy16jdCKES9IZ6OOBCa1uhA/5IqZLqwUg==
X-Google-Smtp-Source: ABdhPJyWcI7r5iOiGtGzuUAxvhLA44h5393hO+egwkMucsytcbRIQyR7e8xwVW3kCOBm5nSQUiWqBkzQW27w7w==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a0c:f809:: with SMTP id
 r9mr3775595qvn.17.1607011415132; Thu, 03 Dec 2020 08:03:35 -0800 (PST)
Date:   Thu,  3 Dec 2020 16:02:43 +0000
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Message-Id: <20201203160245.1014867-13-jackmanb@google.com>
Mime-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v3 12/14] bpf: Pull tools/build/feature biz into
 selftests Makefile
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is somewhat cargo-culted from the libbpf build. It will be used
in a subsequent patch to query for Clang BPF atomics support.

Change-Id: I9318a1702170eb752acced35acbb33f45126c44c
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/bpf/.gitignore |  1 +
 tools/testing/selftests/bpf/Makefile   | 38 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 395ae040ce1f..3c604dff1e20 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -35,3 +35,4 @@ test_cpp
 /tools
 /runqslower
 /bench
+/FEATURE-DUMP.selftests.bpf
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 894192c319fb..f21c4841a612 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -104,8 +104,46 @@ OVERRIDE_TARGETS := 1
 override define CLEAN
 	$(call msg,CLEAN)
 	$(Q)$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
+	$(Q)$(RM) $(OUTPUT)/FEATURE-DUMP.selftests.bpf
 endef
 
+# This will work when bpf is built in tools env. where srctree
+# isn't set and when invoked from selftests build, where srctree
+# is set to ".". building_out_of_srctree is undefined for in srctree
+# builds
+ifeq ($(srctree),)
+update_srctree := 1
+endif
+ifdef building_out_of_srctree
+update_srctree := 1
+endif
+ifeq ($(update_srctree),1)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+
+FEATURE_USER = .selftests.bpf
+FEATURE_TESTS = clang-bpf-atomics
+FEATURE_DISPLAY = clang-bpf-atomics
+
+check_feat := 1
+NON_CHECK_FEAT_TARGETS := clean
+ifdef MAKECMDGOALS
+ifeq ($(filter-out $(NON_CHECK_FEAT_TARGETS),$(MAKECMDGOALS)),)
+  check_feat := 0
+endif
+endif
+
+ifeq ($(check_feat),1)
+ifeq ($(FEATURES_DUMP),)
+include $(srctree)/tools/build/Makefile.feature
+else
+include $(FEATURES_DUMP)
+endif
+endif
+
 include ../lib.mk
 
 SCRATCH_DIR := $(OUTPUT)/tools
-- 
2.29.2.454.gaff20da3a2-goog

