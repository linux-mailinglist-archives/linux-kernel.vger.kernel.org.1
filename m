Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E322DED87
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 07:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgLSGcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 01:32:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:49934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgLSGcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 01:32:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608359496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W7It98Z0GUNNQl0L2v0ZRaWFiumpgvCVR6+DzhT4F3M=;
        b=mOHEYBPDHlpDsNSxc4JotGLnoUNOhKzH8M9LGngwgAK5QrkicMt6V2FAeTLYrZhxHNbm0g
        OW36HhK3pRLCtR7v7ZClx8626x+UDRl+i4lFHGrJOR1DrFNKwGvHakwNZLg8EEek/ozJZ+
        HHRYT3bIpLlmbCnmrpa6Z0eFmHgZXwE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5D98ACC4;
        Sat, 19 Dec 2020 06:31:36 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.11-rc1
Date:   Sat, 19 Dec 2020 07:31:36 +0100
Message-Id: <20201219063136.5828-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc1b-tag

xen: branch for v5.11-rc1

It contains some minor cleanup patches and a small series disentangling some Xen
related Kconfig options.

Thanks.

Juergen

 arch/x86/include/asm/xen/page.h |  2 +-
 arch/x86/xen/Kconfig            | 38 ++++++++++++++++++++++----------------
 arch/x86/xen/p2m.c              | 12 +-----------
 drivers/block/xen-blkfront.c    |  1 +
 drivers/xen/Makefile            |  2 +-
 drivers/xen/manage.c            |  1 +
 6 files changed, 27 insertions(+), 29 deletions(-)

Gustavo A. R. Silva (2):
      xen-blkfront: Fix fall-through warnings for Clang
      xen/manage: Fix fall-through warnings for Clang

Jason Andryuk (3):
      xen: Remove Xen PVH/PVHVM dependency on PCI
      xen: Kconfig: nest Xen guest options
      xen: Kconfig: remove X86_64 depends from XEN_512GB

Qinglang Miao (1):
      x86/xen: Convert to DEFINE_SHOW_ATTRIBUTE

Tom Rix (1):
      xen: remove trailing semicolon in macro definition
