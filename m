Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CC629B683
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 16:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1796921AbgJ0PUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:20:36 -0400
Received: from z5.mailgun.us ([104.130.96.5]:24760 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1796337AbgJ0PR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:17:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603811848; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=qzW8YMnl+1hEgHMlfrnCir6CmAPG6BS63/6JCiKRGlg=; b=nQGe/xZXvBLg9BXGofCxfmET//mO8v45G38dUtDOh+V5LRaM81YsP5BjQF3zX49J8p8XsW39
 EZyIIhRo/LTlZycgzkSHNFbdWcpV13yJluEd1Je6J5NpDlHHPKcUPJiVZMQWfkr57Q08gyEA
 NtI+EIBysuyIDhm+ygBscIZ6wrI=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f98370b00143fe65276828d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Oct 2020 15:04:43
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 15711C4344B; Tue, 27 Oct 2020 15:04:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E8C8C433FF;
        Tue, 27 Oct 2020 15:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E8C8C433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuabhs@chromium.org, dianders@chromium.org,
        briannorris@chromium.org, Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH] ath10k: Fix the parsing error in service available event
Date:   Tue, 27 Oct 2020 20:34:27 +0530
Message-Id: <1603811067-23058-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wmi service available event has been
extended to contain extra 128 bit for new services
to be indicated by firmware.

Currently the presence of any optional TLVs in
the wmi service available event leads to a parsing
error with the below error message:
ath10k_snoc 18800000.wifi: failed to parse svc_avail tlv: -71

The wmi service available event parsing should
not return error for the newly added optional TLV.
Fix this parsing for service available event message.

Tested-on: WCN3990 hw1.0 SNOC

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 932266d..3b49e29 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -1404,9 +1404,12 @@ static int ath10k_wmi_tlv_svc_avail_parse(struct ath10k *ar, u16 tag, u16 len,
 		arg->service_map_ext_len = *(__le32 *)ptr;
 		arg->service_map_ext = ptr + sizeof(__le32);
 		return 0;
+	case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
+		return 0;
 	default:
 		break;
 	}
+
 	return -EPROTO;
 }
 
-- 
2.7.4

