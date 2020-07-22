Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E1722A305
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 01:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbgGVXVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 19:21:22 -0400
Received: from outpost17.zedat.fu-berlin.de ([130.133.4.110]:40571 "EHLO
        outpost17.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733242AbgGVXVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:21:21 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2020 19:21:08 EDT
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <mkarcher@physik.fu-berlin.de>)
          id 1jyNwH-000bao-U8; Thu, 23 Jul 2020 01:14:17 +0200
Received: from mx.physik.fu-berlin.de ([160.45.64.218])
          by relay1.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_DHE_RSA_WITH_AES_128_CBC_SHA
          (envelope-from <mkarcher@physik.fu-berlin.de>)
          id 1jyNwH-001IwG-Ra; Thu, 23 Jul 2020 01:14:17 +0200
Received: from epyc.physik.fu-berlin.de ([160.45.64.180])
        by mx.physik.fu-berlin.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <mkarcher@physik.fu-berlin.de>)
        id 1jyNwB-0002Uf-Bg; Thu, 23 Jul 2020 01:14:11 +0200
Received: from mkarcher by epyc.physik.fu-berlin.de with local (Exim 4.94 #2 (Debian))
        id 1jyNwB-001lBq-3K; Thu, 23 Jul 2020 01:14:11 +0200
From:   Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
To:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH 4/4] sh: bring syscall_set_return_value in line with other architectures
Date:   Thu, 23 Jul 2020 01:13:22 +0200
Message-Id: <20200722231322.419642-4-kernel@mkarcher.dialup.fu-berlin.de>
X-Mailer: git-send-email 2.28.0.rc1
In-Reply-To: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
References: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 160.45.64.218
X-ZEDAT-Hint: RV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other architectures expect that syscall_set_return_value gets an already
negative value as error. That's also what kernel/seccomp.c provides.

Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 arch/sh/include/asm/syscall_32.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/syscall_32.h b/arch/sh/include/asm/syscall_32.h
index 0b5b8e75edac..cb51a7528384 100644
--- a/arch/sh/include/asm/syscall_32.h
+++ b/arch/sh/include/asm/syscall_32.h
@@ -40,10 +40,7 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	if (error)
-		regs->regs[0] = -error;
-	else
-		regs->regs[0] = val;
+	regs->regs[0] = (long) error ?: val;
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
-- 
2.28.0.rc1

