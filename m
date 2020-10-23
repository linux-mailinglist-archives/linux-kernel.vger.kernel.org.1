Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34779297791
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbgJWTRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752967AbgJWTRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:17:21 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADEAC0613CE;
        Fri, 23 Oct 2020 12:17:21 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CCD597DE;
        Fri, 23 Oct 2020 19:17:20 +0000 (UTC)
Date:   Fri, 23 Oct 2020 13:17:19 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 5.10
Message-ID: <20201023131719.5fec285a@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
4fb220da0dd03d3699776220d86ac84b38941c0c:

  gpiolib: Update indentation in driver.rst for code excerpts (2020-10-12 13:15:34 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.10-2

for you to fetch changes up to 62af696471e58bdfcf416fd56f032a60853c2bae:

  docs: Add two missing entries in vm sysctl index (2020-10-22 16:11:46 -0600)

----------------------------------------------------------------
A handful of late-arriving documentation fixes.

----------------------------------------------------------------
Bailu Lin (1):
      Documentation: Chinese translation of Documentation/arm64/hugetlbpage.rst

Colin Ian King (1):
      docs/vm: trivial fixes to several spelling mistakes

Fam Zheng (1):
      docs: Add two missing entries in vm sysctl index

Hui Su (1):
      docs/cpu-load: format the example code.

Kees Cook (2):
      docs: deprecated.rst: Expand str*cpy() replacement notes
      docs: lkdtm: Modernize and improve details

Krzysztof Kozlowski (1):
      docs: submitting-patches: describe preserving review/test tags

Mauro Carvalho Chehab (1):
      docs: driver-api: remove a duplicated index entry

Wei Lin Chang (1):
      Documentation: x86: fix a missing word in x86_64/mm.rst.

 Documentation/admin-guide/cpu-load.rst             | 63 +++++++++++-----------
 Documentation/admin-guide/sysctl/vm.rst            |  2 +
 Documentation/arm64/hugetlbpage.rst                |  2 +
 Documentation/driver-api/index.rst                 |  1 -
 Documentation/fault-injection/provoke-crashes.rst  | 56 +++++++++++--------
 Documentation/process/deprecated.rst               | 44 ++++++++-------
 Documentation/process/submitting-patches.rst       |  7 +++
 .../translations/zh_CN/arm64/hugetlbpage.rst       | 45 ++++++++++++++++
 Documentation/translations/zh_CN/arm64/index.rst   |  1 +
 Documentation/vm/mmu_notifier.rst                  |  2 +-
 Documentation/vm/page_migration.rst                |  2 +-
 Documentation/vm/page_owner.rst                    |  2 +-
 Documentation/vm/slub.rst                          |  2 +-
 Documentation/x86/x86_64/mm.rst                    |  2 +-
 14 files changed, 154 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/arm64/hugetlbpage.rst
