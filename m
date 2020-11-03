Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B55D2A46D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgKCNqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgKCNpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:45:18 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A38EC0613D1;
        Tue,  3 Nov 2020 05:45:18 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f93so11553474qtb.10;
        Tue, 03 Nov 2020 05:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9/hEAP0td3DKDEonOQx/BrDGR67nDcwn+HdeFH8wdFU=;
        b=PMy31dQJueagbOReuh4TyHKDHnWAkQvYrpAxEIErX4xPuMN4MlNB2tU7IkrAnlx5qR
         uhiVg0r41UxTv/gr4jsg2Wl8FCoeHTXIjjT8/6kSbvOBLPV4TYfJCrk8J0g2rFJRrlKD
         1hx2REJtkovGnmyDSF4OhzIchxZlhVI33gOeYruCrarfFMdqwMbuze+ne7D3usBg1+Vq
         DnVMU0VjWHDphquu2ZmwzzqKtLL7eO8+3YSpHLjN+/oLDv2OFzem5txt9rfYq8LN1OI+
         2+w6DzMI4hNFhProTsfpRsIxSVaEXoTrzgUyJ2J91ehNlbAFEuRmMAY+8h22ZlecP47B
         /smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/hEAP0td3DKDEonOQx/BrDGR67nDcwn+HdeFH8wdFU=;
        b=FAOUUw8qgEFsLyntO8HMv17VykQMUfNp0Lo06RXXleJk80dVCX0wyKHf4l2Y/q6nb8
         AeaqzWnhimpH3y6g8lMqFWh+UwmM6V+WXstJlv1DDIeZvSnNAgSCwryqhP8Ntr6knMHV
         OuKB1v5mz0DiAoa8eytYEinPfSjZr/GqwpnXq19VRIvZF7XSRNPyMs+bubf+lS7o1u9z
         VygetQe6GuvoyZ/MJUkPu/R0eKKxJc8Vbv0Eu76m9NGz1SC7WuARpMJi8ZaQ7XJkrVDv
         XzboR4LkhS3ZYockGV8p+B55E0LZe2hVO6P1lt81b66Q1yHh3C0iwpWnz7I2bv9aOare
         1TVQ==
X-Gm-Message-State: AOAM530PXGjSHEPMfnR9aUytKqM6P2ZEGRz/yEUsltJuQyQsrKabs+lT
        xSUzzLl6k8zpOhd0vhsjhio=
X-Google-Smtp-Source: ABdhPJxZpuM+FL2rdeo54BZFwmZgnUAh5zGzhGJrI7NUoaE9OPGoZYZ+/yTeLM9bmqKuOcXR8gpKgw==
X-Received: by 2002:aed:2064:: with SMTP id 91mr19450606qta.383.1604411117345;
        Tue, 03 Nov 2020 05:45:17 -0800 (PST)
Received: from zhuyifei1999-ThinkPad-T480.gw.illinois.edu ([2620:0:e00:400f::31])
        by smtp.gmail.com with ESMTPSA id a206sm7356568qkb.64.2020.11.03.05.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 05:45:16 -0800 (PST)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH seccomp 6/8] sh: Enable seccomp architecture tracking
Date:   Tue,  3 Nov 2020 07:43:02 -0600
Message-Id: <46d7f8d02bdaadf364a59db2d60f43466227b3af.1604410035.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1604410035.git.yifeifz2@illinois.edu>
References: <cover.1604410035.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

To enable seccomp constant action bitmaps, we need to have a static
mapping to the audit architecture and system call table size. Add these
for sh.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/sh/include/asm/seccomp.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/sh/include/asm/seccomp.h b/arch/sh/include/asm/seccomp.h
index 54111e4d32b8..b8d169292a34 100644
--- a/arch/sh/include/asm/seccomp.h
+++ b/arch/sh/include/asm/seccomp.h
@@ -8,4 +8,14 @@
 #define __NR_seccomp_exit __NR_exit
 #define __NR_seccomp_sigreturn __NR_rt_sigreturn
 
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define __SECCOMP_ARCH_LE_BIT		__AUDIT_ARCH_LE
+#else
+#define __SECCOMP_ARCH_LE_BIT		0
+#endif
+
+#define SECCOMP_ARCH_NATIVE		(AUDIT_ARCH_SH | __SECCOMP_ARCH_LE)
+#define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+#define SECCOMP_ARCH_NATIVE_NAME	"sh"
+
 #endif /* __ASM_SECCOMP_H */
-- 
2.29.2

