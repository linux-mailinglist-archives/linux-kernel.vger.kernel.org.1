Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AA61E84AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE2RVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 13:21:01 -0400
Received: from foss.arm.com ([217.140.110.172]:39746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgE2RVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:21:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E8AE1045;
        Fri, 29 May 2020 10:21:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D2C83F52E;
        Fri, 29 May 2020 10:20:59 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fix for 5.7-rc8/final
Date:   Fri, 29 May 2020 18:20:55 +0100
Message-Id: <20200529172055.28307-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit 8cfb347ad0cffdbfc69c82506fb3be9429563211:

  arm64: Add get_user() type annotation on the !access_ok() path (2020-05-22 16:59:49 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to ba051f097fc30b00f6b66044386901141351a557:

  arm64/kernel: Fix return value when cpu_online() fails in __cpu_up() (2020-05-28 12:04:55 +0100)

----------------------------------------------------------------
Ensure __cpu_up() returns an error if cpu_online() is false after
waiting for completion on cpu_running.

----------------------------------------------------------------
Nobuhiro Iwamatsu (1):
      arm64/kernel: Fix return value when cpu_online() fails in __cpu_up()

 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
