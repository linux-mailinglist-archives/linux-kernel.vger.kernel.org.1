Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BC42D5894
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389075AbgLJKtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389073AbgLJKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:49:13 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D953C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:48:00 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id r4so2561141pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bVxoTM9ZIDuLtAtEZCaE86d03rCpF39qAUQSwcojzBQ=;
        b=mCzBo3T7pjVoucpOnWfWM+ywq7wwbqcufmD7e+j4SDVNHPVXEgjxmw0PgQPIZlYvoN
         FaCLmRNc/fmz9xEqpT/1D8VlDCq9wKCZ/Q1gsvL/uBjrlm2tTLp0BB7l03y0mcOezM80
         kMb0qYWr/YBfzgUq2L+AGo8Hng4rKToF0xWs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVxoTM9ZIDuLtAtEZCaE86d03rCpF39qAUQSwcojzBQ=;
        b=oI1lmt7lkcqSjAG2JSou6RAKpfheFDnpizOyBho6H8cLgGC5ygzXKSRp0s7VDFE6tu
         Jw9poIlfeqm2ng/z3ZC1jEB3hc99zoRYtCdm6sRsQHdDolWIUWZgo4H39VRuxkVIOYGk
         AQQLHBYHmBi/MfUS98jgOc3YwpLzsT2dPbJO0C7s7y40MBzzj/14hYRptUg58LbRu3Qj
         Lw+KZye01BTXadJWHtVsSATPfbu3XtDCmGcGHFS8c19rdFR3rw0mo5WKQEm8yPPJ+Qpj
         SG4OcUitG1hMidyUsUcAzkeAABIoG/GobtPDbQroEiZP0PwTrYOWfq656VYaheB2CtRH
         djCw==
X-Gm-Message-State: AOAM532sMCNXr8SqTPnVDf1vPNwUjMNdxpidmZ9hy5aYna3/y7PXLrPj
        nfuHIq4VXbtGq5UtO/0lv3G/9g==
X-Google-Smtp-Source: ABdhPJxr7DuO4PC45I9h6/PmEATHMWDZamF91OytRBLHd3oflEYtNyuiMontSXkEgPoJ7p6PKKDnnw==
X-Received: by 2002:a17:902:82c7:b029:da:cb88:38f8 with SMTP id u7-20020a17090282c7b02900dacb8838f8mr967622plz.49.1607597280180;
        Thu, 10 Dec 2020 02:48:00 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id y1sm6386658pff.17.2020.12.10.02.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 02:47:59 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
Cc:     Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] usb: xhci-mtk: delay association of tt and ep
Date:   Thu, 10 Dec 2020 18:47:46 +0800
Message-Id: <20201210184700.v2.2.I236cbd6fe27db5a9c776b6d14fe146748373bbce@changeid>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210104747.3416781-1-ikjn@chromium.org>
References: <20201210104747.3416781-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci-mtk creates internal data structures for representing the
relationship between endpoint and TT.

This patch simply delays its association between endpoint and TT
when it's really loaded onto internal bandwidth table.

This is a preparation step for fixing unreleased periodic
TT bandwidth data, no functional changes.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

 drivers/usb/host/xhci-mtk-sch.c | 40 ++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index c334b6d76479..439391f1dc78 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -174,7 +174,6 @@ static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
 	struct usb_host_endpoint *ep, struct xhci_ep_ctx *ep_ctx)
 {
 	struct mu3h_sch_ep_info *sch_ep;
-	struct mu3h_sch_tt *tt = NULL;
 	u32 len_bw_budget_table;
 	size_t mem_size;
 
@@ -192,15 +191,6 @@ static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
 	if (!sch_ep)
 		return ERR_PTR(-ENOMEM);
 
-	if (is_fs_or_ls(udev->speed)) {
-		tt = find_tt(udev);
-		if (IS_ERR(tt)) {
-			kfree(sch_ep);
-			return ERR_PTR(-ENOMEM);
-		}
-	}
-
-	sch_ep->sch_tt = tt;
 	sch_ep->ep = ep;
 
 	return sch_ep;
@@ -377,10 +367,10 @@ static void update_bus_bw(struct mu3h_sch_bw_info *sch_bw,
 	}
 }
 
-static int check_sch_tt(struct usb_device *udev,
-	struct mu3h_sch_ep_info *sch_ep, u32 offset)
+static int check_sch_tt(struct mu3h_sch_tt *tt,
+			struct mu3h_sch_ep_info *sch_ep,
+			u32 offset)
 {
-	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
 	u32 extra_cs_count;
 	u32 fs_budget_start;
 	u32 start_ss, last_ss;
@@ -450,10 +440,9 @@ static int check_sch_tt(struct usb_device *udev,
 	return 0;
 }
 
-static void update_sch_tt(struct usb_device *udev,
-	struct mu3h_sch_ep_info *sch_ep)
+static void update_sch_tt(struct mu3h_sch_tt *tt,
+			  struct mu3h_sch_ep_info *sch_ep)
 {
-	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
 	u32 base, num_esit;
 	int i, j;
 
@@ -465,10 +454,12 @@ static void update_sch_tt(struct usb_device *udev,
 	}
 
 	list_add_tail(&sch_ep->tt_endpoint, &tt->ep_list);
+	sch_ep->sch_tt = tt;
 }
 
 static int check_sch_bw(struct usb_device *udev,
-	struct mu3h_sch_bw_info *sch_bw, struct mu3h_sch_ep_info *sch_ep)
+			struct mu3h_sch_bw_info *sch_bw,
+			struct mu3h_sch_ep_info *sch_ep)
 {
 	u32 offset;
 	u32 esit;
@@ -480,8 +471,14 @@ static int check_sch_bw(struct usb_device *udev,
 	u32 min_cs_count;
 	bool tt_offset_ok = false;
 	int ret;
+	struct mu3h_sch_tt *tt = NULL;
 
 	esit = sch_ep->esit;
+	if (is_fs_or_ls(udev->speed)) {
+		tt = find_tt(udev);
+		if (IS_ERR(tt))
+			return -ENOMEM;
+	}
 
 	/*
 	 * Search through all possible schedule microframes.
@@ -493,7 +490,7 @@ static int check_sch_bw(struct usb_device *udev,
 	min_num_budget = sch_ep->num_budget_microframes;
 	for (offset = 0; offset < esit; offset++) {
 		if (is_fs_or_ls(udev->speed)) {
-			ret = check_sch_tt(udev, sch_ep, offset);
+			ret = check_sch_tt(tt, sch_ep, offset);
 			if (ret)
 				continue;
 			else
@@ -531,10 +528,11 @@ static int check_sch_bw(struct usb_device *udev,
 
 	if (is_fs_or_ls(udev->speed)) {
 		/* all offset for tt is not ok*/
-		if (!tt_offset_ok)
+		if (!tt_offset_ok) {
+			drop_tt(udev);
 			return -ERANGE;
-
-		update_sch_tt(udev, sch_ep);
+		}
+		update_sch_tt(tt, sch_ep);
 	}
 
 	/* update bus bandwidth info */
-- 
2.29.2.576.ga3fc446d84-goog

