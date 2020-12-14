Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F842D9D60
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408393AbgLNRPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502097AbgLNRIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:08:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26233C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=b7V9C5rYB2gK5xFWJZfpw2tKiubulRuOf3rkkopOWBo=; b=gQVGd/fyl532SO0TyBJPTSgccz
        dNduGGgCcoueu0HviYZUiraqFE9y9LknY4CfiVQlKZL7E1JsqZ7GyAmuuosyuOS/MjTc//CDtBKL0
        2LjLbbvMr03TEicWt3iwKWPvg4PODaU4o3d2Hkg/VkCMnKrjzOznGV/6jTG5ff8TAqc20mg8uz788
        paEKMNVWq0o1/ITV9UB+o2B31TH8RJ98Day1uomriiMrdjrQtMIyR9so/V3a/KLcfOvcd71YocRmQ
        qwOiYGiaATffGMvisWqGsH983KYw94JkxV2eZZs1DMhYT6Iea2K3zPlT4wihzCY7d2K6PGXuDO0fF
        k/55IzRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1korJS-0000iD-Qc; Mon, 14 Dec 2020 17:07:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 99A6E305C11;
        Mon, 14 Dec 2020 18:07:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6224E235BB0B0; Mon, 14 Dec 2020 18:07:04 +0100 (CET)
Message-ID: <20201214164822.402812729@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Dec 2020 17:48:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mgorman@techsingularity.net, vincent.guittot@linaro.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        aubrey.li@linux.intel.com, mingo@redhat.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, benbjiang@gmail.com
Subject: [RFC][PATCH 0/5] select_idle_sibling() wreckage
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hai, here them patches Mel asked for. They've not (yet) been through the
robots, so there might be some build fail for configs I've not used.

Benchmark time :-)

---
 include/linux/sched/topology.h |    1
 kernel/sched/core.c            |   19 +++-
 kernel/sched/fair.c            |  171 +++++++++++------------------------------
 kernel/sched/idle.c            |    1
 kernel/sched/sched.h           |   13 ---
 5 files changed, 63 insertions(+), 142 deletions(-)

