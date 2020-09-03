Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B65525C048
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 13:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgICLZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 07:25:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:56254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbgICLLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:11:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCD61B6C7;
        Thu,  3 Sep 2020 11:11:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2231ADA6E0; Thu,  3 Sep 2020 13:09:51 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS fix for 5.9
Date:   Thu,  3 Sep 2020 13:09:46 +0200
Message-Id: <cover.1599130324.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there's one fix to make permissions work the same way as on AmigaOS.
Please pull, thanks.

----------------------------------------------------------------
The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-5.9-tag

for you to fetch changes up to d3a84a8d0dde4e26bc084b36ffcbdc5932ac85e2:

  affs: fix basic permission bits to actually work (2020-08-31 12:20:31 +0200)

----------------------------------------------------------------
Max Staudt (1):
      affs: fix basic permission bits to actually work

 Documentation/filesystems/affs.rst | 16 ++++++++++------
 fs/affs/amigaffs.c                 | 27 +++++++++++++++++++++++++++
 fs/affs/file.c                     | 26 +++++++++++++++++++++++++-
 3 files changed, 62 insertions(+), 7 deletions(-)
