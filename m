Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B4A2FD6CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404207AbhATRUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404214AbhATRT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611163079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8e3kT56buVvtt8Sag6D6TWd0VBoE+dYbK5rpcksHoCU=;
        b=G5eEeSsgtNMdIoAe75RUdNPVcjjIa4OO8Al0hcgUvbyPlo5CDfYPlD7MQXsjp+ouKzMJG0
        xeQ+q9ZsNyujsZ7UOY3Jkl8veWc6Wtuk3GsQPKSunWOII3Oa4vfS6bbRasW0FKDMIGgxvU
        x8ZUkhlhX0YQFUHsSHnZ8iMOwKaSJaI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-4IK76k5nM3Gq_JLA_OMslg-1; Wed, 20 Jan 2021 12:17:58 -0500
X-MC-Unique: 4IK76k5nM3Gq_JLA_OMslg-1
Received: by mail-wm1-f70.google.com with SMTP id x20so1811948wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:17:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8e3kT56buVvtt8Sag6D6TWd0VBoE+dYbK5rpcksHoCU=;
        b=KacYFlLGJJ5HeIuukgrsT3WDwcsC2q71FkrmDb8CR3IgMrnPgGwhLP4qtiAkVO6ze5
         qQt93wVd1OzG16IcjKchrjvyo3CgG4QlZKEDquL5uBTXOAobd1o5uPVGTd+1bi1F6n7w
         xQqotK/zT72jzshl4/zhGq/nIcYYdq6hLjoq+tOpMb7KqfQMr/wOo52P84rxoTL8+k5o
         8hHgPl5YtPJ7tmRprf62cW766MDTrbBLQ5wi2daGu89pRTz5fsOP/6tYDhHvTRhwrFbo
         UiColh5JEKDu5XyQ68PqWROC5x9RCyTRIgtAfNouEcMvQz+uq2iXwDvUGwHkk4Puju75
         +YGg==
X-Gm-Message-State: AOAM531Zr63q2WI8lI4+We//lH0jkQK7NnI+FkaJ00X17LZcgMuIQnq/
        2xpqqyhq/mOYa88xNYBI3+/gMk2UfrMY/3G89n2PiC7tPN7DkE2XCKEx7g6yfleK5vAI5Lzy05P
        BqVeB2FclxmEd7RUchaQikVy84nO4yO3/I3fF08NAOLXdRktx55vEZFKtpxge8DMFGoDyBc424n
        bJ
X-Received: by 2002:a1c:6308:: with SMTP id x8mr5127169wmb.108.1611163076466;
        Wed, 20 Jan 2021 09:17:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9/Da8tncM9FW1gM7j7pp0Cfvb9+o70yKYJdFyq5RTHywzEfimDcDdwKpOAUg8QvuwvF7OiQ==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr5127152wmb.108.1611163076301;
        Wed, 20 Jan 2021 09:17:56 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id o124sm5444077wmb.5.2021.01.20.09.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:17:55 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 4/5] arm64: aarch64-insn: Add some opcodes to instruction decoder
Date:   Wed, 20 Jan 2021 18:17:44 +0100
Message-Id: <20210120171745.1657762-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120171745.1657762-1-jthierry@redhat.com>
References: <20210120171745.1657762-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add decoding capability for some instructions that objtool will need
to decode.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/include/asm/aarch64-insn.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/aarch64-insn.h b/arch/arm64/include/asm/aarch64-insn.h
index d0fee47bbe6e..3a0e0ad51f5b 100644
--- a/arch/arm64/include/asm/aarch64-insn.h
+++ b/arch/arm64/include/asm/aarch64-insn.h
@@ -305,6 +305,12 @@ __AARCH64_INSN_FUNCS(adr,	0x9F000000, 0x10000000)
 __AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
 __AARCH64_INSN_FUNCS(prfm,	0x3FC00000, 0x39800000)
 __AARCH64_INSN_FUNCS(prfm_lit,	0xFF000000, 0xD8000000)
+__AARCH64_INSN_FUNCS(store_imm,	0x3FC00000, 0x39000000)
+__AARCH64_INSN_FUNCS(load_imm,	0x3FC00000, 0x39400000)
+__AARCH64_INSN_FUNCS(store_pre,	0x3FE00C00, 0x38000C00)
+__AARCH64_INSN_FUNCS(load_pre,	0x3FE00C00, 0x38400C00)
+__AARCH64_INSN_FUNCS(store_post,	0x3FE00C00, 0x38000400)
+__AARCH64_INSN_FUNCS(load_post,	0x3FE00C00, 0x38400400)
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
 __AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
@@ -313,6 +319,8 @@ __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
 __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
 __AARCH64_INSN_FUNCS(load_ex,	0x3F400000, 0x08400000)
 __AARCH64_INSN_FUNCS(store_ex,	0x3F400000, 0x08000000)
+__AARCH64_INSN_FUNCS(stp,	0x7FC00000, 0x29000000)
+__AARCH64_INSN_FUNCS(ldp,	0x7FC00000, 0x29400000)
 __AARCH64_INSN_FUNCS(stp_post,	0x7FC00000, 0x28800000)
 __AARCH64_INSN_FUNCS(ldp_post,	0x7FC00000, 0x28C00000)
 __AARCH64_INSN_FUNCS(stp_pre,	0x7FC00000, 0x29800000)
@@ -345,6 +353,7 @@ __AARCH64_INSN_FUNCS(rev64,	0x7FFFFC00, 0x5AC00C00)
 __AARCH64_INSN_FUNCS(and,	0x7F200000, 0x0A000000)
 __AARCH64_INSN_FUNCS(bic,	0x7F200000, 0x0A200000)
 __AARCH64_INSN_FUNCS(orr,	0x7F200000, 0x2A000000)
+__AARCH64_INSN_FUNCS(mov_reg,	0x7FE0FFE0, 0x2A0003E0)
 __AARCH64_INSN_FUNCS(orn,	0x7F200000, 0x2A200000)
 __AARCH64_INSN_FUNCS(eor,	0x7F200000, 0x4A000000)
 __AARCH64_INSN_FUNCS(eon,	0x7F200000, 0x4A200000)
-- 
2.25.4

