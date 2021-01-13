Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013D72F50D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbhAMRQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbhAMRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:16:17 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465A2C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:15:37 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id u26so5667219iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mbojagrid7EMat3k71i//dwCY64PLUqlpY24sZ6+aKA=;
        b=cGZRplSHTD2Y4jia/SdOPef5K2u3AZ4W7bsSTUySGHzADee1NeaONoQ3XbhjZR07v3
         VeLgYQlH+mgzbf7Z/OsuGxSdMPW1jSbf5APzuuNnMm7AmcwG5+x2M0Trt+ds0XHfrxOU
         R8VlD9WQXOMT7KYBRjHd0lOgtQLDecAt402eH1BBCUeo7Em7RZp0cDYAiXeczmSDlnpT
         7mAiGx4h2bPuD+XoK/Ko6z6GpaTLmcUCpn7eHrCNiBEas5MnK2HT9DiccOp5EepmguHl
         y+jo4f+eaqpTdWkbU626eKCI9selPjjEFP+9ZuxM0CdRKGnxAuso6lQ6a7h8hHUbsVjY
         kkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mbojagrid7EMat3k71i//dwCY64PLUqlpY24sZ6+aKA=;
        b=lNGFk14Ia1anVOYX2WMX6L7DtKE1lJnMD23RDMURxTyHrdUta8mW0w5OD+lSWrTuYB
         tCyb+TKa4RBE5B0hIFC2B5Qw2PoLuwl5nTr2jbGkEYppkrIckDEDEYp3zVI2PwSif5RW
         VfzMq8l1q/Gmk6hfAM1WgXDFhVERjdSwr4TDZv2Z8s8S5ZUb54eNrGLr0PZdu6LYHN07
         c6vTIcqA94stLhY4ah91gnlnvARmcVNLqkoE5f8T3ofufuF1enkUz1mHfg85fn7irVbL
         xOowb2xmpuEkMzMOLhp3bscDZDg8wJfZnMvCZgDSd/t/Y7UzJ1lB/HwYjetXsGGpJFkG
         uK1A==
X-Gm-Message-State: AOAM532XkxatoSKvLdypHBSAjbHhMP00Y5RtGt0S6+Q/diuiQk9Gfxex
        iQ9D2iKybGeRaKI9JpG61H3d/Q==
X-Google-Smtp-Source: ABdhPJx7Kj/HdS2tLEosrnwVkhSKth4ETMmDdnz9gaprNjmrht4ej3iqefMJY5gNUu1aAr2Hsp/IYQ==
X-Received: by 2002:a92:dc4a:: with SMTP id x10mr3208152ilq.153.1610558136726;
        Wed, 13 Jan 2021 09:15:36 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id h9sm1120579ili.43.2021.01.13.09.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 09:15:35 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] net: ipa: GSI interrupt updates
Date:   Wed, 13 Jan 2021 11:15:26 -0600
Message-Id: <20210113171532.19248-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements some updates for the GSI interrupt code,
buliding on some bug fixes implemented last month.

The first two are simple changes made to improve readability and
consistency.  The third replaces all msleep() calls with comparable
usleep_range() calls.

The remainder make some more substantive changes to make the code
align with recommendations from Qualcomm.  The fourth implements a
much shorter timeout for completion GSI commands, and the fifth
implements a longer delay between retries of the STOP channel
command.  Finally, the last implements retries for stopping TX
channels (in addition to RX channels).

					-Alex

Alex Elder (6):
  net: ipa: a few simple renames
  net: ipa: introduce some interrupt helpers
  net: ipa: use usleep_range()
  net: ipa: change GSI command timeout
  net: ipa: change stop channel retry delay
  net: ipa: retry TX channel stop commands

 drivers/net/ipa/gsi.c          | 140 +++++++++++++++++++--------------
 drivers/net/ipa/ipa_endpoint.c |   4 +-
 2 files changed, 83 insertions(+), 61 deletions(-)

-- 
2.20.1

