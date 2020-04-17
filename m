Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C2F1AE656
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 21:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbgDQTyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 15:54:14 -0400
Received: from ms.lwn.net ([45.79.88.28]:42742 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730590AbgDQTyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:54:13 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CC35F9A9;
        Fri, 17 Apr 2020 19:54:12 +0000 (UTC)
Date:   Fri, 17 Apr 2020 13:54:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Some documentation fixes
Message-ID: <20200417135411.3730b17c@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-fixes

for you to fetch changes up to d98dbbe0d331b1a6dc1ca0b948c99d58cdba580c:

  scripts: documentation-file-ref-check: Add line break before exit (2020-04-15 15:13:13 -0600)

----------------------------------------------------------------
A handful of fixes for reasonably obnoxious documentation issues.

----------------------------------------------------------------
Chris Packham (1):
      docs: timekeeping: Use correct prototype for deprecated functions

Eric Biggers (1):
      docs: admin-guide: merge sections for the kernel.modprobe sysctl

Peter Maydell (1):
      scripts/kernel-doc: Add missing close-paren in c:function directives

Tiezhu Yang (1):
      scripts: documentation-file-ref-check: Add line break before exit

 Documentation/admin-guide/sysctl/kernel.rst | 47 ++++++++++++-----------------
 Documentation/core-api/timekeeping.rst      |  6 ++--
 scripts/documentation-file-ref-check        |  2 +-
 scripts/kernel-doc                          |  2 +-
 4 files changed, 24 insertions(+), 33 deletions(-)
