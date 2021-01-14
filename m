Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7298F2F6D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbhANVbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:31:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728455AbhANVay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610659768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q2P0vyfvm+lC2mrTYNPxI2NyRvXwdgTknWpZPQ4nBmo=;
        b=W6tvPl4wiV1AIqO3w/HouHo+dRSflUQ6Of1pPyW305O2X2ExAOHevVVayRGsUtJL8oetV0
        EGbIrp+Si+fTRIJowPYoajH3B3uIfl0QWXsli7NrN4a5ueXmN4buQ4Bxjwa/KL4cM+5cDg
        g6pfpq8+U2kTtaffcoTLAm1rvRxfd/0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-UXiDZvouOuO1zTYu9psQrg-1; Thu, 14 Jan 2021 16:29:24 -0500
X-MC-Unique: UXiDZvouOuO1zTYu9psQrg-1
Received: by mail-qk1-f199.google.com with SMTP id u17so5858047qku.17
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q2P0vyfvm+lC2mrTYNPxI2NyRvXwdgTknWpZPQ4nBmo=;
        b=GW47WUqXCsAGpvW1ciN9fh3zcLPfRNziYiWraOyRxUEHvat32Bkj9r/XXkmAsdk5rg
         glbYQw2KbEFKUJBPR3e/e4mVlDPX5JwoeTq/q9oLBkbLXMjtd/irHtiXCB2mTCOksHn4
         wQ6h5qphcVjwMrAHUV/rKfgOw9EKVk2bMjdHQqHWKn9wIrGywQ6XnqrdVh7aGfRtU4JM
         43eg3gZtO9u3rij0w715Jz3gvzzp3WROn/Alc+dk5mgDJ+elc8nosAhDp7Iu2KTGrIUf
         1kHeij1+gloq2ciGjftHFU/K5+3YCzEVkoTUg1Wkli7CPNwB8HfN+Q8FZnDT1DHMh/2u
         ImYg==
X-Gm-Message-State: AOAM533PoKH5iBVaLvdwrrfdfkRoT2ezEJarouWqeyDUnc+9eEKfyIyt
        AQ/6jZAR3Tuzjcqf7xJp+6lWc10GDTpbXrdkQbaAXUd/qzzFVeII4hafXdY6/Z+u4Lmoc9slgiz
        0bXfoF4k7jPMJRX2WhrwIh/I6
X-Received: by 2002:a37:aa15:: with SMTP id t21mr8790917qke.86.1610659764060;
        Thu, 14 Jan 2021 13:29:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy660NxlfmFC7YykhHaL7gpHQa4Mlrrf+1B0hrXr457WolnKxaoCBz0Ox7FHABSYo6DgKEeIw==
X-Received: by 2002:a37:aa15:: with SMTP id t21mr8790902qke.86.1610659763883;
        Thu, 14 Jan 2021 13:29:23 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t184sm3722613qkd.100.2021.01.14.13.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 13:29:23 -0800 (PST)
From:   trix@redhat.com
To:     davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        liuhangbin@gmail.com, viro@zeniv.linux.org.uk, jdike@akamai.com,
        mrv@mojatatu.com, lirongqing@baidu.com, roopa@cumulusnetworks.com,
        weichen.chen@linux.alibaba.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] neighbor: remove definition of DEBUG
Date:   Thu, 14 Jan 2021 13:29:17 -0800
Message-Id: <20210114212917.48174-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Defining DEBUG should only be done in development.
So remove DEBUG.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/core/neighbour.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 277ed854aef1..ff073581b5b1 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -41,7 +41,6 @@
 
 #include <trace/events/neigh.h>
 
-#define DEBUG
 #define NEIGH_DEBUG 1
 #define neigh_dbg(level, fmt, ...)		\
 do {						\
-- 
2.27.0

