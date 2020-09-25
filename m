Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83E5278477
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgIYJ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgIYJ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:56:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631AFC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:56:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s12so2866550wrw.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9+H6h4cgVmMWVMCKArQ1jX8o5awoy/k5dT1ORGPQ8M=;
        b=VzDCVBZHq1xwrAYRIskF6LmQWraYp2yScKpgz73ZgUMlV9/hr3fOyojeEfTCr4SdvW
         ZNXVqyzaDHTFG7DfE/klcXSLSAJsc2C5b8a9zdchR9LbjZOZ516XDkkWigtKwzmS1GJN
         Fik3fYVpLd5XnGaoi6D6dVO/RGI1XkZpiLTTe8fBX6LOwKW5w00FbR2kcw9AuYzDMMX0
         TRKSSt+df09EuJrPuaPBldl7pNopYNB0hDES8sHwUF277Vyi5OEUDwxPxv5nQaRORQZe
         396nWxcvrZzy2zCpI+CCTx6AB67e+8booYOTRBH+nVJEQw2PdtoSHoucDxIlYtc3G4Oc
         Qe7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9+H6h4cgVmMWVMCKArQ1jX8o5awoy/k5dT1ORGPQ8M=;
        b=VlAUdpW93gDmh8nh22Lhl6rkmOq+H4qAZh2BYq8zOIzOtCYQk7oA6A+USx/4V+1pzq
         CYpMvugcKrdRwfIMs7YGz9GFq6qvqMs/MhGikVGkYPa12LQgfTU22aprU0TacBNgi/R9
         GZOX4lMICHDTMjz/a2A+nuqHsXxk6Uo+cnOXoyHVeGC4q5FnBaFGAYUboVbTABFPPjRz
         p7bFwcWC1cz1lcb0qWaErxjte6KYIOibS/6BGAh5byFZpzHJkW8tjdDKlo4j20aYGXAi
         /kJHAsnnzjcG8HSYIaaUMnPbMpvgR0QsqzAKemNXG8H9RAPyPVhxgvuPSUFydFB1ceDt
         ydLg==
X-Gm-Message-State: AOAM531pkDXdQcs9j/Yzdw9L6qbNjpGNJ5lkhztsWHGEt6/qyE0KNC1q
        OoHUxY1VyiBbHthMmwJj+OsLzQ==
X-Google-Smtp-Source: ABdhPJwi9yN0JgR4HgcFChTb5oflFvaQsrOZ8ZUPJhfD3NFm1Sauq5JLjUxjFU1fndEBIJytOzKg3g==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr3505366wrq.365.1601027767088;
        Fri, 25 Sep 2020 02:56:07 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g14sm2227598wrv.25.2020.09.25.02.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 02:56:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] slimbus: fixes for 5.10
Date:   Fri, 25 Sep 2020 10:55:17 +0100
Message-Id: <20200925095520.27316-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, 

Here are few fixes found recently while testing Qualcomm SSR (SubSystem Restart)
feature on SDM845 SoC. Mostly the fixes are around when device absense is reported.

If its not too late, can you take them for 5.10.

Many thanks,
Srini


Srinivas Kandagatla (3):
  slimbus: core: check get_addr before removing laddr ida
  slimbus: core: do not enter to clock pause mode in core
  slimbus: qcom-ngd-ctrl: disable ngd in qmi server down callback

 drivers/slimbus/core.c          | 6 ++----
 drivers/slimbus/qcom-ngd-ctrl.c | 4 ++++
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.21.0

