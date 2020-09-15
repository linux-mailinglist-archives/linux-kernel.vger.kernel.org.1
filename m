Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC4926A03C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIOHyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:54:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53834 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726134AbgIOHxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600156414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TR7JxnOBNr424Beez9Q5MTM9hQnK+cl0m0mKhD17YaA=;
        b=Yo2DkjvhLOWfCdHKTbJX8AUSF5WcBJB7Epu77Voz6GUVE7ZSUnzNmexUxk8dWri6S/lZMJ
        AeZO+3rhvdBNA38gI3WDWY1ZGqo1RwfHfD5Lz2QVe2Ndc7b55G9QZopNN1PWnVRaFrlNHd
        GpFPhvk4x67aiS4KL+vse8pf8d0Go0U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-HcdBepG6Pz-HKtCykrbjrg-1; Tue, 15 Sep 2020 03:53:33 -0400
X-MC-Unique: HcdBepG6Pz-HKtCykrbjrg-1
Received: by mail-wr1-f70.google.com with SMTP id a10so877506wrw.22
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 00:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TR7JxnOBNr424Beez9Q5MTM9hQnK+cl0m0mKhD17YaA=;
        b=dZXVoOdqbVmPiYypeLwtjvujhFeyo2Cn4ifIvK6VslBGBlypEX3LuFY30ubgTVcZXX
         aBJaQYi/r2M87AQdeQibADSrZi7lwircadkbaTs1MrE/hpadZsn6CSKq8iDP9hamzZ0F
         yyrwoTJuvy0tqsX0iEisQgRMhO1BWXY1fCuWhsgcAi+/6fbWBoZqIiZdHQMV0RKdL2qY
         c0DvtxQiIlZCBljKn+ZDwbtnJKKIfxUUTzwewoDP1wf6X+qguomuZGnlY7hgDNqRa7/+
         cDq5dNKMKkTvwST3wAefixdF3g/T6zrfoIeQokDw/QdzDVL4Pv/WQ5BOk8btvPuVRH0D
         1Ufw==
X-Gm-Message-State: AOAM531FBF/pVcKIX1p+7mBbJZTjci+YwPIFAMjjeKOCCQXGNSqsaeg0
        RnDRoAaRx5HkZM41t6JRB5bAM1FEwOxkMvc2VYK/ng2MTW4i/4uVo/3Ny7PEjur/mIoCPNybMW3
        RjRMBY5M2eBgH2IbFc4bm25q5
X-Received: by 2002:a5d:67d0:: with SMTP id n16mr21603275wrw.198.1600156411512;
        Tue, 15 Sep 2020 00:53:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcnuPIQLgkGz4EQMffvKTc4V/aYPutLoJf1Mxip9nYIgSetEZ9acO+lGavC3kJYRL7eYi9qQ==
X-Received: by 2002:a5d:67d0:: with SMTP id n16mr21603256wrw.198.1600156411382;
        Tue, 15 Sep 2020 00:53:31 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id t16sm25301572wrm.57.2020.09.15.00.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 00:53:30 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 1/3] objtool: check: Remove useless tests
Date:   Tue, 15 Sep 2020 08:53:16 +0100
Message-Id: <20200915075318.7336-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200915075318.7336-1-jthierry@redhat.com>
References: <20200915075318.7336-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

save_reg already checks that the register being saved does not already
have a saved state.

Remove redundant checks before processing a register storing operation.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4e2f703b6a25..fd2edab8e672 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2030,7 +2030,7 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				/* drap: push %rbp */
 				cfi->stack_size = 0;
 
-			} else if (regs[op->src.reg].base == CFI_UNDEFINED) {
+			} else {
 
 				/* drap: push %reg */
 				save_reg(cfi, op->src.reg, CFI_BP, -cfi->stack_size);
@@ -2059,9 +2059,7 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 
 				/* save drap offset so we know when to restore it */
 				cfi->drap_offset = op->dest.offset;
-			}
-
-			else if (regs[op->src.reg].base == CFI_UNDEFINED) {
+			} else {
 
 				/* drap: mov reg, disp(%rbp) */
 				save_reg(cfi, op->src.reg, CFI_BP, op->dest.offset);
-- 
2.21.3

