Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1EC280577
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbgJARfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732917AbgJARfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:35:11 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 531512085B;
        Thu,  1 Oct 2020 17:35:10 +0000 (UTC)
Date:   Thu, 1 Oct 2020 18:35:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fix for 5.9-rc8/final
Message-ID: <20201001173505.GA6432@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit 75df529bec9110dad43ab30e2d9490242529e8b8:

  arm64: paravirt: Initialize steal time when cpu is online (2020-09-17 18:12:18 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to a509a66a9d0d4f4e304d58fad38c078d0336c445:

  arm64: permit ACPI core to map kernel memory used for table overrides (2020-09-30 22:27:51 +0100)

----------------------------------------------------------------
A previous commit to prevent AML memory opregions from accessing the
kernel memory turned out to be too restrictive. Relax the permission
check to permit the ACPI core to map kernel memory used for table
overrides.

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: permit ACPI core to map kernel memory used for table overrides

 arch/arm64/kernel/acpi.c | 22 ++++++++++++++++++++--
 include/linux/acpi.h     |  2 +-
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
Catalin
