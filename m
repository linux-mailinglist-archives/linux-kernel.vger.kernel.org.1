Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE9D1E10F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391020AbgEYOvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 10:51:12 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53947 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390990AbgEYOvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:51:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TzckENZ_1590418264;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzckENZ_1590418264)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 May 2020 22:51:04 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [RFC PATCH 0/5] x86/hw_breakpoint: protects more cpu entry data
Date:   Mon, 25 May 2020 14:50:57 +0000
Message-Id: <20200525145102.122557-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The patchset is based on (tag: entry-v9-the-rest, tglx-devel/x86/entry).
And it is complement of 3ea11ac991d
("x86/hw_breakpoint: Prevent data breakpoints on cpu_entry_area").

After reading the code, we can see that more data needs to be protected
against hw_breakpoint, otherwise it may cause
dangerous/recursive/unwanted #DB.


Lai Jiangshan (5):
  x86/hw_breakpoint: add within_area() to check data breakpoints
  x86/hw_breakpoint: Prevent data breakpoints on direct GDT
  x86/hw_breakpoint: Prevent data breakpoints on per_cpu cpu_tss_rw
  x86/hw_breakpoint: Prevent data breakpoints on user_pcid_flush_mask
  x86/hw_breakpoint: Prevent data breakpoints on debug_idt_table

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20200505134058.272448010@linutronix.de
Link: https://lore.kernel.org/lkml/20200521200513.656533920@linutronix.de


 arch/x86/kernel/hw_breakpoint.c | 71 +++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 8 deletions(-)

-- 
2.20.1

