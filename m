Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A3F205356
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 15:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbgFWNYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 09:24:53 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:43140 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732594AbgFWNYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:24:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0VzALe_1592918683;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U0VzALe_1592918683)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jun 2020 21:24:43 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Some improvements for NVMe
Date:   Tue, 23 Jun 2020 21:24:31 +0800
Message-Id: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The fisrt patch adds Arbitration Burst support, and other 2 patches
are small improvements. Please help to review. Thanks.

Baolin Wang (3):
  nvme: Add Arbitration Burst support
  nvme-pci: Add controller memory buffer supported macro
  nvme: Use USEC_PER_SEC instead of magic numbers

 drivers/nvme/host/core.c | 25 ++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  |  4 +++-
 include/linux/nvme.h     |  1 +
 4 files changed, 30 insertions(+), 2 deletions(-)

-- 
1.8.3.1

