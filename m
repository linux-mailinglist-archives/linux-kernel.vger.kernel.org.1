Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E71A2E7518
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 00:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgL2XE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 18:04:27 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:41733 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgL2XE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 18:04:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609283042; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=EcGr7jPbsIV016J8qpPWQhkLnpm44nvrJJGdYGx4j2I=; b=bl4cOUpWdo/x0ltg+Lq5tPn3Juhl/YC7D4TSxyp1/usgJmyJaIIWY86OIrHd+kWNFS/4G/tp
 VIAQOzLBdPG+kpGFxNFqlLFE90kKMLbymqWIgDaFXlPMIWJf3Zg9EA2hjLp+1iS6utOzLvK2
 Aw5s4m6jMT5QDFGI35CGrxbF6FY=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5febb5c86d2f42c6666911c1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Dec 2020 23:03:36
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 52566C433C6; Tue, 29 Dec 2020 23:03:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A9A0C433C6;
        Tue, 29 Dec 2020 23:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A9A0C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     peter.chen@nxp.com, balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH 0/3] Add vbus draw support to DWC3
Date:   Tue, 29 Dec 2020 15:03:28 -0800
Message-Id: <1609283011-21997-1-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices are connected to standard downstream ports (SDP) and draw current
from them.  The current rates are defined in the BC1.2 specification, and
highlights the different charge rates depending on the device state.  The DWC3
gadget does not currently have a mechanism to notify external drivers about
how much current can be drawn.

The current rates are notified by the USB gadget layer, and the DWC3 gadget will
propagate this potentially to external charger drivers.  Also, the USB gadget
needs to be fixed to only allow 100mA current draw when receiving a bus reset
from the host, as the BC1.2 specification states that this is the max current
draw possible when in the connected and unconfigured state.

Wesley Cheng (3):
  usb: dwc3: gadget: Introduce a DWC3 VBUS draw callback
  usb: gadget: composite: Split composite reset and disconnect
  usb: gadget: configfs: Add a specific configFS reset callback

 drivers/usb/dwc3/gadget.c      | 11 +++++++++++
 drivers/usb/gadget/composite.c | 21 +++++++++++++++++++--
 drivers/usb/gadget/configfs.c  | 24 +++++++++++++++++++++++-
 include/linux/usb/composite.h  |  2 ++
 4 files changed, 55 insertions(+), 3 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

