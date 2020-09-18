Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5A26F6BB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIRHX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgIRHXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:23:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B0FC061221
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so4535319wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RREMgoQ10AgEzpG5x2JxpJp9Y6xrNHTkcUblYPCMXMg=;
        b=HkHU/RuOacOBTr1v8pD8gw93Dk2xa6hsEqa7Aoe3HIk27GD5wjUQWn2ZA8+ROdU8m/
         MS2gTneDwTjM3HCO1qogpjmczY5egH9fMNsIfUQx1FHdd09JuZ9LZgXzbKSM7bfoIrNP
         WRqOe16IK9Fw3sfbmR0jUCAtvPxZUrmNpzqN8+GiK4Q8hfGUACdAwPmsVOWbGCtbyI3n
         MJnTFiz5W/kJh0dbKd5n5kxMIfvcSDN1+7XHjg5uR7mJPTP1RXcSbcY8bf/o/7tLAj9u
         Cz27U2rGSi/5ovHw5xhNVYYgQ7Ghj1ffW6VHdiJ2Uj7o3gvpCbWTcPMEvyz4ckSbSuyf
         wG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RREMgoQ10AgEzpG5x2JxpJp9Y6xrNHTkcUblYPCMXMg=;
        b=CQfxVLvggOQt6iBMZXL0x0tYjQ6mLcXlzkINK+P62G8Etx0ryRORo5yy36zaQqA75m
         hLU68t1DWQ2PQ0NvhQch7wkyayOToj764P+xOPR1fl87Q3Ii34vxNUyUJfwSNW/B0wPQ
         2MtLvH8FyIX90NNnmn7HTj8nC0ougdldbR8B8LoF3pWtlfKRB84ZRRFQ1EQb3lputQ+B
         IVcG/XDJldbxiHOuGHWZgr8ux1D6xSNlpujN2gZ/MMOsxDUVQbBAQn5vt4g0mOOaOXeJ
         2EktRitovuFXs2wzeM95HG3jsc+6vKYbLixBr31IrztkohwskcbBoapRrM5cYGjV3oyF
         f0uw==
X-Gm-Message-State: AOAM531SGYK+oWijwJULhSWnauR3vgEy0Fdzh/Vc0uoR15BVXwDHHEGH
        CN7dV5mWtpiW2Fyi8yEanvygXg==
X-Google-Smtp-Source: ABdhPJzrtZkV7XKdpdogHscJqjSpplrsVfnghJi5052mVZFzVZtfCQHBIG2VdoJST/XZhQKA27wCxA==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr38252772wro.178.1600413824201;
        Fri, 18 Sep 2020 00:23:44 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id z19sm3349546wmi.3.2020.09.18.00.23.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 00:23:43 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 17/17] crypto: sun8i-ss: fix comparison of integer expressions of different signedness
Date:   Fri, 18 Sep 2020 07:23:15 +0000
Message-Id: <1600413795-39256-18-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
References: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the warning:
warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 739874596c72..c9cfe20b383d 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -414,7 +414,7 @@ static struct sun8i_ss_alg_template ss_algs[] = {
 static int sun8i_ss_dbgfs_read(struct seq_file *seq, void *v)
 {
 	struct sun8i_ss_dev *ss = seq->private;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < MAXFLOW; i++)
 		seq_printf(seq, "Channel %d: nreq %lu\n", i, ss->flows[i].stat_req);
@@ -571,7 +571,8 @@ static void sun8i_ss_pm_exit(struct sun8i_ss_dev *ss)
 
 static int sun8i_ss_register_algs(struct sun8i_ss_dev *ss)
 {
-	int ss_method, err, id, i;
+	int ss_method, err, id;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ss_algs); i++) {
 		ss_algs[i].ss = ss;
@@ -642,7 +643,7 @@ static int sun8i_ss_register_algs(struct sun8i_ss_dev *ss)
 
 static void sun8i_ss_unregister_algs(struct sun8i_ss_dev *ss)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ss_algs); i++) {
 		if (!ss_algs[i].ss)
-- 
2.26.2

