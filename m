Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066131AFB72
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 16:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgDSOky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 10:40:54 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54691 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgDSOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 10:40:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Tw-JlLh_1587307252;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tw-JlLh_1587307252)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 19 Apr 2020 22:40:53 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 0/3] x86: cleanups
Date:   Sun, 19 Apr 2020 14:40:46 +0000
Message-Id: <20200419144049.1906-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple cleanups found while reading the code.

Lai Jiangshan (3):
  x86/entry: remove unneeded kernel cr3 switching
  x86: remove address operator on function machine_check()
  x86/entry: remove an unused label

 arch/x86/entry/entry_64.S | 2 --
 arch/x86/kernel/idt.c     | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.20.1

