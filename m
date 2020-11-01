Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B792A1F0E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 16:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgKAP3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 10:29:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbgKAP3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 10:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604244540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=bWiVlvXp1WAql73np6JVzWGg8n0Nd1xMuTUmok2L8fI=;
        b=N5Ux4kqx+/nhN9j3YttyVN93DIULJm1sZ96K+tKb7KGh8p/ecg6LEKNkEiC6uzyV5b4vlq
        XqGt8xpnbzrCXKigaVCP7I06melvhBtZyEVsp9ZA8emYhIX3xvTGaJqXLu+bU2Q3gHrE8T
        TwHjk/O625DB3K0jCg8OM6ZhgZADmRg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-cUCPq_QPOdKisn1am61Pjw-1; Sun, 01 Nov 2020 10:28:57 -0500
X-MC-Unique: cUCPq_QPOdKisn1am61Pjw-1
Received: by mail-oi1-f197.google.com with SMTP id e3so4577421oig.17
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 07:28:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bWiVlvXp1WAql73np6JVzWGg8n0Nd1xMuTUmok2L8fI=;
        b=ZWOQ2WOea0O40Fq6WFadbh8HDgT+PpTMCCryoK+tXOiAe9gzQq6zcKQAzEfQJa5hx/
         Rk0fD2hKPvdF7YskltGG26hpps25jeUPuDjL2QmcQ1jeo46Fw6N2kgflgmJEmSvsOpQO
         djIVQL/uzCQvfRxUSUb7uz7CVzfBf+rSTWnfyZUFKUIRQjjhH+Wwpt0wtR3Ml1IONluv
         5NqWsqwkwW42RbbtttyAhzVKkBcWhRNU5iBbGIc5ezsyA9eKVTD1GpbSmRLyMWCMPyT9
         1rc/nPHtz+/4547L89OtzpJPDjxIOqR44OUyFc65PKCW31Itk639BxtyG6EvTVuDetfm
         F3pg==
X-Gm-Message-State: AOAM530nDuPPPHEP2Ay6jiAE1xwABmzNa3Zwz+njLwWi2o1+OHE3qbcX
        MA5qwdxQ/oT5x3jCrsF8RMVpmrf8iWA15Kl7u75MDkRHcLekK+C/Vw7Wo9jnp1F/Zb1PlQpHuXK
        8woGqT4q77uKi2aE9rbg49opk
X-Received: by 2002:a9d:798f:: with SMTP id h15mr9367225otm.83.1604244536417;
        Sun, 01 Nov 2020 07:28:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzfwmS7mhGV1nrgDknHQb009zyvSbaveWLGdobtmvsJa5sVPtTe4GngH6uTIpawbEFjyUW+g==
X-Received: by 2002:a9d:798f:: with SMTP id h15mr9367214otm.83.1604244536254;
        Sun, 01 Nov 2020 07:28:56 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b92sm2948531otc.70.2020.11.01.07.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 07:28:55 -0800 (PST)
From:   trix@redhat.com
To:     kgene@kernel.org, krzk@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] soc: samsung: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 07:28:44 -0800
Message-Id: <20201101152844.2290728-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/soc/samsung/exynos5422-asv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos5422-asv.c b/drivers/soc/samsung/exynos5422-asv.c
index 01bb3050d678..ca409a976e34 100644
--- a/drivers/soc/samsung/exynos5422-asv.c
+++ b/drivers/soc/samsung/exynos5422-asv.c
@@ -383,7 +383,7 @@ static int __asv_offset_voltage(unsigned int index)
 		return 25000;
 	default:
 		return 0;
-	};
+	}
 }
 
 static void exynos5422_asv_offset_voltage_setup(struct exynos_asv *asv)
-- 
2.18.1

