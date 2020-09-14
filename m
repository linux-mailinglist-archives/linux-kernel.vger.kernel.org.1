Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EA72682BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 04:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgINCpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 22:45:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22390 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725991AbgINCpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 22:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600051519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=aBvg4ZsjHs40Kc9w9Qs5hEd580WSaR6Ix3MTYhAg0bQ=;
        b=A36RaUi2ehsX/TZm8kEdVXR4GRxCavMgCysBcrPZ846dg5o7iKHU8ZeQsQ6wGtoJ9Dq6I6
        wVcWlqMF013D0kgOlHpFEd0FDi+UkRQHbWoLUfgZPbu+OSxEz+bAPX82bfnABWmSyjOBmy
        EBIx3lSnQ0IiWMKWrnUALuD+FR+rvxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-rAI_uQyyNq6Nde0A3owwgg-1; Sun, 13 Sep 2020 22:45:15 -0400
X-MC-Unique: rAI_uQyyNq6Nde0A3owwgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CED210066FB;
        Mon, 14 Sep 2020 02:45:13 +0000 (UTC)
Received: from llong.com (ovpn-113-90.rdu2.redhat.com [10.10.113.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F33F260CD1;
        Mon, 14 Sep 2020 02:45:03 +0000 (UTC)
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
Subject: [PATCH v2 0/3] mm/memcg: Miscellaneous cleanups and streamlining
Date:   Sun, 13 Sep 2020 22:44:49 -0400
Message-Id: <20200914024452.19167-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
 - For patch 2, separate v1 and v2 processing and add back the missing
   total_swap_pages check.
 - For patch 3, use union to merge swap and memsw page counters.

Patch 1 removes an unused enum charge_type.

Patch 2 streamlines mem_cgroup_get_max().

Patch 3 unifies swap and memsw page counters in mem_cgroup.

Waiman Long (3):
  mm/memcg: Clean up obsolete enum charge_type
  mm/memcg: Simplify mem_cgroup_get_max()
  mm/memcg: Unify swap and memsw page counters

 include/linux/memcontrol.h | 13 ++++++++-----
 mm/memcontrol.c            | 29 ++++++++---------------------
 2 files changed, 16 insertions(+), 26 deletions(-)

-- 
2.18.1

