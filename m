Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC802DD266
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgLQNq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgLQNqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:46:55 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51325C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 05:46:15 -0800 (PST)
Received: from zn.tnic (p200300ec2f10f600957b9387e8d7e202.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:f600:957b:9387:e8d7:e202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C3D741EC03D5;
        Thu, 17 Dec 2020 14:46:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608212773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=YGc3T6z89tizhAoRWJpKXmxVG6rZwRFRRTRkmhJdB/U=;
        b=J929rixlaRI1npgy+ZgPB27m4YeXXrFdTPdfb5YWAbbpnahKIfBmpXlsjvaP2PUUsOM7Fr
        yfxLgV18NfeLoR5JVAgPjERDTOoxudrVUHYrogKoc0z71x1aw9uh/FUy/vNvKpO3b2Z8fr
        sQLmWflbCTWEMIya7WtWs5bpBTipGbI=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] x86/build: Add {kvm_guest,xen}.config targets to make help's output
Date:   Thu, 17 Dec 2020 14:46:07 +0100
Message-Id: <20201217134608.31811-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Add the targets which add Kconfig items to the .config so that the
kernel can be run as a guest, to the 'make help' output so that they
can be found easier and there's no need to grep the tree each time to
remember what they should be called.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 7116da3980be..3dae5c90c159 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -304,4 +304,7 @@ define archhelp
   echo  '                  bzdisk/fdimage*/isoimage also accept:'
   echo  '                  FDARGS="..."  arguments for the booted kernel'
   echo  '                  FDINITRD=file initrd for the booted kernel'
+  echo  '  kvm_guest.config - Enable Kconfig items for running this kernel as a KVM guest'
+  echo  '  xen.config	  - Enable Kconfig items for running this kernel as a Xen guest'
+
 endef
-- 
2.29.2

