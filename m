Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA262ACA4E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbgKJBU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:20:56 -0500
Received: from z5.mailgun.us ([104.130.96.5]:44389 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgKJBUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:20:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604971254; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=t/aMaPilFWKPkOrUGWkhN1HWlqHvRzdumb+OAPpywOM=; b=u4Mg3b/F+VhiPWpfqqEQSiSqCZwyv/TwSAjsTcNJvEYeTTLM2FtTH3rIw84IO9UxK+iagvIs
 d6Eui38uiDS8y5Dj9duJmwnE+WfYJnpCsItyDLUWC8og5IkxsMlZHKfm3VI1dStUDjpFCd21
 7DitJZ7K/ncPDMx33TTLZ8lhamw=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fa9eaf19d6b206d9423917b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Nov 2020 01:20:49
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D806BC433FF; Tue, 10 Nov 2020 01:20:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE758C433C6;
        Tue, 10 Nov 2020 01:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE758C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH 0/2] Add trace events to q6v5_pas and mdt_loader driver
Date:   Mon,  9 Nov 2020 17:20:39 -0800
Message-Id: <1604971241-29000-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create and insert trace points in mdt_loader and qcom_q6v5_pas
drivers. These tracepoints will be used to analyze the time taken
at each step during bootup/shutdown of the remoteproc. Also 
provide information about location and size of firmware segments
being loaded.

Rishabh Bhatnagar (2):
  soc: qcom: Add tracepoints to mdt loader
  remoteproc: qcom: Add trace events for q6v5_pas driver

 drivers/remoteproc/qcom_q6v5_pas.c | 11 ++++++++
 drivers/soc/qcom/mdt_loader.c      |  8 ++++++
 include/trace/events/mdt_loader.h  | 57 ++++++++++++++++++++++++++++++++++++++
 include/trace/events/q6v5_pas.h    | 34 +++++++++++++++++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 include/trace/events/mdt_loader.h
 create mode 100644 include/trace/events/q6v5_pas.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

