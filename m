Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F1E2288CD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 21:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbgGUTHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 15:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbgGUTG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:06:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5A4C0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 9so465831wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=laHnxcRjPmQy9VaO/clWypRhfggwpc5qovCSuzLReNY=;
        b=QAnVtcZkVkETeqRJ7UhjGVUFOq5LUWUoreoJPx0uYX+WcB0QhDa8EQgZpB/x43AnEp
         se8w81A+aiy28s59yFk5xO9n7rCwJkgCpF4WomL30kcBQyCFpax3jUUrLRtRHjLrGYRI
         cu6FrITYrJKCbOTavfcv3IeKswJcaEyOIykOl5NFgDpfI6oUp4QZBzzPFhCQmFLgqPZR
         WuSK/uKV7GAnnCrpJjN+UtfsxnZucm4BqKuhg45DV+Oa9AhUwaskpNfqsFRSSv00UZjN
         uUVY+0JgX7Ql+ovPkLNOHyObmVc4vac7V9OCi8fVVVneYJfUGa/8JFbLdKC62+Gcd59J
         PIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=laHnxcRjPmQy9VaO/clWypRhfggwpc5qovCSuzLReNY=;
        b=QAVp1zckiG7+q3PAQS0l4O80z+d8a1zshTdoHbiV5x7sidbDwl01h9/He2qBlp5lMI
         agPXLCMCzKPiZCIRUFYcH5l00yjYEef3DxGbVJja5m+RjExBt/c7jKBjsggjt+2VOqRj
         VGkS7usqydhzb22BPBWlvHpiMUuxh9g9YlGB+h1sZ38xeuJOsnmSWVn6z0daTVTFBlNc
         Vj7Wxxo/S5YEpfSBzpaRb0g7TBrM9gjQuRwT2eIpv7fyLPVY51Q4koIoL16rJTJPQCt6
         RdpkT+AN662Q3Q8SG6yfawJP087VXWpO2uc1YTscrme/Iq/n1QNBD4NYKesLx76kc6jT
         07sg==
X-Gm-Message-State: AOAM532dUDCc8P4WcAv/1pl5qF+puQgkD5lajgM3yDdXp5qOnMp26jI7
        vwq7DGct4g+vSqlAqYOgRyC7Dg==
X-Google-Smtp-Source: ABdhPJxQHbPR+lsd7erqeGgjthIiB3YfPMd4IJcJvoLnUjJ/UZENfZjgWdMlQKNMew+ohFr/pAs3BQ==
X-Received: by 2002:a1c:2e57:: with SMTP id u84mr5680617wmu.52.1595358417148;
        Tue, 21 Jul 2020 12:06:57 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id s14sm25794848wrv.24.2020.07.21.12.06.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 12:06:56 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 17/17] crypto: sun8i-ss: fix comparison of integer expressions of different signedness
Date:   Tue, 21 Jul 2020 19:06:31 +0000
Message-Id: <1595358391-34525-18-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
References: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
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
index de32107817b3..a17241483b8e 100644
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

