Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA5520CB10
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 01:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgF1XZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 19:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgF1XZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 19:25:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A040BC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 16:25:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so14775867wrn.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 16:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jd1oUmsw7qGCe3zJwrNPzneUBgaH8UuHmFFNjsoAHY0=;
        b=LW+eWHBjgnEzf/Eah3WfMdCn2VBm3OJGM065dQQy6sCLWEz2TsfHS0jyHoMFImJ3YO
         bGTbsN2Tr2KxeeeR204Ead+lzWU+dknUaJLQFozWBM8DCfRBg5BWyMoH3yMnfPFrk53R
         UEqHoqY8qRwzxTTWLuz0g9cEcpqxWklftuTFvil6e1IGy2WDsxQ5ch7g6MTFtDR+iWhe
         +fQErPkNefS+CNqZdud8dVKSr0wm7sXZ35TaTYmI1kgozntbAKbyQZCBcDuu5bRnO5IY
         RClhFPRpyDVcpoWlw4583qM26e6IjZZ4Pw+cNArual+o5LdfNQo6JfcqcBSjxEjrb+Lv
         Y9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jd1oUmsw7qGCe3zJwrNPzneUBgaH8UuHmFFNjsoAHY0=;
        b=gD2XOYgiJGZw9Y2vPzlf5vqPmgvaCjJBmU7T2cIXsWpJ8M37KD4PmpYRNiQ6PfRPay
         sVVixzAXjoKzkxkZWl2f5yxeI0PbqK14H1ds9dGgdNBcFz/bk4zpKYq7EoNafCGNsqCS
         EuBZbQDVh5hQb9Y/t3306IJ2xX7MVO6Pjok6pekges2+7xHIh3xShH56QydKOijvGxmp
         nKghAsADpa+mRUVJEKSCgs6ws8gjqUtlLe+cxWWszLEeiTy0Tqog4i36G8l5KsA5nl7T
         4s5yMYhZ6vEjabZPqlLwOKSTowz1cMvnPeQPUWFPl4pgg73LL/LsD+HnNsRGh+rJoSTi
         MvYw==
X-Gm-Message-State: AOAM533C6QsSEYyUbVz1etRJAtbhZhzxE3NDBz34Yr5Cy3K6NvaMtF4w
        ayhEp6+xXBo3O5bzECjwX9ofHjti6ndBiQ==
X-Google-Smtp-Source: ABdhPJy568Qsqwbuz5bYN8jJIlSqACcEZ5H3bie51V4NfXH8jak3sDol1z7frPBfJRgt9n8qQBMIHg==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr15301110wrn.179.1593386744663;
        Sun, 28 Jun 2020 16:25:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:d870:1c00:d905:af8f:383:7f91])
        by smtp.gmail.com with ESMTPSA id n8sm43396497wrj.44.2020.06.28.16.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 16:25:44 -0700 (PDT)
From:   Emmanouil Maroudas <emmanouil.maroudas@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Emmanouil Maroudas <emmanouil.maroudas@gmail.com>
Subject: [PATCH 0/2] perf tools: minor fixes regarding macro usage
Date:   Mon, 29 Jun 2020 02:25:19 +0300
Message-Id: <20200628232521.22686-1-emmanouil.maroudas@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello,

    Here are some minor fixes for perf tools regarding *SEC_PER*SEC macro usage,
    found while reading the code.

    Patch 1 replaces a macro with a more suitable one (same value, different name).
    Patch 2 converts some hardcoded values (which seem appropriate IMHO) with their
    respective macros.

    Based on v5.8-rc3.

    No functionality change. The final perf binary is the same, before and after
    these patches.

    Thanks,
    Emmanouil Maroudas

Emmanouil Maroudas (2):
  perf stat: use proper macro for time conversions
  perf tools: use *SEC_PER_*SEC macros

 tools/perf/builtin-record.c |  2 +-
 tools/perf/builtin-stat.c   | 12 ++++++------
 tools/perf/builtin-trace.c  |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.17.1

