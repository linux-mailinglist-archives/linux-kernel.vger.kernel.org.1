Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A3A2131E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 04:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgGCCtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 22:49:36 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45205 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbgGCCtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:49:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U1XOWIX_1593744573;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U1XOWIX_1593744573)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 10:49:34 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Some cleanups for NVMe-pci driver
Date:   Fri,  3 Jul 2020 10:49:19 +0800
Message-Id: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are some cleanups for NVMe-pci driver, and no functional
changes, please help to review. Thanks.

Baolin Wang (5):
  nvme-pci: Fix some comments issues
  nvme-pci: Add a blank line after declarations
  nvme-pci: Remove redundant segment validation
  nvme-pci: Use the consistent return type of nvme_pci_iod_alloc_size()
  nvme-pci: Use standard block status macro

 drivers/nvme/host/pci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
1.8.3.1

