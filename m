Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA6725DCFF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 17:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgIDPO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 11:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbgIDPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:14:53 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FA2C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:14:52 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o5so6549919qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=47tZzOOPU5OLzSSR8h+IPPDqm4bQH2Jhd8l+lyN/6do=;
        b=ne+MMC5ehTbyPTFu0b4/QJtZHJSHOwOFyoNA04zMV+QdNJ7MRDbKqocQ6PuSTEq//Z
         4SOO172pSbAMElslBAImMET5spGhsbAWbGv785iAv01gzR2gYmXijQVw5+i1zq8SPSfO
         /r6DhxyPqTcBK/aMnXL6ekuGAEVMRTxtxFkwAh7PlSRQbbO1LsSwl86C+HBNxPDC5NHe
         mJuHoZV/2w/hGkx+kTX1QwzT+yALNLPZabjolZsXy9dkIjhoM/jm7ndVBQogmSwPIMA3
         5DEz3AkceB3XrZWejyFg6IKCM1FvHf4aA2anhTsGkBbs2qWLS3bYxTo/kXR6kugc37wF
         DpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=47tZzOOPU5OLzSSR8h+IPPDqm4bQH2Jhd8l+lyN/6do=;
        b=rJSfXTpFzeGQj78kMzKFS/TQjfugDzzl3iW2pcs6BLv3IOuNUnM3qDWmgkiXjFBm+v
         BbszTswAB9EIVeW/kgdAb58TIq674g3b+Sa835Z9WL6dvoEdy+ZwC0iTvwZFXwFblSwp
         2YHcDfAhQzqcVblT1NS9VLJntWDc3Q37nWfi/BpTz9gaXaxyLRZTOuLEylCnj+/WMDC9
         3xaPRONguEIajxXVqJ4Y7Bi6GVl8XgohbM/rFNSPsJ3Ag7OM/eQdBKDfaKDTOgzZQSyq
         roACM10HZ0h0w0TtoT1MIwWuQ5u2DAKOBd4qVRZFfFzrShGdXsga6FA3mtH5G0Y5Xm81
         eZvw==
X-Gm-Message-State: AOAM530PARjdACjBS2b7vFSXYaWiPBrn7ZWy62pHRxG2MFwAbiMXVY0Z
        8MK0/tJqc7vxbWPjckECXJEevefHVPQnqw==
X-Google-Smtp-Source: ABdhPJxV5fmTSbh6jIcNEATYImcWw+yW8zoZ+XFXvxb3xoSNP7q4LtcAc8QLiTYoeJqtQfYTNoAOjw==
X-Received: by 2002:a37:67d2:: with SMTP id b201mr8239158qkc.96.1599232490598;
        Fri, 04 Sep 2020 08:14:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r21sm4802727qtj.80.2020.09.04.08.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:14:49 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, pasha.tatashin@soleen.com,
        osalvador@suse.de, richard.weiyang@gmail.com, david@redhat.com,
        vbabka@suse.cz, rientjes@google.com
Subject: [PATCH v3 0/2] drain pcp outside of page isolation
Date:   Fri,  4 Sep 2020 11:14:46 -0400
Message-Id: <20200904151448.100489-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moved drain_all_pages() from start_isolate_page_range() to users. This
makes it more efficient, symmetric, and solves the race condition.

This is a proposal that I described in Version 1 thread, otherwise no changes
to patch 1.

Version 1:
https://lore.kernel.org/lkml/20200901124615.137200-1-pasha.tatashin@soleen.com

Version 2:
https://lore.kernel.org/lkml/20200903140032.380431-1-pasha.tatashin@soleen.com

Pavel Tatashin (2):
  mm/memory_hotplug: drain per-cpu pages again during memory offline
  mm: drain per-cpu pages outside of isolate_migratepages_range

 mm/memory_hotplug.c |  1 +
 mm/page_alloc.c     |  2 ++
 mm/page_isolation.c | 32 ++++++++++++--------------------
 3 files changed, 15 insertions(+), 20 deletions(-)

-- 
2.25.1

