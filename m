Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1F226CA75
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgIPUAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:00:42 -0400
Received: from foss.arm.com ([217.140.110.172]:34560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgIPRfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9208C1045;
        Wed, 16 Sep 2020 03:46:42 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D5033F68F;
        Wed, 16 Sep 2020 03:46:41 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Add usercopy fixup accuracy tests
Date:   Wed, 16 Sep 2020 10:46:35 +0000
Message-Id: <20200916104636.19172-1-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a selftest subtarget that can be used to verify the
accuracy of the usercopy fixup routines.

The patch contains a test module that integrates with the selftest
framework and can be specified as a subtarget for the arm64 selftest
target. It can be invoked through the same method as the other
subtargets, provided that test_usercopy_fixup is installed prior to the
run. This enables debugging of modifications made to the usercopy fixup
routines, and/or provides a method of verification across system
configurations.

Comments are welcome regarding the suitability of this location for these
tests, and any other suggestions would also be greatly appreciated.

This was used in conjunction with lib/test_user_copy.c to help verify
the following usercopy fixup patches:
https://lore.kernel.org/lkml/20200914150958.2200-1-oli.swede@arm.com/

Thanks in advance,
Oli

Oliver Swede (1):
  kselftest: arm64: Add usercopy fixup accuracy tests

 arch/arm64/Kconfig.debug                      |   7 +
 arch/arm64/lib/Makefile                       |   2 +
 arch/arm64/lib/test_usercopy_fixup.c          | 276 ++++++++++++++++++
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/README          |   2 +-
 .../testing/selftests/arm64/usercopy/Makefile |   3 +
 tools/testing/selftests/arm64/usercopy/config |   1 +
 .../arm64/usercopy/run_fixup_tests.sh         |   4 +
 8 files changed, 295 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/lib/test_usercopy_fixup.c
 create mode 100644 tools/testing/selftests/arm64/usercopy/Makefile
 create mode 100644 tools/testing/selftests/arm64/usercopy/config
 create mode 100755 tools/testing/selftests/arm64/usercopy/run_fixup_tests.sh

-- 
2.17.1

