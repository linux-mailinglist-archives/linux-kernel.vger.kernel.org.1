Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E22E2C9004
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbgK3V0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388536AbgK3V0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:26:41 -0500
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6526BC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:25:55 -0800 (PST)
Received: by mail-vs1-xe4a.google.com with SMTP id f23so3185883vsh.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=1AhVkXOhR2TzNH+ZXV3TQQWYQmTiMRd6bP6O/1CZpuM=;
        b=hdS37evH95STMC1FCXnH1rBusR8KNThCfQdU2yBgD6GdnQjNNiCBi71dut6kQSKJ76
         IqLNiSE192eFpj/ZYUc07be3aeNRSHl79g+TcTAUjv5p9B6HGlQiE/g3Zss55/nnwq7y
         sIfyDFLze4P7utdf4xAvLq2y+WHmeGa8diXx2764WsYXzn6KGIHByMq7CSl6humc2Rpb
         q/X72Se9LnYtSjo6/h6KrnxKPqz2UmxQbxFzewJUQvUKU83jQq42tL2W1dm0M8wiT/hV
         zCvdjj3p9ELE8zlHKWVIqy9BT3t4FnbItx4+BvVPAFqeDluVaS7QgFHXqAzD2utvhwd7
         CnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=1AhVkXOhR2TzNH+ZXV3TQQWYQmTiMRd6bP6O/1CZpuM=;
        b=lJLR9ilvvKLBedoZYtyUjCph6SJ7FAJLCUehSVTL6yJBI6pmBb50SsNrSeP/dIBu3p
         oO/MIvFV+TMwVPV3sJF2zfdXcwdxaVAFfBUfMVetqfcnAYGv6by97JJobVaV0oovZf7k
         cfrjzY0ThvwbYLQ0ccCQ3hWyDSkfjcqe+vi5EnMbSWdKPFHn1ZqbYFal3GAowEfO2PmI
         OlpCfXpc0F0kEZVTxfslslhKINH2MTSjKq6Q32jYMWPMS+ezIMfrCNGq2ahamG6heXJD
         8ehlmy4HiuPDNGV6hPiqrTqvvT+Gl1N841k9ggz23vChoBuzOC8vhZKDAsjDx8OB0c69
         bhog==
X-Gm-Message-State: AOAM532B0H4JSH2IfzCGS6qW6SdVB+z+zrixcho1XU4Uj80Zl6MKh/Cd
        /Q8zkedwDn3uj8Tfq/uvagY2JhbpdkSM4Q==
X-Google-Smtp-Source: ABdhPJyqzEUpeoSQftF1IG3b5nCuc1YiEIetXPA/6CAkF3P/VKxbwRspiFP04boyFI4A8ChM97hwhIHywIdnOQ==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:a67:fad2:: with SMTP id g18mr18303835vsq.45.1606771554436;
 Mon, 30 Nov 2020 13:25:54 -0800 (PST)
Date:   Mon, 30 Nov 2020 13:25:39 -0800
Message-Id: <20201130212541.2781790-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 0/2] memcg: add pagetable comsumption to memory.stat
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many workloads consumes significant amount of memory in pagetables. One
specific use-case is the user space network driver which mmaps the
application memory to provide zero copy transfer. This driver can
consume a large amount memory in page tables. This patch series exposes
the pagetable comsumption for each memory cgroup.

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

