Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B602214466
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jul 2020 08:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGDG5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 02:57:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:33536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgGDG5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 02:57:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F0BAAB89;
        Sat,  4 Jul 2020 06:57:03 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.8-rc4
Date:   Sat,  4 Jul 2020 08:57:02 +0200
Message-Id: <20200704065702.3073-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.8b-rc4-tag

xen: branch for v5.8-rc4

It contains only 1 small cleanup patch for ARM and two patches for the
xenbus driver fixinf latent problems (large stack allocations and bad
return code settings).

Thanks.

Juergen

 arch/arm/xen/enlighten.c           |   1 -
 drivers/xen/xenbus/xenbus_client.c | 167 ++++++++++++++++++-------------------
 2 files changed, 81 insertions(+), 87 deletions(-)

Juergen Gross (2):
      xen/xenbus: avoid large structs and arrays on the stack
      xen/xenbus: let xenbus_map_ring_valloc() return errno values only

Xiaofei Tan (1):
      arm/xen: remove the unused macro GRANT_TABLE_PHYSADDR
