Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D242BFF1A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 05:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgKWEpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 23:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgKWEpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 23:45:20 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5E5C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 20:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=yKcHtyaxlx+ewY9Z5a1EvClxIgQyoFSSzVBNPvzu77w=; b=iw073ASdzBWKPwW/g9luAU5eXi
        ZpWdfb5zjXAd72StXCgEYKmalwgefjYLLhrOM9EEJ9taPXiDAnWLRkLl3bs6LI91IujrB3GyAP45M
        shEpT1Lw1aue0hdSoKODRZ0HEUzCZz8SWZKrg6n7wRGnZbtzg1H90b3ORn3OFJGIFNnpQf6ZnfgmN
        r00wBwuIQo33XNSwUak+TJrjipnaNSDurEsVA36hyLSyk0Jzh584prqxYJXIQjNogyMJyzFh1pqeS
        ODrSFUM6RbJ+EpJLU+v5CrBDIGv7TPtfhIVc5oL2SidbwlXHcbO2eYN2yMXUiH5368Ebd7R9TJcGZ
        WKRz8UpA==;
Received: from [2601:1c0:6280:3f0::bcc4] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kh3j1-0007rT-R7; Mon, 23 Nov 2020 04:45:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Will Deacon <will@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] arm64/fpsimd: add <asm/insn.h> to <asm/kprobes.h> to fix fpsimd build
Date:   Sun, 22 Nov 2020 20:45:10 -0800
Message-Id: <20201123044510.9942-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding <asm/exception.h> brought in <asm/kprobes.h> which uses
<asm/probes.h>, which uses 'pstate_check_t' so the latter needs to
#include <asm/insn.h> for this typedef.

Fixes this build error:

  In file included from arch/arm64/include/asm/kprobes.h:24,
                    from arch/arm64/include/asm/exception.h:11,
                    from arch/arm64/kernel/fpsimd.c:35:
  arch/arm64/include/asm/probes.h:16:2: error: unknown type name 'pstate_check_t'
      16 |  pstate_check_t *pstate_cc;


Fixes: c6b90d5cf637 ("arm64/fpsimd: Fix missing-prototypes in fpsimd.c")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Tian Tao <tiantao6@hisilicon.com>
---
 arch/arm64/include/asm/probes.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20201120.orig/arch/arm64/include/asm/probes.h
+++ linux-next-20201120/arch/arm64/include/asm/probes.h
@@ -7,6 +7,8 @@
 #ifndef _ARM_PROBES_H
 #define _ARM_PROBES_H
 
+#include <asm/insn.h>
+
 typedef u32 probe_opcode_t;
 typedef void (probes_handler_t) (u32 opcode, long addr, struct pt_regs *);
 
