Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865DB2E200E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgLWRnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:43:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39540 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgLWRn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:43:29 -0500
Received: from zn.tnic (p200300ec2f0de600b74d534b1676c98b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:b74d:534b:1676:c98b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F6FF1EC052C;
        Wed, 23 Dec 2020 18:42:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608745368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+NaPAg2Mqrevy0pOLY7SFPtAdYDDXm3mlVRRt9/3A+E=;
        b=N+3lfNVPNN38z8lJLC0Kaukay3stdDez3qaPcKk0860HNZXjJsWtxnn8CDdEzRJfYDmbIS
        yCN5mcSrpVbGhR/rlekysjpk++OjONEVKhzccoBuA8t+OAmegmjVEeL1t1i1Qa4rCzN85h
        3sePhOt9KNwcqv7RKy+EViVKp00F1jw=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 11/19] x86/sev-es: Convert to insn_decode()
Date:   Wed, 23 Dec 2020 18:42:25 +0100
Message-Id: <20201223174233.28638-12-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223174233.28638-1-bp@alien8.de>
References: <20201223174233.28638-1-bp@alien8.de>
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
2.29.2

