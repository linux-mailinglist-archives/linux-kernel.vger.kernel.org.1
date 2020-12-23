Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCF02E2006
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgLWRn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:43:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39422 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbgLWRnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:43:25 -0500
Received: from zn.tnic (p200300ec2f0de600b74d534b1676c98b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:b74d:534b:1676:c98b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 480A21EC0527;
        Wed, 23 Dec 2020 18:42:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608745364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dn7xdOixbJ18iX/uu48fTyX8QZ8h+c1ptsOI2BGg9UA=;
        b=ZZDYVYp+rzAXOpeIqUwzoRrg59G3GihctzqSZUGyjXo0i2dFV5Y56LHLdkVz3DT2d7t9AI
        x9GWO+336/YjyrdUXZ5wlN1jmqDJkjSmWi2PJK7x7BZZ4Erd9i1ivoqD9kfoICRd4jt58c
        qxMtfYq2cCAFXAtoUsEeLfCmpxHGOvQ=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 05/19] x86/boot/compressed/sev-es: Convert to insn_decode()
Date:   Wed, 23 Dec 2020 18:42:19 +0100
Message-Id: <20201223174233.28638-6-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223174233.28638-1-bp@alien8.de>
References: <20201223174233.28638-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Other than simplifying the code there should be no functional changes
resulting from this.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/boot/compressed/sev-es.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 27826c265aab..801c626fc3d4 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -78,16 +78,15 @@ static inline void sev_es_wr_ghcb_msr(u64 val)
 static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	enum es_result ret;
+	int ret;
 
 	memcpy(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
 
-	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE, 1);
-	insn_get_length(&ctxt->insn);
+	ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
+	if (ret < 0)
+		return ES_DECODE_FAILED;
 
-	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
-
-	return ret;
+	return ES_OK;
 }
 
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
-- 
2.29.2

