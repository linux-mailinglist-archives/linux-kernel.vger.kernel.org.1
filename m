Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B9D2877D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgJHPro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgJHPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:47:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EA8C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 08:47:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 7so4617008pgm.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Xu7D1/iifhAl89mciVhCgz8cwDykyyXroMOo4n3QiNI=;
        b=h6e1DvVLPeE00Hm/JAvqpNu7kTdQtJE9tvUac89n4jW6HfKrMaRTNTT7whol2ibSO3
         pc8KkKddTKcTGamJy8+SLXglUivCx5QuuZAYttOBDZoP/uUziB4NWf3T5S0rDnxtKUG5
         u6sfArme3tu6OQtuAfqG+HEy3WcovlTm0wZ1BTdJjtRMawUeHu7YPE6m7IvpxzwQQUNZ
         fqBjbMeMBrurmty9gQVvh44GKaUdvAoAQEE37kIeRT1iLUFSHPu9s0+Ug/s8FfiFoeNk
         /5615wWLUvT9MyJRVaFaxPK3XIVKXoN1sn6BS8oD/q1ppkJlVO+mC+QR0SUjt5LMBMQz
         isUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Xu7D1/iifhAl89mciVhCgz8cwDykyyXroMOo4n3QiNI=;
        b=hgLk19XfWXiqYIxH5YH0Vbil+0mRPOSCMzUOV1Mgi9e/bFFhUzvx0gpXREQRiK73Y0
         rMH365OSqot03cjPKya8JFIw7QHSBM622RZCnQCh/drDlkJqxR3ODg+uB9P8K2HFqoZY
         uZ6QDNzhEcCIWBWQm8yEha5Ym2xVA1MPBiCrjZ19hE7XCLOkkiZqxnjjXQNjp7uxyyhp
         gfNlP4LiJWmxtnsjlq1wg7szA6a80O6sSbkeOyUVL9riDzNXoSlJRSi1XNk4Yzi+7ehq
         q8Stxe2/PLziumXj0qeUWJLaiYjelWgtzozQczVHItJH7DQy+cKWSGO3LjP5QBx033IE
         9jBA==
X-Gm-Message-State: AOAM532nanhSxO7i4JSJ87AeO294UXyrgZAzJCIiveQIyU2e0B53FWio
        DkO/wKhqp5B9hOxuFWeMoY1GH01ij/c=
X-Google-Smtp-Source: ABdhPJyeMrD+/60tg34yY/OHzyvVrTDWVcnOanWHEvtgdsRbzav6VkCs7tQCCMn9o5pgCAF8W8cNzw==
X-Received: by 2002:a63:cb0a:: with SMTP id p10mr8130707pgg.314.1602172061730;
        Thu, 08 Oct 2020 08:47:41 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id j12sm7776086pjd.36.2020.10.08.08.47.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Oct 2020 08:47:40 -0700 (PDT)
Date:   Thu, 8 Oct 2020 23:47:36 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, valentin.schneider@arm.com, raistlin@linux.it,
        iwtbavbm@gmail.com
Subject: [PATCH v6 0/2] sched/deadline: Fix and optimize
 sched_dl_global_validate()
Message-ID: <cover.1602171061.git.iwtbavbm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When change global rt bandwidth, we check to make sure that new
settings could accommodate the allocated dl bandwidth.

Under SMP, the dl_bw is on a per root domain basis, currently we check
and update the new settings one cpu by one cpu, but not in the unit of
root domain, which is either overdoing or error.

patch 1 removed the superfluous checking and updating
patch 2 fixed the error validation

For details, please see the corresponding patch.

----------------
v6 <-- v5:
 - no functional changes, just revert visit_gen back to u64;

v5 <-- v4:
 - no functional changes, just split the v4 single patch to two to
   obey the "one patch do only one thing" rule;
 - turn root_domain::visit_gen from u64 to u32;
   both suggested by Juri.
 - refine changelog;

v4 <-- v3:
 - refine changelog;
 - eliminate the ugly #ifdef guys with Peter's method;

v3 <-- v2:
 - fix build error for !CONFIG_SMP, reported by kernel test robot;

v2 <-- v1:
 - replace cpumask_weight(cpu_rq(cpu)->rd->span) with dl_bw_cpus(cpu),
   suggested by Juri;

Peng Liu (2):
  sched/deadline: Optimize sched_dl_global_validate()
  sched/deadline: Fix sched_dl_global_validate()

 kernel/sched/deadline.c | 44 +++++++++++++++++++++++++++--------
 kernel/sched/sched.h    | 51 ++++++++++++++++++++++-------------------
 kernel/sched/topology.c |  1 +
 3 files changed, 63 insertions(+), 33 deletions(-)

-- 
2.20.1

