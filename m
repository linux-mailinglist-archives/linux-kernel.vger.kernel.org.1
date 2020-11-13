Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA852B25F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgKMUyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgKMUyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:54:10 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDCFC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:54:09 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 34so4796432pgp.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bk8vHF0tT8ztZ+U57073Ow5h2docyDMHtlyObudynDc=;
        b=ms/PIi/YnevYmcaWqTNDmJjkEPhUzUbCxQhpNU0UZI6cLSWomkqgY4xGptZN2YQNeb
         r5BCyKkFILhtli0Jy3XxXaV/vBRgm1IIVtWNWmdmfI0DWJlTZ/1v5MN/vCIF+3zQnKm2
         zOylaiLD+l/RVHOXqOpcDVYDHa76sL1mFxkAchXKiI+zygSitgwzpBK/gUKRjJjXyM0G
         3/nekSXSHvcOyniVS9yEQhJP0NRmiC4K/ZrpsfMu33imRMVzf69QEFVHxZouv5QSPz/4
         SediNe/hxUGddOMxAabMhJixJM+nLyyw6lftcmGGIBZJzXNaxXbXxZ99+29rQVuMw+IM
         9pGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bk8vHF0tT8ztZ+U57073Ow5h2docyDMHtlyObudynDc=;
        b=XuQlEZ7CHoKtEdYAaccjHWuXgKHHfISaVxn3s8Yc6Gw1cc4DdcT91IgiXgmrTELC2N
         bbNRmj9jWxDQ+NcVcHzgM0pQHWJkBDSWzAM0EHOwuePzk966f39vdVDu2J78dJ7CXC/0
         vxgfignTb80JaddU50KogfsylyKr+0rlTF1kA2q2OaBNcElHZkPa6OSvrktBW2j4TQAg
         AIcnJU8okNgdNtReTJ+oXLPwUuQglsU5F/WYkmvSr2C0BCF2VeUSDejvYM/s5iIcuSow
         ZR/V2ac3ZZ1aR6TTI/AmcXRZ7tCe4R3XcADlt7iK6dYwLi8czcUryDZCrgaIi1+BvbvB
         Gm1A==
X-Gm-Message-State: AOAM531gnDASztjWsT1/gRtY5k5lMics858f4M23yFH3XuFs+uz65Y68
        jc7pa2zOor890qfJNGp1WIs=
X-Google-Smtp-Source: ABdhPJxjDpTvty9BLWzy2k7Q1G1p5iejS5jG9y46a7aWnobReEgunlHIg4HvvL3R476cmTfOuHjriw==
X-Received: by 2002:a17:90a:a609:: with SMTP id c9mr4991124pjq.124.1605300849528;
        Fri, 13 Nov 2020 12:54:09 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id a18sm3780234pfa.151.2020.11.13.12.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 12:54:08 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 0/5] mm: misc migrate cleanup and improvement
Date:   Fri, 13 Nov 2020 12:53:54 -0800
Message-Id: <20201113205359.556831-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Some misc migrate code cleanup and improvement.

v3: * Incorporated the comments from Willy

v2: * Fixed the comments from Zi Yan
    * Collected Reviewed-by


Yang Shi (5):
      mm: truncate_complete_page is not existed anymore
      mm: migrate: simplify the logic for handling permanent failure
      mm: migrate: skip shared exec THP for NUMA balancing
      mm: migrate: clean up migrate_prep{_local}
      mm: migrate: return -ENOSYS if THP migration is unsupported

 include/linux/migrate.h |   4 +--
 mm/mempolicy.c          |   8 ++---
 mm/migrate.c            | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
 mm/vmscan.c             |   2 +-
 4 files changed, 108 insertions(+), 64 deletions(-)

