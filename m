Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAE02EC738
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 01:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbhAGANd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 19:13:33 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:47798 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbhAGANd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 19:13:33 -0500
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4F751C009A;
        Thu,  7 Jan 2021 00:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1609978352; bh=VEDI60u1cbWLwMz2J6HNd2ehfUiLmU2NYKL62iOlY48=;
        h=From:To:Cc:Subject:Date:From;
        b=IC/mVtE0bhrhHnF1QyG21ZD/UNOYLvTO+K5zWmIA/pY/YRkH1cbCDx4QiiKD5h7Xq
         JkKix3yDM11I2UkDNlQ/miPvCzAzT9vE8Ncvodt1FGcxJwg/OSNgECf+c9VbuTdDZj
         IHIL3gaqQYzuJyAfsqkHwowMbf8veSA56h34zQmTgXZG1Af0set1D3L+vcqQOZ+XIa
         ceCkyIu+7HKaK/pvmqy/CkXhNfj0JYGhkXgLNl+/eY98hASPYfgIDU69/Iy5Oomwzh
         d7ddizmfV4IfupKD9E4cBjPtpJHQaBkDA+PXiV9rzpJcWE549xunbh8bAJn52Dw0me
         OT59WX0HC8dQg==
Received: from vineetg-Latitude-7400.internal.synopsys.com (unknown [10.13.183.89])
        by mailhost.synopsys.com (Postfix) with ESMTP id E9579A009C;
        Thu,  7 Jan 2021 00:12:27 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] ARC: unbork 5.11 bootup: fix snafu in _TIF_NOTIFY_SIGNAL handling
Date:   Wed,  6 Jan 2021 16:12:25 -0800
Message-Id: <20210107001225.3063163-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 5.11.rcX was failing to boot on ARC HSDK board. Turns out we have
a couple of issues, this being the first one, and I'm to blame as I
didn't pay attention during review.

TIF_NOTIFY_SIGNAL support requires checking multiple TIF_* bits in
kernel return code path. Old code only needed to check a single bit so
BBIT0 <TIF_SIGPENDING> worked. New code needs to check multiple bits so
AND <bit-mask> instruction. So needs to use bit mask variant _TIF_SIGPENDING

Cc: Jens Axboe <axboe@kernel.dk>
Fixes: 53855e12588743ea128 ("arc: add support for TIF_NOTIFY_SIGNAL")
Link: https://github.com/foss-for-synopsys-dwc-arc-processors/linux/issues/34
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 1f5308abf36d..1743506081da 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -307,7 +307,7 @@ resume_user_mode_begin:
 	mov r0, sp	; pt_regs for arg to do_signal()/do_notify_resume()
 
 	GET_CURR_THR_INFO_FLAGS   r9
-	and.f  0,  r9, TIF_SIGPENDING|TIF_NOTIFY_SIGNAL
+	and.f  0,  r9, _TIF_SIGPENDING|_TIF_NOTIFY_SIGNAL
 	bz .Lchk_notify_resume
 
 	; Normal Trap/IRQ entry only saves Scratch (caller-saved) regs
-- 
2.25.1

