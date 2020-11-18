Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564EB2B7483
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 04:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgKRDFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:05:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725613AbgKRDFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605668703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=1tHTZo0NWIQ6U/qkej3mS/LRGrC8hfvrmLswNc7GVTU=;
        b=bVcpEq5CumX18md6R37cs5tmcwDpFQjFW4806jHlJ39fQfB/3QJoB3f8vd+6CfgVj2+vk0
        QhNlbpXpJYrt4lRspzeWmhqPQkXJiEof1+sOI856lpc3GwXpF9JHvcDIsTqSh27PO9US5y
        lhvNeA+2m0DW/agS9+pBFbckRqneOu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-_YoaksjpNB2KnzEAWxd0aw-1; Tue, 17 Nov 2020 22:05:01 -0500
X-MC-Unique: _YoaksjpNB2KnzEAWxd0aw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B73346414C;
        Wed, 18 Nov 2020 03:04:59 +0000 (UTC)
Received: from llong.com (ovpn-113-17.rdu2.redhat.com [10.10.113.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E36BF5C1A3;
        Wed, 18 Nov 2020 03:04:55 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH 0/5] locking/rwsem: Rework reader optimistic spinning
Date:   Tue, 17 Nov 2020 22:04:24 -0500
Message-Id: <20201118030429.23017-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent report of SAP certification failure caused by increased system
time due to rwsem reader optimistic spinning led me to reexamine the
code to see the pro and cons of doing it. This led me to discover a
potential lock starvation scenario as explained in patch 2. That patch
does reduce reader spinning to avoid this potential problem. Patches
3 and 4 are further optimizations of the current code.

Then there is the issue of reader fragmentation that can potentially
reduce performance in some heavy contention cases. Two different approaches
are attempted:
 1) further reduce reader optimistic spinning
 2) disable reader spinning

See the performance shown in patch 5.

This patch series adopts the second approach by dropping reader spinning
for now. We can discuss if this is the right move or we should try the
alternative or just don't do anything further.

Waiman Long (5):
  locking/rwsem: Pass the current atomic count to
    rwsem_down_read_slowpath()
  locking/rwsem: Prevent potential lock starvation
  locking/rwsem: Enable reader optimistic lock stealing
  locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED
  locking/rwsem: Remove reader optimistic spinning

 kernel/locking/lock_events_list.h |   6 +-
 kernel/locking/rwsem.c            | 277 ++++++++----------------------
 2 files changed, 73 insertions(+), 210 deletions(-)

-- 
2.18.1

