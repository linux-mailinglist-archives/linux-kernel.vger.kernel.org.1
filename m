Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D4A2B0C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgKLSBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgKLR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:07 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5DFC0613D6;
        Thu, 12 Nov 2020 09:59:07 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsB-0006ue-SO; Thu, 12 Nov 2020 18:59:03 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 00/26] Make reporting-bugs easier to grasp and yet more detailed & helpful
Date:   Thu, 12 Nov 2020 18:58:37 +0100
Message-Id: <cover.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203947;764f585d;
X-HE-SMSGID: 1kdGsB-0006ue-SO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series rewrites the "how to report bugs to the Linux kernel
maintainers" document to make it more straight forward and its essence
easier to grasp. At the same time make the text provide a lot more details
about the process in form of a reference section, so users that want or
need to know them have them at hand.

The goal of this rewrite: improve the quality of the bug reports and
reduce the number of reports that get ignored. This was motivated by many
reports of poor quality the submitter noticed while looking after Linux
kernel regression tracking many moons ago.

This is v2, but still RFC, as there are still quite a number of things to
discuss (see below). For the curious, this is how the text currently looks
in the end:
https://gitlab.com/knurd42/linux/-/raw/reporting-bugs-v2/Documentation/admin-guide/reporting-bugs.rst

The main author of this rewrite is fully aware the new text is quite long
and thus might look a bit intimidating. But the text's structure with a
TDLR, a step-by-step guide and a reference section was carefully crafted
to make sure the text can serve different needs depending on what readers
know about bug reporting and the linux kernel; that's why the text among
others can work for kernel developers that just need to look something up,
developers & experienced FLOSS contributors that are new to the kernel and
need a rough instructions, as well as Linux users that just want to report
a problem upstream. The text is thus a bit like the kernel itself, which
works well for small embedded machines, a typical desktop PC, cloud
servers, as well as HPC.

There are a few points that will need discussions which comments in the
individual patches will point out. That for example includes things like
"is dual licensing under CC-BY 4.0 a good idea", "are we asking too much
from users when telling them to test mainline?", and "create a mailing
list that should be CCed on all reports?". But a few points are best
raised here:

 * The old and the new reporting-bugs text take a totally different
approach to bugzilla.kernel.org. The old mentions it as the place to file
your issue if you don't know where to go. The new one mentions it rarely
and most of the time warn users that it's often the wrong place to go.
This approach was chosen as the main author noticed quite a few users (or
even a lot?) get no reply to the bugs they file in bugzilla. That's kind
of expected, as quite a few (many? most?) of the maintainers don't even
get notified when reports for their subsystem get filed there. Anyway: not
getting a reply is something that is just annoying for users and might
make them angry. Improving bugzilla would be an option, but on the kernel
and maintainers summit 2017 (sorry it took so long) it was agreed on to
first go this route, as it's easier to achieve and less controversial, as
putting additional burden on already overworked maintainers is unlikely to
get well received.

 * The text states "see above" or "see below" in a few places. Should
those be proper links? But then anchors will need to be placed in some
places, which slightly hurt readability of the plain text version. Could
RST or autosectionlabel help here somewhat (without changing the line
"autosectionlabel_maxdepth = 2" in Documentation/conf.py, which I assume
is unwanted)?

 * The new text avoids the word "bug" and uses "issues" instead, as users
face issues which might or might not be caused by bugs. Due to this
approach it might make sense to rename the document to "reporting-issues".
But for now everything is left as it is, as changing the name of a well
known file has downsides; but maybe at least the documents headline should
get a s/bugs/issues/ treatment.

 * How to make sure everybody that cares get a chance to review this? As
this still is an early RFC, the author chose to sent it only to the docs
maintainer, linux-docs and LKML, to see how well this approach is received
in general. Once it is agreed that this is the route forward, a lot of
other people need to be CCed to review parts of it; the stable maintainers
for example should check if the section on handling issues with stable and
longterm kernels is acceptable for them. In the end it's something a lot
of maintainers might want to take at least a quick look at, as they will
be dealing with the reports. But there is no easy way to contact all of
them (apart from CCing many people), as most of them likely don't read
LKML anymore. Should the author maybe abuse ksummit-discuss, as this
likely will reach all the major stakeholders? Side note: maybe it would be
good to have a list for things like this on vger...

