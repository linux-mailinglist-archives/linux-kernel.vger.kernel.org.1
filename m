Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B9F2CE841
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 07:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgLDGoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 01:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgLDGoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 01:44:37 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BBAC061A4F;
        Thu,  3 Dec 2020 22:43:57 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kl4op-0001Rq-EK; Fri, 04 Dec 2020 07:43:51 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] New documentation text describing how to report issues (aka "reporting-bugs rewritten")
Date:   Fri,  4 Dec 2020 07:43:47 +0100
Message-Id: <cover.1607063223.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1607064237;d850bb54;
X-HE-SMSGID: 1kl4op-0001Rq-EK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a new and mostly finished document describing how to report
issues with the Linux kernel to its developers. It is designed to be a lot more
straight forward and yet more detailed than the current text about this
(Documentation/admin-guide/reporting-bugs.rst). The new text still needs to be
reviewed by more people and a few open issues will need discussion. To make
these tasks easier, it was decided to add this document to the kernel sources in
parallel to the existing text for now:
https://lkml.kernel.org/r/20201118172958.5b014a44@lwn.net

The first patch in the series adds the CC-BY-4.0 license to the
LICENSES/preferred/ directory, as the main author wants to make it easy for
others to use the new text as a base when writing about this topic in books or
on websites. He for now went with for dual-licensing the text under GPL-2.0+ and
CC-BY-4.0. We shouldn't lose much when people use the more liberal of the two,
but gain one thing: it increases chances that texts about this topic are based
on this one, which should make them more accurate and to our liking.

The last patch in the series adds a note to
Documentation/admin-guide/reporting-bugs.rst, declaring it obsolete and telling
readers to head over to the new text, as discussed after the v2 submission.

To see how the new text relates to the current reporting-bugs.rst document, see
v2 of this patchset, which gradually replaced the old text with the new (which
hasn't changed much since then):
https://lore.kernel.org/lkml/cover.1605203187.git.linux@leemhuis.info/

To see how the new text from v3 and v4 relates to the one from v2 or v1, compare
these files with tools like meld or kdiff3:

https://gitlab.com/knurd42/linux/-/raw/reporting-bugs/Documentation/admin-guide/reporting-bugs-v4-wrapped.rst
https://gitlab.com/knurd42/linux/-/raw/reporting-bugs/Documentation/admin-guide/reporting-bugs-v3-wrapped.rst
https://gitlab.com/knurd42/linux/-/raw/reporting-bugs/Documentation/admin-guide/reporting-bugs-v2-wrapped.rst
https://gitlab.com/knurd42/linux/-/raw/reporting-bugs/Documentation/admin-guide/reporting-bugs-v1-wrapped.rst

The patch series is against docs-next and can also be found on gitlab:
git://git@gitlab.com:knurd42/linux.git reporting-bugs-v4

[1] https://lkml.kernel.org/r/20201118172958.5b014a44@lwn.net

= Changes =

v3 -> v4
- move CC-BY-4.0 from LICENSES/preferred/ to LICENSES/dual/
- add note to CC-BY-4.0 file explaining why it's best used together with GPL
- add a note to as comment to the header of reporting-issues.rst, pointing out
only the unprocessed version of this file is available under CC-BY-4.0.

v2 -> v3
- drop the RFC tag
- add CC-BY-4.0 to LICENSES/preferred/
- instead of adding the new text in small parts while gradually replacing the
  old text simply dump the whole new text in a new file in one go
- add a note at the top pointing out the text is not completely finished yet,
  but ready for consumption
- add a few notes to the text pointing to issues that need discussion or work;
  this until now was done in the patch
- let the automarkup extension handle links to Documentation/whatever instead of
  using an explicit :ref:
- leave scripts/ver_linux untouched
- a handful of small improvements and fixes in the main text
- add a patch that makes reporting-bugs.rst obsolete

v1 -> v2
- all over: a whole lot of spelling fixes and small improvements. Many thx to
  suggestions from Randy Dunlap (many thx!).
- use "ref:" to reference MAINTAINERs file
- the licensing advice is now a rst comment near the top
- reshuffle and rewrite some parts to make them more straight forward:
 - The short guide (aka TL;DR)" (patch 2)
 - Locate kernel area that causes the issue (patch 9)
 - Install a fresh kernel for testing (patch 15)

= Links =

v3 submission:
https://lore.kernel.org/lkml/cover.1606137108.git.linux@leemhuis.info/

v2 submission:
https://lore.kernel.org/lkml/cover.1605203187.git.linux@leemhuis.info/

v1 submission:
https://lore.kernel.org/lkml/cover.1601541165.git.linux@leemhuis.info/

Current version of reporting-bugs.rst
https://www.kernel.org/doc/html/latest/admin-guide/reporting-bugs.html
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-bugs.rst

Commits to it and its predecessor:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/Documentation/admin-guide/reporting-bugs.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/REPORTING-BUGS

Thorsten Leemhuis (3):
  LICENSES: Add the CC-BY-4.0 license
  docs: Add a new text describing how to report bugs
  docs: make reporting-bugs.rst obsolete

 Documentation/admin-guide/README.rst          |    4 +-
 Documentation/admin-guide/bug-bisect.rst      |    2 +-
 Documentation/admin-guide/index.rst           |    3 +-
 Documentation/admin-guide/reporting-bugs.rst  |    5 +
 .../admin-guide/reporting-issues.rst          | 1631 +++++++++++++++++
 Documentation/admin-guide/security-bugs.rst   |    2 +-
 .../device_drivers/ethernet/3com/vortex.rst   |    4 +-
 Documentation/process/howto.rst               |    9 +-
 LICENSES/dual/CC-BY-4.0                       |  410 +++++
 9 files changed, 2058 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/admin-guide/reporting-issues.rst
 create mode 100644 LICENSES/dual/CC-BY-4.0


base-commit: ac7711427014a84ba08353df2b77f115565216d8
-- 
2.28.0

