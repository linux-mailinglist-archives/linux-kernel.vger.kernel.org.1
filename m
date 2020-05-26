Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB891C2614
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 16:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgEBO0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 10:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgEBO0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 10:26:46 -0400
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18B4524956;
        Sat,  2 May 2020 14:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588429605;
        bh=T0uL7V2GxJ0KJIHLBXzdJDnKFjm8L8mFABZiFNKziDU=;
        h=From:To:Cc:Subject:Date:From;
        b=VuZJ008ICcBXi2Tm2+47iUxfEea/DDJ+rsQD3+xPlTdIxcA4IqqyHf9dYliblLjab
         A1Acz9u65OBVklKBX9ZoicrngiiTKuBkugOThjDOqK59Oox2OTyQWg5o3e8bA4OcEy
         157taWykCJ0zb37pEb51W8zXAk5zfJJWmmZRG2Zc=
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, Wolfram Sang <wsa@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/5200: update contact email
Date:   Sat,  2 May 2020 16:26:42 +0200
Message-Id: <20200502142642.18979-1-wsa@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My 'pengutronix' address is defunct for years. Merge the entries and use
the proper contact address.

Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
 arch/powerpc/boot/dts/pcm032.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/pcm032.dts b/arch/powerpc/boot/dts/pcm032.dts
index c259c6b3ac5a..780e13d99e7b 100644
--- a/arch/powerpc/boot/dts/pcm032.dts
+++ b/arch/powerpc/boot/dts/pcm032.dts
@@ -3,9 +3,7 @@
  * phyCORE-MPC5200B-IO (pcm032) board Device Tree Source
  *
  * Copyright (C) 2006-2009 Pengutronix
- * Sascha Hauer <s.hauer@pengutronix.de>
- * Juergen Beisert <j.beisert@pengutronix.de>
- * Wolfram Sang <w.sang@pengutronix.de>
+ * Sascha Hauer, Juergen Beisert, Wolfram Sang <kernel@pengutronix.de>
  */
 
 /include/ "mpc5200b.dtsi"
-- 
2.20.1

