Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9022679C3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 13:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgILLKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 07:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgILLJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 07:09:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DEFC061387
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 04:08:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so9077859pfn.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 04:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A/DJWaOGDg8TnLfPzYOmd0dx0QQlX1IuvmauX5MM/z4=;
        b=B7Pu6ciAM9Wj8FHsJTVw46Ua5S9hrVltSsm5GGaS80TxiMZMNP4Qchvzd+nfqOXIU1
         CHHjGHFwSGw6mUCZfJJDYG/a3j1+8UwQZY/t6O8DeOFsvbaU2KZs+7xn2lyBMtJ97Y3C
         3z/bEjC9kfU9Qffz2o59RBia8wGEjG4xeBAXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A/DJWaOGDg8TnLfPzYOmd0dx0QQlX1IuvmauX5MM/z4=;
        b=ZUuV2idMoAiRLVflgroxo+1WPtPmoMPk/aFQAsCga5BqWfEWpbLtbm4aI//7KqjRvu
         fUdQpvRz7vDFLMrMarMBD2uyA0Hm0eF2c+K04K3zydGVvIzqAbPWiIFAZ/8pJfFm2EZS
         NvcXproRurcBkuvi8G95aeYrjt4PvhERWNR4iuatGyUTIbLLE08ceUrHFF2ElWZ6OOP+
         EsdwvrOV+m5svKnUDwnLsmIQp5HXUlIZALPd8aLCYx7T4fhBMUvd+v4fK8qVww2YnceR
         fodtz9LCvPTekPC92ckf9n6quouTq7BKXpDPbeGBpODv/smL6raO/rmK/6ylfMyoepgP
         KhfA==
X-Gm-Message-State: AOAM530aM9YzIJyN7o8k+rV6bkcLb06UhS8KpDUdd9qiXppGHXyN3dDc
        Pfo4wKbPAyUdNGqurRwqVe03lw==
X-Google-Smtp-Source: ABdhPJymdaGehFfmWOF8pjaRXGA9IFueCBtSZeu4mHAGimcnmquUAgmxx02n5nOMGKgTrLGxVr5RwQ==
X-Received: by 2002:a62:301:0:b029:13c:1611:6587 with SMTP id 1-20020a6203010000b029013c16116587mr5993137pfd.4.1599908912736;
        Sat, 12 Sep 2020 04:08:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x192sm4807719pfc.142.2020.09.12.04.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 04:08:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/15] selftests/seccomp: Avoid redundant register flushes
Date:   Sat, 12 Sep 2020 04:08:15 -0700
Message-Id: <20200912110820.597135-11-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912110820.597135-1-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When none of the registers have changed, don't flush them back. This can
happen if the architecture uses a non-register way to change the syscall
(e.g. arm64) , and a return value hasn't been written.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index d9346121b89b..2790d9cd50f4 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1859,11 +1859,12 @@ int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
 void change_syscall(struct __test_metadata *_metadata,
 		    pid_t tracee, int syscall, int result)
 {
-	ARCH_REGS regs;
+	ARCH_REGS orig, regs;
 
 	EXPECT_EQ(0, ARCH_GETREGS(regs)) {
 		return;
 	}
+	orig = regs;
 
 	SYSCALL_NUM_SET(regs, syscall);
 
@@ -1876,7 +1877,8 @@ void change_syscall(struct __test_metadata *_metadata,
 #endif
 
 	/* Flush any register changes made. */
-	EXPECT_EQ(0, ARCH_SETREGS(regs));
+	if (memcmp(&orig, &regs, sizeof(orig)) != 0)
+		EXPECT_EQ(0, ARCH_SETREGS(regs));
 }
 
 void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
-- 
2.25.1

