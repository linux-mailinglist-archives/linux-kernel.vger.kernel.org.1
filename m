Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84532AF286
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgKKNfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgKKNel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:34:41 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB26BC0613D1;
        Wed, 11 Nov 2020 05:34:40 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q5so1560704qkc.12;
        Wed, 11 Nov 2020 05:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+eMXBOnvKPM7N/Eu0cs4UA1I6FeurfdgB6uFLVTMPX8=;
        b=CtuNdkss3y7rgKc1l9KsIQZTv0LgZAhMRYi/6z6qZmeZkTtZ4x7E48r/LeELYZ06IN
         8cgqYZ8dHlw0uxtVdsPuGe5k/uNahk9dBk2utYsfhVEV4Ba/sogSqNiIxMOka14XZD8a
         eupUAgtHJBLzSWs9IfisbVC1mdakqgfudFjJHeYdfmpXX0W03tbjgHa1X2SdS54+cwbz
         4hcZkRNxXc8xWoaxyCLZaNV6QnzDrrzHDB6WZ3omhkvvhakq0V/TBs/W/M2pg4I58bEk
         U0Idcw73pn5TTYmrEG4CqfKVjhniq9pyecl8f2TP5P/XCIVnlIMOYfN29gQ3XF6HZQop
         jcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+eMXBOnvKPM7N/Eu0cs4UA1I6FeurfdgB6uFLVTMPX8=;
        b=o+PNKlr606hn2RK4tip9lJKu/b2ENbQAy0NCBgdCsz5sjxUITQFpoK1Jbe9vUmo4mK
         DdPnaPjZ0LfHr+Kckm7oaIsJX9rk9XbcpQleOStc4gphOejzdK6bLYmVzRsr4Q2WV913
         vJ7RXnI/2/b7YUJRVoA5/yZGFC/YDjdw2MaqBmLjjlmfOJHGENf/Iu781jQ7FcVH+U3g
         X+wo1vFr5UztC5pp8iwQLzR6aPyRQ1289D/NRswV6u1Q11xrYuCR6YWnNhW01aevePIr
         hxSYg4OmAqBJQQJ0Q5A1k8M6/R7F6qHcT0D23gAk+EncLeJnvJ1OTi97LcYAM3YeSCF1
         6+lw==
X-Gm-Message-State: AOAM531D3NxYv5mPN66jCwv/w9pyxbijyKNHsDnNHyXQMF6fLBwcIyYG
        LqluE9+OM8SmWTMYjLfy3so=
X-Google-Smtp-Source: ABdhPJziT3nG/TSXJ4p+Pm6vLQUb4KIz+diKiufrVwDSoSwTeA58/VG9OWAb2+vs2wrY9VS5+FBB5A==
X-Received: by 2002:a37:7fc7:: with SMTP id a190mr24750394qkd.337.1605101680151;
        Wed, 11 Nov 2020 05:34:40 -0800 (PST)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id r190sm1997814qkf.101.2020.11.11.05.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:34:39 -0800 (PST)
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
Subject: [PATCH seccomp v2 5/8] s390: Enable seccomp architecture tracking
Date:   Wed, 11 Nov 2020 07:33:51 -0600
Message-Id: <a381b10aa2c5b1e583642f3cd46ced842d9d4ce5.1605101222.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605101222.git.yifeifz2@illinois.edu>
References: <cover.1605101222.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

To enable seccomp constant action bitmaps, we need to have a static
mapping to the audit architecture and system call table size. Add these
for s390.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/s390/include/asm/seccomp.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/include/asm/seccomp.h b/arch/s390/include/asm/seccomp.h
index 795bbe0d7ca6..71d46f0ba97b 100644
--- a/arch/s390/include/asm/seccomp.h
+++ b/arch/s390/include/asm/seccomp.h
@@ -16,4 +16,13 @@
 
 #include <asm-generic/seccomp.h>
 
+#define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_S390X
+#define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+#define SECCOMP_ARCH_NATIVE_NAME	"s390x"
+#ifdef CONFIG_COMPAT
+# define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_S390
+# define SECCOMP_ARCH_COMPAT_NR		NR_syscalls
+# define SECCOMP_ARCH_COMPAT_NAME	"s390"
+#endif
+
 #endif	/* _ASM_S390_SECCOMP_H */
-- 
2.29.2

