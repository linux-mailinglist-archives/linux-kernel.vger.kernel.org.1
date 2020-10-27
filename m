Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9821229C820
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829265AbgJ0TBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1829228AbgJ0TBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603825294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=8RAi/H/kGv3MO4sBmaUvbuSCKIvqaL12soVzyl8Q1vc=;
        b=VSHjL42AfJKyUgXeZUUFEtgitBYa73SuXYVaCiJiRlR04V9GH9B1aAZjhdgD8KThCDI2HZ
        vxrfi5j3wu08DSHZzD2GOrA+NZ7DxnJC3+jHiNbWomVak3tGtfXv9QrRFO51f+Z/jQ1wg+
        RLLvT7V87xewzQnJT6cMfR3gx8SQzTw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-jOoirAEVNOONGkOiQbWe2Q-1; Tue, 27 Oct 2020 15:01:32 -0400
X-MC-Unique: jOoirAEVNOONGkOiQbWe2Q-1
Received: by mail-oi1-f198.google.com with SMTP id 204so1102411oid.21
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8RAi/H/kGv3MO4sBmaUvbuSCKIvqaL12soVzyl8Q1vc=;
        b=rzbea+DRKVaNvWKciFU6XgfDx8sOz/EhhhQt8R2KgSmhZArHYWxef1JnBzYD9XnJdu
         7aR9xepalataQCs5xiqm+SLCjxWKWfGLw4zaspt9NKXaGZm5kAI9KMN81f+PGYlt4xrd
         QxdCFSL5wbxF/Jkqi0B4YBvnbvFfYR1rzO/T9V7k5lWnil2M1Mvkb1IXOhaE2yZNavcV
         1kykMXqwRcYg6IBMv/S2G9MxecQ5aGZWC/5qvvv/rMaAbh+Uo4S+bTObRFxXNsj+KKBB
         4P6ZFu0iYo3qcS+8nITDfMxMvhUSUeHsgm4wcQZAy2+F5IuvODGYcEsMbXfNdUBlrjmg
         nyEQ==
X-Gm-Message-State: AOAM533biOIeLIA58OEiUxLgOgs87VvV/ro2Y2qcVYPhcFriHcJ8ohcr
        eeeYc6pGBk0CRYeSXNnIu5LMqs+k4T8cCHVi26w7QY35XzTUJh0pX3DmyS+iaY4Jir6kws4sAt2
        mBLTnqdrUga9HXw4/GkMuCtge
X-Received: by 2002:aca:ed50:: with SMTP id l77mr2551955oih.42.1603825291478;
        Tue, 27 Oct 2020 12:01:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz31yjyQCJ9nTi7BotvDyi/x6qMqKMbD10mFhh2+4+odp3X/jP8VbXWjHo2AkVEg+PSOTOxaQ==
X-Received: by 2002:aca:ed50:: with SMTP id l77mr2551945oih.42.1603825291318;
        Tue, 27 Oct 2020 12:01:31 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b21sm1384586ots.30.2020.10.27.12.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:01:30 -0700 (PDT)
From:   trix@redhat.com
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] crypto: cavium/nitrox: remove unneeded semicolon
Date:   Tue, 27 Oct 2020 12:01:25 -0700
Message-Id: <20201027190125.1587447-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/crypto/cavium/nitrox/nitrox_mbx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_mbx.c b/drivers/crypto/cavium/nitrox/nitrox_mbx.c
index b51b0449b478..73993f9e2311 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_mbx.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_mbx.c
@@ -112,7 +112,7 @@ static void pf2vf_resp_handler(struct work_struct *work)
 	case MBX_MSG_TYPE_ACK:
 	case MBX_MSG_TYPE_NACK:
 		break;
-	};
+	}
 
 	kfree(pf2vf_resp);
 }
-- 
2.18.1

