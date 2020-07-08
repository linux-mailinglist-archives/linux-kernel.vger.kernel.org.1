Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E22021907E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 21:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGHTaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 15:30:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53220 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGHT36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:29:58 -0400
Message-Id: <20200708192934.301116609@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594236596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=VtXUsasEdF8nRrAXP25I9U4V0/9eTBALtd5EYwQfCIM=;
        b=BeTkTdV5koiKblsuq8CKRUZUMkr0JwJbkj2adrVhUXfpJ4eXz28FknDfdutRw03drMTy+C
        7Hcd2NYXy0tGfxHHOZHsA49lPRTYCyeoZKMHstV/tTxx8xf088i+cbzwmP63Gh/aCScL//
        ZoreOfwPjSHR1fYPBr0GC/SJ1+elWzn1z0XTfU2umz8s2j345UmbBzKLGZ+XMVUB9vvaNH
        2ypYinYfivqhCKtNePy+eE9WaK0XEhmSXQrxsfxP1j87APAV9G4vnn+GeuqEQD/dB9w75y
        xdiW/96jFmEk2yOttV7g0DVOd+1VllumtzQvNCQ6LHAR93YSwfIHFuPG3Qf2oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594236596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=VtXUsasEdF8nRrAXP25I9U4V0/9eTBALtd5EYwQfCIM=;
        b=Eydbk1Ze6IDrigvIksbM0Us9jpgKI/SvhCDE5eQQypuTxj+sR3gLbML5J0flh+bPqymI/h
        4CZgDaRHgc7Zi1Bg==
Date:   Wed, 08 Jul 2020 21:28:07 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [patch 3/3] x86/entry/common: Make prepare_exit_to_usermode() static
References: <20200708192804.911958542@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users outside this file anymore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -294,7 +294,7 @@ static void __prepare_exit_to_usermode(s
 #endif
 }
 
-__visible noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
+static noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
 {
 	instrumentation_begin();
 	__prepare_exit_to_usermode(regs);

