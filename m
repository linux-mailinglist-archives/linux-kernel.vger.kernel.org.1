Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695E12FD5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391578AbhATQjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:39:31 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:14864 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730055AbhATQdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:33:20 -0500
Received: from sc9-mailhost1.vmware.com (10.113.161.71) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 20 Jan 2021 08:31:59 -0800
Received: from sc-dbc2115.eng.vmware.com (sc-dbc2115.eng.vmware.com [10.182.28.6])
        by sc9-mailhost1.vmware.com (Postfix) with ESMTP id 67BC5207BD;
        Wed, 20 Jan 2021 08:32:04 -0800 (PST)
From:   Jorgen Hansen <jhansen@vmware.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <gregkh@linuxfoundation.org>, <pv-drivers@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH v2 0/3] VMCI: Queue pair bug fixes
Date:   Wed, 20 Jan 2021 08:32:04 -0800
Message-ID: <1611160324-30066-1-git-send-email-jhansen@vmware.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: jhansen@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains three bug fixes for the queue pair
implementation in the VMCI driver.

v1 -> v2:
  - format patches as a series
  - use min_t instead of min to ensure size_t comparison
    (issue pointed out by kernel test robot <lkp@intel.com>)

Jorgen Hansen (3):
  VMCI: Stop log spew when qp allocation isn't possible
  VMCI: Use set_page_dirty_lock() when unregistering guest memory
  VMCI: Enforce queuepair max size for IOCTL_VMCI_QUEUEPAIR_ALLOC

 drivers/misc/vmw_vmci/vmci_queue_pair.c | 16 ++++++++++------
 include/linux/vmw_vmci_defs.h           |  4 ++--
 2 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.6.2

