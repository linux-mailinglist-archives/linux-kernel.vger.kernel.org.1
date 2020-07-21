Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0BB227C61
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 12:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgGUKCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 06:02:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46285 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgGUKCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:02:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jxp6H-0000Kf-Mg; Tue, 21 Jul 2020 10:02:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        xen-devel@lists.xenproject.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] x86/ioperm: initialize pointer bitmap with NULL rather than 0
Date:   Tue, 21 Jul 2020 11:02:17 +0100
Message-Id: <20200721100217.407975-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer bitmap is being initialized with a plain integer 0,
fix this by initializing it with a NULL instead.

Cleans up sparse warning:
arch/x86/xen/enlighten_pv.c:876:27: warning: Using plain integer
as NULL pointer

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/xen/enlighten_pv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c46b9f2e732f..2aab43a13a8c 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -873,7 +873,7 @@ static void xen_load_sp0(unsigned long sp0)
 static void xen_invalidate_io_bitmap(void)
 {
 	struct physdev_set_iobitmap iobitmap = {
-		.bitmap = 0,
+		.bitmap = NULL,
 		.nr_ports = 0,
 	};
 
-- 
2.27.0

