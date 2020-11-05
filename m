Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCC62A7696
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 05:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgKEEue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 23:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgKEEud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 23:50:33 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D811C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 20:50:31 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id q1so128066oot.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 20:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXvgDxUHZDgdioVnVUBDyJDddujUGaP7Ie4ZuxcP+CI=;
        b=nucqWknzsoq365apuWXQVlZcjnkYpcNJaHtDoaRoDKUB9VtXBeHQua/2hyFp8jlOHJ
         lIAltg8yVtQrq5Nmbo0qFJA08479IkdQvYUt8IaJT7uBn9/JfDt4FK5lDlw1aiCyiPD9
         UJEuBld5zdrWbrIS5jqvzdqN9LjbCW1nYejygDLY39k1TX9eRYMfpmQbpdTfzGDY/APs
         AUGCAhhWhsXwal0ove22yWRvOt8Jo17OpD/DOR8kA4njQXL1TA9EtWJM4zf+50AaOwLS
         DzpatBmTWwhEpyuBu2P6DKQfBUvykIm6uJ7Rx8gII5ghxEcwxE1lSWjhy8NnDwi8TcrM
         GpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXvgDxUHZDgdioVnVUBDyJDddujUGaP7Ie4ZuxcP+CI=;
        b=sQuMRwZR7eDwMzRRK8ftSi+lZoydCS+jUI4vY9IcXorTrv+AXck4oPkAtdpMgPivd6
         0im+d/skfwlwOc4Ps7FxxqzXbnAf5xYWAhJKU4ZylIOLAu7w9DlZY7TNcsIXJYqD0349
         J3HJ4mBDvrhbQUkRdYP0WFGahcQ6nI8MM5zxj4WMJYi409qafsIEYH2/kDFuxI0HZXJr
         ohuBLMle01hjKIHa5NSgTJvgesAENxmozGQGHBgwbtbqeZLEkEVVKoiC0F8M/+Oxou6C
         VPnfN35mcdAJfZbUaH/8Nkw9g4LNWale84dUYe/w9xkeyRPd234rOvo1ogkc9FnaFiqR
         P9nA==
X-Gm-Message-State: AOAM533cWLsmpiBYvqRkxWRBw0tXH/ZUTAgZ2DQdv3vKA/m3FYJwmLGl
        RFDPgiLTT0gRMr0uqlEzGIu2ZQ==
X-Google-Smtp-Source: ABdhPJyMFQp7wq6UClyhJmtWpQ9QnmWlEsO1pCt2RlzkGZsjTJ+HA4MmmJIEK8SAHA5Oy68pkjl6uQ==
X-Received: by 2002:a4a:e96d:: with SMTP id i13mr546876ooe.66.1604551830486;
        Wed, 04 Nov 2020 20:50:30 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k13sm100553ooi.41.2020.11.04.20.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 20:50:29 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] remoteproc: Improvement for the Qualcomm sysmon
Date:   Wed,  4 Nov 2020 20:50:47 -0800
Message-Id: <20201105045051.1365780-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core part of this series is the update to the sysmon driver to ensure that
notifications sent to the remote processor are consistent and always present
valid state transitions.

In testing this I finally took the time to fix up the issue of the SMP2P based
graceful shutdown in the remoteproc drivers always timing out if sysmon has
already successfully shut down the remote processor.

Bjorn Andersson (4):
  remoteproc: sysmon: Ensure remote notification ordering
  remoteproc: sysmon: Expose the shutdown result
  remoteproc: qcom: q6v5: Query sysmon before graceful shutdown
  remoteproc: sysmon: Improve error messages

 drivers/remoteproc/qcom_common.h    |   6 ++
 drivers/remoteproc/qcom_q6v5.c      |   8 +-
 drivers/remoteproc/qcom_q6v5.h      |   3 +-
 drivers/remoteproc/qcom_q6v5_adsp.c |   2 +-
 drivers/remoteproc/qcom_q6v5_mss.c  |   2 +-
 drivers/remoteproc/qcom_q6v5_pas.c  |   2 +-
 drivers/remoteproc/qcom_q6v5_wcss.c |   2 +-
 drivers/remoteproc/qcom_sysmon.c    | 121 +++++++++++++++++++++-------
 8 files changed, 109 insertions(+), 37 deletions(-)

-- 
2.28.0

