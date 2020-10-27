Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5548329A5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508490AbgJ0H5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:57:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44835 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508483AbgJ0H5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:57:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id h2so323358pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 00:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WTGC2OTITxlQLtj5zM0pFSoVah1I+fME0Bx3VBUu+Yo=;
        b=JP1L/hqgpYoepOQ3ejAHcxMgOon16s5amlaf/SsSxdhvw982pStR+nZXKSo5OA2n1s
         H/c7cg+12r/pMF0SkpABvySTyVfTsrB20jVhtU96QhPOQfH1j/QRSWO10Zqmu2qYa1UI
         nX2jozFMAEfQFUbinMh2s9Y50XMv+S9qPCh2lnmWqq4WxfWzySBDDFmDfODOTbKYBgYr
         p+j+Cy2YcU0Z24CoAeKAC28TKgBQ1d92ZrWdDRZTw5TDHPhgsqzW86LmaoCU96J1Lh4t
         fdEgIqXkwtPvQ4qyrZwDAeIp1Ok3ME6HjZI4qqXaE/rq8NTBydolaxbpcqQlkra0cbSi
         xHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WTGC2OTITxlQLtj5zM0pFSoVah1I+fME0Bx3VBUu+Yo=;
        b=U6L2fYI7V9PNgsmq3k8jFzCT1VWHwcALjpfY1vEl3tbTm+ofF9ac6Rf9WhKsUsxPZQ
         bf0b/EDmKDrhLMcAahfehQDHoNaIrkOO4bIgJ8b9DjbM6N0BLUinO2NH2DIMwHJwGakq
         mdiIEgD3IQePZXD2yBE9hG0wXyVIq0o68XMSGr/1B5xPEa9lSTIfFMtVHBEXSo4PDORs
         18HV4avPtuczREK95XodH67fW6fWGo1OpBLTZ9hohELBgJ2ZVOnu3KQ4yxeRmIBjuDKs
         JOb72CKoJbBOugvuLl1NOMu0lANV2u25FcA+/wfLEs/jpBH/8aGAU31uLjxYbbuvYyXh
         NugQ==
X-Gm-Message-State: AOAM5309cpLXpTbTrwzJFVq9K0HQBFs3jt998FRwBLpHcwYz+vmISFPH
        Po7ulhtRYTxa0zPbFjkcf7GYDA==
X-Google-Smtp-Source: ABdhPJwd354cCqeKi4ljRpmFshygrJuB4B086tJCKwr85zi67cGcxWbK7tBwaL8IV0iw93wYVTqRVw==
X-Received: by 2002:a17:90a:d082:: with SMTP id k2mr905742pju.195.1603785431787;
        Tue, 27 Oct 2020 00:57:11 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id m13sm976201pjr.30.2020.10.27.00.57.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 00:57:11 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Reduce the size of critical section in _opp_table_kref_release()
Date:   Tue, 27 Oct 2020 13:27:06 +0530
Message-Id: <e0df59de670b48a923246fae1f972317b84b2764.1603785323.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a lot of stuff here which can be done outside of the big
opp_table_lock, do that. This helps avoiding few circular dependency
lockdeps around debugfs and interconnects.

Reported-by: Rob Clark <robdclark@gmail.com>
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Rob: I know this only fixes the issue partially for you and I am still
looking into that. I just wanted to get this merged in early as this
fixes lockdep for other users as well.

 drivers/opp/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4ac4e7ce6b8b..0e0a5269dc82 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1181,6 +1181,10 @@ static void _opp_table_kref_release(struct kref *kref)
 	struct opp_device *opp_dev, *temp;
 	int i;
 
+	/* Drop the lock as soon as we can */
+	list_del(&opp_table->node);
+	mutex_unlock(&opp_table_lock);
+
 	_of_clear_opp_table(opp_table);
 
 	/* Release clk */
@@ -1208,10 +1212,7 @@ static void _opp_table_kref_release(struct kref *kref)
 
 	mutex_destroy(&opp_table->genpd_virt_dev_lock);
 	mutex_destroy(&opp_table->lock);
-	list_del(&opp_table->node);
 	kfree(opp_table);
-
-	mutex_unlock(&opp_table_lock);
 }
 
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table)
-- 
2.25.0.rc1.19.g042ed3e048af

