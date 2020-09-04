Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040A025DFED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 18:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgIDQlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 12:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgIDQlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:41:35 -0400
Received: from localhost.localdomain (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0453F2064E;
        Fri,  4 Sep 2020 16:41:33 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.9-rc4
Date:   Fri,  4 Sep 2020 17:41:32 +0100
Message-Id: <20200904164132.18160-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to e0328feda79d9681b3e3245e6e180295550c8ee9:

  arm64/module: set trampoline section flags regardless of CONFIG_DYNAMIC_FTRACE (2020-09-02 08:35:33 +0100)

----------------------------------------------------------------
- Fix the loading of modules built with binutils-2.35. This version
  produces writable and executable .text.ftrace_trampoline section which
  is rejected by the kernel.

- Remove the exporting of cpu_logical_map() as the Tegra driver has now
  been fixed and no longer uses this function.

----------------------------------------------------------------
Jessica Yu (1):
      arm64/module: set trampoline section flags regardless of CONFIG_DYNAMIC_FTRACE

Sudeep Holla (1):
      arm64: Remove exporting cpu_logical_map symbol

 arch/arm64/kernel/module-plts.c | 3 +--
 arch/arm64/kernel/setup.c       | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)
