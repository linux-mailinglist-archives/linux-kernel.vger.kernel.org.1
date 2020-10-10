Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C95C28A287
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390545AbgJJW5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbgJJTvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:51:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8507BC0613DE
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 02:37:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e7so2484pfn.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 02:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uY6vICbjDw3/Nue8pip9A8mVoEd17wpGPbuSUfwpgAU=;
        b=ZExhGn5E7TXEAkrOuICsp54Kn74Ct9cwsfd90HFmv+XN2tQ942iV3ILHBfOgo08WlT
         ZoWJnvomag6+gHkPcheBZq5Y9Ejh62rC8TuDG5Dj/iD0wEvxoNuVNyNlnAyEb6JK23z6
         CKXSW6YBgYNkxycXtKeQPWhTn7zYA1XMV7Hi+yme7WdIY+mEFE5G4CorQZcGVsNpWNEg
         UJr7cgxW7hHfgrH87WpxmuWPhJs45PfR4AJsLlWLG8bHsrpEIwb6VtJr+xUTeZg3n2LA
         7MScPliDIpMr8goqp62304++kV062l+BRt469hSNLwqb4Q1mXDZxOVJJ2hz76ebmsgU4
         akqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uY6vICbjDw3/Nue8pip9A8mVoEd17wpGPbuSUfwpgAU=;
        b=j28denXNLJ4aCNW1W88GygkI38wJyEukrsV9sz5qtukVhmKQJp4GHl7HZT+mb77B6Y
         ZiyLNQ53ygkFVJA1aSt7J0Sch0B/WzNRGSQuqgraoYNBYj2Ld+4vOXy5QIm+9oJBKolI
         x+pB3Rb6IaM1HZU0s3L9uIbJtIlVYjpOfx9TRvB6vf2o6c5cN/JTPbCHCgMSnzvWf6dE
         L9cu+NubhkYVRXc3mfdY80tA/AWkJ3v9pfYr7MyjFGWwgNPsLxtY4gTv4oCPFHVTZglX
         yS+WsgzNHdjUwMV2JX2p84ffqR0lTKDwurX97BRUzApC14Vxiwuuf3PtJHoEZSrlm4Yt
         bkRg==
X-Gm-Message-State: AOAM5304AQmLC1a+AUmpWmtADptBfKKrv7rDmizAbbbU+2E5d7JpQIue
        H87FJqBq68FkccRS2iPzBF1HIGmm/dHWz3ED
X-Google-Smtp-Source: ABdhPJyytESe/AHRO3S9jwTuCwjstQ6JjoCgGo3kxsZX9PXWwayWGDrEuzzbG6UuArzf20PBChrRiA==
X-Received: by 2002:a62:1851:0:b029:154:8ed7:bf5d with SMTP id 78-20020a6218510000b02901548ed7bf5dmr15732802pfy.66.1602322657935;
        Sat, 10 Oct 2020 02:37:37 -0700 (PDT)
Received: from Zs-MacBook-Pro.local.net ([103.136.220.68])
        by smtp.gmail.com with ESMTPSA id d128sm13793124pfd.94.2020.10.10.02.37.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Oct 2020 02:37:37 -0700 (PDT)
From:   zangchunxin@bytedance.com
To:     corbet@lwn.net
Cc:     andre.azevedo@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chunxin Zang <zangchunxin@bytedance.com>
Subject: [PATCH] Documentation/scheduler: Modify the description of sched-stats column 9
Date:   Sat, 10 Oct 2020 17:37:30 +0800
Message-Id: <20201010093730.28567-1-zangchunxin@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunxin Zang <zangchunxin@bytedance.com>

The column 9 get datas from sched_info->pcount. It's update
when context_switch only. So it meaning 'times' not 'timeslices'.

Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
---
 Documentation/scheduler/sched-stats.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
index dd9b99a025f7..5fd17a85e7fd 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -59,7 +59,7 @@ Next three are statistics describing scheduling latency:
      7) sum of all time spent running by tasks on this processor (in jiffies)
      8) sum of all time spent waiting to run by tasks on this processor (in
         jiffies)
-     9) # of timeslices run on this cpu
+     9) # of times task hits this cpu
 
 
 Domain statistics
-- 
2.11.0

