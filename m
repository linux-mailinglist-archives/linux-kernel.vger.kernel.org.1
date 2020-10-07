Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4558B2856EC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgJGDQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgJGDQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:16:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B07EC0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 20:16:51 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b26so531897pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 20:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nHndZKwwfOOj5bwaqodAdSawGiEECEuWU/h1JxfIjE=;
        b=tAplSRDrpqc0bLhzdVINXo66tsmyG4077hKzUat22H5dF7Vj//0RV7AArxOdQoESc2
         Pc1oXj5o1aBDxEsXhyFT5DUjos3yqJdciaIWy9R7gRRGZ3bi//gyke/tUgu5dAYfEGni
         xfH9eipKOHyy0sVf76ROJzb0besS5j3UyYOzr1UUM/kkUuaSuETXstNK3e9bku88JvMc
         pOa/pbNOepvAIcA7Zij2sTe3d08qjaUHOpnkXnWpGeghOWKktvhXZd66o5IYI9tTjAwz
         rHyMxgYjLvQvepUW0rMgxFRZtwjga7DYckXPZg367rZiMg3h3mDNWFMIR0AlwCDy5lzx
         UMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nHndZKwwfOOj5bwaqodAdSawGiEECEuWU/h1JxfIjE=;
        b=H0Jc59f7ZS/j3OO1D+oiGu/7fAGKS8RGYSlDcQBh7mFS3zvwvL0RwTQMsP2sqWVcca
         8IKWKgUZdPXlcOMe5jrI5bLf6o991Mmy2AuI819sRgKvr9m3WD2BSfHNbfs0cq13M8Uf
         9mb1wi9FwJLVe109Wo+uxgwKt3TNxuIEpp7Fv09/fuXnCXYp4ES/S0zd3BrXJtKFk5wM
         tolbHnzhL4ORkjfxUlkd2F1dOxY0HRAOXPB51gQQEjwEKgA6nz4zhBZCYOE7zoJkeF5D
         odkNLtNqc5/asayThZBgfiHA6GZbRN5AG1e+VjG4pFXoqsiTHI/O2p3y44OOgnT7YHiq
         E3ow==
X-Gm-Message-State: AOAM533YaX0iMFnUA0G6o2TCEc5T48O8rrRYuHtMOn+dauwk7r+t6JXR
        nWFgcfEfVmXg+fOwQLcfflCa9w==
X-Google-Smtp-Source: ABdhPJxjUqK0ytYdUt6Nfja9Covk8gWR2hTabrYqA/cE6OV7oT6XN3O0+nt+zWZnwe+FrHvxZ3gc9A==
X-Received: by 2002:a63:705c:: with SMTP id a28mr1165305pgn.266.1602040610841;
        Tue, 06 Oct 2020 20:16:50 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id e1sm729094pfd.198.2020.10.06.20.16.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 20:16:50 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/4] io_uring: Fix async workqueue is not canceled on some corner case
Date:   Wed,  7 Oct 2020 11:16:31 +0800
Message-Id: <20201007031635.65295-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should make sure that async workqueue is canceled on exit, but on
some corner case, we found that the async workqueue is not canceled
on exit in the linux-5.4. So we started an in-depth investigation.
Fortunately, we finally found the problem. The commit:

  1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")

did not completely solve this problem. This patch series to solve this
problem completely. And there's no upstream variant of this commit, so
this patch series is just fix the linux-5.4.y stable branch.

changelog in v3:
  1. Merge patch-4 to patch-1.

changelog in v2:
  1. Fix missing save the current thread files
  2. Fix double list add in io_queue_async_work()

Muchun Song (4):
  io_uring: Fix missing smp_mb() in io_cancel_async_work()
  io_uring: Fix remove irrelevant req from the task_list
  io_uring: Fix missing save the current thread files
  io_uring: Fix double list add in io_queue_async_work()

Yinyin Zhu (1):
  io_uring: Fix resource leaking when kill the process

 fs/io_uring.c | 59 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 20 deletions(-)

-- 
2.11.0

