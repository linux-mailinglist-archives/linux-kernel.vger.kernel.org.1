Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D522CD52F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbgLCMJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387983AbgLCMJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:09:39 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EE8C061A4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 04:08:58 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id q1so1361394wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 04:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=nWnhV2L36jl8Q2KQ48DfmO4+zFQ9NK25B8o4zxmFHTU=;
        b=CxjBqchGiISIeMXgdc8TuT103CM5diiFGOQO78yeW11SH5o7HYBmKkWKoRRwkjbdQk
         MEE7YC0xvc7zw5NAV2RkJmAaP6Jr3jdga8bAjllM8i2ZKxpdg+DRvgdf4sXT+s/2HqRP
         H7XtpjMSAkfcnTGpPFF0kU1N7+EMFd8N7V9f4tejWbkUp/Sy1vy9Bp7MmIpRIMXjgShN
         iB/KUqH8YE0TZQZFfkiimAC5qCgQ3qLUDOQ3iVH/SSoy8PXYfqJoBYvtNojCkcSY8PYc
         AS/UdgOigttdvB/N1gSXbKPJGXhiIYrxKscHrIg1RhzY3oKXNLcxda0Hjnpf0jcBthpq
         I4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=nWnhV2L36jl8Q2KQ48DfmO4+zFQ9NK25B8o4zxmFHTU=;
        b=Sz5kqLPQccmLyyLj+IER74k3WnP9jkK+YTJo1StKX/TD3/xKvAUmDVxjSk1lA3f0JA
         a/5xKnDMpvnTLZWlMYbSCHweG2I9qO8ajpC39rwV33CdM9ufxw4N23ISBL5CKkOFw49u
         jdGS5iAHk6kJa2bgIsWV3c7ZBl/tQxy3RWmCuY7I/UmkxwVZvcUfF6FctOX83+r1ZUjZ
         aTRZ9qbq0bKUHpgC/VGTZJywfPQSrmFmKtCs8MEoyLPcnAvd62AQC4eDuc1wFCoaNH1F
         HTitmtOtOQSO/1IujIAoNt1chB/cojdnbU8myAz62D19XVw4xeNg2qBuvexwhILaKlml
         2lrQ==
X-Gm-Message-State: AOAM533jq4pN+agUS+AO4lYoCuYo6BnjtZ+mJpjprsc5awPVUc4drME6
        AK97JHcuRrXgWVqEz94YX6imV/4FSpJMeg==
X-Google-Smtp-Source: ABdhPJwWFNl4s0ki9ODJ5mmINtSjGhbTT2wgDva5LjbGNkLDaeP7l2jIh0IvFqE9V96y0llq+H6SNNdONZWENA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:791a:: with SMTP id
 l26mr998488wme.1.1606997336622; Thu, 03 Dec 2020 04:08:56 -0800 (PST)
Date:   Thu,  3 Dec 2020 12:08:50 +0000
Message-Id: <20201203120850.859170-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next] bpf: Fix cold build of test_progs-no_alu32
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This object lives inside the trunner output dir,
i.e. tools/testing/selftests/bpf/no_alu32/btf_data.o

At some point it gets copied into the parent directory during another
part of the build, but that doesn't happen when building
test_progs-no_alu32 from clean.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 894192c319fb..371b022d932c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -378,7 +378,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     | $(TRUNNER_BINARY)-extras
 	$$(call msg,BINARY,,$$@)
 	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
-	$(Q)$(RESOLVE_BTFIDS) --no-fail --btf btf_data.o $$@
+	$(Q)$(RESOLVE_BTFIDS) --no-fail --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
 
 endef
 

base-commit: 97306be45fbe7a02461c3c2a57e666cf662b1aaf
-- 
2.29.2.454.gaff20da3a2-goog

