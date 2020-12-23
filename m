Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B32B2E211C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 21:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgLWUEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 15:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbgLWUEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 15:04:20 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD91C061794;
        Wed, 23 Dec 2020 12:03:40 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ECCBC5F5A;
        Wed, 23 Dec 2020 20:03:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ECCBC5F5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1608753820; bh=CMksKZFChsp3UeetSclBU5RLGpOU1VPv5kNjhi6S2h8=;
        h=Date:From:To:Cc:Subject:From;
        b=g4+MIf3C35Ifm7EpiAQ+0tIRHW4BDPTwbBwGZxu++rXyIiA4cn4vKKGE2Q10i1Buw
         zWJNqFbuOj1ZGeHrWxdEMhqHayYCsYR8aWk2KOU/Hegv16hHBOMoA7ubEHFOifsKzW
         ynfqXZQNljN0dFL98zcNvWvzXaPFbreEPH6odCuySodHm+fFX3XdjwLWuNDXkq8Ne1
         LweG4+EywLmgnfIvRcSAA1k8AOUWqb2nQR94q1aPmNeIy89utVcYQzkQtfBQ2kUmnV
         UgpHquI1WzrDwBlf+dVA0xfGAov7Dn6MVUpV5k9U8G/oUBKDnB8XMFCchLgwMKPoRb
         Sc736oGeWCLyQ==
Date:   Wed, 23 Dec 2020 13:03:39 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] A few documentation fixes
Message-ID: <20201223130339.4f7b9ec5@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
47e44ed01434e51e2e42b188482d837c01e5d16e:

  docs: fix broken cross reference in translations/zh_CN (2020-12-14 13:14:22 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.11-2

for you to fetch changes up to c635b0cea6b812898563809a13e65278989b2c72:

  docs: admin-guide: Fix default value of max_map_count in sysctl/vm.rst (2020-12-21 09:59:07 -0700)

----------------------------------------------------------------
A small set of late-arriving, small documentation fixes.

----------------------------------------------------------------
Borislav Petkov (1):
      Documentation/submitting-patches: Document the SoB chain

Fengfei Xi (1):
      docs: admin-guide: Fix default value of max_map_count in sysctl/vm.rst

Lee Jones (1):
      docs: submitting-patches: Trivial - fix grammatical error

Milan Lakhani (1):
      Documentation: process: Correct numbering

 Documentation/admin-guide/sysctl/vm.rst      |  2 +-
 Documentation/process/submit-checklist.rst   | 24 ++++++++++++------------
 Documentation/process/submitting-patches.rst |  8 +++++++-
 3 files changed, 20 insertions(+), 14 deletions(-)
