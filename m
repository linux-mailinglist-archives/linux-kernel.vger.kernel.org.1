Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D092910A4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 10:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406626AbgJQICx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 04:02:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33292 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388136AbgJQICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 04:02:51 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 861FA1F45E3C;
        Sat, 17 Oct 2020 09:02:50 +0100 (BST)
Date:   Sat, 17 Oct 2020 10:02:47 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] i3c: Changes for 5.10
Message-ID: <20201017100247.475552a8@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

I'm a bit late, but here is the I3C PR for 5.10.

Regards,

Boris

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.10

for you to fetch changes up to abea14bfdebbe9bd02f2ad24a1f3a878ed21c8f0:

  i3c: master: Fix error return in cdns_i3c_master_probe() (2020-10-07 15:14:07 +0200)

----------------------------------------------------------------
* Fix DAA for the pre-reserved address case
* Fix an error path in the cadence driver

----------------------------------------------------------------
Jing Xiangfeng (1):
      i3c: master: Fix error return in cdns_i3c_master_probe()

Parshuram Thombare (2):
      i3c: master add i3c_master_attach_boardinfo to preserve boardinfo
      i3c: master: fix for SETDASA and DAA process

 drivers/i3c/master.c                 | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------
 drivers/i3c/master/i3c-master-cdns.c |   4 +++-
 2 files changed, 94 insertions(+), 54 deletions(-)
