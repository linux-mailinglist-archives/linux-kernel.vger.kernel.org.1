Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DAD2B53F4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgKPVow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:44:52 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:39063 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgKPVow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:44:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605563091; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=oc3xa/mkBQIhUBblS+TGGHDeHXWcsS+CUmK5xECBbt0=; b=PPN6bbZ4LSTp1EiOsDF1BU2xeFuUOWr2/p4kHNQSb68iCU6rYNtHXGdy2b1XGi8kPuMEO0uj
 JCmoU11Efd5WoxWDpRUQHRHo1gzToHg6Hr5RnYM7hA5sCkESj1oiUaji9QX6bH+aoktT0Inq
 czzvSD2hUCh4cRcgeX68rFZqsJs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fb2f2d2ba0e43f355268989 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Nov 2020 21:44:50
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BC5DAC43462; Mon, 16 Nov 2020 21:44:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4042C433C6;
        Mon, 16 Nov 2020 21:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4042C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v2 0/3] Add events to trace remoteproc lifecycle
Date:   Mon, 16 Nov 2020 13:44:41 -0800
Message-Id: <1605563084-30385-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Insert tracepoints in mdt_loader, qcom_scm and remoteproc_core drivers.
These tracepoints will be used to analyze the time taken
at each step during bootup/shutdown of the remoteproc. Tracepoints
in mdt_loader driver provides information about location and size
of firmware segments being loaded. Also trace the scm pas calls
used to boot/load remote processors.

Changelog:

v2 -> v1:
- Add traces in qcom_scm driver
- Add traces in remoteproc core to trace the remoteproc state
- Trace the physical address where segment is loaded in mdt_loader

Rishabh Bhatnagar (3):
  soc: qcom: Add tracepoints to mdt loader
  firmware: scm: Add tracepoints to scm driver for pas calls
  remoteproc: Add ftrace events to trace lifecycle of remoteprocs

 drivers/firmware/qcom_scm.c          |  9 ++++
 drivers/remoteproc/remoteproc_core.c | 19 +++++++-
 drivers/soc/qcom/mdt_loader.c        |  7 +++
 include/trace/events/mdt_loader.h    | 38 +++++++++++++++
 include/trace/events/qcom_scm.h      | 34 ++++++++++++++
 include/trace/events/remoteproc.h    | 91 ++++++++++++++++++++++++++++++++++++
 6 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/mdt_loader.h
 create mode 100644 include/trace/events/qcom_scm.h
 create mode 100644 include/trace/events/remoteproc.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

