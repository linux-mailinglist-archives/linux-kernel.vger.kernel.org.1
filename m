Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2028B2B4356
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgKPMJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgKPMJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:09:35 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD52C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 04:09:35 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CZSYR4ypxz9sPB; Mon, 16 Nov 2020 23:09:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1605528571;
        bh=6A7R6hXBzktVAliInkv7WMJvPqsNyb2IbSOaOZ0E2qM=;
        h=From:To:Cc:Subject:Date:From;
        b=ZbgmUQ5Edo6V5mjRw3t7a2sD+xqpGP0KzFaUHiKoA0L1HuRQiYl/EGo3xTC9RJO2D
         LDQ5rYRVBJhp8MiBKBNGqz+eTnhnty9bdjKRSE4J/Ycj4HhBichZURClEZXOEzwBAR
         etJgCeJl1CfZYXgIsLDV01ixVIM/v+8Os/7xJGpyEArPwqp/UpBkZkWBCP+YDYQTX6
         JCjA4C68a2hKHn1zsKMh9ID+4MayQzgNhNPOyo/Co7MXywl6psU7PFJes81q6VS+lN
         QwE4PTMMDwSWWyGYSxc+z3zRzZCGHKcOLFPwoMC9j2EXp6inCcUnDl+/z+/eGuJBgb
         qqVBVdjTSy9oQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     christophe.leroy@csgroup.eu, segher@kernel.crashing.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        natechancellor@gmail.com, oss@buserror.net
Subject: [PATCH] powerpc: Drop -me200 addition to build flags
Date:   Mon, 16 Nov 2020 23:09:13 +1100
Message-Id: <20201116120913.165317-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a build with CONFIG_E200=y will fail with:

  Error: invalid switch -me200
  Error: unrecognized option -me200

Upstream binutils has never supported an -me200 option. Presumably it
was supported at some point by either a fork or Freescale internal
binutils.

We can't support code that we can't even build test, so drop the
addition of -me200 to the build flags, so we can at least build with
CONFIG_E200=y.

Reported-by: Németh Márton <nm127@freemail.hu>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

More discussion: https://lore.kernel.org/lkml/202011131146.g8dPLQDD-lkp@intel.com
---
 arch/powerpc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a4d56f0a41d9..16b8336f91dd 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -248,7 +248,6 @@ KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
 cpu-as-$(CONFIG_40x)		+= -Wa,-m405
 cpu-as-$(CONFIG_44x)		+= -Wa,-m440
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
-cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 
 # When using '-many -mpower4' gas will first try and find a matching power4
-- 
2.25.1

