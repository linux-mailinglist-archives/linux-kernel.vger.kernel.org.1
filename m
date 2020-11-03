Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896352A49B0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgKCP37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgKCP3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:41 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D67FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:41 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c18so13167264wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKsKw1F2BAQMuIzZzyGzXWp0QYVpF5RBWBEfz9BGXpo=;
        b=tfX2b2dcek+TReeBlp5mnNHEk7j9Zt0V4ZzuC/iPrgl4S/xUM2HEroQYYtGPgAKL1C
         jtvjAOQtjUm5/tAKhcMPUuWMuqQhwRKgyN+daKtU8CbInqStRD0W6RX662D8aaLmzjiZ
         ykbaRbEmK7d2FXRv0/0ZDw8LxxZW10I3QyTNqkSZ82bBdA45bDh5AM2aKH7LwwivjGpH
         TKBzvO7LcWIXU+qtSrxgMZ6/3mb+UPxBXaXSRODsi0VDgz5603D6OeQ1gUsmH+J5Llro
         Bn6Edxm91zd94g8VMXYJDu05YRQ4kYSeFjAB/hZOjN0kjz7khYmdkpxgdSRuv0wsCQD/
         VMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKsKw1F2BAQMuIzZzyGzXWp0QYVpF5RBWBEfz9BGXpo=;
        b=mohtkxfnJxG4PsqqC/0gbNHxOC7Vimp2w3O+OzJVzNg8qTwyNS7eG1fwS8AKNtl1Qi
         rWs8X7o0PNImsEkpxvJfY7FUbYSZAkKWwJHCPbZ23gktUpXPlOKoZnvgPAJl8XqsCBRb
         UTiP6Kw2rV2PB4t9ZY7HIQLyzEvvi6SuboQkHM0Ny7LHo5cBeBW0vw53kmzFO8hBh+XN
         OEecElKF4ofTQjSfm4W7HWw7nS4gJuFqIwuwdw5LDkuCg3Hjcu/Nj0ZPx5Lmw8wEpN0c
         Yeg5h6pyAiLwHWIsm5ec1BLuofVzEj4UZ44vGdjWyYJNZOU/fCsSR1C+S3hT+Qin/nAt
         iWLg==
X-Gm-Message-State: AOAM5302tULgenQx0FvkW35jY2Q36o6Z9W5lLBCOji5CADXGoMvVa17i
        gDezlratxfQkwFEB7vuO3vR0Lg==
X-Google-Smtp-Source: ABdhPJw2SrHOA51CXhnIm+fvhFzA2zVKerlb63r4uC0+TIJN662jESE5GKLXdfnCb0jRrXn9Jmj2Ag==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr333667wmj.52.1604417380263;
        Tue, 03 Nov 2020 07:29:40 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:39 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>
Subject: [PATCH 23/25] soc: ti: k3-ringacc: Provide documentation for 'k3_ring's 'state'
Date:   Tue,  3 Nov 2020 15:28:36 +0000
Message-Id: <20201103152838.1290217-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/ti/k3-ringacc.c:163: warning: Function parameter or member 'state' not described in 'k3_ring'

Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/ti/k3-ringacc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 1147dc4c1d596..9bd771eea4b8e 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -137,6 +137,7 @@ struct k3_ring_state {
  * @elm_size: Size of the ring element
  * @mode: Ring mode
  * @flags: flags
+ * @state: Ring state
  * @ring_id: Ring Id
  * @parent: Pointer on struct @k3_ringacc
  * @use_count: Use count for shared rings
-- 
2.25.1

