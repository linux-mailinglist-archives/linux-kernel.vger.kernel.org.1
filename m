Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C6E2BBCF0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgKUEOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbgKUEOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605932072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Nysw+ALeJ2uJP9IshMO/7Qd/B8DM61mZ9shnVFeRmCk=;
        b=XkC/I4LD09IGI05ezRUZ9UEzWtTYxjmczAp4gaQNZcd0AxTHsdxb+Wh4rOdfGudarcOP4l
        JdLTDlVjQ/mlrwl8ItdBAKTWM3HPiSn57QluW4vSBWRibEQi+YZ2il5Rsg4Da+PFrkTNjU
        upxH/AO2bO1mPa3x+5OEoC5XotTyo3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-iEFxbKjKOPOoeJSfthAsdA-1; Fri, 20 Nov 2020 23:14:30 -0500
X-MC-Unique: iEFxbKjKOPOoeJSfthAsdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1666C1DDE7;
        Sat, 21 Nov 2020 04:14:29 +0000 (UTC)
Received: from llong.com (ovpn-119-225.rdu2.redhat.com [10.10.119.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5868F6064B;
        Sat, 21 Nov 2020 04:14:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/5] locking/rwsem: Rework reader optimistic spinning
Date:   Fri, 20 Nov 2020 23:14:11 -0500
Message-Id: <20201121041416.12285-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v2:
  - Update some commit logs to incorporate review comments.
  - Patch 2: remove unnecessary comment.
  - Patch 3: rename osq_is_empty() to rwsem_no_spinners() as suggested.
  - Patch 4: correctly handle HANDOFF clearing.
  - Patch 5: fix !CONFIG_RWSEM_SPIN_ON_OWNER compilation errors.

A recent report of SAP certification failure caused by increased system
time due to rwsem reader optimistic spinning led me to reexamine the
code to see the pro and cons of doing it. This led me to discover a
potential lock starvation scenario as explained in patch 2. That patch
does reduce reader spinning to avoid this potential problem. Patches
3 and 4 are further optimizations of the current code.

Then there is the issue of reader fragmentation that can potentially
reduce performance in some heavily contented cases. Two different
approaches are attempted:
 1) further reduce reader optimistic spinning
 2) disable reader spinning

See the performance shown in patch 5.

This patch series adopts the second approach by dropping reader spinning
for now as it simplifies the code. However, writers are still allowed
to spin on a reader-owned rwsem for a limited time.

Waiman Long (5):
  locking/rwsem: Pass the current atomic count to
    rwsem_down_read_slowpath()
  locking/rwsem: Prevent potential lock starvation
  locking/rwsem: Enable reader optimistic lock stealing
  locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED
  locking/rwsem: Remove reader optimistic spinning

 kernel/locking/lock_events_list.h |   6 +-
 kernel/locking/rwsem.c            | 293 ++++++++----------------------
 2 files changed, 82 insertions(+), 217 deletions(-)

-- 
2.18.1

