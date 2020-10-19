Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21A292E47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbgJSTSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727681AbgJSTSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603135096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=u6bS9bJa+Ao5A9CkxCp7enwJrwEfE+CirmUjlBhSHVI=;
        b=PV9A1FYzK2gEgOoj5gbV4eP8H48gHwQKnCxssBTVN1D4tmRs/IYo2RHWBMoUP4ujOgS7Rm
        oKlM3VEBhS7SSR2h77uJjkp/DQg+sfrbc0xeK2pBFS35oAsDNMkPglUbyTSbPiy5LyueCE
        IyEczL3x3Uwrtju9gYvGyPi4HaJ+z/Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-aK85BAX_PRKhDK_7C03KZA-1; Mon, 19 Oct 2020 15:18:14 -0400
X-MC-Unique: aK85BAX_PRKhDK_7C03KZA-1
Received: by mail-qt1-f197.google.com with SMTP id o25so688659qtt.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u6bS9bJa+Ao5A9CkxCp7enwJrwEfE+CirmUjlBhSHVI=;
        b=mPXSFGWrWvTrFdoFUQwZ1lUqjrdnJQRkwiWt7a9C1URI3OevgdFhGlBpe4cd4aV0pW
         3LydiIuNrUdy6Z2UJiehul4Lt9/lH64sWAXJLM4UCui9n9x4EyNzGrMpMIxmWkSsfCCh
         QtDf9tUnkynd9TgFV7mIEvgS9HZm61P/EO7oiQimydttiSIaflG0NzO6Uw0hyjkqaJel
         ccLNFvNVqDw2i2CG8mYz63T+dkmkFBXQuHuYDXb+rSc1ay9F6kL1+zygRRvzU5tjRsOo
         o2C9aKifQFafGAdI0NJRtjYrLbNuZqaM1w5tT/wi2LnjVUEsuq5Te5fy2+avlgDkk3eQ
         MZnQ==
X-Gm-Message-State: AOAM531dNYSgEKC2zN+cXaSg9IaXEURmC4UABREqhEk6pHa21nDg1jNT
        wGe3ENKsGkIfc6F1tllln9GetJajtDD8Zb1VpOps8CXlUWlT7wRt9X0ydnBcbxdU7XSca/T3OTt
        jZBlygpQqVYPevF/RFjkvC7K1
X-Received: by 2002:a0c:b482:: with SMTP id c2mr1319644qve.44.1603135093281;
        Mon, 19 Oct 2020 12:18:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6m1RO6ciO7XGI/wkDTIed8z5095i7LHeS2xcc0JQkLMn+Rp80LfhIgIPDZbCMdEEpsXOInw==
X-Received: by 2002:a0c:b482:: with SMTP id c2mr1319623qve.44.1603135093075;
        Mon, 19 Oct 2020 12:18:13 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v13sm392970qkv.113.2020.10.19.12.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:18:12 -0700 (PDT)
From:   trix@redhat.com
To:     tomas.winkler@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] misc: mei: remove unneeded break
Date:   Mon, 19 Oct 2020 12:18:08 -0700
Message-Id: <20201019191808.9891-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/misc/mei/hbm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index a97eb5d47705..686e8b6a4c55 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -1377,7 +1377,6 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		dev_info(dev->dev, "hbm: stop response: resetting.\n");
 		/* force the reset */
 		return -EPROTO;
-		break;
 
 	case CLIENT_DISCONNECT_REQ_CMD:
 		dev_dbg(dev->dev, "hbm: disconnect request: message received\n");
-- 
2.18.1