Note: The main autor is not a developer, so he will have gotten a few
things in the procedure wrong. Let him know if you spot something where
things are off.  And strictly speaking this series is not bisectable, as
the old text it left in place and removed slowly by the patches in the
series when they add new text that covers the same aspect. Thus, both old
and new text are incomplete or inconsistent (and thus would not build, if
we'd talked about code). But that is only relevant for those that read the
text before the series is fully applied.  That seemed like an acceptable
downside here IMHO, as this makes it easier to compare the old and new
approach.

The patch series is against docs-next and can also be found on gitlab:
git://git@gitlab.com:knurd42/linux.git reporting-bugs-v2

= Big outstanding issues =

 * is the general approach a good idea?
 * dedicated mailing lists for issues (see patch !!!)
 * input needed how to properly prepare and handle stack dumps these days
(see patch !!!)
 * should we accept reports for issues with kernel images
that are pretty close to vanilla? (see patch !!!) * linking back and forth
within the text?

= Changes =

v1 -> v2
 * all over: a whole lot of spelling fixes and small improvements. Many
thx to suggestions from Randy Dunlap (many thx!).
 * use "ref:" to reference MAINTAINERs file
 * the licensing advice is now a rst comment near the top
 * reshuffle and rewrite some parts to make them more straight forward:
  * The short guide (aka TL;DR)" (patch 2)
  * Locate kernel area that causes the issue (patch 9)
  * Install a fresh kernel for testing (patch 15)
 * to see all changes since v1 compare these two files with tool like meld
or kdiff3:
https://gitlab.com/knurd42/linux/-/raw/reporting-bugs/Documentation/admin-guide/reporting-bugs-v1.rst
https://gitlab.com/knurd42/linux/-/raw/reporting-bugs/Documentation/admin-guide/reporting-bugs-v2.rst

= Links =

v1:
https://lore.kernel.org/lkml/cover.1601541165.git.linux@leemhuis.info/

Current version of reporting-bugs.rst
https://www.kernel.org/doc/html/latest/admin-guide/reporting-bugs.html
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-bugs.rst

Commits to it and its predecessor:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/Documentation/admin-guide/reporting-bugs.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/REPORTING-BUGS

Thorsten Leemhuis (26):
  docs: reporting-bugs: temporary markers for licensing and diff reasons
  docs: reporting-bugs: Create a TLDR how to report issues
  docs: reporting-bugs: step-by-step guide on how to report issues
  docs: reporting-bugs: step-by-step guide for issues in stable &
    longterm
  docs: reporting-bugs: begin reference section providing details
  docs: reporting-bugs: point out we only care about fresh vanilla
    kernels
  docs: reporting-bugs: let users classify their issue
  docs: reporting-bugs: make readers check the taint flag
  docs: reporting-bugs: help users find the proper place for their
    report
  docs: reporting-bugs: remind people to look for existing reports
  docs: reporting-bugs: remind people to back up their data
  docs: reporting-bugs: tell users to disable DKMS et al.
  docs: reporting-bugs: point out the environment might be causing issue
  docs: reporting-bugs: make users write notes, one for each issue
  docs: reporting-bugs: make readers test a fresh kernel
  docs: reporting-bugs: let users check taint status again
  docs: reporting-bugs: explain options if reproducing on mainline fails
  docs: reporting-bugs: let users optimize their notes
  docs: reporting-bugs: decode failure messages [need help!]
  docs: reporting-bugs: instructions for handling regressions
  docs: reporting-bugs: details on writing and sending the report
  docs: reporting-bugs: explain what users should do once the report is
    out
  docs: reporting-bugs: details for issues specific to stable and
    longterm
  docs: reporting-bugs: explain why users might get neither reply nor
    fix
  docs: reporting-bugs: explain things could be easier
  docs: reporting-bugs: add SPDX tag and license hint, remove markers

 Documentation/admin-guide/bug-bisect.rst      |    2 +
 Documentation/admin-guide/reporting-bugs.rst  | 1652 +++++++++++++++--
 Documentation/admin-guide/tainted-kernels.rst |    2 +
 scripts/ver_linux                             |   81 -
 4 files changed, 1507 insertions(+), 230 deletions(-)
 delete mode 100755 scripts/ver_linux


base-commit: f8394f232b1eab649ce2df5c5f15b0e528c92091
-- 
2.28.0

