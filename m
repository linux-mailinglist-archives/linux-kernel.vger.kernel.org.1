Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934D02705C9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIRTsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIRTsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:48:39 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26710C0613CE;
        Fri, 18 Sep 2020 12:48:39 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a22so5983292ljp.13;
        Fri, 18 Sep 2020 12:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGRBhoEIYM+I62uhtkzSGBAX+5us/YHtB+9Vgg1zTtY=;
        b=nqW26T8OmNe5+E2dLewM6NhPfcOBIFPhxmshxeaPCd3/CNcEzUwyciqvYOimc4nCWZ
         d6ahQ6xO9c03qe4fnvRVpFbGe3BbO1F1IHkhs2HizzY1bNziXGzJsPgkJuMLsmHp7bER
         +BBGfCAMJKqezojoPek2mjW4+mNscce+qsljzbS+zhN3rZxZuCpll8pE+/SZoUXjyFv8
         1e41FNCJ5E+DyfiQ78Zf/NKrs9oSsjn0tqD+aAW+GFem3xNt73k94D7Rwdv6hTFW/t8V
         iEfTfleACAerSnWZOqjud72CkZnzAffr45ahnqzqWLSxtoDTEiB4TKyjLspPkgh4uTQ5
         LT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGRBhoEIYM+I62uhtkzSGBAX+5us/YHtB+9Vgg1zTtY=;
        b=Qzz9KXjpq93RRi/PMYF0mVQigA7KTmZ6bw4ZAmytJON3pgfgJ6N7rNeD3NY1+RqtHg
         u7fng0tUltwIsplDWcIv5K1BtDeJiL3j5RbVtV4fXMHFm8kgKMsWQoJmknf+fTSEPQ0X
         VWeNw1KD6Wv1xHce/iDEkcAbyYHwAeDxPq0fmoM3jW9wbLQq+YRBxq9D8Tu+d+cGFrZr
         DgmgSTHsI6VLNwW+OP8niSitlr6xUOKbglwDi8qEk9n+NnXETS90Bzsfi0ktQjOVeV2K
         AskzMLDP/HkW4ziQZLdf6ah1Z09ZkL+TFqD+JH1q/wxoD+b45Je2yzPoUZTtqq/yu3Nd
         8Xvg==
X-Gm-Message-State: AOAM530EOLmeNPIpC56TZ74sbCBIYVOuadw5jy2OYrQROrpSlWzVHdAU
        zYIyd3JxhvwvNtnkG8354di1eJHo66fjQ378
X-Google-Smtp-Source: ABdhPJyn9sqZurK+0ib9MIFAesyL3MylhyXr116ZbhuJNj3ywoGWgVAqgvt4drq460J31feLyaJP+w==
X-Received: by 2002:a2e:b6cd:: with SMTP id m13mr13092130ljo.383.1600458517144;
        Fri, 18 Sep 2020 12:48:37 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a17sm766769lfd.148.2020.09.18.12.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 12:48:36 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 0/4] kvfree_rcu() and _LOCK_NESTING/_PREEMPT_RT 
Date:   Fri, 18 Sep 2020 21:48:13 +0200
Message-Id: <20200918194817.48921-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, folk!

This is another iteration of fixing kvfree_rcu() issues related
to CONFIG_PROVE_RAW_LOCK_NESTING and CONFIG_PREEMPT_RT configs.

The first discussion is here https://lkml.org/lkml/2020/8/9/195.

- As an outcome of it, there was a proposal from Peter, instead of
using a speciall "lock-less" flag it is better to move lock-less
access to the pcplist to the separate function.

- To add a special worker thread that does prefetching of pages
if a per-cpu page cache is depleted(what is absolutely normal). 

As usual, thank you for paying attention to it and your help!

Uladzislau Rezki (Sony) (4):
  rcu/tree: Add a work to allocate pages from regular context
  mm: Add __rcu_alloc_page_lockless() func.
  rcu/tree: use __rcu_alloc_page_lockless() func.
  rcu/tree: Use schedule_delayed_work() instead of WQ_HIGHPRI queue

 include/linux/gfp.h |  1 +
 kernel/rcu/tree.c   | 90 ++++++++++++++++++++++++---------------------
 mm/page_alloc.c     | 82 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 41 deletions(-)

-- 
2.20.1

