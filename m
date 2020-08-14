Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198B8244CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 18:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgHNQoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 12:44:06 -0400
Received: from mail.efficios.com ([167.114.26.124]:58780 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgHNQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:44:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2CFC8298C61;
        Fri, 14 Aug 2020 12:44:05 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1aC3aBf118nC; Fri, 14 Aug 2020 12:44:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E143E298A7E;
        Fri, 14 Aug 2020 12:44:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E143E298A7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1597423444;
        bh=DswlVBKuKd2labIqCgEoG1MueK2NYXX+j88XAidVLtA=;
        h=From:To:Date:Message-Id;
        b=Kam7TpDtW8qARJT1zHH+eX3cD6Z15F9lutypm6NieFgdM+HBUP6mxEEoolqZ6H7z+
         HXWYJT+aEmlIX/M5fDEZBv4z/1L3GyipuLMtwNOkAsP2neL4c0fnfuTac9R+ylxrO2
         ckH9455z5mSz3DJqtr22C8/jwSxpfHnbhqwcvi6b06uz7IBHYCTGyiQVO2/YGrTxfP
         ZAfIbwSrtYC6lVUcCcrTgJrua+nVuSyUrUYgHjXUSIGZzmDUPXmzOso/7SzaKj8IEs
         WHa9y9OFOTOsKWBEmYYZBGPiFq62qJ1wNyk0n0Ow7RELBGuP0l0XHIt7qPs/MY59WY
         MeVpvl2ZkZZAQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hAjUmPJdomMi; Fri, 14 Aug 2020 12:44:04 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 9FE97299002;
        Fri, 14 Aug 2020 12:44:04 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 0/3] sched: membarrier updates
Date:   Fri, 14 Aug 2020 12:43:55 -0400
Message-Id: <20200814164358.4783-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please find those three changes based on our recent discussions about
interaction between membarrier and exit_mm and kthread_use_mm. I added
documentation of memory ordering scenarios to membarrier.c as well.

Thanks,

Mathieu

Mathieu Desnoyers (3):
  sched: fix exit_mm vs membarrier (v2)
  sched: membarrier: cover kthread_use_mm (v2)
  sched: membarrier: document memory ordering scenarios

 kernel/exit.c             |   8 +++
 kernel/kthread.c          |  19 +++++++
 kernel/sched/idle.c       |   1 +
 kernel/sched/membarrier.c | 136 ++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 158 insertions(+), 6 deletions(-)

-- 
2.11.0

