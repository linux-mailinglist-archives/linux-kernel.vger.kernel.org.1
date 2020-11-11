Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED82AF26F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgKKNfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgKKNek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:34:40 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AEEC0613D1;
        Wed, 11 Nov 2020 05:34:39 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id g19so871059qvy.2;
        Wed, 11 Nov 2020 05:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=do2IkGTsgJZMce9dLCi5y9V7vjNX63EvX8bAUDpEGLM=;
        b=kqmci8479r1GmpSX/CsPK24jcw4ackZR09/fqBvzcYwOBOneuWx5PFapDrNR/y91zk
         ExAMU598dyHT/RcJ0vEsvLy4Ops+sFNh3zgqOE4JArPSyF7W9sja/hApRc2rC1Nwm2hJ
         u50FMSKsKEcagX5U7XeUcBUJxC1PhPsCIK1LzOF+1qxQDwvzDgWYavL+OHfPE2kcPPFp
         EApyeIYNOUYqsqaYXaV0Ji65m4GhaGRycYlamUWs8R5m/Eh5ESQ0qNfQZrDakTPeWfnR
         dkjvod65hl/fav16KIifE1cRgTcdlFaQ87PvVYqF5inQSFpWoASygEZjooid8wnIuGLL
         DptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=do2IkGTsgJZMce9dLCi5y9V7vjNX63EvX8bAUDpEGLM=;
        b=QTGIEZQ8GQj1TUY2NMZ60UICNhwyYCLZu2w/tYQoJuSCzzimyOPskoBuD6hIcc8fNG
         9nzZxQZ542btFmB8d6FVEB/CEdlnfps+y6bQsmcUe+941/v3dpkH/I8RLYSs4KQTcM4F
         maKKd2CROrsgehLktteNRaJpIYeOhxtilB/Q0GuQDnH5JXhTjNeeT649nfM8OM+p8II6
         Ux9b4P6PgFKdxni/zKWtQmwCCdU63KykiM0w7q9DxIfJnKUNRno3qXKfdNwLNlfle93D
         ZaqRmMBL4NJHU+6FQWBdLvQQelIE/TVbcYTzOz8DlfeSvtLS3WldyVRLCq9Df8tdoyNj
         H7pg==
X-Gm-Message-State: AOAM533zFW6hWoP88n+8LQPBf6eduh7Xw7DlkB54E8kDnkuINHyK1ICq
        2xuAiJ0X9Rd5q3iLmcvArZ8nVbetsb+wRg==
X-Google-Smtp-Source: ABdhPJzFsUI0zV9/mJU71uSGXIEeuyYH9ZXGj+0WaVMtZXX0iy4+DwFsWuBQL0cgOtuNbH4AHKgOyQ==
X-Received: by 2002:a0c:e443:: with SMTP id d3mr13987966qvm.18.1605101678476;
        Wed, 11 Nov 2020 05:34:38 -0800 (PST)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id r190sm1997814qkf.101.2020.11.11.05.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:34:37 -0800 (PST)
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
Subject: [PATCH seccomp v2 4/8] riscv: Enable seccomp architecture tracking
Date:   Wed, 11 Nov 2020 07:33:50 -0600
Message-Id: <58ef925d00505cbb77478fa6bd2b48ab2d902460.1605101222.git.yifeifz2@illinois.edu>
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

