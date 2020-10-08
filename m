Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96690287C50
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgJHTQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:16:43 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42339 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbgJHTQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:16:31 -0400
Received: by mail-qv1-f66.google.com with SMTP id 13so3609191qvc.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 12:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWZPrk2HAzOluyH/d6XXY+zNuc54KSPlwvPVs4xhysM=;
        b=AUAfPQ2poBXfrtmeTkm/Yqs0djhLbk9831eGwB0OR7ydZJZwtAnTMGRMLcJw+3k8g3
         uW5ohXc6g9WW+0gsSYGyL68N0bp8BskrONIpJdfVjsNO6IeMdoy2ldK4AOeAXRoMKp11
         xYr8wrlalBuCj24+/RQxez5wNCrjjA0nLnaZwifStfg7qVu8zD8uLxR9ZsZp+d7g7IHc
         qE+4h+iYBxRfMVgqeeqj6wNRli7c4Nbl70eS0JURwLfXX9OPoMsbdDfRbgCSX15m8FZB
         L6Q4VidFR6KMrh95LloLA0OXjgluLV0k+HjKZSayfO4A50GkvISULA5mmh2e5d/tDQtS
         DlmA==
X-Gm-Message-State: AOAM530PHQWY7byb2savho2CKXvY+J9ZN00ZJNH9MR6N/u/sLoCFrp38
        PT4v4+U/GG2tX4pBzKJ5qmU=
X-Google-Smtp-Source: ABdhPJzmFfS9kNtZ0uxQIoIBm2Uq4AlVz2LTIkKLu8JL8/4qsbfmTOUxNQEWdwljapsbuzgJinallg==
X-Received: by 2002:a0c:e054:: with SMTP id y20mr9822120qvk.30.1602184590083;
        Thu, 08 Oct 2020 12:16:30 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z37sm4726759qtz.67.2020.10.08.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 12:16:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] x86/head/64: Disable stack protection for head$(BITS).o
Date:   Thu,  8 Oct 2020 15:16:23 -0400
Message-Id: <20201008191623.2881677-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201008191623.2881677-1-nivedita@alum.mit.edu>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit, the startup_64_setup_env() function added in
  866b556efa12 ("x86/head/64: Install startup GDT")
has stack protection enabled because of set_bringup_idt_handler().

At this point, %gs is not yet initialized, and this doesn't cause a
crash only because the #PF handler from the decompressor stub is still
installed and handles the page fault.

Disable stack protection for the whole file, and do it on 32-bit as
well to avoid surprises.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 04ceea8f4a89..68608bd892c0 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -47,6 +47,8 @@ endif
 # non-deterministic coverage.
 KCOV_INSTRUMENT		:= n
 
+CFLAGS_head$(BITS).o	+= -fno-stack-protector
+
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
 obj-y			:= process_$(BITS).o signal.o
-- 
2.26.2

