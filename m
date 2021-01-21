Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079A32FE35A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbhAUHC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:02:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbhAUG7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:59:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7443B239EF;
        Thu, 21 Jan 2021 06:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212245;
        bh=+ImL2UR5Wqlq3NTKFXbClIjnQPRXcWNhsbOJ57BukIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AlT4o4NYdCjcQL1ej7N5a2QKB85hlyQATlg3lxcFx0p1sqVjqTOOY7etvWfGcX5Mg
         g7M7vkISuImY2yosFHD2js0KLUQAEoKfAoM9dUVVKB38/sq4BfpfZcJGgWlZQL7yHX
         xpmPGUR+bBZ/2eBIBnNs98VOk/GruGWCcefG/YIt9uem2Hh0s0feHjSMs9Mw8vyHPp
         1LARxusDq6lyGFCL5Ls8GtjyAzk89obR98NGMqDkgZB+GSzhAa9w261zlqjMeA0M/B
         Bo9s20uHJvobo8IE1Jd/8iVueFk3M/0FmJWW1y7XZMD0jfztutcfDHkfycj3LEWyTq
         X3o+XxeasALTA==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 21/29] csky: Fix a size determination in gpr_get()
Date:   Thu, 21 Jan 2021 14:53:41 +0800
Message-Id: <20210121065349.3188251-21-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenzhong Duan <zhenzhong.duan@gmail.com>

"*" is missed  in size determination as we are passing register set
rather than a pointer.

Fixes: dcad7854fcce ("sky: switch to ->regset_get()")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 417b759fab6c..0105ac81b432 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -84,7 +84,7 @@ static int gpr_get(struct task_struct *target,
 	/* Abiv1 regs->tls is fake and we need sync here. */
 	regs->tls = task_thread_info(target)->tp_value;
 
-	return membuf_write(&to, regs, sizeof(regs));
+	return membuf_write(&to, regs, sizeof(*regs));
 }
 
 static int gpr_set(struct task_struct *target,
-- 
2.17.1

