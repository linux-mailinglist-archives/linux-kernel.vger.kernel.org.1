Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BD22566C7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 12:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgH2KEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 06:04:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:36142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgH2KEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:04:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71682ACB5;
        Sat, 29 Aug 2020 10:04:39 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.9-rc3
Date:   Sat, 29 Aug 2020 12:04:05 +0200
Message-Id: <20200829100405.23826-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc3-tag

xen: branch for v5.9-rc3

It contains two fixes for Xen: one needed for ongoing work to support
virtio with Xen, and one for a corner case in IRQ handling with Xen.


Thanks.

Juergen

 drivers/xen/events/events_base.c   | 16 ++++++++--------
 drivers/xen/xenbus/xenbus_client.c | 10 ++++++++--
 include/xen/arm/page.h             |  6 +++++-
 3 files changed, 21 insertions(+), 11 deletions(-)

Simon Leiner (2):
      xen/xenbus: Fix granting of vmalloc'd memory
      arm/xen: Add misuse warning to virt_to_gfn

Thomas Gleixner (1):
      XEN uses irqdesc::irq_data_common::handler_data to store a per interrupt XEN data pointer which contains XEN specific information.
