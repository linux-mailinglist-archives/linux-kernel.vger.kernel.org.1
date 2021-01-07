Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB8F2ECDEA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbhAGKe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbhAGKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:34:25 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667B2C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:33:30 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n16so4640646wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=asSp+/DMMwMJalGof8YNSkFl2LZ/5ABaWHsM4v5Eee4=;
        b=eGGPTq1zC5RABYdfNZUVRLL34O38mU3eA51DiYmqH9S1zUvcaaBgkUdUlWTJUUv8Qt
         WqkBpDIKZHYSWYezARw1epikqrlAS38Q1ResheSeYIbtDIfq4d75lC7NBe0yruM9BQoo
         QfUwjbvwtll/d2xXJO7NKxx9Wtnnch4EN+QwhD25Q9GSspTASqSQoqiLkJ3Hx+5JXRYG
         yOZW1XgXQ/OqLoAqVtUfYI13iNlEvhS3mTKd63r2hNWeCrtGX/V2ibE4Z6jZfvPS+ZmY
         h0MBoypdNlREp6S79zXKNlPm5EBennamwNk72wyeYsNcz/VoPb/UPvI3PP/M1r24vv1E
         PpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=asSp+/DMMwMJalGof8YNSkFl2LZ/5ABaWHsM4v5Eee4=;
        b=JwWfj06qcZfSrL4hK45mGbK8WQXPUoSuIevpPk+I/Ys8EKNBzDPZ2a/Q7eW4tAB6bY
         qT99MIqQHvi3tUkXuPEZgd/5q1/EyzniGBVIHhf6S3qAFdlHva8W2KGy81A7DgAXDWSF
         da6IcCJPgCNS5nDmDm0hGSwOgAl+UM+wG1vRsARNZSZvZsBDj7K7QBPOuv0hECbmGwDP
         L6oL5dL/VYemyjI4lDfvLDGBRBBZG7/cLlo+I3iPi8T6VVRaK09jdK+IUAxgeSBRKOBf
         QKi4mF6j/SFYmpkqNXnDKd0L4BaM/KEKMFHkG9WVKa9DNk9667vNOXdc+yKVQnn2svKo
         1MkQ==
X-Gm-Message-State: AOAM532uwKiZo8LHJTAPIiwCBGU+uitLAVJuKFkbhR2HbMV3qH16JC8C
        OYCUOenk3813iQmAVupoYtc5Wg==
X-Google-Smtp-Source: ABdhPJwNzqUQA0X76hwH99DGsSWfxXvzt7Gmaw2wSrEyziUIiQgk81Rtz6Cgk8U5dnkJ6+0FzbHajw==
X-Received: by 2002:a1c:6a02:: with SMTP id f2mr7665360wmc.36.1610015609059;
        Thu, 07 Jan 2021 02:33:29 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d7b:24c9:55f9:4b75])
        by smtp.gmail.com with ESMTPSA id i9sm7734120wrs.70.2021.01.07.02.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:33:27 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/3 v2] Reduce number of active LB
Date:   Thu,  7 Jan 2021 11:33:22 +0100
Message-Id: <20210107103325.30851-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few improvements related to active LB and the increase of LB interval.
I haven't seen any performcne impact on various benchmarks except for 
  -stress-ng mmapfork : +4.54% on my octo-core arm64
But this was somewhat expected as the changes impact mainly corner cases.

Changes since v1:
- patch 2: change how LBF_ALL_PINNED is managed as proposed by Valentin
- patch 3: updated comment and fix typos
  
Vincent Guittot (3):
  sched/fair: skip idle cfs_rq
  sched/fair: don't set LBF_ALL_PINNED unnecessarily
  sched/fair: reduce cases for active balance

 kernel/sched/fair.c | 57 +++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

-- 
2.17.1

