Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A77D293D98
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407643AbgJTNrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:47:20 -0400
Received: from mail.efficios.com ([167.114.26.124]:43488 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407620AbgJTNrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:47:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 335E02D9584;
        Tue, 20 Oct 2020 09:47:19 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NPHE36RPRnLu; Tue, 20 Oct 2020 09:47:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E3FA62D9499;
        Tue, 20 Oct 2020 09:47:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E3FA62D9499
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603201638;
        bh=kf5TuldOxXtW2R7NBqNhrqXW+h/MrQrkZiaPBR8GLgU=;
        h=From:To:Date:Message-Id;
        b=eeygBOjdiMTgVC00q10e5Zl4PdGmjUgjfB7FsSfDt/8K7EpgU26dSEe9FAsK5oyzH
         b+2mlzgT8UPI3XrXUyjQ0XuOQj+NxCvy6pk6eRRNw4EzSkSveZHWxkWeMvY+22VpeY
         sRwHUlTU/A4LJSFLF3lknR2+c4H6LjUX2nVdla7807xM/cZBI8zw7R/zRzliJo7aFZ
         MMeosgXhKY1I4SXlptSh83Vz1aCB9prabJHJ5/k0PCi7a+fGE9ihDQ0uqZUFFh9B5v
         LIewKXT4R6qz/r5HorFuchQcNCnlDuFcV7n2S2vEjzVeBb9SiRc9SQnaPfhKjm9QQ4
         1eSZPcViLOtAg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i18uqsULWlHJ; Tue, 20 Oct 2020 09:47:18 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id A7F982D8D7A;
        Tue, 20 Oct 2020 09:47:18 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 0/3] Membarrier updates
Date:   Tue, 20 Oct 2020 09:47:12 -0400
Message-Id: <20201020134715.13909-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please find the following membarrier updates series posted for inclusion
upstream.

Thanks,

Mathieu

Mathieu Desnoyers (3):
  sched: fix exit_mm vs membarrier (v4)
  sched: membarrier: cover kthread_use_mm (v4)
  sched: membarrier: document memory ordering scenarios

 include/linux/sched/mm.h  |   5 ++
 kernel/exit.c             |  16 ++++-
 kernel/kthread.c          |  21 ++++++
 kernel/sched/idle.c       |   1 +
 kernel/sched/membarrier.c | 147 ++++++++++++++++++++++++++++++++++++--
 5 files changed, 185 insertions(+), 5 deletions(-)

-- 
2.17.1

