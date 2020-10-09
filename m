Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331A0288473
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbgJIIAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732753AbgJIIAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:00:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A57CC05BD0A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 01:00:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z22so8390991wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ybAifwX7tm2P00t2K95NUlLTVV/59iglzyZOopNSY4g=;
        b=iRqcoi2J+8TbvYv/OI6gZry2qWJjsQLn24G4kqdeeRuUA+0H9YClu5xZhMUQNcmsMG
         JPS6JPnqs6Bk/zroCRZ/wHG6IvC2ZDGDlX/Z457NYm+VvK3sD2Y2DmyMs0uQyILuAN0N
         24HSnEGcXQk//4F2Y2Z5Ww4FDBcpxX8FuiubM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybAifwX7tm2P00t2K95NUlLTVV/59iglzyZOopNSY4g=;
        b=F6xx/rXSMTLk51mM1EMDwYjJYSvQF163wkfnpbJQbSL4SMvGe1yk+vq1tscG61tyO4
         +hINt0+ngVQGdM8WXa4wtyjVMP271rZiCcKqFzMRfOnsmo7bhsDKlwvDUPjRPD+kS7iL
         fMAPICY0yGUdPMz1/O1xwRx45DWRCiNMnPKlI0HG/+OqoM0ydb7Rn4xCU7OdDKhuQbIZ
         t3t37AzWAMVsqLDKs3QJXuhaxbfUCJsI8/bZu630/bss+h86EY/YLLvQhE0EA4vLveNz
         iTmu45sCMkeiZgYp/cP0OZasyz18y/mNdghZzr+eI3YQ8gCeObA4QiSWkWazFk8UBuod
         KIXw==
X-Gm-Message-State: AOAM532kuA7LrbF/cq2o8wzzPmAk2Zbm1blf0WxEe9FWhk+Lf5KFc8Av
        DWdj7h0qPW7mWdFhEx/cGpXyTw==
X-Google-Smtp-Source: ABdhPJz/a+ItIs4nZkG5GhoSduiU6qGLoEKHXdDdLg7sXZkEX3DpeqBcVWskPvNGNUhuSuQAqMr6Cg==
X-Received: by 2002:a7b:c01a:: with SMTP id c26mr11729750wmb.35.1602230410816;
        Fri, 09 Oct 2020 01:00:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u17sm11634118wri.45.2020.10.09.01.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 01:00:10 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 13/17] /dev/mem: Only set filp->f_mapping
Date:   Fri,  9 Oct 2020 09:59:30 +0200
Message-Id: <20201009075934.3509076-14-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we care about pagecache maintenance, we need to make sure that
both f_mapping and i_mapping point at the right mapping.

But for iomem mappings we only care about the virtual/pte side of
things, so f_mapping is enough. Also setting inode->i_mapping was
confusing me as a driver maintainer, since in e.g. drivers/gpu we
don't do that. Per Dan this seems to be copypasta from places which do
care about pagecache consistency, but not needed. Hence remove it for
slightly less confusion.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-media@vger.kernel.org
---
 drivers/char/mem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index abd4ffdc8cde..5502f56f3655 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -864,7 +864,6 @@ static int open_port(struct inode *inode, struct file *filp)
 	 * revocations when drivers want to take over a /dev/mem mapped
 	 * range.
 	 */
-	inode->i_mapping = devmem_inode->i_mapping;
 	filp->f_mapping = inode->i_mapping;
 
 	return 0;
-- 
2.28.0

