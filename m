Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7AC2D9701
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407694AbgLNLHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395246AbgLNLHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:07:14 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F00C061794
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 03:06:34 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id m12so29142340lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 03:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SFONqpKBx0+WGexIMJg0MppTIKw83Md/mUpNBwOPGvw=;
        b=EIEKyQp1tYGSTyeqRijNIjiczO2nSEeSBQk8Ma/kB23zAfJ2RyTgZFzV0gAEE8GDZ7
         Kz6qOl0CJ2jcPMaeq0jgh8wyIvMYZkNn5br85W90ieiSHichYtkjs9dg3KnsxlE73HaR
         q8s99VSj/i4PKdx8Me6eqBLB5Hl6wX0rYJqdZWuHQGmuSlEOy/2nNVnglr/lLue8u6Z0
         qElKdwbtKKpdYzhLehEbdircnTUPwN8cC2yGbvQrC5udBjxmtS9kkQrM3VnnEl5XIXFF
         F1q+n9koowuSNU1GmhDyEFYQeKwVwjR4nN5TCQKU5Mszqe71hLNHwBHt7D5j/PvbRYj2
         byAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SFONqpKBx0+WGexIMJg0MppTIKw83Md/mUpNBwOPGvw=;
        b=PNc22g1DjnXq82QwOwkkCtHLUuOILTS/KkUSTETOZznRgSvGQiKy9HoypgGteB24Ru
         ZpwwLmJ98VJu0gH8bphJ/DuVM07HiQRJwuMd+XTSg4mUeoKOk6T+EYJCMgDIIqpEj56T
         51aEhJv2ODMgeogAYmtOBb/mMdZEPN4CanqAFoOMNlFWAVkSgecjNdBJKS3BZVwYlqVg
         +7wu7ozyo69vova80NGlHlHWkX5aj+HB1W3r7LfRf4tS/Kjip9+BPYXjOWwOC4EmOaUk
         eJnkQkHXmrURmDzFgK0ovB712D6BpYzqkt54JuU6LZAlmADfTw/N7rcDVH0AaTPeRfsq
         5/QA==
X-Gm-Message-State: AOAM531r9xqgfuzx1ekj5qBJj6CIflKJ6dtbOUWIditAqeEtDWonXSvy
        1orOSwaknhcZLRsxVLu7CvWExQ==
X-Google-Smtp-Source: ABdhPJwL99/BSTWjRTj1U5PSzQVTLj1X/NsvFtRTbp1VIM938jxZMvi4BvM4RzVvsYqDFSkzDCUcsQ==
X-Received: by 2002:a2e:2417:: with SMTP id k23mr10009497ljk.373.1607943992681;
        Mon, 14 Dec 2020 03:06:32 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id q19sm2092217lfa.80.2020.12.14.03.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 03:06:32 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 1/2] usb: dwc3: drd: Avoid error when extcon is missing
Date:   Mon, 14 Dec 2020 13:07:40 +0200
Message-Id: <20201214110741.8512-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214110741.8512-1-semen.protsenko@linaro.org>
References: <20201214110741.8512-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "port" node is missing in PHY controller node, dwc3_get_extcon()
isn't able to find extcon devices. This is perfectly fine in case when
"usb-role-switch" or OTG is used, but next misleading error message is
printed in that case, from of_graph_get_remote_node():

    OF: graph: no port node found in /phy@1234abcd

Avoid printing that message by checking if the port node exists in PHY
node before calling of_graph_get_remote_node(). While at it, add the
comment from mentioned code block, explaining how checking the port
availability helps to avoid the misleading error.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in v4:
  - Moved the comment from patch 2/2 to 1/2
  - Fixed typos in commit message and comment
Changes in v3:
  - Split patch into two patches: logic diff and style diff

 drivers/usb/dwc3/drd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 3e1c1aacf002..da428cf2eb5b 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -462,8 +462,18 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 		return edev;
 	}
 
+	/*
+	 * Try to get an extcon device from the USB PHY controller's "port"
+	 * node. Check if it has the "port" node first, to avoid printing the
+	 * error message from underlying code, as it's a valid case: extcon
+	 * device (and "port" node) may be missing in case of "usb-role-switch"
+	 * or OTG mode.
+	 */
 	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
-	np_conn = of_graph_get_remote_node(np_phy, -1, -1);
+	if (of_graph_is_present(np_phy))
+		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
+	else
+		np_conn = NULL;
 
 	if (np_conn)
 		edev = extcon_find_edev_by_node(np_conn);
-- 
2.29.2

