Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9CA2A8AC0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbgKEX2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:28:48 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:44066 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732625AbgKEX2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:28:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604618926; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=1KAhvuLf/yvnWPBQm8h6VYbwH4+MlaWZaU2ApTgCAck=; b=Vu0wksspNZQkYYX9gAWiR8wSVzN8E1f2AgbQRKxoMKM+jTrBxkftsB/ts59Ru1uk5SklD9nm
 wXugin4UHeFjWp/GOWr0t2qgx/lLzYL1+nhxcD9m1GE8s+gXl9NcGZ+Q+lCvJc4oJQmPajcc
 BWlqy4U21Vhs7RDQdHXhvrYwKbQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fa48aad903b44cb0e659c76 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Nov 2020 23:28:45
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0CDC5C433FF; Thu,  5 Nov 2020 23:28:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D922EC433C9;
        Thu,  5 Nov 2020 23:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D922EC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v2 0/2] Allow DWC3 runtime suspend if UDC is unbinded
Date:   Thu,  5 Nov 2020 15:28:23 -0800
Message-Id: <20201105232825.5233-1-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Modified logic for executing the runtime PM resume.  Using a sychronous get
   call to avoid race conditions.

During the following scenario, the DWC3 runtime suspend routine is blocked as
the connected flag is still true:

1.  Enumerate device w/ host.
2.  Gadget is unbinded
	- echo "" > /sys/kernel/config/usb_gadget/g1/UDC
3.  Disconnect the USB cable (VBUS low)
4.  No dwc3_gadget_disconnect_interrupt() seen (since controller is
   halted from step#1)
5.  Runtime PM autosuspend fails due to "dwc->connected" being true
(cleared in dwc3_gadget_disconnect_interrupt())
6.  Gadget binded
	- echo udc_name > /sys/kernel/config/usb_gadget/g1/UDC
7.  No runtime suspend until cable is plugged in and out

Technically, for device initiated disconnects, there is no active session/link
with the host, so the DWC3 controller should be allowed to go into a low power
state.  Also, we need to now consider when re-binding the UDC,
dwc3_gadget_set_speed() is executed before dwc3_gadget_pullup(), so if the DWC3
controller is suspended/disabled, while accessing the DCFG, that could result in
bus timeouts, etc...  Change the dwc3_gadget_set_speed() to save the speed
being requested, and program it during dwc3_gadget_run_stop(), which is executed
during PM runtime resume.  If not, previous setting will be overridden as we
execute a DWC3 controller reset during PM runtime resume. 

Wesley Cheng (2):
  usb: dwc3: gadget: Allow runtime suspend if UDC unbinded
  usb: dwc3: gadget: Preserve UDC max speed setting

 drivers/usb/dwc3/core.h   |   1 +
 drivers/usb/dwc3/gadget.c | 121 ++++++++++++++++++++++----------------
 2 files changed, 71 insertions(+), 51 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

