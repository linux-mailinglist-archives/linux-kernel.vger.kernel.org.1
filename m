Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B29D28D9A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 07:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgJNFjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 01:39:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:38970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgJNFjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 01:39:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602653957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rwKx1/PQRXwtK7KwNu38C2wugXfvHcRdY2flAxFD91w=;
        b=t7YOMgrsuNovYjNiiI0fbC0zzmSIKOSylwsD6FLibphK3Nq6v+FM3K1dkbOe4Suj/S1bBV
        1GdGihQbgiOVU7PIFd8uDj79bEPUVhfVxNIP5V/qliYP/6QXR0I3+MFiOisvMbdBY0is8z
        0qFl/BkRNtbTF4VAOdQeE8Gcjv5FW1s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BFF4AFCC;
        Wed, 14 Oct 2020 05:39:17 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.10-rc1
Date:   Wed, 14 Oct 2020 07:39:17 +0200
Message-Id: <20201014053917.19251-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10b-rc1-tag

xen: branch for v5.10-rc1

It contains:

- 2 small cleanup patches

- A fix for avoiding error messages when initializing MCA banks in a
  Xen dom0

- A small series for converting the Xen gntdev driver to use
  pin_user_pages*() instead of get_user_pages*()

- An intermediate fix for running as a Xen guest on Arm with KPTI
  enabled (the final solution will need a new Xen functionality)


Thanks.

Juergen

 arch/arm/include/asm/xen/page.h   |  5 +++++
 arch/arm/xen/enlighten.c          |  6 ++++--
 arch/arm64/include/asm/xen/page.h |  6 ++++++
 arch/x86/xen/enlighten_pv.c       |  9 +++++++++
 arch/x86/xen/mmu_pv.c             |  2 +-
 drivers/xen/gntdev.c              | 17 +++++++++--------
 drivers/xen/pvcalls-front.c       |  2 +-
 7 files changed, 35 insertions(+), 12 deletions(-)

Hui Su (1):
      x86/xen: Fix typo in xen_pagetable_p2m_free()

Jing Xiangfeng (1):
      xen: remove redundant initialization of variable ret

Juergen Gross (1):
      x86/xen: disable Firmware First mode for correctable memory errors

Souptick Joarder (2):
      xen/gntdev.c: Mark pages as dirty
      xen/gntdev.c: Convert get_user_pages*() to pin_user_pages*()

Stefano Stabellini (1):
      xen/arm: do not setup the runstate info page if kpti is enabled
