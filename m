Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9032F05D3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 08:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbhAJHMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 02:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbhAJHMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 02:12:07 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950F2C061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 23:11:26 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id hg11so8991778pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 23:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=GX5wmdMBIxsyuKXN1f72+Mt3KLOzjKU3/Nv/Rv3H5MQ=;
        b=MoG5wiMFDYLMHzeuZw/016RgrckIEvkaXjUrEv25pKY/Y2WPMLHNJzR6EMIgMoErPb
         iX+Mm7eYc93/f7Y9VmXqH+nr6tuvD6AeI2igdK5FQH3IuWc5wYS7J+p2axNiUOUrDZZx
         0/j3xwtqDcvyf2t45MKXp9T4sgmcFnZWCMA70towKZOXwRLHPAChNt48Z1dNPfjH7pCA
         /1iz+2gnme7tSZWZIUviNe+T5gZLEgXh5nV/p2qLt3wIpCKJJX9XRQCw+Xc0vcBzu1q+
         PgvaBvRScwaMKYUFqW/+6B3o8DKD4hGEmeRpTw2H4k1sSxGcpK3Urlo9eX4M4NU6+kJS
         Nd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=GX5wmdMBIxsyuKXN1f72+Mt3KLOzjKU3/Nv/Rv3H5MQ=;
        b=MoYma+FjiN9CIDTVQJ7aTwEaDYppHEj30BOWrnO8DB5WwsIrUmuk4x6C1p97vb0ckK
         GfZlk5IXHYOCuA+gfTEQCfmMH4/yceItV5lW2gw//DCcpNMTutlZEsRiOjVI80J5GLAG
         qJyr0oAwj2DVnj20vWA2PXxKOq0zHd6RR34eFEoXYysBoVPEiPEMCcsf6a/PBLQTg74a
         s2nDqnpK8HPgpYB8efIuHS9OmZoXNmCCjxo4W50wz56YkiWt/TBU5EXZosuAvyi/FIrJ
         0JNyr8hBgPYwTx5FU3I964GI6cUAAfaQDSuc6JVOjmuDO3TuTuzRAm2qwz1AXjVpo519
         zjRQ==
X-Gm-Message-State: AOAM531+jyn7TNxbMHagegTrxhzVekskK8jxAps3PuCC8PzabtHMM/nh
        GjXxzczSkdWmJNy2FQYoGUJKJzDoZ3Y=
X-Google-Smtp-Source: ABdhPJw8tZmFmQAwZWwQ7xCp6SHWgHSNQBN/jYz+x1virdg9CMA/MoIul198pFOqVjSTyth2RZcJZiGR6Y0=
Sender: "baekhw via sendgmr" <baekhw@heavenly0xe8.kir.corp.google.com>
X-Received: from heavenly0xe8.kir.corp.google.com ([2620:0:1008:11:f693:9fff:feea:d503])
 (user=baekhw job=sendgmr) by 2002:a62:ee03:0:b029:1a9:cc29:7d1f with SMTP id
 e3-20020a62ee030000b02901a9cc297d1fmr11136072pfi.24.1610262685608; Sat, 09
 Jan 2021 23:11:25 -0800 (PST)
Date:   Sat,  9 Jan 2021 23:11:02 -0800
Message-Id: <20210110071102.2576186-1-baekhw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH V2] x86/sev-es: Fix SEV-ES #VC handler for string port IO
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

This patch is tested by invoking INSB/OUTSB instructions in kernel space in a
SEV-ES-enabled VM. Without the patch, the kernel crashed with the following
message:
  "SEV-ES: Unsupported exception in #VC instruction emulation - can't continue"
With the patch, the instructions successfully read/wrote the string from/to
the I/O port.

 arch/x86/kernel/sev-es.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 0bd1a0fc587e..ab31c34ba508 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -286,6 +286,12 @@ static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
 	u16 d2;
 	u8  d1;

+	/* If instruction ran in kernel mode and the I/O buffer is in kernel space */
+	if (!user_mode(ctxt->regs) && !access_ok(target, size)) {
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
2.30.0.284.gd98b1dd5eaa7-goog

