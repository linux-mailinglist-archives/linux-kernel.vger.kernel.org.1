Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1102F27FBF6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbgJAIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJAIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:54:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F51C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 01:54:06 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu7v-0006b9-K1; Thu, 01 Oct 2020 10:39:47 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 00/26] Make reporting-bugs easier to grasp and yet more detailed
Date:   Thu,  1 Oct 2020 10:39:21 +0200
Message-Id: <cover.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601542446;0366e042;
X-HE-SMSGID: 1kNu7v-0006b9-K1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series rewrites the "how to report bugs to the Linux kernel maintainers"
document to make it more straight forward and the essence easier to grasp. At
the same time make the text provide a lot more details about the process in form
of a reference section, so users that want or need to know them have them at
hand.

The goal of this rewrite: improve the quality of the bug reports and reduce the
number of reports that get ignored. This was motivated by many reports of poor
quality the main author of the rewrite stumped upon when he was tracking
regressions.

For the curious, this is how the text looks in the end:
https://gitlab.com/knurd42/linux/-/raw/reporting-bugs-rfc/Documentation/admin-guide/reporting-bugs.rst

For comparison, here you can find the old text and the commits to it and its
predecessor:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-bugs.html
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-bugs.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/Documentation/admin-guide/reporting-bugs.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/REPORTING-BUGS

This is an early RFC and likely has some spelling and grammatical mistakes.
Sorry for that, the main author is not a native English speaker and makes too
many of those mistakes even in his mother tongue. He used hunspell and
LanguageTool to find errors, but noticed those tools miss quite a few mistakes.
Hopefully it's not too bad.

The main author of the rewrite is also fully aware the text got quite long in
the end. That happened as he tried to make users avoid many of the problem he
noticed in bug report, which needed quite a bit of space to describe.
Nevertheless, he tried to make sure the text uses a structure where only those
that want to know all the details have to read it. That's mainly realized with
the help of the TL;DR and the short guide at the top of the document. Those
should be good enough for a lot of situations.

There are a few points that will need to be discussed. The comment in the
individual patches will point some of those out; that for example includes
things like "dual licensing under CC-BY 4.0", "are we asking too much from users
when telling them to test mainline?", and "CC LKML or something else on all
reports?". But a few points are best raised here:

 * The old and the new reporting-bugs text take a totally different approach to
bugzilla.kernel.org. The old mentions it as the place to file your issue if
you don't know where to go. The new one mentions it rarely and most of the
time warn users that it's often the wrong place to go. This approach was
chosen as the main author noticed quite a few users (or even a lot?) get no
reply to the bugs they file in bugzilla. That's kind of expected, as quite a
few (many? most?) of the maintainers don't even get notified when reports for
their subsystem get filed there. Anyway: not getting a reply is something
that is just annoying for users and might make them angry. Improving bugzilla
would be an option, but on the kernel and maintainers summit 2017 (sorry it
took so long) it was agreed on to first go this route, as it's easier to
reach and less controversial, as many maintainers likely are unwilling to
deal with bugzilla.

 * The text states "see above" or "see below" in a few places. Should those be
proper links? But then some anchors will need to be placed manually in a few
places, which slightly hurt readability of the plain text. Could RST or
autosectionlabel help here somewhat (without changing the line
"autosectionlabel_maxdepth = 2" in Documentation/conf.py, which likely is
unwanted)?

 * The new text avoids the word "bug" and uses "issues" instead, as users face
issues which might or might not be caused by bugs. Due to this approach it
might make sense to rename the document to "reporting-issues". But for now
everything is left as it is, as changing the name of a well known file has
downsides; but maybe at least the documents headline should get the
s/bugs/issues/ treatment.

 * How to make sure everybody that cares get a chance to review this? As this is
an early RFC, the author chose to sent it only to the docs maintainer,
linux-docs and LKML, to see how well this approach is received in general.
Once it is agreed that this is the route forward, a lot of other people need
to be CCed to review it; the stable maintainers for example should check if
the section on handling issues with stable and longterm kernels is acceptable
for them. In the end it's something a lot of maintainers might want to take
at least a quick look at, as they will be dealing with the reports. But there
is no easy way to contact all of them (apart from CCing all of them), as most
of them likely don't read LKML anymore. Should the author maybe abuse
ksummit-discuss, as this likely will reach all the major stakeholders Side
note: maybe it would be good to have a list for things like this on vger...

The patch series is against docs-next and can also be found on gitlab:
git://git@gitlab.com:knurd42/linux.git reporting-bugs-rfc

Strictly speaking this series is not bisectable, as the old text it left in
place and removed slowly by the patches in the series when they add new text
that covers the same aspect. Thus, both old and new text are incomplete or
inconsistent (and thus would not build, if we'd talked about code). But that is
only relevant for those that read the text before the series is fully applied.
That seemed like an acceptable downside in this case, as this makes it easier to
compare the old and new approach.

Note: The main autor is not a developer, so he will have gotten a few things in
the procedure wrong. Let him know if you spot something where things are off.

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
  docs: reporting-bugs: make readers test mainline, but leave a loophole
  docs: reporting-bugs: let users check taint status again
  docs: reporting-bugs: explain options if reproducing on mainline fails
  docs: reporting-bugs: let users optimize their notes
  docs: reporting-bugs: decode failure messages [need help]
  docs: reporting-bugs: instructions for handling regressions
  docs: reporting-bugs: details on writing and sending the report
  docs: reporting-bugs: explain what users should do once the report got
    out
  docs: reporting-bugs: details for issues specific to stable and
    longterm
  docs: reporting-bugs: explain why users might get neither reply nor
    fix
  docs: reporting-bugs: explain things could be easier
  docs: reporting-bugs: add SPDX tag and license hint, remove markers

 Documentation/admin-guide/bug-bisect.rst      |    2 +
 Documentation/admin-guide/reporting-bugs.rst  | 1586 +++++++++++++++--
 Documentation/admin-guide/tainted-kernels.rst |    2 +
 scripts/ver_linux                             |   81 -
 4 files changed, 1441 insertions(+), 230 deletions(-)
 delete mode 100755 scripts/ver_linux


base-commit: e0bc9cf0a7d527ff140f851f6f1a815cc5c48fea
-- 
2.26.2

