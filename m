Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B224DF0A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHUSCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 14:02:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:36280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgHUSCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:02:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 133F2ACA3;
        Fri, 21 Aug 2020 18:02:46 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.9-rc2
Date:   Fri, 21 Aug 2020 20:02:17 +0200
Message-Id: <20200821180217.14469-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc2-tag

xen: branch for v5.9-rc2

It contains one build fix and a minor fix for suppressing a useless
warning when booting a Xen dom0 via UEFI.


Thanks.

Juergen

 arch/x86/pci/xen.c          | 1 +
 drivers/video/fbdev/efifb.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

Juergen Gross (1):
      efi: avoid error message when booting under Xen

Randy Dunlap (1):
      Fix build error when CONFIG_ACPI is not set/enabled:
