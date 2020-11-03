Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4D02A8864
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbgKEUxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEUxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:53:41 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBE5C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 12:53:41 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 72so2276804pfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glxnw0G7mxkHwrXWKFo1FuZeLsueNuAwrkAI5cvobhs=;
        b=KDgDPHLCwQNjq5ZevQXlPQyPpemkdsQuLbYTPNaG/g2JQkTMTSKuf8dBXtgLXmtg6E
         pTn+g84r/p2ezItTwPsXkOC7cnygQfyQHNhWcFkWCr3Gdu61XTW46uFVpmesvrXQb2Lc
         VgWwP1v7Irp/RBZlm5IS7yP066DSUkT+RazNa8AL4vDf/ndVHqLK7m8fMpx4VO8QxDtc
         Wb4vl4CPL5WAtqJAf04E1nX7MeVMIzi/WDQ0IcTo81AJgmlhSbdisZKTwT0vT4V1hHkF
         CAsK1PiOGuK3wgI0678kaE2DLjQecdLPB87g9LxzJc+vydmqW70Br5Kmij0jJFBS7Ikv
         CAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glxnw0G7mxkHwrXWKFo1FuZeLsueNuAwrkAI5cvobhs=;
        b=Gc3UiKIDD0T7BQ8YwH+t0xbrFg/W9O0VmXa6f7SlevC9KAwVrBJX2Ob7dQl7EaLD8e
         dWJwlSKjvVPr4z9vP/dF1V81SD4AwLVGSCHuYj6BEPy4icBEz+UVttwPdlmdMYVFUFJS
         R6ZdRF3qQrkc1LkVPAmoU8JINbKUL7su/aIoJyVTdQcpMhUmzhhOt3ktJ8qEPyi98TJH
         uXW81zHLQyUvLFw9VBtE+Swh5a85q4h3lB7JkpO9IrCDkMSDOIO5AaZ4yBhEIjhHqWkM
         fhDGpZLa5qML8kWssaJc76z5ZnJ9RJDqSwLzGWGjwWe+OyrP8XsytLoW+dqi58M0hQts
         URBQ==
X-Gm-Message-State: AOAM5316N04j3wW3tm0sb88EZdN6sxcwD8BJSyhJzBgDLi7kJvwUscl8
        89bnktShFUrqDltrM58d/RM=
X-Google-Smtp-Source: ABdhPJyhAkapNdkpklhp3VVPTNJjZxbq2eyxfS+sTZd+MNej0Btgyt5rp0RM8Y8rT9MnkqSvAoiaDg==
X-Received: by 2002:a17:90b:496:: with SMTP id bh22mr4354896pjb.120.1604609621292;
        Thu, 05 Nov 2020 12:53:41 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id u22sm3265528pgf.24.2020.11.05.12.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 12:53:39 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] mm: misc migrate cleanup and improvement
Date:   Tue,  3 Nov 2020 05:03:29 -0800
Message-Id: <20201103130334.13468-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Some misc migrate code cleanup and improvement.

Yang Shi (5):
      mm: truncate_complete_page is not existed anymore
      mm: migrate: simplify the logic for handling permanent failure
      mm: migrate: skip shared exec THP for NUMA balancing
      mm: migrate: clean up migrate_prep{_local}
      mm: migrate: return -ENOSYS if THP migration is unsupported

 include/linux/migrate.h |   4 +--
 mm/mempolicy.c          |   8 ++----
 mm/migrate.c            | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
 mm/vmscan.c             |   2 +-
 4 files changed, 99 insertions(+), 63 deletions(-)

