Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C142F24BD5C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 15:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgHTNE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 09:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726974AbgHTNEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597928653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=hToOrTBcLzAKV5opdBYDcXptdpuWDT/30+sf1Uf9L88=;
        b=i+O9/34nFr8ztmA+rTsZvTl6P9PPJwnqEv8YWtNXpcWhm2YjWrDcIcMNwTwsX9g6SOFrce
        yzg3Bt7kZsFJTbg09/ILSKfr561BaBCuSbaMGmPWduL5lfkWqGKCBAsviJq7qpXLiPL8JU
        JNlAeG+8jnqwN2oEUxS7kG+MHrs5JEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-nFOjyWgxPEmHla2QCC5ykg-1; Thu, 20 Aug 2020 09:04:11 -0400
X-MC-Unique: nFOjyWgxPEmHla2QCC5ykg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 328A981F02E;
        Thu, 20 Aug 2020 13:04:09 +0000 (UTC)
Received: from llong.com (unknown [10.10.115.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81757600DD;
        Thu, 20 Aug 2020 13:04:04 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/3] mm/memcg: Miscellaneous cleanups and streamlining
Date:   Thu, 20 Aug 2020 09:03:47 -0400
Message-Id: <20200820130350.3211-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 removes an unused enum charge_type.

Patch 2 streamlines mem_cgroup_get_max().

Patch 3 unifies swap and memsw page counters in mem_cgroup.

Waiman Long (3):
  mm/memcg: Clean up obsolete enum charge_type
  mm/memcg: Simplify mem_cgroup_get_max()
  mm/memcg: Unify swap and memsw page counters

 include/linux/memcontrol.h |  3 +--
 mm/memcontrol.c            | 30 ++++++++++--------------------
 2 files changed, 11 insertions(+), 22 deletions(-)

-- 
2.18.1

