Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC1626BAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 05:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgIPDnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 23:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgIPDmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:42:33 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D81C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 20:42:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s14so849414pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 20:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K/FvWTJd2sC1s/q6HIctsUeXvWdRb3k8TXhXySKpcYg=;
        b=FURdj5cgT+MEvatnJhzqihYGDTiwy8/KZV1BpRElEntDJ9KKqVV06gIW3+5kFAGD9J
         tJ/rMnQl4d9H4LFxcifVZ/tNH0D4Ca3fiO/6+uLq/SUUMWFOanXkDAqtcdONc1HIbvSr
         TBvBg7ReE0YlAYUGAc8zVGh/ELDLeWtUx4bcMt5jfBfz/YtS9CBZPxALLzAJMwz22Myi
         6+SL5GxHJLnwh9ocJwFiO84gwcOIv2fRw20UjaPwOCtl03gSS1Xo4ZxQxDoKYXlnkaHH
         f+zZdwMMUp+tiCd/kKdo6I7EfzVO24ErfM3ncyiwh0OWl+RXfQqVioztqXfepfq+Hrvy
         036A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K/FvWTJd2sC1s/q6HIctsUeXvWdRb3k8TXhXySKpcYg=;
        b=Kkj40XibzmCdk+dYyy6DluFBqaqlDNtJl3oY13N4brfRS9F6LzraiNVCNpGrDppAev
         YQ5ZEIyN9TLK2PAf26HNhemCT5tVYXPGNRckVyLwAV7NRt66WnVBZKiM8MQl8PDafVse
         eqXFWCBB9JzQF9PqHkaUX1tucXLvHbqts/2XVrelDxmRQzL+RLsTiNxZRSY3mANGnAql
         ZN1gzVjMAVUIQ+huVKGvIo+ceRNKpLguVROjr7rMz9whjpPK0uJjRiP7bIp0FW5AArka
         KJl8WsCeu/Gi5QWvv+cBGsvAT35vkVsynoiejt/iJlkMWZVvYdP+o4Fa1KQInSQv2nTL
         mCBw==
X-Gm-Message-State: AOAM532kBCKTrynIuXeRooS9oj6LHZ6fqOEC17k+6jBjPfOfEK4PBvTy
        qUeB20JviXPuTbd37+KMSWk=
X-Google-Smtp-Source: ABdhPJwYF79XaOXQNVeytfPn/NEsg03bNx8urof1Q0c8Cxyo7mTytaPlZz4yAiUIfNMrNK4pvjBj7w==
X-Received: by 2002:a17:902:5992:b029:d1:e5e7:be7b with SMTP id p18-20020a1709025992b02900d1e5e7be7bmr4246001pli.85.1600227751773;
        Tue, 15 Sep 2020 20:42:31 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.171.169])
        by smtp.gmail.com with ESMTPSA id x13sm2496243pff.152.2020.09.15.20.42.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 20:42:30 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     mporter@kernel.crashing.org, alex.bou9@gmail.com,
        akpm@linux-foundation.org, gustavoars@kernel.org,
        jhubbard@nvidia.com, madhuparnabhowmik10@gmail.com,
        dan.carpenter@oracle.com
Cc:     linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [linux-next PATCH] rapidio: Fix error handling path
Date:   Wed, 16 Sep 2020 09:12:17 +0530
Message-Id: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an error when pin_user_pages_fast() returns -ERRNO and
inside error handling path driver end up calling unpin_user_pages()
with -ERRNO which is not correct.

This patch will fix the problem.

Fixes: e8de370188d09 ("rapidio: add mport char device driver")
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index a303429..163b6c72 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -871,15 +871,16 @@ static int do_dma_request(struct mport_dma_req *req,
 				rmcd_error("pin_user_pages_fast err=%ld",
 					   pinned);
 				nr_pages = 0;
-			} else
+			} else {
 				rmcd_error("pinned %ld out of %ld pages",
 					   pinned, nr_pages);
+				/*
+				 * Set nr_pages up to mean "how many pages to unpin, in
+				 * the error handler:
+				 */
+				nr_pages = pinned;
+			}
 			ret = -EFAULT;
-			/*
-			 * Set nr_pages up to mean "how many pages to unpin, in
-			 * the error handler:
-			 */
-			nr_pages = pinned;
 			goto err_pg;
 		}
 
-- 
1.9.1

