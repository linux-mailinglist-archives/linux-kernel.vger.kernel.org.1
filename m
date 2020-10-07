Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A49F2861D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgJGPLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgJGPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:11:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AB2C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 08:11:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c6so1143290plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=l+RYEMLdNk0/QYSwVGZ6nGTKatNypM/9is1rBGsG+GI=;
        b=szM93K/4UhSnf2FXhvO0Zhr0eHqq2qQWmYIW6DEUn8D1ZUlKyMQXeCVKtz1Z0e3T0p
         GdSrR5OsFVto9A8ROydPqJ+CsdC0opVHnm/5X+D0LY16wMoU/9hjugjqaSczbAlvjGFr
         eMqQKgVhnyqKEBDx6ddXlPHHi8TPTqmgZipo05li2NyJa9jq2cJAeUeCVmgL2d7RgqpV
         IEr8DhHau7pXcVoSlghUf50NxQwgtkC/IDqbVi+uaRzl2ZKQDvv10+4Ii//pHstGfow5
         cVIM2avqA1YSEo3OX5UR1ZGo6lN7eDJYtjdwU2bW5hrMvJTfMbT33OhE2k8CHuf+Wfpl
         Wk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=l+RYEMLdNk0/QYSwVGZ6nGTKatNypM/9is1rBGsG+GI=;
        b=ZjoloA5RTpp3C0Z78IR0oKbHUEC2DEvAly02QRYFzKYmYF8yLnTvRKrlRK7cGHC+hy
         D/K3gn9LDGwkbuVZ6a6ItNXmw6FOv7leETwCZTWWmAaF5Y+bv8yIzi9tvKuUYlP3r0um
         GmJHq1v4cC4Exm7UsXZ0P0C85MunuLzBcfa5Ge1/5owUNuaE9jpNWaeOIqgt8XUdeNAs
         h1NhEQ6WKuNJ2dobKET4azylf2gr6kK+op0ulojz84GcSsbFMeWewAgasI1yw5L8/zW+
         OvSqvVcCWE96H87WR+zhifSdKII3182eeP16iU6TIocYbEQGsq4syyhjmacFGvHvLnxU
         fXqQ==
X-Gm-Message-State: AOAM530P6Vxivyot6QPqzRDO2qA1tNzpZO4QR289ZBklkFwIVtEsYUrY
        jtpiZ+rJ64vyEUdAB+Glxkq7z811my8=
X-Google-Smtp-Source: ABdhPJxb2RTofFM1GGgzh6dr/HUxCn67Xl0eukzM9TgKD6BmR79A0EeLfGpIa0cFhT5s+du+E7wrlQ==
X-Received: by 2002:a17:902:7d8d:b029:d3:95b9:68ed with SMTP id a13-20020a1709027d8db02900d395b968edmr3293214plm.28.1602083488357;
        Wed, 07 Oct 2020 08:11:28 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id u18sm3890053pgk.18.2020.10.07.08.11.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Oct 2020 08:11:27 -0700 (PDT)
Date:   Wed, 7 Oct 2020 23:11:23 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, valentin.schneider@arm.com, raistlin@linux.it,
        iwtbavbm@gmail.com
Subject: [PATCH v5 0/2] sched/deadline: Fix and optimize
 sched_dl_global_validate()
Message-ID: <cover.1601993091.git.iwtbavbm@gmail.com>
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
  sched/deadline: optimize sched_dl_global_validate()
  sched/deadline: Fix sched_dl_global_validate()

 kernel/sched/deadline.c | 46 +++++++++++++++++++++++++++++---------
 kernel/sched/sched.h    | 49 +++++++++++++++++++++--------------------
 kernel/sched/topology.c |  1 +
 3 files changed, 62 insertions(+), 34 deletions(-)

-- 
2.20.1

