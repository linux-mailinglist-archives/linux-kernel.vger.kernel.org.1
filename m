Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65271A485E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDJQXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 12:23:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:38098 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgDJQXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:23:40 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8C392307;
        Fri, 10 Apr 2020 16:23:40 +0000 (UTC)
Date:   Fri, 10 Apr 2020 10:23:39 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes
Message-ID: <20200410102339.2a14df24@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
abcb1e021ae5a36374c635eeaba5cec733169b78:

  Documentation: x86: exception-tables: document CONFIG_BUILDTIME_TABLE_SORT (2020-03-27 10:50:01 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.7-2

for you to fetch changes up to befacdcf47d4a19eb584ae5b43da40941e8e660c:

  Documentation: android: binderfs: add 'stats' mount option (2020-04-10 10:14:53 -0600)

----------------------------------------------------------------
A handful of late-arriving fixes for the documentation tree.

----------------------------------------------------------------
Alyssa Ross (1):
      Documentation: sysrq: fix RST formatting

Jimmy Assarsson (2):
      docs: kernel-parameters.txt: Remove nompx
      docs: kernel-parameters.txt: Fix broken references

Joakim Lönnegren (1):
      Documentation: driver-api/usb/writing_usb_driver.rst Updates documentation links

Lukas Bulwahn (1):
      docs: driver-api: address duplicate label warning

Randy Dunlap (1):
      Documentation: android: binderfs: add 'stats' mount option

Vilhelm Prytz (1):
      docs: filesystems: fix typo in qnx6.rst

 Documentation/admin-guide/binderfs.rst              |  6 ++++++
 Documentation/admin-guide/kernel-parameters.txt     |  8 ++------
 Documentation/admin-guide/sysrq.rst                 | 20 +++++++++++---------
 Documentation/driver-api/usb/writing_usb_driver.rst |  7 ++-----
 Documentation/driver-api/w1.rst                     |  3 ---
 Documentation/filesystems/qnx6.rst                  |  2 +-
 6 files changed, 22 insertions(+), 24 deletions(-)
