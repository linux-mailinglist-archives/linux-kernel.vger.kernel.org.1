Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AD029512E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503253AbgJUQ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:56:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37064 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503246AbgJUQ43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:56:29 -0400
Received: from zn.tnic (p200300ec2f0c9a004cef083969089481.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9a00:4cef:839:6908:9481])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 220711EC034B;
        Wed, 21 Oct 2020 18:56:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603299388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=hwZKqNwa1XZNoSHmp3qtbS9rLuv4lyMQf4OfbzE0kN0=;
        b=d8kx5keLvUKZakoUlBJv4BLSHulXGroKGd3iCOZwebUje3OAAjosqkzM7Yyx4g5uZEwn+7
        /iDQRuTMiqYZK25Wek3T6npyvpWLjJQz4TygoLrk3r+um/2+R8wGsHBFwG8egmcq2wnU4O
        +gwrkeE4L1G6DujfiehtEigEFUEUkWI=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/setup: Remove unused MCA variables
Date:   Wed, 21 Oct 2020 18:56:14 +0200
Message-Id: <20201021165614.23023-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Commit

  bb8187d35f82 ("MCA: delete all remaining traces of microchannel bus support.")

removed the remaining traces of Micro Channel Architecture support but
one trace remained - three variables in setup.c which have been unused
since 2012 at least.

Drop them finally.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/setup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 84f581c91db4..a23130c86bdd 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -119,11 +119,6 @@ EXPORT_SYMBOL(boot_cpu_data);
 
 unsigned int def_to_bigsmp;
 
-/* For MCA, but anyone else can use it if they want */
-unsigned int machine_id;
-unsigned int machine_submodel_id;
-unsigned int BIOS_revision;
-
 struct apm_info apm_info;
 EXPORT_SYMBOL(apm_info);
 
-- 
2.21.0

