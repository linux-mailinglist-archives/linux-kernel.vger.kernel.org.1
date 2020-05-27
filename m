Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DFF1E4E81
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 21:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387405AbgE0TrI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 May 2020 15:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgE0TrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:47:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4018C03E96E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:47:02 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1je20x-0005H4-Ul; Wed, 27 May 2020 21:47:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 0/2] workqueue: Make the workqueue code PREEMPT_RT safe
Date:   Wed, 27 May 2020 21:46:31 +0200
Message-Id: <20200527194633.1660952-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series changes `wq_manager_wait' from waitqueues to simple
waitqueues and its internal locking (pool::lock and wq_mayday_lock) to
raw spinlocks so that workqueues can be used on PREEMPT_RT from truly
atomic context.

v1…v2: Use rcuwait instead of swait.

v1 can be found at
   https://lore.kernel.org/lkml/20200513162732.977489-1-bigeasy@linutronix.de/

Sebastian


