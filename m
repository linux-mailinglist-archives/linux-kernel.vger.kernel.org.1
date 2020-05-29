Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F921E7644
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 08:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgE2G7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 02:59:06 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:33468 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbgE2G7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:59:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Tzy5TGV_1590735544;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tzy5TGV_1590735544)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 May 2020 14:59:04 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 0/4] workqueue: simple cleanups
Date:   Fri, 29 May 2020 06:58:58 +0000
Message-Id: <20200529065903.1758-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple cleanups found when I was reviewing the lkml patches.

Lai Jiangshan (4):
  workqueue: void unneeded requeuing the pwq in rescuer thread
  workqueue: rescuer doesn't check wq->rescuer
  workqueue: free wq->unbound_attrs earlier
  workqueue: remove useless unlock() and lock() in series

Cc: Tejun Heo <tj@kernel.org>

 kernel/workqueue.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

-- 
2.20.1

