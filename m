Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38411BB59E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 07:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgD1FCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 01:02:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31129 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbgD1FCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588050172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aKCNIcVoG7r+R/o+L3JV6BX0afKeSbXEAsVJ13PnLAQ=;
        b=ONJ/emjMqcMB5slKQri2KgZzw9RYlVOGklpz/E2a/NTwSt1yPLqD7uuH/uweryIKcsGSY+
        jNDRaC+eyULOvHGUvEA7oYIH56LDj/tAmvPw5+WJYT7xCD3UA9ydsPhqH3pCxPoP4gG2Wq
        PelLv9M82MprVHcRcDkbQb8euyian6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-4Ay0BtX0MTO1xH0QuGjMDw-1; Tue, 28 Apr 2020 01:02:48 -0400
X-MC-Unique: 4Ay0BtX0MTO1xH0QuGjMDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FB201895A2B;
        Tue, 28 Apr 2020 05:02:45 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5816E19C4F;
        Tue, 28 Apr 2020 05:02:43 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [RFC PATCH 0/3] newidle_balance() latency mitigation
Date:   Tue, 28 Apr 2020 00:02:39 -0500
Message-Id: <20200428050242.17717-1-swood@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches mitigate latency caused by newidle_balance() on large
systems, by enabling interrupts when the lock is dropped, and exiting
early at various points if an RT task is runnable on the current CPU.

When applied to an RT kernel on a 72-core machine (2 threads per core), I
saw significant reductions in latency as reported by rteval -- from
over 500us to around 160us with hyperthreading disabled, and from
over 1400us to around 380us with hyperthreading enabled.

This isn't the first time something like this has been tried:
https://lore.kernel.org/lkml/20121222003019.433916240@goodmis.org/
That attempt ended up being reverted:
https://lore.kernel.org/lkml/5122CD9C.9070702@oracle.com/

The problem in that case was the failure to keep BH disabled, and the
difficulty of fixing that when called from the post_schedule() hook.=20
This patchset uses finish_task_switch() to call newidle_balance(), which
enters in non-atomic context so we have full control over what we disable
and when.

There was a note at the end about wanting further discussion on the matte=
r --
does anyone remember if that ever happened and what the conclusion was?
Are there any other issues with enabling interrupts here and/or moving
the newidle_balance() call?

Rik van Riel (1):
  sched,rt: break out of load balancing if an RT task appears

Scott Wood (2):
  sched/fair: Call newidle_balance() from finish_task_switch()
  sched/fair: Enable interrupts when dropping lock in newidle_balance()

 kernel/sched/core.c  |  7 +++--
 kernel/sched/fair.c  | 72 +++++++++++++++++++++++---------------------
 kernel/sched/sched.h | 12 +++++---
 3 files changed, 49 insertions(+), 42 deletions(-)

--=20
2.18.2

