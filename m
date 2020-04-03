Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9694D19E1B6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 02:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDDAAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 20:00:08 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:26382 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgDDAAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 20:00:07 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vH445nXfzBh;
        Sat,  4 Apr 2020 02:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585958405; bh=ZL1FnraQ0/rs6zSMOmrniVCYmeY3lor0j5mVDSLrkwQ=;
        h=Date:From:Subject:To:Cc:From;
        b=g96g/S/HMVqayegesKET2uy/rGUz5fVOTxMYhm6LLgpGPeyWJo+kzZJlxYzUg4GOu
         rbfz2yXiLRB0jQrSBF+cOmjussS0DlyAbPmRWxanmFsryVatBe17SPlI1vr9JrOedD
         Hv6ndl6700AAUjF0cySL/WfZIADP/j0eWZ7p+CbwckRXrNpIm0FS8F3saNKUQyu+lq
         HKBqSHGuVPHMfePnha96KnV9SODP/TOzuRz7/P/zKHQwVwYPTgCxyQkV0FPWR4/0SK
         v/FaCCCITgKpiDSTkXRLiD2dMQU+FnZXpwRWl8U79RuIxr2C49fsqZ6VCWC3vercGS
         wueAzHUFwrm9g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sat, 04 Apr 2020 01:59:58 +0200
Message-Id: <2b6d70595475a3ddbd5bb8ae1765868a98c404b6.1585958250.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/5] usb: chipidea: usb2: constify zynq_pdata
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pdata is copied anyway to allow setting device name.
Make the source const.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/usb/chipidea/ci_hdrc_usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index c044fba463e4..62cf8a99cf78 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -28,7 +28,7 @@ static const struct ci_hdrc_platform_data ci_default_pdata = {
 	.flags		= CI_HDRC_DISABLE_STREAMING,
 };
 
-static struct ci_hdrc_platform_data ci_zynq_pdata = {
+static const struct ci_hdrc_platform_data ci_zynq_pdata = {
 	.capoffset	= DEF_CAPOFFSET,
 };
 
-- 
2.20.1

