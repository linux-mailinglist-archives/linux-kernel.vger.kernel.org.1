Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3350129504A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444300AbgJUP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444293AbgJUP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:59:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA2DC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 08:59:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h7so3725479wre.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctjUV/qDzuMk+99Zc1qceboDHYtb3OZdKyaQ+fU3OVg=;
        b=V2K64qCtTgV8FUgCG4h32MU/PMEDUom+DqEluPXdvc+C5bRsP2g/ezqF1IsksWDmIS
         aHK7H4cJcC6MNJLz7dmjZbhqDhedvLHwXAWKy4l1BPrUQVcoLEx4f6lEacNcdJfYQUVi
         grwut/0Vhll0dnz3WNXmQFHHYClIsrPZycBp5koAx/0OGFecQX6L6jCH4DeV/9H1j8vc
         sm2/pvBwWK9eqqa4Jy0baKN1Wd1a5+sSkNHiJzmrQF3lSVuPBJOM5j/svWSbi4yLy/3F
         FUZgwWcFWw4lUdrqHlv0oBpkkzDqsKJMS1fzFeq7woPTXapF7p6dVc4FQH9Uh6i28ylV
         0CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctjUV/qDzuMk+99Zc1qceboDHYtb3OZdKyaQ+fU3OVg=;
        b=MUsBfSU3f4hMZUQWpfe4s32TonCv9qZftrSPLc/HXA1Tc3ZUSXUu9lKkynSA25tW2a
         SiNoC3ZjK3Fu8qlCXzYfW9sReHWaJfqIsttMWertNWPMojbXuzcBNwLOK1IW/kBKgrvB
         Y1Te4jGUbk9STOSxCJHxgVrUY/bb2otJfhpJEZzZlo3uI2JN0TXoCgN506+etmh7OMa3
         jKDSheEZZVag1Wx9DcKz6PoVi2qZGf5G9GjOVpckHgqLTC5xCddqZ/hWDS0El37B/Nig
         wkpgAtz7MCijuOfVN4gZ1LmDjLE5s4tvH6rmy6kam1g4xMWbwkkZW8pqfwAUR2cu6q3u
         tXMw==
X-Gm-Message-State: AOAM533kSkTOG9XIy0AhKFKJ7QNt6Qc2IMPY5VJIzp9qYoLTv1Upqeld
        aZUyxCrrMvA2Lz+2NH6SHQEptw==
X-Google-Smtp-Source: ABdhPJzNeqpfZ9Z5/doYrUWxZ6Y/WBmCmbimWFc1mEb+N2LkVgz3WH5jS5Bk///p9yyi/huPjiIlPg==
X-Received: by 2002:a5d:4ccd:: with SMTP id c13mr5545597wrt.221.1603295980283;
        Wed, 21 Oct 2020 08:59:40 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id j13sm4617571wru.86.2020.10.21.08.59.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 08:59:39 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     akashast@codeaurora.org, mdtipton@codeaurora.org,
        saravanak@google.com, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH] interconnect: qcom: Ensure that the floor bandwidth value is enforced
Date:   Wed, 21 Oct 2020 18:59:38 +0300
Message-Id: <20201021155938.9223-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account the initial bandwidth from the framework and update
the internal sum and max values before committing if needed. This will
ensure that the floor bandwidth values are enforced until the providers
get into sync state.

Fixes: 7d3b0b0d8184 ("interconnect: qcom: Use icc_sync_state")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/icc-rpmh.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index cf10a4b9611b..bf01d09dba6c 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -79,6 +79,7 @@ EXPORT_SYMBOL_GPL(qcom_icc_aggregate);
 int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_icc_provider *qp;
+	struct qcom_icc_node *qn;
 	struct icc_node *node;
 
 	if (!src)
@@ -87,6 +88,12 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		node = src;
 
 	qp = to_qcom_provider(node->provider);
+	qn = node->data;
+
+	qn->sum_avg[QCOM_ICC_BUCKET_AMC] = max_t(u64, qn->sum_avg[QCOM_ICC_BUCKET_AMC],
+						 node->avg_bw);
+	qn->max_peak[QCOM_ICC_BUCKET_AMC] = max_t(u64, qn->max_peak[QCOM_ICC_BUCKET_AMC],
+						  node->peak_bw);
 
 	qcom_icc_bcm_voter_commit(qp->voter);
 
