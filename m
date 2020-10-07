Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F062868A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgJGTyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:54:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43512 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgJGTx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:53:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id c2so4342296qkf.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 12:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWZPrk2HAzOluyH/d6XXY+zNuc54KSPlwvPVs4xhysM=;
        b=PaEqu3bVgON++U0YY3NGkuWQQ6ECfGruMoqXAqYpYGowkpFmpPAinXqO+Tgjp+ZeVm
         j6IyGDSUjZ0Db9p+9hy3KbMJR64kdiL8VyXfOieS3t5ifqQlmqAwiMpEwqB+bLjaNBbE
         iMEQQyFpSlr1jGlmfdqt3q217qNluntf61RoVNB+2/A8/H3zP1V/+HDupaVHd4ju3YdK
         LpBhC6h63jELbCjldDxW/crNL7bgP4k193WC6V+lX3XpSlYlqVgyLKU/KvJMbF9kY6Mz
         pZSmtRFOeKcvxeeKzXria00LeOodGst3xXTqS40kOPwxHFi1tWf6uJRrNX/pAnjHUsbZ
         JGZg==
X-Gm-Message-State: AOAM530ZlgPpEa1sixTWkcLbRZEM9xlgaADNsbg4/7ifLndsy6/+o8CE
        iLxzcquz/QHgUiTpWNiQHvaatuTReWzOeQ==
X-Google-Smtp-Source: ABdhPJxwgCqsMILmGrT/3Bd2MeJ+iNwiRB1wnb4cGqrszxCTZelL/sNN96Nr7S+Gy2iLwLPQAQK48w==
X-Received: by 2002:a37:6288:: with SMTP id w130mr4484526qkb.193.1602100437277;
        Wed, 07 Oct 2020 12:53:57 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k20sm2287658qtm.44.2020.10.07.12.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 12:53:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] x86/head/64: Disable stack protection for head$(BITS).o
Date:   Wed,  7 Oct 2020 15:53:51 -0400
Message-Id: <20201007195351.776555-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007195351.776555-1-nivedita@alum.mit.edu>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
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

