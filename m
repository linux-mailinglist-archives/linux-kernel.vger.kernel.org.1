Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411922EF678
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbhAHRcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbhAHRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:32:01 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF57C0612EA;
        Fri,  8 Jan 2021 09:31:21 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 232427DB;
        Fri,  8 Jan 2021 17:31:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 232427DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610127081; bh=buUWoDkE18q1AeRyuA4cMNBnZ3FdNTmMpr5kz7V2qTY=;
        h=Date:From:To:Cc:Subject:From;
        b=X0yxz1u9yFAo4VUQ1QWcWySK/nnd12xoV180RRGvolwcw7YFlIudPI354dg6hCqdU
         DBQX67oR9krZwQL0cHXAqrqKU1WHVdN39UJlgNeVx41UWnXuuu5hrkfftm4jRkw+wW
         hZ+j84+GlIbHoP27F6DKXq4vKp3DTFHUdrDkMdjCYh+KBLaLQ2tv/J1ajCDvhsNq8A
         ghhNnZ7DgpLyunta/uyqlJEPamj25E8MA4qftA7OzLfCvaIWal0jYs5+gT0YsqhQYS
         bhLe7P09TLk/gf9IU5mCv9kpRqvwL8qsDYLt7/psq/6fp8KFt5RJrxGbZY3RiLNTpv
         kBkshvxtEQQaA==
Date:   Fri, 8 Jan 2021 10:31:20 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes
Message-ID: <20210108103120.73a35ba6@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.11-3

for you to fetch changes up to 9d54ee78aef62c29b15ae2f58a70b1d1cd63a8f0:

  docs: admin-guide: bootconfig: Fix feils to fails (2021-01-07 14:44:58 -0700)

----------------------------------------------------------------
A handful of relatively small documentation fixes.

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      docs: admin-guide: bootconfig: Fix feils to fails

Jonathan Neuschäfer (1):
      docs: binfmt-misc: Fix .rst formatting

Liao Pingfang (1):
      docs/mm: concepts.rst: Correct the threshold to low watermark

Lukas Bulwahn (1):
      atomic: remove further references to atomic_ops

Miguel Ojeda (1):
      docs: remove mention of ENABLE_MUST_CHECK

Nícolas F. R. A. Prado (1):
      docs: Fix reST markup when linking to sections

Randy Dunlap (3):
      Documentation: admin: early_param()s are also listed in kernel-parameters
      Documentation: doc-guide: fixes to sphinx.rst
      Documentation/admin-guide: kernel-parameters: hyphenate comma-separated

 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst   |  8 +++---
 .../RCU/Design/Requirements/Requirements.rst       | 20 +++++++-------
 Documentation/admin-guide/binfmt-misc.rst          |  4 +--
 Documentation/admin-guide/bootconfig.rst           |  2 +-
 Documentation/admin-guide/kernel-parameters.rst    |  4 +--
 Documentation/admin-guide/kernel-parameters.txt    | 12 ++++----
 Documentation/admin-guide/mm/concepts.rst          |  2 +-
 Documentation/core-api/index.rst                   |  1 -
 Documentation/doc-guide/sphinx.rst                 | 32 +++++++++++-----------
 Documentation/kernel-hacking/locking.rst           |  8 +++---
 Documentation/process/4.Coding.rst                 |  6 ++--
 .../sound/kernel-api/writing-an-alsa-driver.rst    | 16 +++++------
 MAINTAINERS                                        |  1 -
 13 files changed, 56 insertions(+), 60 deletions(-)
