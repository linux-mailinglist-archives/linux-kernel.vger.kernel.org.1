Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF5F2C4C53
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 01:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgKZA4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 19:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKZA4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 19:56:17 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDCBC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:56:16 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id f19so231066pgm.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=WW6m8L5ILiyKOjiCLA3OcaWjbEvpgZIBT6xWyxaeAqE=;
        b=hNe83evmXHNPeoUDa9KHUtwJdsKP0LEGh2o8muVDlhqkycNrye72bmqREzcPsCuWPO
         SfyycYrmcvZpQL3ksnratthwbFLQRs5KyyWj80HqJTJ4Qd8FzmXPlpXkxmLQQWk4E3il
         3KyLXf5vpdkrAicVGTsbpOb6IggG68Zc3WOxIUsP9qtuU34/hIAZXHoqDlttn+mr/UmM
         Vuqt8udB3MfKiwGDUsElbblakYHGvhvv05BXQa+iG6f7efc6a8NCC+6EDrQm65SP/TxS
         874pvchEujZmWrbT4CVryYJkMr3BfFDHMuUH5kPBQYbaEKRo+PUNNeVZ2XY7gNVtl7cY
         fh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=WW6m8L5ILiyKOjiCLA3OcaWjbEvpgZIBT6xWyxaeAqE=;
        b=hBfUnd2fuGOymj+NCu9E7VBFnqhMfctp0Z90i/epgpZnV3DzXsy4rYz8sYhWBhRMP1
         3uuXwvJbB08y8tS9CILuTwvQEpsyUjd5OZZj98hBeWr+cL4Bx+Fb/ScDca9ESz0I6HYJ
         +PpYwGDi8xje5hPB0yMu3TE3+9kendzls76UKYowj/cDamk0w0qO9uYZiiH2sdH4TH8v
         D7tixznyyt9mq+RtQ3u+efN0KCcsBFRu2hA4e8JRQ32njAaqfrtqItXAPS3RJVFk0JRr
         uc5zPpjxfhnQmaI+Vb//7SLOE046nMfKIKvwmqjo+Sl2rEHpMWR5vSHVnuxF7lyvEmsa
         60MA==
X-Gm-Message-State: AOAM530IFAc65KHOhD25ryxgfViVcmuhH52j35iqo7X7XgMoH1ACAS3i
        zYmrLCbDn6l6HKFfexlYtCNPAOsQDk6+Sw==
X-Google-Smtp-Source: ABdhPJzDD9mk0WYMoX9dRvEtwjPauAbZkezzXH6KjIzbn66WmX9gH2+pq21j2WyEle5g7FTSmLqML7/dsCGozg==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:a63:e612:: with SMTP id g18mr456740pgh.388.1606352175534;
 Wed, 25 Nov 2020 16:56:15 -0800 (PST)
Date:   Wed, 25 Nov 2020 16:56:01 -0800
Message-Id: <20201126005603.1293012-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 0/2] memcg: add pagetable comsumption to memory.stat
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many workloads consumes significant amount of memory in pagetables. This
patch series exposes the pagetable comsumption for each memory cgroup.

Shakeel Butt (2):
  mm: move lruvec stats update functions to vmstat.h
  mm: memcontrol: account pagetables per node

 Documentation/admin-guide/cgroup-v2.rst |   3 +
 arch/nds32/mm/mm-nds32.c                |   6 +-
 drivers/base/node.c                     |   2 +-
 fs/proc/meminfo.c                       |   2 +-
 include/linux/memcontrol.h              | 112 ------------------------
 include/linux/mm.h                      |  11 ++-
 include/linux/mmzone.h                  |   2 +-
 include/linux/vmstat.h                  | 104 ++++++++++++++++++++++
 mm/memcontrol.c                         |  19 ++++
 mm/page_alloc.c                         |   6 +-
 10 files changed, 142 insertions(+), 125 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

