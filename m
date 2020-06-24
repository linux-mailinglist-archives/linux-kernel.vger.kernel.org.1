Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCF7206D00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 08:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389393AbgFXGuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 02:50:10 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:57837 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388262AbgFXGuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:50:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0Zd2IB_1592981406;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U0Zd2IB_1592981406)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Jun 2020 14:50:06 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Some improvements for NVMe
Date:   Wed, 24 Jun 2020 14:49:56 +0800
Message-Id: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The fisrt patch adds Arbitration Burst support, and another one is
a small improvement. Please help to review. Thanks.

Changes from v1:
 - Add new parameter to decide if use the controller's recommended
 arbitration burst.
 - Add arbitration burst mask in case overflow.
 - Do not export the nvme_set_arbitration_burst().
 - Add reviewed tag from Sagi.
 - Drop patch 2 in v1 patch set.

Baolin Wang (2):
  nvme: Add Arbitration Burst support
  nvme: Use USEC_PER_SEC instead of magic numbers

 drivers/nvme/host/core.c | 31 ++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 include/linux/nvme.h     |  1 +
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
1.8.3.1

