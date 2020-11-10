Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673D02ADF1E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgKJTMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:12:23 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7F0C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:12:21 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i26so11073893pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :organisation:user-agent;
        bh=7uvN+JUhe0Ly83KsJpNf32fXXbxwaleyLczJ8RRKDnA=;
        b=E0aSgu+Kal2uzsw3M+46aGrpFPmhimyWmCqfITI3h8c3QYItYUP+SNSAobDHwZdEwC
         QcdXuhRaZoGkHfUS0p+LPnzWeoe82XO1ZWj8g76+nZwWwYlOY3f5fdRDSVWTfPB4f14w
         phLYzEpolT0nk2+0Z/33jRZACT4EIbnNK9ne8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:organisation:user-agent;
        bh=7uvN+JUhe0Ly83KsJpNf32fXXbxwaleyLczJ8RRKDnA=;
        b=G6YuEaeb6ag4U/D0HzvuuORs04d/d7QhMl/bZlPQ+MpviRl43y/rT6W/VkEGiLN7Ot
         E0eOBPTKF8HulUIEg4tefZSP+ROJLRRZ+zgP4QwcGCXXeAYAAeTqyK5AEh/Uktx4qhqP
         L8plodhiGWzHV7OqYSjJg4y+hffTU0576zBMEQeM1Kc7DMR3ATuPxM5ep9fJRQhKvy+v
         8YSUtALfuPGAKWWRxXq/FU8YRf0aiMqGE3eWyvZ0r/niXzneKr1oDrJxztnAyANfYU5S
         NJMszeOrUi1nl0+8Qyk3lNRB4+NXYsMqk3Pu4R7ZVJUZi5KIREkmRs22EhrqQZLtOBNa
         256g==
X-Gm-Message-State: AOAM532Z7H8JOvlgrfPfLaQJA1A7cdQCS6pSkR7AmNM5FoE7bv0BXJ4c
        8ETeAySEYIZxD67OSZy1U5MoXyxQepaE2w==
X-Google-Smtp-Source: ABdhPJyxYd/LmfpgckDuUMTPYuXw8xeQz8UVAbHDmPmMvSbm9UVAaPYp1BSNR9jLGYGh3GF0vZgtQQ==
X-Received: by 2002:a17:90b:3789:: with SMTP id mz9mr596067pjb.123.1605035541339;
        Tue, 10 Nov 2020 11:12:21 -0800 (PST)
Received: from mariadb.com (173-160-235-21-Washington.hfc.comcastbusiness.net. [173.160.235.21])
        by smtp.gmail.com with ESMTPSA id h13sm2995101pjj.30.2020.11.10.11.12.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 11:12:20 -0800 (PST)
Date:   Tue, 10 Nov 2020 11:12:18 -0800
From:   Sidney Cammeresi <sac@mariadb.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] fix incorrect comment in kernel/sched/rt.c
Message-ID: <cover.1605034896.git.sac@cheesecake.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: MariaDB Corporation Ab
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was reading rt.c and was looking at the code pertaining to allowing a
non-migratable task to preempt a migratable task of the same priority.
It appears to me that one of the comments describing when this will
happen is wrong.

It appears that preemption will only happen when the task is *not* about
to be otherwise preempted.  The comment appears to describe an older
version of the code, in which preemption would happen when the task *was*
about to be preempted, the opposite condition.

Sidney Cammeresi (1):
  sched/rt: fix incorrect comment about non-migratable tasks' priority

 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4


-- 
Sidney Cammeresi
Staff Software Engineer, MariaDB Corporation Ab
