Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DDB29D7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbgJ1W2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731994AbgJ1W1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:49 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AECBC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:27:49 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k1so1085540ilc.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8qusyvIaw6eTnT926D9tsiv7hSb4Zih6Q4OCXNl7nNo=;
        b=lSUcNG3KEYFbcgjZQk9QhmEslqabew/HEZ10OIUz6RxVSC+aUBYVSz43txrAFn8Iao
         N7CK8Wk7O5HNIcyw2nK/w6ouXZ1+ieygFQQYt4IGUiSFyI4aTwXMJJAZsJhBRA3OZWo1
         3g8Uk5JjBrVT6ESt7TWi0R+nGgnVSPplJirburmgaaWijaJdcHy+J9/OkGQfINAlHyyc
         A4VW/w8sWkIvGadDDTU8ir4EFdjByBaES7wWOjCYvMpfgm8+6u10dd8HUNcnlYKKTnxY
         bV4OG4/y22qDs2ECGpT6Py96UCHXMcYtYhTBk7hqBcp/frw+PSsrNPZx9XiOQxc1cdV+
         8Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qusyvIaw6eTnT926D9tsiv7hSb4Zih6Q4OCXNl7nNo=;
        b=eD7clCOOyRT+LeQpDUGQa+HQEVC9ASNiRzUVTcAepfrq7UlvETNmZBdH5+42rna4+P
         o7Ce5uhmg13E3TL/w/7C0YJkUVD2oTkaUUIIyFyI1yQsplOXZ/D9VenZ4YLBXefl2ekR
         TeDcepvzRJRIBNufDTKlm6BjG46vvIgy4St5viCoeT5sG1GhapWaaOhEKWkih4SZHz8f
         BMWQkn8Uw0giAcdVUm5nxJEiM/NTxTYxe3Ycfl/eZz8uJzFhzy8KunJ7PLeZ1TMJO+UZ
         deIavbfWyrtN2SHTBsRdcMGCvw00246XEnGfJ3g5saNygEu0NsKBZ6Qf+uRQ3hApku51
         Q9PQ==
X-Gm-Message-State: AOAM532S7at5ZGjwfTP/jhv+uLhskaPQ8bhcYYfNKElAxe/WLIjfB0Vp
        BWUyMKOnhb/z2s0F9eiwRrQLiyMJtqPxt/BI
X-Google-Smtp-Source: ABdhPJwWbXTfDGdBxT+TvO4YZAL0VRTk/C5BUNkCywDKsvABGAJi1DC0cw3Ntfcz80iXYgEiNEkmwA==
X-Received: by 2002:a92:d3cb:: with SMTP id c11mr543689ilh.188.1603914117616;
        Wed, 28 Oct 2020 12:41:57 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m66sm359828ill.69.2020.10.28.12.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 12:41:56 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        sujitka@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 3/5] net: ipa: assign endpoint to a resource group
Date:   Wed, 28 Oct 2020 14:41:46 -0500
Message-Id: <20201028194148.6659-4-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201028194148.6659-1-elder@linaro.org>
References: <20201028194148.6659-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPA hardware manages various resources (e.g. descriptors)
internally to perform its functions.  The resources are grouped,
allowing different endpoints to use separate resource pools.  This
way one group of endpoints can be configured to operate unaffected
by the resource use of endpoints in a different group.

Endpoints should be assigned to a resource group, but we currently
don't do that.

Define a new resource_group field in the endpoint configuration
data, and use it to assign the proper resource group to use for
each AP endpoint.

Fixes: 84f9bd12d46db ("soc: qcom: ipa: IPA endpoints")
Tested-by: Sujit Kautkar <sujitka@chromium.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-sc7180.c |  4 ++++
 drivers/net/ipa/ipa_data-sdm845.c |  4 ++++
 drivers/net/ipa/ipa_data.h        |  2 ++
 drivers/net/ipa/ipa_endpoint.c    | 11 +++++++++++
 4 files changed, 21 insertions(+)

