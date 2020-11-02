Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77B92A285B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgKBKc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbgKBKcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:32:25 -0500
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C1F2225E;
        Mon,  2 Nov 2020 10:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604313144;
        bh=cdD+P63da3bSzKkXW5DTy6aAw0tIAR4tLACFzMENEc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjgUkmQVY8qNtQpkefM08kuhsuKuC5H5CsoYsqhEq7pB/ZWHC1i8AB5oozHqiwLQi
         7LRMqJRm5uGflSxPsPhr/RLQlev0ffkwSjBZCH48pkfiM6CkI+0172Q7RfrLKxDD5h
         AnJBLBoJ3/IHANwOF+tBTEZKt9gAU3p7sL2A7IY4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kZX8P-005tuX-PC; Mon, 02 Nov 2020 11:32:21 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Dan Murphy <dmurphy@ti.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: [PATCH 0/5] Some fixes for ABI documentation
Date:   Mon,  2 Nov 2020 11:32:11 +0100
Message-Id: <cover.1604312590.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <ff1301ed-6040-3aac-c057-7f37184604d3@infradead.org>
References: <ff1301ed-6040-3aac-c057-7f37184604d3@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This small series contain fixes against Kernel 5.10-rc2.

It is meant to address the issue reported by Randy, with regards
to some "SEVERE" docutils warnings that it is causing the build
to fail for him.

I was not able to reproduce the bug myself, but fixing it is easy.

While here, I noticed a few typos at a few sysfs ABI entries.
The first two patches address them.

The third patch fixes a small issue: I added a new ReST file
at the ABI series, but the index file didn't receive the update.

The forth patch is the one that actually fix the reported issue.

While here, I added small change at get_abi.pl, for it to generate
some index entries for the symbols. That sounded to me a
natural change after having patch 4 removing some ABI indexes.
This patch should make life easier for people looking for a symbol 
inside the ABI books.

Mauro Carvalho Chehab (5):
  docs: ABI: sysfs-driver-dma-ioatdma: what starts with /sys
  docs: ABI: sysfs-class-net: fix a typo
  docs: leds: index.rst: add a missing file
  scripts: get_abi.pl: Don't let ABI files to create subtitles
  scripts: get_api.pl: Add sub-titles to ABI output

 .../ABI/stable/sysfs-driver-dma-ioatdma       | 10 ++++----
 Documentation/ABI/testing/sysfs-class-net     |  2 +-
 Documentation/leds/index.rst                  |  1 +
 scripts/get_abi.pl                            | 23 +++++++++++++++++++
 4 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.26.2


