Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532F52A4880
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgKCOUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgKCNpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:45:15 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021B0C0613D1;
        Tue,  3 Nov 2020 05:45:15 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id c5so11584864qtw.3;
        Tue, 03 Nov 2020 05:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=do2IkGTsgJZMce9dLCi5y9V7vjNX63EvX8bAUDpEGLM=;
        b=GZPVvErj4PHBMLqkcSjbNmjmJr4IFQAsCF6LbDLPnOqXfs7SLj1TTKqhDmNgH840z/
         JMTtucvAwREP+cEU+Z5Iz9lcArpHDNTiECZewb/MjCmRhNpQ6PuqqdTsVjqPNl8xvRdo
         sip44uxOeEAEVkGMyHAODxwQELEMs/kd6J09+5V1ZmN3zfpxAieTNiIx3evs2766AEOo
         gEP+Z4M+G2wLoWKjcrT41XHAyl01UzldioGtYHEGV1haEI4YToOheJ1zn1dRAZHSXrbf
         pKglRVS7f6vVvyFumFCM3MU4VHkFYyeDA7+teIbMSHjdZA03RLUMjsja8eSRa7PJSF9s
         Z5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=do2IkGTsgJZMce9dLCi5y9V7vjNX63EvX8bAUDpEGLM=;
        b=QEv3j+gKk05w7Izq+8719nIBaPYK8YTtsuT/2pXuBxIOWoUenxhvrG6GwbiQftmxhg
         rTrzUfII6DvcS+exru+2gaF9JaVN5WvhCZZgQyoagOZbjneL2YjuJCncP331ZMKVyoOn
         H+fWrryZXUL3h31OQpVk+MLtoFYSFYtRxD/GGBawCOfU7fRDJbbBti7fc5ZDwLNS6/91
         F8L7xC2u660EbLQV9J7gdMpSshc82OccXLmeCMoJBaSCmTX2ana+N3DlPGjFjn3ipS7R
         jsbUOA5ybKmSu2BV2S+WlR53iR83FLdJY4aAZ1NEJIf16EpIF5rYQ/4eSmQwdpnyagjb
         vmVg==
X-Gm-Message-State: AOAM533gxYZ43bjDWzDxOHRvJYZ7697dyxJd4xij5/oxt/8YeC36w3gV
        9L7dDbF/YXRia5DFbbEc7s0=
X-Google-Smtp-Source: ABdhPJzhvqPfN56+Yli4koNRw2qkj9WiJNRq59eXTsSDpfjJx+9FOdsirhwbtC1KEzvqsKxYUpRyXg==
X-Received: by 2002:a05:622a:8a:: with SMTP id o10mr19841485qtw.274.1604411113872;
        Tue, 03 Nov 2020 05:45:13 -0800 (PST)
Received: from zhuyifei1999-ThinkPad-T480.gw.illinois.edu ([2620:0:e00:400f::31])
        by smtp.gmail.com with ESMTPSA id a206sm7356568qkb.64.2020.11.03.05.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 05:45:13 -0800 (PST)
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
Subject: [PATCH seccomp 4/8] riscv: Enable seccomp architecture tracking
Date:   Tue,  3 Nov 2020 07:43:00 -0600
Message-Id: <c2a5b127d7b52557bca6526eeaa73c91fa989816.1604410035.git.yifeifz2@illinois.edu>
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
for riscv.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/riscv/include/asm/seccomp.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/seccomp.h b/arch/riscv/include/asm/seccomp.h
index bf7744ee3b3d..c7ee6a3507be 100644
--- a/arch/riscv/include/asm/seccomp.h
+++ b/arch/riscv/include/asm/seccomp.h
@@ -7,4 +7,14 @@
 
 #include <asm-generic/seccomp.h>
 
+#ifdef CONFIG_64BIT
+# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_RISCV64
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"riscv64"
+#else /* !CONFIG_64BIT */
+# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_RISCV32
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"riscv32"
+#endif
+
 #endif /* _ASM_SECCOMP_H */
-- 
2.29.2

