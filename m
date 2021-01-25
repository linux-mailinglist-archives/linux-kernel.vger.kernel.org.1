Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0790A3039EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403762AbhAZKMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731666AbhAYTUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:20:08 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1E9C061756
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:27 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id n3so3202275qvf.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=etL32FYt+98u1sEnSN2D9m2zEWLuZNtfowf09CYacIU=;
        b=fd0Lk6UOzO0TicMR5oWXHg+JuTghXP3CauOmv+oga2qmCQO/ZG/IiT8HXfv2U++qqc
         KbyfcrG5gvFX62FWqf92w2nWIOCis9V5mQX1tQd+Ywe6zBeMa5xAdRflPHcI/Vhb+CB5
         ArtjxyEr8hBh7PGYANxNGz7SyV5FeTRqEFDuquVkiK6f2rPEjTV8PU5aIhSSDteWN8nQ
         cZbAyCVs6sQpDayWlXkRJUoDMIX5pQAeFQZ5a4K8F5nO0isXUUoeNe3znwWYTxHKC6pL
         EB42Cxu/hu0LdmQdPRypPBrnMU+fYdv0cKqxTUvu29es2XrwE/96x6W4ShlArBm+SW68
         /Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etL32FYt+98u1sEnSN2D9m2zEWLuZNtfowf09CYacIU=;
        b=dlb4J/8WqJbbslZUN9GYXPRmfhC0rKaGC28/d/NJywUH8IRiUtczlyIDxu441kglcu
         ihGRyL88y43GqaB3oI79mIKBL8TZKE86R3SJKFzCWUsZXqwst+2k+YiqXHCFla7CO2Rb
         EKZqR8plW1yt8XERQZu5Hi4jUrbOvL37Uwx/ojpxOgWhhgD/2h6oPHrnTtwxxo0vc2tJ
         6ROuuKvRtvdLYRzOntWKeiZkuu7eauDfuey2/1gcS+PlU+IXUvyTfCNkEPAOkArwGCf4
         CNVgdcFLLbKNXXwqmZb+fBzpGOezMnRQIKKMpTuJ2yJsjit0CnHAQ14wctuJN4pX6Ekl
         AZ7Q==
X-Gm-Message-State: AOAM533uMQqNGgpy5S9XwlLTGngQKTcMroJ7PM3I6onh4x/3TuKTzJIH
        Vy9Cr6NZ20elWZ2xSsUgLQqlAA==
X-Google-Smtp-Source: ABdhPJxsUsLk3uypyODw2uSFbzFEEVUFtn5pCaoqujizEArj1agTAVjfzSE4qT7+XYJRN9kW/PJkwQ==
X-Received: by 2002:a05:6214:36b:: with SMTP id t11mr2228378qvu.33.1611602367042;
        Mon, 25 Jan 2021 11:19:27 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:26 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v10 01/18] arm64: kexec: make dtb_mem always enabled
Date:   Mon, 25 Jan 2021 14:19:06 -0500
Message-Id: <20210125191923.1060122-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, dtb_mem is enabled only when CONFIG_KEXEC_FILE is
enabled. This adds ugly ifdefs to c files.

Always enabled dtb_mem, when it is not used, it is NULL.
Change the dtb_mem to phys_addr_t, as it is a physical address.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/kexec.h    | 4 ++--
 arch/arm64/kernel/machine_kexec.c | 6 +-----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d24b527e8c00..61530ec3a9b1 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,18 +90,18 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
-#ifdef CONFIG_KEXEC_FILE
 #define ARCH_HAS_KIMAGE_ARCH
 
 struct kimage_arch {
 	void *dtb;
-	unsigned long dtb_mem;
+	phys_addr_t dtb_mem;
 	/* Core ELF header buffer */
 	void *elf_headers;
 	unsigned long elf_headers_mem;
 	unsigned long elf_headers_sz;
 };
 
+#ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_image_ops;
 
 struct kimage;
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index a0b144cfaea7..8096a6aa1d49 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -204,11 +204,7 @@ void machine_kexec(struct kimage *kimage)
 	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
 	cpu_soft_restart(reboot_code_buffer_phys, kimage->head, kimage->start,
-#ifdef CONFIG_KEXEC_FILE
-						kimage->arch.dtb_mem);
-#else
-						0);
-#endif
+			 kimage->arch.dtb_mem);
 
 	BUG(); /* Should never get here. */
 }
-- 
2.25.1

