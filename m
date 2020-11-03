Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81992A46BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgKCNky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:40:54 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:40933 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728029AbgKCNkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:40:53 -0500
Received: from localhost.localdomain (ip5f5af1b7.dynamic.kabel-deutschland.de [95.90.241.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3B0CC20647132;
        Tue,  3 Nov 2020 14:40:51 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Joe LeVeque <jolevequ@microsoft.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH] kexec: Add kexec reboot string
Date:   Tue,  3 Nov 2020 14:40:36 +0100
Message-Id: <20201103134036.23554-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe LeVeque <jolevequ@microsoft.com>

The purpose is to notify the kernel module for fast reboot.

Upstream a patch from the SONiC network operating system [1].

[1]: https://github.com/Azure/sonic-linux-kernel/pull/46

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 8798a8183974..9aaa6ce48cdf 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1167,7 +1167,7 @@ int kernel_kexec(void)
 #endif
 	{
 		kexec_in_progress = true;
-		kernel_restart_prepare(NULL);
+		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
 
 		/*
-- 
2.29.2

