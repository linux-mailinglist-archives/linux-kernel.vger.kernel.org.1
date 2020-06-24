Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E1B20726F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389528AbgFXLq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 07:46:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45094 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388491AbgFXLq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:46:57 -0400
Received: from zn.tnic (p200300ec2f0a930055750ecb74485dbb.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9300:5575:ecb:7448:5dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F299F1EC03C5;
        Wed, 24 Jun 2020 13:46:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592999216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Zv+i4nBbejEnpL9aLrtKKx1Oi4NNtt4nn4BUaSR2qOU=;
        b=WOpXhTbyr2qhacesgTZGqBiCtlXiFG3FkSOpiJeseR8Hm5omiyx0Y4UcTOFO9h673oEfXh
        2sMh/wV1TC9zlBm6uhlBWffK+rYj7q+0RgD1vEALX26e8w8+yCjqiK2PFytv6uiHR/Ilfq
        4hYiV7m8lnsdkEDKN14Png/EuejoU88=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Petteri Aimonen <jpa@kernelbug.mail.kapsi.fi>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] x86/FPU: FPU sanitization for in-kernel use
Date:   Wed, 24 Jun 2020 13:46:44 +0200
Message-Id: <20200624114646.28953-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Ok,

here's v2 with build fixes and other review comments addressed.

Thx.

Changelog:
----------

v1:
==

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
 lib/Makefile                                | 24 ++++++
 lib/test_fpu.c                              | 89 +++++++++++++++++++++
 tools/testing/selftests/Makefile            |  1 +
 tools/testing/selftests/fpu/.gitignore      |  2 +
 tools/testing/selftests/fpu/Makefile        |  9 +++
 tools/testing/selftests/fpu/run_test_fpu.sh | 46 +++++++++++
 tools/testing/selftests/fpu/test_fpu.c      | 61 ++++++++++++++
 10 files changed, 254 insertions(+)
 create mode 100644 lib/test_fpu.c
 create mode 100644 tools/testing/selftests/fpu/.gitignore
 create mode 100644 tools/testing/selftests/fpu/Makefile
 create mode 100755 tools/testing/selftests/fpu/run_test_fpu.sh
 create mode 100644 tools/testing/selftests/fpu/test_fpu.c

-- 
2.21.0

