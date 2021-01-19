Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0CF2FC17E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbhASUqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733305AbhASUpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:45:54 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D70AC061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:45:13 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m6so13027574pfm.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gCsWuNpJqoaKmXUbqD2yoFjbhOP/NQNls4IpQYcF/Q=;
        b=BOomRctyxyEqp6sAYPFH+XcCAixJ9mdS3M4PS9Y1Hs6E8tPpzPoXFJ7GtEq0ZqmFX/
         bvhzR+TJgZVMqHH0HGzclpgi6jHb4tp/UtdkQysgd8hBfqUTrR17Y6FjSOhJWQ2F65jI
         r1SvnCIuGt5FEZtRnmIoXeTeKg9AnfvEJ8THUXkDay1yIct1VropoKQyZoua/576XOuD
         HIzDN4aSMbE4zlQfV44ERRSILhcgU3FKtUKbczAlrE/k83vWca3WhG+5a8lAddZX2g8Q
         Z5jTjcfBLXAGwxTXTJE5Rl1C1/t5U+IzOftefmhcvZTXwPrIAFUJ7fNQJ0hP5B+sqD5A
         ke+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gCsWuNpJqoaKmXUbqD2yoFjbhOP/NQNls4IpQYcF/Q=;
        b=ojjDFYJHPonsOLdTbj13AKrM7Xih4r64/Uq5nYQzgKvyWkD0wiSL/EYjStSbYlPBT5
         jkSw+uB4MIZSePSbb2ZHc3SxMfIQVSE+zztu+I0GxRCQQ8pRmJMa1YNz5QUrYmjkg3bJ
         X+pbKAI4z7UnUHqZc8LBJxs+6bYUBRudQJ1UJoaMn21FA41Oev+ISUj9AHkzDq0N3UzP
         JVLz3f0IJNkbMNg90E743o3zASZHo+nakruX4dT53tGqc7z9SiT8o9J4f4Kkp1FGwix4
         3vMfmphrjsN7DuBwKX6sJsVp7cCRVpTcephuk+jV4Pt8rrwIWccOkX/X+REmCcgj8UEd
         EVLQ==
X-Gm-Message-State: AOAM533FoFroITa5aUC4O6W1nlff0ABpzWdP804r60ud0aHI0gMR4MDa
        AayxU4uRzpd6WUsfY5G6BW91jSYAy9TzHg==
X-Google-Smtp-Source: ABdhPJzu4DX94t/qf1W5DtWbi8rKWJWe4eKwpUf4bPI5rvqgtbBrSK+Jq+SaY8+fAOZRUOFW+e520A==
X-Received: by 2002:a62:36c3:0:b029:1b9:e110:e126 with SMTP id d186-20020a6236c30000b02901b9e110e126mr3294942pfa.64.1611089112103;
        Tue, 19 Jan 2021 12:45:12 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id md7sm4129838pjb.52.2021.01.19.12.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:45:11 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
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
Subject: [RESEND][PATCH 1/3] dma-buf: system_heap: Make sure to return an error if we abort
Date:   Tue, 19 Jan 2021 20:45:06 +0000
Message-Id: <20210119204508.9256-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we abort from the allocation due to a fatal_signal_pending(),
be sure we report an error so any return code paths don't trip
over the fact that the allocation didn't succeed.

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
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma-buf/heaps/system_heap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 17e0e9a68baf..405351aad2a8 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -363,8 +363,10 @@ static int system_heap_allocate(struct dma_heap *heap,
 		 * Avoid trying to allocate memory if the process
 		 * has been killed by SIGKILL
 		 */
-		if (fatal_signal_pending(current))
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
 			goto free_buffer;
+		}
 
 		page = alloc_largest_available(size_remaining, max_order);
 		if (!page)
-- 
2.17.1

