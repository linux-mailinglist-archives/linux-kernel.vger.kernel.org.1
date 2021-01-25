Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35892302BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbhAYTn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731744AbhAYTV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:21:28 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38012C061352
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:57 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id a1so6701892qvd.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bntzwWb0HnF+pu1wTRlxa4nGPd0MURNpYR8uZbvPwl4=;
        b=aznWjElVYsHK1zXw38ZeQN4JK2jZE1LCcfMo91RU+SnIfejFZOlOFF6GnXfHtUxTuB
         nx+vd0X1j3aObV6HjWaRTYR3YFz3OMIKiMzQsFdP8O//rc3JyHEGvZ1eza4Hx9FhM9Xu
         MLPWDXzEokhcrZo7iPjKXIf8uyiVouOu6eWmBrQdBUyASn920C6UxGCP11uwpZJnT8Aq
         c0PQ22aHJcWhVfHa+IuSyf3iqMVoSgtM7PDqmk74MOJ5xqFyGUnmJ1Dw4Bg7hGJGR+Jq
         o7Vrk/rs5TNslgwP46rBg/KriUXV461e/WvbyR+EfD1Cn1cQnLm6i4tN3YvEpNTWjQwh
         psfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bntzwWb0HnF+pu1wTRlxa4nGPd0MURNpYR8uZbvPwl4=;
        b=p0TDmDT9x7M8OFWJ3/z5ExtQISIMjiLs87RT/Gl/L9qZSFnOII1BO5BY1Fd9jJhZTu
         2YJJ1NZNJKJxR1+OgBwizf0fzJ5v37HbW39fVWZGM6AD3KPmPc0V3lqwiCFNpooSYXwf
         LXyJge19b1BYa4Csxq7TnVgY7MtTYGYWH8r/3Cq7zDcSaAQpbbcICImhqlH5q0mjmBdE
         yFp2zp5Oloo2db50SrlpfjNJvm3KAeZjRQgWzQ07w3AYL08Ba0mlU7yWX7O3MX4DaT0G
         DRe0Dib8iKBlkEr4XPCfDW0UPdU4gUSDMAYxTyM57NQM6POVrrtSr/PIp4liSCacSnhY
         95rg==
X-Gm-Message-State: AOAM532jW/3hI6PsY6P4Wo571aNrIWB7LSJAZfl0B7C6O3qG5T9qYEtQ
        r3h3ugeaK/vo7HJG/h+ty9bjbg==
X-Google-Smtp-Source: ABdhPJytuTHdBIVuiybjpt5hI8b1ljcElIFMcTl+j/BWrIjw/SnfAX/Yl/DjO9FsYiUxo5xvziJ1Kw==
X-Received: by 2002:a05:6214:138e:: with SMTP id g14mr2241683qvz.7.1611602396408;
        Mon, 25 Jan 2021 11:19:56 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:55 -0800 (PST)
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
Subject: [PATCH v10 18/18] arm64: kexec: remove head from relocation argument
Date:   Mon, 25 Jan 2021 14:19:23 -0500
Message-Id: <20210125191923.1060122-19-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that relocation is done using virtual addresses, reloc_arg->head
is not needed anymore.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    | 2 --
 arch/arm64/kernel/asm-offsets.c   | 1 -
 arch/arm64/kernel/machine_kexec.c | 1 -
 3 files changed, 4 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 049cde429b1b..2fa4109bd582 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -97,7 +97,6 @@ extern const char arm64_kexec_el2_vectors[];
 
 /*
  * kern_reloc_arg is passed to kernel relocation function as an argument.
- * head		kimage->head, allows to traverse through relocation segments.
  * entry_addr	kimage->start, where to jump from relocation function (new
  *		kernel, or purgatory entry address).
  * kern_arg0	first argument to kernel is its dtb address. The other
@@ -113,7 +112,6 @@ extern const char arm64_kexec_el2_vectors[];
  * copy_len	Number of bytes that need to be copied
  */
 struct kern_reloc_arg {
-	phys_addr_t head;
 	phys_addr_t entry_addr;
 	phys_addr_t kern_arg0;
 	phys_addr_t kern_arg1;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 06278611451d..94f050ad6471 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -153,7 +153,6 @@ int main(void)
   BLANK();
 #endif
 #ifdef CONFIG_KEXEC_CORE
-  DEFINE(KEXEC_KRELOC_HEAD,		offsetof(struct kern_reloc_arg, head));
   DEFINE(KEXEC_KRELOC_ENTRY_ADDR,	offsetof(struct kern_reloc_arg, entry_addr));
   DEFINE(KEXEC_KRELOC_KERN_ARG0,	offsetof(struct kern_reloc_arg, kern_arg0));
   DEFINE(KEXEC_KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, kern_arg1));
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index dc1b7e5a54fb..c2dff232a85b 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -168,7 +168,6 @@ int machine_kexec_post_load(struct kimage *kimage)
 	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
 	kimage->arch.kern_reloc = __pa(reloc_code) + func_offset;
 	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
-	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
 	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
 
-- 
2.25.1

