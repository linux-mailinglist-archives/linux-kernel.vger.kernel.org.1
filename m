Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7712EEB7C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 03:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhAHCwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 21:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbhAHCwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 21:52:02 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BB2C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 18:51:21 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 15so5606310pfu.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 18:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=igBGrAi6Rm5zuPhj7f6tM3a6FH4jJ4t835DAUEG27WY=;
        b=NkJg0hcph3kLiTW/09AU80ChiiYrzkV/MKO33Iako84r/B723quJq1qwiNUafzuDOc
         1vYHMDLG+AGqgZi6UkYPxZHzAuRzj4ST71oWMmMm4xMR/Zfc9DTnfeNi+mayoHcncQKA
         9xhwIdzrdTd5wNGA5KcXKF04SR1gaJtD/R1TCePFMrnTJy16eFXEn2BKueRCnEHXX2GA
         Hxx50oPqGcPBFRyV/if7ErbMYwq4W19jBC1nR4t6UxCSoiLBJpnPUmD3E8w5cA/F0o6h
         NrZTYFVHu9MEdmwQwrC3tfeMT+cMjs7VmHiTRrQFEsaQStJbquJZR5YT6kE/OuLpQlPm
         qQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=igBGrAi6Rm5zuPhj7f6tM3a6FH4jJ4t835DAUEG27WY=;
        b=Bow7qS3aGnWp4OH0s2lOTu8YpmNliO2h5xRh3VFYfrCcKMnHuBjHgJ/q9wy6hA2IxW
         oqHR2IUsPH9hQnzUNtFy207kNgZMEftyktlK8IxF66OKCse+QXPv09g4kue+wZIta+j/
         NfPAewKarlW/BUds9n5MT886Q5oija2SyqrWPRdSjvQ31wm1Y2i8rfMrV3BbVrLJenou
         KML3iNxzCTpcEKc3s12B7xXsZLSUckZumQ2NIRLz4sxUMenQdobgCDfpxgbXLCNcPtqG
         hdJ/dE2Do3W5EgCayj5RQ+WIQT07FXVWCAn0Qnm30xktWcnX9P7VkCNsr6RZMPkKfhql
         VNpg==
X-Gm-Message-State: AOAM53314EvfJZNwNI/OC97sJkFq1m10bW7CgD+s2GA15bcvN6P6Qunf
        /cEExTQuoD9Bt3WBxqNnXoV3SZdzl7k=
X-Google-Smtp-Source: ABdhPJwJ/hjL4qcB91A5Mt4uYQAf/7kFnz8+SYqM0DpYLT7O6zdyS6JzC1YkuIJ4kx5su6Y8jPmRqN2PkiQ=
Sender: "baekhw via sendgmr" <baekhw@heavenly0xe8.kir.corp.google.com>
X-Received: from heavenly0xe8.kir.corp.google.com ([2620:0:1008:11:f693:9fff:feea:d503])
 (user=baekhw job=sendgmr) by 2002:a17:902:7205:b029:db:d2d5:fe79 with SMTP id
 ba5-20020a1709027205b02900dbd2d5fe79mr4929950plb.30.1610074281228; Thu, 07
 Jan 2021 18:51:21 -0800 (PST)
Date:   Thu,  7 Jan 2021 18:51:07 -0800
Message-Id: <20210108025107.1223487-1-baekhw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] x86/sev-es: Fix SEV-ES #VC handler for string port IO
From:   "Hyunwook (Wooky) Baek" <baekhw@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Rientjes <rientjes@google.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "Hyunwook (Wooky) Baek" <baekhw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't assume dest/source buffers are userspace addresses when manually
copying data for string I/O or MOVS MMIO, as {get,put}_user() will fail
if handed a kernel address and ultimately lead to a kernel panic.

Signed-off-by: Hyunwook (Wooky) Baek <baekhw@google.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 arch/x86/kernel/sev-es.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 0bd1a0fc587e..812494d216ba 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -286,6 +286,12 @@ static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
 	u16 d2;
 	u8  d1;
 
+	/* If instruction ran in kernel mode and the I/O buffer is in kernel space */
+	if (!user_mode(ctxt->regs) && !access_ok(s, size)) {
+		memcpy(dst, buf, size);
+		return ES_OK;
+	}
+
 	switch (size) {
 	case 1:
 		memcpy(&d1, buf, 1);
@@ -335,6 +341,12 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 	u16 d2;
 	u8  d1;
 
+	/* If instruction ran in kernel mode and the I/O buffer is in kernel space */
+	if (!user_mode(ctxt->regs) && !access_ok(s, size)) {
+		memcpy(buf, src, size);
+		return ES_OK;
+	}
+
 	switch (size) {
 	case 1:
 		if (get_user(d1, s))
-- 
2.29.2.729.g45daf8777d-goog

