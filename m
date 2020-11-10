Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877AA2ADC70
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgKJQvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKJQvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:51:40 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D557CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 08:51:39 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id qgre230064C55Sk01greXK; Tue, 10 Nov 2020 17:51:38 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcWrp-001ET1-TL; Tue, 10 Nov 2020 17:51:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcWrp-00EJMx-61; Tue, 10 Nov 2020 17:51:37 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] parisc/uapi: Use Kbuild logic to provide <asm/types.h>
Date:   Tue, 10 Nov 2020 17:51:36 +0100
Message-Id: <20201110165136.3411004-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uapi <asm-generic/types.h> just includes <asm-generic/int-ll64.h>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
This is a resend of a very old patch from 2013, which is still valid.

 arch/parisc/include/uapi/asm/types.h | 7 -------
 1 file changed, 7 deletions(-)
 delete mode 100644 arch/parisc/include/uapi/asm/types.h

diff --git a/arch/parisc/include/uapi/asm/types.h b/arch/parisc/include/uapi/asm/types.h
deleted file mode 100644
index 28c7d7453b10f9b1..0000000000000000
--- a/arch/parisc/include/uapi/asm/types.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _PARISC_TYPES_H
-#define _PARISC_TYPES_H
-
-#include <asm-generic/int-ll64.h>
-
-#endif
-- 
2.25.1

