Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DAB1AFFEA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 04:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgDTCon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 22:44:43 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:45358 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbgDTCon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 22:44:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tw0pjwj_1587350675;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0Tw0pjwj_1587350675)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Apr 2020 10:44:38 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, bsegall@google.com,
        chiluk+linux@indeed.com, vincent.guittot@linaro.org,
        pauld@redhead.com, Huaixin Chang <changhuaixin@linux.alibaba.com>
Subject: [PATCH 0/2] Two small fixes for bandwidth controller
Date:   Mon, 20 Apr 2020 10:44:19 +0800
Message-Id: <20200420024421.22442-1-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains two small fixes for bandwidth controller, and also
preparation for burstable CFS bandwidth controller.

Huaixin Chang (2):
  sched: Defend cfs and rt bandwidth quota against overflow
  sched/fair: Refill bandwidth before scaling

 kernel/sched/core.c  | 8 ++++++++
 kernel/sched/fair.c  | 4 ++--
 kernel/sched/rt.c    | 9 +++++++++
 kernel/sched/sched.h | 2 ++
 4 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.14.4.44.g2045bb6

