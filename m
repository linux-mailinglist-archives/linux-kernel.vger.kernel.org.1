Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595032A85F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbgKESQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgKESQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:16:20 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFB5C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:16:20 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 1so1182215ple.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8DAc+yqZFTta9RaCxZpWb6+nPvWwsd8gU2kgzP9O8nc=;
        b=NDDHLjmKCrwxORbkYjMPorLHS+6jqgXsTkedKqV0bhbGMIiZdDpX3u2gGayQO4iQL9
         VRanoOw05oECWNtoGEqgHQrXzhBNN8O6SCxY0U9pTN9fHeQ2+shkjTqd86TQQ4Mk7zqw
         qSXvQDz/nCLepFzTwLsJoFwn0poktE8iyyzVhd2aeMo6osmBph6keMEaoTnqFMJR0MsI
         1Kk0iOaZzPA6JRPJiqbFMqLB+a7OGB8DnFpvoX32lgMQfM75KOacMW8lJbGKqiBiw+QX
         rVQQz1c2W6RLzaPMjH0mH1eMYar/JrWRhVb8qgqwzJHI9cVqlo7dvgJSMGposDJL2rVQ
         kAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8DAc+yqZFTta9RaCxZpWb6+nPvWwsd8gU2kgzP9O8nc=;
        b=uQ5QhBGO3KMqADMYSEKc0DX1JXEfMme0p5zfcVoSvhRdEVISBf3OSNyL7fNJRw2WIH
         iqK4Fu6XCQ4jPNEZUo9G6MSfWSngYNkmo63N+5PBTRew43rOaySXwzIKHUA6c267h8lE
         nw1aNNJsJ4EXyyEathejvnBUTsPoYK6dN69fIrXFdLhnHZFQ91lJ2lhxK8ziGdKk96HF
         5K5v+1u15S239Pd/56nhZqSDdyK8Z/gWsd2LsIVPyzBSzsReEqAbkT5b7hdVtwSZrd8g
         eeLKcJ/2pgarstdb3zJwXs2smr+1edc7xc5U5pkMvr6Nhbzrp9y6ugvYSzbzpVR7trKY
         vkaw==
X-Gm-Message-State: AOAM5311jYXGBDl9Bp3fMgfRN2a4cSLgQBOk+KG0an5X39RH2v3663LS
        Rdhy7Nh3yjy0cGQDljCaHdY=
X-Google-Smtp-Source: ABdhPJxFb/P68iReWq/rQU77ozYWg2HQsHgI3Jdm1aL9Q9i/nGtoo22bjdLmibG1FNtQPPFxGYjq/g==
X-Received: by 2002:a17:90b:4a4e:: with SMTP id lb14mr1740465pjb.23.1604600179899;
        Thu, 05 Nov 2020 10:16:19 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id i11sm3259743pfq.156.2020.11.05.10.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:16:19 -0800 (PST)
Date:   Thu, 5 Nov 2020 23:46:13 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, maxime@cerno.tech, mripard@kernel.org
Subject: [PATCH] drm/vc4: replace idr_init() by idr_init_base()
Message-ID: <20201105181613.GA42968@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_init() uses base 0 which is an invalid identifier for this driver.
The idr_alloc for this driver uses VC4_PERFMONID_MIN as start value for
ID range and it is #defined to 1. The new function idr_init_base allows
IDR to set the ID lookup from base 1. This avoids all lookups that
otherwise starts from 0 since 0 is always unused / available.

References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
index f4aa75efd16b..7d40f421d922 100644
--- a/drivers/gpu/drm/vc4/vc4_perfmon.c
+++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
@@ -77,7 +77,7 @@ struct vc4_perfmon *vc4_perfmon_find(struct vc4_file *vc4file, int id)
 void vc4_perfmon_open_file(struct vc4_file *vc4file)
 {
 	mutex_init(&vc4file->perfmon.lock);
-	idr_init(&vc4file->perfmon.idr);
+	idr_init_base(&vc4file->perfmon.idr, 1);
 }
 
 static int vc4_perfmon_idr_del(int id, void *elem, void *data)
-- 
2.25.1

