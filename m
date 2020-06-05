Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8031EF408
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgFEJ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 05:26:02 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:5640 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgFEJ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591349161; x=1622885161;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=bw6+ijwEqZdeFOyRofC8/OSsEoPTXed1r76n2KoBuk8=;
  b=FHWIp24jZmX9kY+KpUNPbQe5QaiMu7IpwDAxlA7i22uNJXXqoaIj39Va
   RlwCe19PkZ1gXB7Kw84LNl3Pels2Kc2ghWMYDmpjG+LB54pxocnwBQWkK
   1FKDY3Ok65z3i0722N/rs2DyO6k4A2f2hfLL+5fnUOPu5yFH10oSAZAzu
   0=;
IronPort-SDR: Rv4x+duE8FNRcJvPz3Jbgh4BJlUeQ5c+chSvXk2zbSzM2ovhjSQawOjgS14XLoXhzuVzGUfQFy
 i0g+1Ga1KQCA==
X-IronPort-AV: E=Sophos;i="5.73,475,1583193600"; 
   d="scan'208";a="50028990"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 05 Jun 2020 09:25:59 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 5D6C1A2179;
        Fri,  5 Jun 2020 09:25:58 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 09:25:41 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.200) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 09:25:35 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 0/2] Trivial fixups
Date:   Fri, 5 Jun 2020 11:25:00 +0200
Message-ID: <20200605092502.18018-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.200]
X-ClientProxiedBy: EX13D32UWB003.ant.amazon.com (10.43.161.220) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This patchset fixes a potential problem in idle page tracking and adds
more typos in the scripts/spelling.txt.  The problem and the typos were
found during my DAMON[1] work.

This patchset is based on next/akpm.

[1] https://lore.kernel.org/linux-mm/20200602130125.20467-1-sjpark@amazon.com/

SeongJae Park (2):
  mm/page_idle.c: Skip offline pages
  scripts/spelling: Add a few more typos

 mm/page_idle.c       | 7 ++-----
 scripts/spelling.txt | 9 +++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.17.1

