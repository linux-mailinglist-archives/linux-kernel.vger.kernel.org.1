Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3549819DAA8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 17:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390818AbgDCPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 11:55:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:50114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgDCPzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:55:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9FE77ABE9;
        Fri,  3 Apr 2020 15:54:58 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.7-rc1
Date:   Fri,  3 Apr 2020 17:54:57 +0200
Message-Id: <20200403155457.27562-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.7-rc1-tag

xen: branch for v5.7-rc1

It contains:

- a cleanup patch removing an unused function
- a small fix for the xen pciback driver
- a series for making the unwinder hyppay with the Xen PV guest idle
  task stacks

Thanks.

Juergen

 arch/x86/xen/smp_pv.c                |   3 +-
 arch/x86/xen/xen-head.S              |  18 ++++-
 drivers/xen/xen-pciback/conf_space.c |   2 +-
 drivers/xen/xen-pciback/conf_space.h |   8 +--
 drivers/xen/xenbus/xenbus_client.c   | 126 ++++++++++++-----------------------
 include/xen/xenbus.h                 |   7 --
 6 files changed, 65 insertions(+), 99 deletions(-)

Juergen Gross (1):
      xen/xenbus: remove unused xenbus_map_ring()

Marek Marczykowski-Górecki (1):
      xen-pciback: fix INTERRUPT_TYPE_* defines

Miroslav Benes (2):
      x86/xen: Make the boot CPU idle task reliable
      x86/xen: Make the secondary CPU idle tasks reliable
