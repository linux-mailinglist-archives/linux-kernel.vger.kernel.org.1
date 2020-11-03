Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26422A583A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbgKCVt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:49:59 -0500
Received: from z5.mailgun.us ([104.130.96.5]:37364 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731136AbgKCUtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:49:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604436563; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=v38VIvvqFPW9T8r0lWGRdQ5SsoAKhs1w4NYwSBxeq3U=; b=mbhgCC+Pd0rV8h24yo8cqFPujSWOuwQS3HwTbwRs5l8GrZxznRJWhZhyLtG53DGAwDwmm3X7
 regqbMc+2Aa4C/ACZ4GcuUturTgGYdeN+uISmnuVBUr81LUvdz6hojUDPpVXuCFYc1qGUGrX
 bNKdZfgTknarqRQOpCHfDUQKuQY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fa1c2527b1a71d66858946a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Nov 2020 20:49:22
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C49D5C384EA; Tue,  3 Nov 2020 20:49:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from khsieh-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7A5BC43443;
        Tue,  3 Nov 2020 20:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7A5BC43443
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=khsieh@codeaurora.org
From:   Kuogee Hsieh <khsieh@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>, tanmay@codeaurora.org,
        abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] fix dp link training failed at irq_hpd request
Date:   Tue,  3 Nov 2020 12:48:59 -0800
Message-Id: <20201103204902.11899-1-khsieh@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some dongle require link training be done at irq_hpd request. This serial
patches address the issues so that DP/HDMI display can be lit up properlly.
This serial Patch also fixes clock stuck at "off" state error caused by
previous link training failed.

Kuogee Hsieh (3):
  drm/msm/dp: deinitialize mainlink if link training failed
  drm/msm/dp: skip checking LINK_STATUS_UPDATED bit
  drm/msm/dp: promote irq_hpd handle to handle link training correctly

 drivers/gpu/drm/msm/dp/dp_catalog.c |  2 +-
 drivers/gpu/drm/msm/dp/dp_catalog.h |  2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 60 +++++++++++++++++++++--------
 drivers/gpu/drm/msm/dp/dp_display.c | 40 ++++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_link.c    | 29 +++++++-------
 drivers/gpu/drm/msm/dp/dp_panel.c   |  2 +-
 6 files changed, 96 insertions(+), 39 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

