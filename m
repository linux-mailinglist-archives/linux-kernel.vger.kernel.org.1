Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D07D28544A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgJFWFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727591AbgJFWFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602021934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XhXf3XDfdJnOL9cVAo1fl4KlATUUXBoOYIcScfg24/M=;
        b=XXZCyx1miDCxlkook1jJTnB47IGycIz78Riq/nQI+TAiCBGp2wvYEFAg632GCbU6f7SQde
        VA0LpQi00hMzRF0QvYsBm/Qp3yhgWRURU8eBEPmpZHj/wSgoYm9wU8QmzRgkgaf70qXCeD
        9xxZC+vBoYoCPgTUuIbah1QvOrv1RgI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-JEIZQiyePGur0Gsn-XP-6w-1; Tue, 06 Oct 2020 18:05:32 -0400
X-MC-Unique: JEIZQiyePGur0Gsn-XP-6w-1
Received: by mail-wr1-f70.google.com with SMTP id e13so115307wrj.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 15:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhXf3XDfdJnOL9cVAo1fl4KlATUUXBoOYIcScfg24/M=;
        b=S6/+RQxmbugAu9YlhJFlkviszYjXzWI46p6vInrsBV33Vb9wUg0houWZgsln1QDx9G
         WVn/LR8X9GP2aYx2rrRNd5zrxLKzbCyjygqBYX0PcUAntx4Q2hALhMjbrtVpWJstmiRX
         JukUhnMMhbiQ5c0d9uNm27rfJ8r2kXjys6anNvDoZNCD2F1eBZMG+zwYBxkHvw8SgSfC
         IRhEEJhW10+bp1VHPBGDHb1tLdnOh/mX70FVb6f99QCk6ebbjFBXe5MOVDF5hDUhlj5X
         S7S9YSqINx0i79dGUXipQ3QiWQnWHVtxc89Lo+keREQMT0Jvuzxu7rz072WcH+m5OSIF
         6Lvg==
X-Gm-Message-State: AOAM533ooCp4A45LHbfWPgl0Gur0GBcuImGefNIhzfkZHPx3d58aPGhV
        4WhLlDUoL3vx0Z834njx+hQs2DCJPCU5F0iztAtxD87Jh+6pX2F9p6GmztENyoFFppPJYt8OooD
        Kegb40dSMF154m2rPp4vzmbEz
X-Received: by 2002:adf:93e5:: with SMTP id 92mr35600wrp.31.1602021931668;
        Tue, 06 Oct 2020 15:05:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEDs2BBYdKwmxA/2uH5QpdSlE9hOLmRZqTj6q8cVAbhd3jWvF8FNSMdXXg6cDO1RfYiVl+mw==
X-Received: by 2002:adf:93e5:: with SMTP id 92mr35588wrp.31.1602021931513;
        Tue, 06 Oct 2020 15:05:31 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b088:c000:2bdf:b7aa:eede:d65f])
        by smtp.gmail.com with ESMTPSA id j17sm157785wrw.68.2020.10.06.15.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:05:30 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] drm/nouveau/mem: guard against NULL pointer access in mem_del
Date:   Wed,  7 Oct 2020 00:05:28 +0200
Message-Id: <20201006220528.13925-2-kherbst@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006220528.13925-1-kherbst@redhat.com>
References: <20201006220528.13925-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

other drivers seems to do something similar

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nouveau_mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_mem.c b/drivers/gpu/drm/nouveau/nouveau_mem.c
index b1bb542d31158..e5fae57fffbd1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_mem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_mem.c
@@ -176,6 +176,8 @@ void
 nouveau_mem_del(struct ttm_mem_reg *reg)
 {
 	struct nouveau_mem *mem = nouveau_mem(reg);
+	if (!mem)
+		return;
 	nouveau_mem_fini(mem);
 	kfree(reg->mm_node);
 	reg->mm_node = NULL;
-- 
2.26.2

