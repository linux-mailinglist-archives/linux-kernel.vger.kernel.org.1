Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAD92A17F7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgJaNqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727407AbgJaNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604152005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=c8vUJq07yKW3wKxpozeAM0ASxuZkYbMJQ+/1NWKmFkQ=;
        b=fyGMkj/71VzCPsuhuvAS+T34KW8eE29BSU+8dtNvKOR+n+2BDIwfSIPDQ7Dle1i1FGj19R
        IBs9eCTmpMniAtWTEvAlHuL+ijuduXHL4TzY6GGurSydcbsZXsuuZUCz17WhZ5WMnu1DWr
        k8kDIlF0SAzTyjR7lCu3l1YMLZs18wY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-q--JpwU0NFOzkP-YkxjR9Q-1; Sat, 31 Oct 2020 09:46:43 -0400
X-MC-Unique: q--JpwU0NFOzkP-YkxjR9Q-1
Received: by mail-ot1-f70.google.com with SMTP id w15so3803759oth.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 06:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c8vUJq07yKW3wKxpozeAM0ASxuZkYbMJQ+/1NWKmFkQ=;
        b=WuxaR6GFySX5oP8eeBlGZS+I/1dYbVJHT4VGCyY3cUea+cf9jWmXOy7swmJtJcJSXN
         km8BJd1myh9ucWXWKcTBsvSjnR8CTxfHTP82tE1farBXH4ORSVpeMNycaU5QH66Pxtt9
         AqASdL+EW4GK6D6VX1PeO5GMP6+AdoFn/eLzN9tXBiXZiv+n7TBBN4Szep7WlsILyVfG
         nBGTMspIQkMU5FS4+Rc0Pg3vnmK1kZZNNU6GrmKWdrh/Zrgn5ABDtPWgj77dSb6l/sHD
         KIf3vLfEAftXJqzQHyhP2SXW/xvDPwHcpqMu/1y6SiUZqQmVtU6N7qe69ekkviTQuuNr
         ROAA==
X-Gm-Message-State: AOAM530IhJkBba0q6ltaNT1giU5YI4cFfGoP5K+nzSj2ySkpocGwwDsL
        ooLXqvBzhap+HhFpEaaW3A+kc6JYsc3jNmPfyx40Qdc/n1z71qumTs1sHzNg8dVWgN7xvIEAvei
        rCuyxvPQ43uZVQqp9BMqig1KP
X-Received: by 2002:aca:b246:: with SMTP id b67mr4934671oif.17.1604152002972;
        Sat, 31 Oct 2020 06:46:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxopvD8vKGdwcJHbit8rJ6oaoG7N/GbA7LoGBxGOsGWH/5rX7ILmNkVtIMI+aFETQPIsKWlkQ==
X-Received: by 2002:aca:b246:: with SMTP id b67mr4934660oif.17.1604152002826;
        Sat, 31 Oct 2020 06:46:42 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h7sm2064262ool.34.2020.10.31.06.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:46:42 -0700 (PDT)
From:   trix@redhat.com
To:     leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] RDMA/mlx5: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 06:46:38 -0700
Message-Id: <20201031134638.2135060-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 600e056798c0..6aad0f39c50c 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3102,7 +3102,7 @@ static int ib_to_mlx5_rate_map(u8 rate)
 		return 5;
 	default:
 		return rate + MLX5_STAT_RATE_OFFSET;
-	};
+	}
 
 	return 0;
 }
-- 
2.18.1

