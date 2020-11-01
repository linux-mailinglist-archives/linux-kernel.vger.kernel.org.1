Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA6E2A1E6E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 15:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgKAOFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 09:05:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbgKAOFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 09:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604239538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=aWuZ6CNcX73ZRXvjOOgvWKSO2p04g3cpgBeEkZo1Tfs=;
        b=hYjydGIQRO1c7RL0GHsjS0gL1JjxijkdzhIYIuvKAlj9NX8+dECXEFmTMdHL/VYFbb4rS4
        s8xWDsV6lLUOCBLeeetzweqeFDq7U22IP7+KSpxJcO3bG9VbZ6N7EADBhw4+5/KZCss8ac
        piYDmVh3pU4V+gwTmkhFmoCmS0X94BA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-1lUUR9KtOMCHQGil4axGVA-1; Sun, 01 Nov 2020 09:05:35 -0500
X-MC-Unique: 1lUUR9KtOMCHQGil4axGVA-1
Received: by mail-ot1-f71.google.com with SMTP id 36so201820otu.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 06:05:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aWuZ6CNcX73ZRXvjOOgvWKSO2p04g3cpgBeEkZo1Tfs=;
        b=SHrjIoh4zuTdZIu2ayulV2o8KxVkuz+wQVJF0nPAd9WhOGGeVeqKNdT4CRPWhma0la
         s+DnmUNMh9Lrr3QDp7l/xwxqJerysPzDJqVVXHcRGsa16cXDI3MGu2vZ2jMh3HPYGQPx
         8K1OcIJvi9GGsxsQld5iSrskkauev6ekpgU2ecWuXLL+5ehCzfMzCn/S7H5Da9dAQvX2
         izXKKicbN6x+y71cxXofQclIxmHybN7P31J9wvSeOql3S8Za19ABYtl+zWWG8uCHm9Re
         W2NYmWZc8OAFJKsat+3bpsUDKpD3pdn/0PfgAZa21IsQLbiCGuTYMuss95JY71PbXLYT
         GThw==
X-Gm-Message-State: AOAM533B1cbf51IWYyA+KsI91r733mD/+pQnx9dVhz4a1/V0NZRl3flH
        jXUTUnfw42KgVWnL1VVsWjS6ilIPgn6NO2/31tGGEEs3bB8b5umgg4yeR9QI0julJ1I40MYJAP+
        CPwWYg953oCcj7OhWgXAc6W9u
X-Received: by 2002:a9d:6c0e:: with SMTP id f14mr8738008otq.275.1604239534469;
        Sun, 01 Nov 2020 06:05:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4WDgKv4A+XxRMymr7Yk4a/1H3WY29ZBfgtBiE1ZxZk/R2BNNIqV4/zyl4X5ZA7JzAKIVmtA==
X-Received: by 2002:a9d:6c0e:: with SMTP id f14mr8737996otq.275.1604239534306;
        Sun, 01 Nov 2020 06:05:34 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s27sm2923193otg.80.2020.11.01.06.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 06:05:33 -0800 (PST)
From:   trix@redhat.com
To:     tariqt@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net/mlx4_core : remove unneeded semicolon
Date:   Sun,  1 Nov 2020 06:05:28 -0800
Message-Id: <20201101140528.2279424-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
index 1187ef1375e2..394f43add85c 100644
--- a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
+++ b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
@@ -300,7 +300,7 @@ static const char *resource_str(enum mlx4_resource rt)
 	case RES_FS_RULE: return "RES_FS_RULE";
 	case RES_XRCD: return "RES_XRCD";
 	default: return "Unknown resource type !!!";
-	};
+	}
 }
 
 static void rem_slave_vlans(struct mlx4_dev *dev, int slave);
-- 
2.18.1

