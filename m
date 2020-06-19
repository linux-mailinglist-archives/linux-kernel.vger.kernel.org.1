Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4152019A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393036AbgFSRld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 13:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730934AbgFSRlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:41:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B33C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 10:41:31 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bac00b008f297983004b5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ac00:b008:f297:9830:4b5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 017C01EC0407;
        Fri, 19 Jun 2020 19:41:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592588490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=lq9+BjT74COFFXzIYrvIX5iYS6Erl39f4ad7jIsTwXw=;
        b=Oj5Hi8OoF9C4L4uUTRffS9CvaLegYwJ2KZcCAWEMZtAF0oNJeh2dx4bqjHLXpcmsL2Ar88
        pFHgj/RTCYA+NqrpKtPeB/9we3o3yf2qzemnhNWt4bfMGbKc28BIikUcx1bHWNH6gN2CvY
        N3+jYRe/36Av02wKWfAZA9IIviMshlY=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     jpa@kernelbug.mail.kapsi.fi, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] x86/FPU: FPU sanitization for in-kernel use
Date:   Fri, 19 Jun 2020 19:41:25 +0200
Message-Id: <20200619174127.22304-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

here's a proper submission of the work started by Petteri. I think I've
addressed all the feedback so far. I've added the preparation work for
the test to run, to a script run_test_fpu.sh which does some basic
checks, loads the module and runs the test for 1000 times on all CPUs,
by default. Thought this is a sane default, feel free to prove me wrong
and I'll change it.

Thx.

Petteri Aimonen (2):
  x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
  selftests/fpu: Add an FPU selftest

 arch/x86/include/asm/fpu/internal.h         |  5 ++
 arch/x86/kernel/fpu/core.c                  |  6 ++
 lib/Kconfig.debug                           | 11 +++
 lib/Makefile                                | 20 +++++
 lib/test_fpu.c                              | 89 +++++++++++++++++++++
 tools/testing/selftests/Makefile            |  1 +
 tools/testing/selftests/fpu/.gitignore      |  2 +
 tools/testing/selftests/fpu/Makefile        |  9 +++
 tools/testing/selftests/fpu/run_test_fpu.sh | 46 +++++++++++
 tools/testing/selftests/fpu/test_fpu.c      | 61 ++++++++++++++
 10 files changed, 250 insertions(+)
 create mode 100644 lib/test_fpu.c
 create mode 100644 tools/testing/selftests/fpu/.gitignore
 create mode 100644 tools/testing/selftests/fpu/Makefile
 create mode 100755 tools/testing/selftests/fpu/run_test_fpu.sh
 create mode 100644 tools/testing/selftests/fpu/test_fpu.c

-- 
2.21.0

