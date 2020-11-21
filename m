Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32882BC267
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 23:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgKUWW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 17:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgKUWW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 17:22:56 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D8C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 14:22:55 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id v20so13893436ljk.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 14:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJ8b4BvA6wzfK+FWWv7arlDw3Ty0opb4cjar+bLcvtg=;
        b=MbkSWQWVJrh2zFM+OhVb0VPg6dhxb031k+7AZ+spotzAsRKws4vXmZ/R85+zPYRrd9
         ORlWaxF1HKFBqH1qL5uMdrDUPpW590zQ4I9K1yNkOw/xAI4LeQ6mYJJMOZoI46Rs3nFh
         tkm2XHaK08Deip4KcWOWRpDFTnEoif2GQC3xZjSHms4u60o9sBxa44Z9rxetDR1VgotR
         65LwxuOD0EXOZJGFCJ13b8dnG7U5WqOSoHWFBY2uNV58Xmqa8aPSLh5VHnbOMNfnjHXh
         zzU3lbDf5LNKKODqYqL2Iwur0j5nI0SVwC9Vz2UMbT/ZUieQTOWrH3ALt3DrQILZhsHt
         x83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJ8b4BvA6wzfK+FWWv7arlDw3Ty0opb4cjar+bLcvtg=;
        b=cXjt/dgO1DJvHG3ZeFwoTmKgRaaF4IeV886I+VBYye4LiRv4fT3nwSYbO6K/JJ+5At
         oQM9gkOwsHzr99R205klGPUUhCQyWrajS0TPRyW8wy58BfdeGpQFRJv8/St0ar3VXB1I
         v6ZmwhjSy7NVXc/MFlFwfRGZKlIUgLjvGV79I9B7FbvaUYEGnrWIby/HJpZAm2y1nM0D
         mQIJlGmwQHxxoiGSi6APf73uhPr73zM8C+zkOB2PHe8KFp+thI24m9zHcf9OifNeiAxl
         nDIMUDrFjIWH6cIJ8WdDrth2P2MRqIYGFov/Sn+aWpPFL4EGg4zpkEEzJFF5gcbLovUl
         sMsQ==
X-Gm-Message-State: AOAM531QnazyBnFpGKsHDnHdUThtHuyTICAREvWTn2Nxb1xsB2OrWoxr
        mb8TQRaCDsQQHShCpq1injA=
X-Google-Smtp-Source: ABdhPJxvunX+BdmeGkwBuIss2DHdAFmv5GOCUSZYkJiwA4Sbm+21EhyDXFNsdHffLvAN1Ee1v1SaHA==
X-Received: by 2002:a2e:b6cd:: with SMTP id m13mr11062641ljo.310.1605997374390;
        Sat, 21 Nov 2020 14:22:54 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-6.NA.cust.bahnhof.se. [158.174.22.6])
        by smtp.gmail.com with ESMTPSA id k9sm837450lfk.288.2020.11.21.14.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 14:22:53 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] dm crypt: Constify static crypt_iv_operations
Date:   Sat, 21 Nov 2020 23:22:48 +0100
Message-Id: <20201121222248.6859-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of these structs is to assign their address to the
iv_gen_ops field in the crypt config struct, which is a pointer to
const. Make them const like the rest of the static crypt_iv_operations
structs. This allows the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/md/dm-crypt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 392337f16ecf..53791138d78b 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1090,16 +1090,16 @@ static const struct crypt_iv_operations crypt_iv_tcw_ops = {
 	.post	   = crypt_iv_tcw_post
 };
 
-static struct crypt_iv_operations crypt_iv_random_ops = {
+static const struct crypt_iv_operations crypt_iv_random_ops = {
 	.generator = crypt_iv_random_gen
 };
 
-static struct crypt_iv_operations crypt_iv_eboiv_ops = {
+static const struct crypt_iv_operations crypt_iv_eboiv_ops = {
 	.ctr	   = crypt_iv_eboiv_ctr,
 	.generator = crypt_iv_eboiv_gen
 };
 
-static struct crypt_iv_operations crypt_iv_elephant_ops = {
+static const struct crypt_iv_operations crypt_iv_elephant_ops = {
 	.ctr	   = crypt_iv_elephant_ctr,
 	.dtr	   = crypt_iv_elephant_dtr,
 	.init	   = crypt_iv_elephant_init,
-- 
2.29.2

