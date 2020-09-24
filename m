Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C582777B4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgIXRZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:25:18 -0400
Received: from mail.efficios.com ([167.114.26.124]:53532 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbgIXRZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:25:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 727AF2D679C;
        Thu, 24 Sep 2020 13:25:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Hldm_-ez9ggs; Thu, 24 Sep 2020 13:25:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 264C02D66CE;
        Thu, 24 Sep 2020 13:25:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 264C02D66CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600968317;
        bh=RgKtNeEweBtM37NlXSzXt4v+YCt27OTRE+kJt6al+6I=;
        h=From:To:Date:Message-Id;
        b=oaOSiJrix2VE1GLawQoK21DquGX4cu+NYvmipaaK535Bmm6Tfd7Xr5BUn6NQ4yIAz
         JVmSOkexJajijhy7zmhnj6nla65vnHyWU9Y3BVoIV1FfoD/jbYk3yLvi7RCSiaoanD
         spoqciOA2PWEi9ISdhrJ6u6p6DBYGJJB4MIlaaeJV2DRhzju5DE7mPkDgwHNCNe5yV
         salc0a9qMbhAVS26QFRXTgOHb9j9FnPdTmuqhdQhOucSRJK0NByJ+NOInjuCi2dN6V
         MPS8+Np1MrCd/U6tNB/Y5JPWFVPMedw/1M5ggwcEHkhJHtHFOb+0AihCpqfRfu6qnO
         iHM8qkVR95LAg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CSnSOlEirdkc; Thu, 24 Sep 2020 13:25:17 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id EEF852D66CD;
        Thu, 24 Sep 2020 13:25:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 0/3] Membarrier updates
Date:   Thu, 24 Sep 2020 13:25:05 -0400
Message-Id: <20200924172508.8724-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please find the following membarrier updates series posted as RFC.

Feedback is welcome,

Thanks,

Mathieu

Mathieu Desnoyers (3):
  sched: fix exit_mm vs membarrier (v3)
  sched: membarrier: cover kthread_use_mm (v3)
  sched: membarrier: document memory ordering scenarios

 include/linux/sched/mm.h  |   5 ++
 kernel/exit.c             |  12 ++++
 kernel/kthread.c          |  21 ++++++
 kernel/sched/core.c       |   3 +-
 kernel/sched/idle.c       |   1 +
 kernel/sched/membarrier.c | 148 ++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h      |   5 +-
 7 files changed, 186 insertions(+), 9 deletions(-)

-- 
2.17.1