diff --git a/drivers/net/ipa/ipa_data-sc7180.c b/drivers/net/ipa/ipa_data-sc7180.c
index d4c2bc7ad24bf..37dada4da6808 100644
--- a/drivers/net/ipa/ipa_data-sc7180.c
+++ b/drivers/net/ipa/ipa_data-sc7180.c
@@ -24,6 +24,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		.endpoint = {
 			.seq_type	= IPA_SEQ_DMA_ONLY,
 			.config = {
+				.resource_group	= 0,
 				.dma_mode	= true,
 				.dma_endpoint	= IPA_ENDPOINT_AP_LAN_RX,
 			},
@@ -42,6 +43,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		.endpoint = {
 			.seq_type	= IPA_SEQ_INVALID,
 			.config = {
+				.resource_group	= 0,
 				.aggregation	= true,
 				.status_enable	= true,
 				.rx = {
@@ -65,6 +67,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 			.seq_type	=
 				IPA_SEQ_PKT_PROCESS_NO_DEC_NO_UCP_DMAP,
 			.config = {
+				.resource_group	= 0,
 				.checksum	= true,
 				.qmap		= true,
 				.status_enable	= true,
@@ -88,6 +91,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		.endpoint = {
 			.seq_type	= IPA_SEQ_INVALID,
 			.config = {
+				.resource_group	= 0,
 				.checksum	= true,
 				.qmap		= true,
 				.aggregation	= true,
diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
index de2768d71ab56..a9a992404b39f 100644
--- a/drivers/net/ipa/ipa_data-sdm845.c
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -26,6 +26,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		.endpoint = {
 			.seq_type	= IPA_SEQ_DMA_ONLY,
 			.config = {
+				.resource_group	= 1,
 				.dma_mode	= true,
 				.dma_endpoint	= IPA_ENDPOINT_AP_LAN_RX,
 			},
@@ -44,6 +45,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		.endpoint = {
 			.seq_type	= IPA_SEQ_INVALID,
 			.config = {
+				.resource_group	= 1,
 				.aggregation	= true,
 				.status_enable	= true,
 				.rx = {
@@ -67,6 +69,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 			.seq_type	=
 				IPA_SEQ_2ND_PKT_PROCESS_PASS_NO_DEC_UCP,
 			.config = {
+				.resource_group	= 1,
 				.checksum	= true,
 				.qmap		= true,
 				.status_enable	= true,
@@ -90,6 +93,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		.endpoint = {
 			.seq_type	= IPA_SEQ_INVALID,
 			.config = {
+				.resource_group	= 1,
 				.checksum	= true,
 				.qmap		= true,
 				.aggregation	= true,
diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
index 7fc1058a5ca93..d084a83069db2 100644
--- a/drivers/net/ipa/ipa_data.h
+++ b/drivers/net/ipa/ipa_data.h
@@ -109,6 +109,7 @@ struct ipa_endpoint_rx_data {
 
 /**
  * struct ipa_endpoint_config_data - IPA endpoint hardware configuration
+ * @resource_group:	resource group to assign endpoint to
  * @checksum:		whether checksum offload is enabled
  * @qmap:		whether endpoint uses QMAP protocol
  * @aggregation:	whether endpoint supports aggregation
@@ -119,6 +120,7 @@ struct ipa_endpoint_rx_data {
  * @rx:			RX-specific endpoint information (see above)
  */
 struct ipa_endpoint_config_data {
+	u32 resource_group;
 	bool checksum;
 	bool qmap;
 	bool aggregation;
diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index b40b711cf4bd5..7386e10615d99 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -751,6 +751,16 @@ static void ipa_endpoint_init_deaggr(struct ipa_endpoint *endpoint)
 	iowrite32(val, endpoint->ipa->reg_virt + offset);
 }
 
+static void ipa_endpoint_init_rsrc_grp(struct ipa_endpoint *endpoint)
+{
+	u32 offset = IPA_REG_ENDP_INIT_RSRC_GRP_N_OFFSET(endpoint->endpoint_id);
+	struct ipa *ipa = endpoint->ipa;
+	u32 val;
+
+	val = rsrc_grp_encoded(ipa->version, endpoint->data->resource_group);
+	iowrite32(val, ipa->reg_virt + offset);
+}
+
 static void ipa_endpoint_init_seq(struct ipa_endpoint *endpoint)
 {
 	u32 offset = IPA_REG_ENDP_INIT_SEQ_N_OFFSET(endpoint->endpoint_id);
@@ -1328,6 +1338,7 @@ static void ipa_endpoint_program(struct ipa_endpoint *endpoint)
 	ipa_endpoint_init_mode(endpoint);
 	ipa_endpoint_init_aggr(endpoint);
 	ipa_endpoint_init_deaggr(endpoint);
+	ipa_endpoint_init_rsrc_grp(endpoint);
 	ipa_endpoint_init_seq(endpoint);
 	ipa_endpoint_status(endpoint);
 }
-- 
2.20.1

