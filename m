Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C8F2EA132
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbhADX6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhADX6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:58:37 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793F8C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 15:57:51 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c12so17339944pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 15:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cbf4qUSPecz1BVMGHHpkX8PIH4EMlFN+qvU7k0BNC6o=;
        b=BSM8zowhQIEBD79vG1JT54Xa0iC40nZD1ap1oOg9lMey5igoND+bdPNi+vSDgqc+jZ
         T4d2wnAPLAvzI3u2TekCAEeRtlOuKRL3Jwk/vTYaGEq5hz9RQ3asX0jN7+0zG6D8v4WY
         mehpUQwkby4N5XNtZS4odrC7a3rvngHnpVWWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cbf4qUSPecz1BVMGHHpkX8PIH4EMlFN+qvU7k0BNC6o=;
        b=dymy/YSt9hqVXR0g8/nMs935I7cfBLdBDgITh2Nv/+rhkE7097UoN8apZUn810XyS2
         GNdtHeucDsUsF7ES3nQHplZCbwBfOVW8WMtDiNczE47HCqi+VEVNkCLCjsj7pegJFbE5
         UegdsdN8LpN6bdpDDq5Yb7geDvl0auIWNThO/X0kBDO10FNHD/9ozDPqDlLfctxOxYkB
         FszwlcEokCppWVE0jj2yPd/uQAqmwnexZq3q7smrX6nm2xnvpIbSk8o2TcEYjwxi8Vhd
         cOtQqpzyTmbFT502FDyYJlDe4omLOh0u+oomf3kUKgGdZAVRE/zkvC5+kdjw1UDFa4aX
         ZRsQ==
X-Gm-Message-State: AOAM532ffhMmBwvN27P8FabDSnTS4SuQPVdLsT0dYimBmpNNMRk7a+z9
        0j3uj5sowEnBrQ4XDkr3fVNJcw==
X-Google-Smtp-Source: ABdhPJwaKybELNdYGIWtV12kgIkwo6PDlLpGPCwHsDZKfaGmlChDzE0hQ8YZUr83N8BLA4F2jWn3/A==
X-Received: by 2002:a65:654e:: with SMTP id a14mr1803618pgw.265.1609804670937;
        Mon, 04 Jan 2021 15:57:50 -0800 (PST)
Received: from localhost (161.136.24.136.in-addr.arpa. [136.24.136.161])
        by smtp.gmail.com with ESMTPSA id 4sm500803pjn.14.2021.01.04.15.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:57:49 -0800 (PST)
From:   Ivan Babrou <ivan@cloudflare.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Ivan Babrou <ivan@cloudflare.com>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH] cpupower: add Makefile dependencies for install targets
Date:   Mon,  4 Jan 2021 15:57:18 -0800
Message-Id: <20210104235719.13525-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows building cpupower in parallel rather than serially.

Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
---
 tools/power/cpupower/Makefile       | 8 ++++----
 tools/power/cpupower/bench/Makefile | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index c7bcddbd486d..3b1594447f29 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -270,14 +270,14 @@ clean:
 	$(MAKE) -C bench O=$(OUTPUT) clean
 
 
-install-lib:
+install-lib: libcpupower
 	$(INSTALL) -d $(DESTDIR)${libdir}
 	$(CP) $(OUTPUT)libcpupower.so* $(DESTDIR)${libdir}/
 	$(INSTALL) -d $(DESTDIR)${includedir}
 	$(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
 	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
 
-install-tools:
+install-tools: $(OUTPUT)cpupower
 	$(INSTALL) -d $(DESTDIR)${bindir}
 	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
 	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
@@ -293,14 +293,14 @@ install-man:
 	$(INSTALL_DATA) -D man/cpupower-info.1 $(DESTDIR)${mandir}/man1/cpupower-info.1
 	$(INSTALL_DATA) -D man/cpupower-monitor.1 $(DESTDIR)${mandir}/man1/cpupower-monitor.1
 
-install-gmo:
+install-gmo: create-gmo
 	$(INSTALL) -d $(DESTDIR)${localedir}
 	for HLANG in $(LANGUAGES); do \
 		echo '$(INSTALL_DATA) -D $(OUTPUT)po/$$HLANG.gmo $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo'; \
 		$(INSTALL_DATA) -D $(OUTPUT)po/$$HLANG.gmo $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo; \
 	done;
 
-install-bench:
+install-bench: compile-bench
 	@#DESTDIR must be set from outside to survive
 	@sbindir=$(sbindir) bindir=$(bindir) docdir=$(docdir) confdir=$(confdir) $(MAKE) -C bench O=$(OUTPUT) install
 
diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index f68b4bc55273..d9d9923af85c 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -27,7 +27,7 @@ $(OUTPUT)cpufreq-bench: $(OBJS)
 
 all: $(OUTPUT)cpufreq-bench
 
-install:
+install: $(OUTPUT)cpufreq-bench
 	mkdir -p $(DESTDIR)/$(sbindir)
 	mkdir -p $(DESTDIR)/$(bindir)
 	mkdir -p $(DESTDIR)/$(docdir)
-- 
2.29.2

