Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812CC29DB21
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390643AbgJ1Xnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:43:35 -0400
Received: from z5.mailgun.us ([104.130.96.5]:29337 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733098AbgJ1Xne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:43:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603928614; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=Emczan62bueoEw9QLI1xvenf6hFHn3vzZ6A/GwOjafg=; b=TTi4Txlfbym+0+OIyilnDhptS86yNOBAumdiAMFzPYNshgiVxF3spZmqlkI0P9C6QiC0aiIh
 /NqZzectmsuXVCfhabcWbLx233o0mOgEj0SZ9dZCECckC0QdCWQUDbgcfhLB+L11cqiwwD4p
 M38r8vm3kWlw5PRusFUhTHkWLtI=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f9a02160d38100718416b42 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Oct 2020 23:43:18
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 274E9C43385; Wed, 28 Oct 2020 23:43:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C919DC433CB;
        Wed, 28 Oct 2020 23:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C919DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH 0/2] Allow DWC3 runtime suspend if UDC is unbinded
Date:   Wed, 28 Oct 2020 16:43:09 -0700
Message-Id: <20201028234311.6464-1-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/usb/dwc3/gadget.c | 114 +++++++++++++++++++++-----------------
 2 files changed, 64 insertions(+), 51 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

