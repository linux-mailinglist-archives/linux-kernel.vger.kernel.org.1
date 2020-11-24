Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05B32C22C5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbgKXKU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50314 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731867AbgKXKUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:08 -0500
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 123061EC0532;
        Tue, 24 Nov 2020 11:20:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4Z0j0u7jLVJMb8Scn5mS7EE1A0OZxR0KuqIDJ96LRE=;
        b=XXYGU9cSo13F/iNmooQJDmsUse9c3J+R59DGb3QNkg1h5qo3p6GkujSLrAkfOeHtyPmXDM
        WE9a7QSN9k4ohF+DDYdlx7GMzChQuehdCitDZsZS7B7OI9OSriT5j0mOjpSR3g+VgS+wdI
        KUtizmpqvB14FYQOp0XV7I6WmkLQ5G4=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 11/19] x86/sev-es: Convert to insn_decode()
Date:   Tue, 24 Nov 2020 11:19:44 +0100
Message-Id: <20201124101952.7909-12-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201124101952.7909-1-bp@alien8.de>
References: <20201124101952.7909-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/sev-es.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 37736486603e..564cc9fc693d 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -244,8 +244,7 @@ static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
 static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	enum es_result ret;
-	int res;
+	int res, ret;
 
 	if (user_mode(ctxt->regs)) {
 		res = insn_fetch_from_user(ctxt->regs, buffer);
@@ -267,13 +266,13 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 			return ES_EXCEPTION;
 		}
 
-		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
-		insn_get_length(&ctxt->insn);
+		ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE - res, INSN_MODE_64);
 	}
 
-	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
-
-	return ret;
+	if (ret < 0)
+		return ES_DECODE_FAILED;
+	else
+		return ES_OK;
 }
 
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
-- 
2.21.0

