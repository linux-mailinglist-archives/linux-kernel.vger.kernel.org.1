Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AAA29063D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407437AbgJPNZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405546AbgJPNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:25:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF57EC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Yoy4Bitu4N8nQBFX3fGLt0YTSjtnYSQ3PQcHpLFTfPM=; b=Yy2ZH6iET6bUUx5WoXn/WWSExN
        sEa+P6VWLCSSWiAVgXaAdn/oxlgL7j92FEJZjSABfOXjMeZaamQv78UXL1bqzMo+reae0hFXtJa+L
        +j3XLWYVaSn2hgy4Bk8mKH3wpca/whjEdDeP5JBZOFFUV3hg2I6F8kncDR193s+Wy/uyO2ndMpe0m
        OgoU2WPXTFVMOJts4uVlAG3eRPjVm3BNzihDXN+UU3tivHoR31eDzTeFDOBh+tdWA8WC4pHD4Prye
        NYWqNf7BHmnWyPKdZruBeIxiDwumEhmXvwywsBbJqi/U7GxGovSPUYk+b/AF0VOi2QFvlJiNG9eJe
        y/e9Ajow==;
Received: from 213-225-9-134.nat.highway.a1.net ([213.225.9.134] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTPjL-00032E-SV; Fri, 16 Oct 2020 13:25:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] pstore/zone: cap the maximum device size
Date:   Fri, 16 Oct 2020 15:20:39 +0200
Message-Id: <20201016132047.3068029-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016132047.3068029-1-hch@lst.de>
References: <20201016132047.3068029-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce an abritrary 128MiB cap to avoid malloc failures when using
a larger block device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/pstore/zone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 3ce89216670c9b..5266ccbec007f3 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1299,6 +1299,10 @@ int register_pstore_zone(struct pstore_zone_info *info)
 		pr_warn("total_size must be >= 4096\n");
 		return -EINVAL;
 	}
+	if (info->total_size > SZ_128M) {
+		pr_warn("capping size to 128MiB\n");
+		info->total_size = SZ_128M;
+	}
 
 	if (!info->kmsg_size && !info->pmsg_size && !info->console_size &&
 	    !info->ftrace_size) {
-- 
2.28.0

