Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353342A8AC1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbgKEX2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:28:49 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:14025 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732577AbgKEX2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:28:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604618927; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=v3U3uqgxyr0I0+Y/blUz/qlnw3UtBamburl8xuGxoqk=; b=ltzKKM400syXsSPf/8o1PNJ7ghO4rmf9cHloTO9ZavEwNEEu6wwwQraHHVQOI8S3E+TKlFT2
 Rxk3XpLLaprLX3JqngcRWNNBbkeFiJalkL64NsQWiOdmYMavXIf7Zp3lrpjw8ZvWNoJIseB4
 Iyjnhhg67P8DI3Kl6bwL7WolkeU=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fa48aaef00e907e28a35868 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Nov 2020 23:28:46
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CEAD8C43387; Thu,  5 Nov 2020 23:28:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8986FC433C8;
        Thu,  5 Nov 2020 23:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8986FC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v2 1/2] usb: dwc3: gadget: Allow runtime suspend if UDC unbinded
Date:   Thu,  5 Nov 2020 15:28:24 -0800
Message-Id: <20201105232825.5233-2-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201105232825.5233-1-wcheng@codeaurora.org>
References: <20201105232825.5233-1-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DWC3 runtime suspend routine checks for the USB connected parameter to
determine if the controller can enter into a low power state.  The
connected state is only set to false after receiving a disconnect event.
However, in the case of a device initiated disconnect (i.e. UDC unbind),
the controller is halted and a disconnect event is never generated.  Set
the connected flag to false if issuing a device initiated disconnect to
allow the controller to be suspended.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
 drivers/usb/dwc3/gadget.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 5d879b7606d5..babf977cadc0 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2012,6 +2012,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		}
 	}
 
+	/*
+	 * Check the return value for successful resume, or error.  For a
+	 * successful resume, the DWC3 runtime PM resume routine will handle
+	 * the run stop sequence, so avoid duplicate operations here.
+	 */
+	ret = pm_runtime_get_sync(dwc->dev);
+	if (!ret || ret < 0) {
+		pm_runtime_put(dwc->dev);
+		return 0;
+	}
+
 	/*
 	 * Synchronize any pending event handling before executing the controller
 	 * halt routine.
@@ -2050,10 +2061,12 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
 						dwc->ev_buf->length;
 		}
+		dwc->connected = false;
 	}
 
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	pm_runtime_put(dwc->dev);
 
 	return ret;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

