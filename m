Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13992EE6D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbhAGU1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbhAGU1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:27:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD74BC0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 12:26:20 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y8so4186263plp.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U9M2e+GyD9N3kdkTu1dWZpMp+TAsO6qz5jF42PL+fHo=;
        b=PdcvmPrsZTt84GZCS+kSt2fsYPUuWBnUZ6TgSGrzQm7LMI06dViN+9q1BlvX3wKwvy
         1wk7rj1JVz438UvHsZkQev7kMal1vDAykDsfxC7na5m4/YFebvq9SSUKtS9Y0YF4N/OF
         whDN3W5ZGFo6U3kffrK2ffFmsDsrro0IYJE2cc7EPQDaGOrY7OAee/+wtZPbpDlgGgAL
         r8gQLptYjvGMrb7QH8D/qwA29QjZF6SuWybgWBfUtX3P53vcbGm0db0nba5hWgQ888ZK
         n+32dBm5G6GBN1TV8lD0c2epBxo233wXHEb1OEUoqkyDzv+UgJ+vMhEXBEPVTXNetmQA
         x0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U9M2e+GyD9N3kdkTu1dWZpMp+TAsO6qz5jF42PL+fHo=;
        b=NIX1wB6ZWJIpD8i/ySR0Eai8HqFDkquL1a9H5P1PfTST5C0oRwWLDF330MYSb8j/Iu
         bqC9Lz9oe9R/1onCibHpYRAIojr5RWU0l2BtbfMljWdSqc9NqsTTpjsD9UbsXlGYupb8
         rlDG3x95vlqOdlOgUCFxwCysAHjsjOQvo0u94a9ElkNLhT13mS+bkpHx8YcbkxqVdAwc
         YXXiYTKHZiUZYdDmV5XfTJbeiR5TYxjtQ9AT1IajhWU207gCtXyXgnE70PxPiLNsjUJa
         4J/c7TukPI/Sngih+f9UK1sVwIRzFgmO78XmokzSfGuQKkxp3tHen7L7XBKaNQZG3OpL
         RvNQ==
X-Gm-Message-State: AOAM533ZRt1WUU1DU77R3dGR9SEmF+LWXaR7K6rjvZ6nzaox1yyXDoyl
        O8qkvd9mAVgnHsGGP8hTBYynkwhkikg3Wg==
X-Google-Smtp-Source: ABdhPJzFeKvAsLz8R7Rwlkdtsye3bkYdvaN9gR1Ris0ONyaGl04w2s13SWnH/vv8k+BsZYzGRRZY/w==
X-Received: by 2002:a17:90a:3948:: with SMTP id n8mr216103pjf.206.1610051180075;
        Thu, 07 Jan 2021 12:26:20 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q9sm7042112pgb.82.2021.01.07.12.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:26:19 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Bing Song <bing.song@nxp.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] dma-buf: cma_heap: Fix memory leak in CMA heap
Date:   Thu,  7 Jan 2021 20:26:16 +0000
Message-Id: <20210107202616.75170-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bing Song noticed the CMA heap was leaking memory due to a flub
I made in commit a5d2d29e24be ("dma-buf: heaps: Move heap-helper
logic into the cma_heap implementation"), and provided this fix
which ensures the pagelist is also freed on release.

Cc: Bing Song <bing.song@nxp.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc: Ørjan Eide <orjan.eide@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ezequiel Garcia <ezequiel@collabora.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: James Jones <jajones@nvidia.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Reported-by: Bing Song <bing.song@nxp.com>
Fixes: a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the cma_heap implementation")
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma-buf/heaps/cma_heap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 3c4e34301172..364fc2f3e499 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -251,6 +251,9 @@ static void cma_heap_dma_buf_release(struct dma_buf *dmabuf)
 		buffer->vaddr = NULL;
 	}
 
+	/* free page list */
+	kfree(buffer->pages);
+	/* release memory */
 	cma_release(cma_heap->cma, buffer->cma_pages, buffer->pagecount);
 	kfree(buffer);
 }
-- 
2.17.1

