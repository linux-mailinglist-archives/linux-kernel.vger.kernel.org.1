Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1D2FF30B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbhAUSP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbhAUJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:46:58 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BEAC061793
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:28 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e15so939379wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBLwu+617zQ07npA6RXz6Tf17IOtHddjN6cfc3yfTCI=;
        b=dfLuKNzZ3ku/O7QE9b2/0QO9aIwxpb3WHqXtAqE0V52WOktO4jw01QZw73WtJjBr5U
         5mbmCFDOjUvG7AIVz4lCKaG7O38kTo78KyHCMLwM2hpML1vlVQoxQlfgxPRa2ZpNWiDx
         djcKyw139NyoRRzxu34PYyn18P55ak47Cnk5UiYhYqTXj1RfRTHlflsQUm44X4yxZG23
         RK/qDniEwy98Fpwz8UOYSSP2NB0BH/u9Opdh9QvEXlDTxfo3alHKXGU7uUVKhBpqsQiJ
         oFNwGbIcHfiDH7byUXHl79PkoSsqNnyfLNAKCJPWrfEjYjuGpOFrIRFf5iKjh5QVVtic
         Rbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBLwu+617zQ07npA6RXz6Tf17IOtHddjN6cfc3yfTCI=;
        b=iRQDrA3bfpvjR1MpWyp4Q/SrJ3bPxQd1v/1tONfxe/yxlHPZrd4vqv0x1luBthi4Of
         A9XQoKtuuLL7NqbCN5ZvBkpodUcUh8k3WSo51D3VYW3ixjD7c5/EV1zxoR/FZQFZ2hpi
         IgW/So9GWwnPikjMnN+hXcOlSyK8OgxB056HseWLN9Kew4iM4iGpC3Bl+kcMnckLjYdm
         gQOE2t2+cEAjCt6hCqGBFWedHbRsyp4wExnB4SHkjss8T5msRFedf+Ytd+0CS6lA37e/
         8HZykfbqOGmsybquXY1dBbm9mweMc0xJjzb9PFszzw8RXfyWqrjmCvOjz5eIrZ2eL+Ll
         QP8w==
X-Gm-Message-State: AOAM531SOJcbpEZDAIXVkGeKH5Epb7IStu8wHoI6L84zfY/hbVgyEOqs
        GFw5jE/1Ri3QJ92XxqFa9+MFKNaDzjQjXAEs
X-Google-Smtp-Source: ABdhPJwO5trW2/kFg2672ZAmOG6H9jxxi6HftdC4+xImSiIHF4p72gEqrWXXpradGXLbGc8ASwjlwQ==
X-Received: by 2002:a05:600c:2249:: with SMTP id a9mr8317598wmm.169.1611222326913;
        Thu, 21 Jan 2021 01:45:26 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Lijun Ou <oulijun@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Wei Hu <xavier.huwei@huawei.com>,
        Nenglong Zhao <zhaonenglong@hisilicon.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH 04/30] RDMA/hw/hns/hns_roce_hw_v1: Fix doc-rot issue relating to 'rereset'
Date:   Thu, 21 Jan 2021 09:44:53 +0000
Message-Id: <20210121094519.2044049-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1398: warning: Function parameter or member 'dereset' not described in 'hns_roce_v1_reset'
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1398: warning: Excess function parameter 'enable' description in 'hns_roce_v1_reset'

Cc: Lijun Ou <oulijun@huawei.com>
Cc: "Wei Hu
Cc: Weihang Li <liweihang@huawei.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Wei Hu <xavier.huwei@huawei.com>
Cc: Nenglong Zhao <zhaonenglong@hisilicon.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index f68585ff8e8a5..23fe8e9f61da5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1391,7 +1391,7 @@ static void hns_roce_free_mr_free(struct hns_roce_dev *hr_dev)
 /**
  * hns_roce_v1_reset - reset RoCE
  * @hr_dev: RoCE device struct pointer
- * @enable: true -- drop reset, false -- reset
+ * @dereset: true -- drop reset, false -- reset
  * return 0 - success , negative --fail
  */
 static int hns_roce_v1_reset(struct hns_roce_dev *hr_dev, bool dereset)
-- 
2.25.1

