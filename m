Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EE82EE9C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbhAGXet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbhAGXes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:34:48 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCA0C0612F8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 15:34:08 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id q5so8443765ilc.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 15:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HiZ/f0eHV5aQFZa+Y8E8w0anBR8YlRAd0P5p11hd21Q=;
        b=bi3iyF594n09MDCSVSCiyjO+ne3h666WZxMh8k5ozUoKAFfkzQSlJO+FVULBXEhnKQ
         DWrLKTOF8SpB5jFeJRr1gJYpfh+wE4Azs8o3phz8oVAdLPK4Gvg5gf+olk6iEuygy2MQ
         KPS4JWhZ/2doj1g3CJTmD7x8mBZcHw+0ifkGbe/wyrPWZLKPsgQsH/BmjrXC7JVaCSle
         vIwey3oJzIBVDPDWZKxRpBrqjtfEgAAG7oIV1lWSd7s9Q/TeNnurLrIDUqRfFTXLlMRK
         8k/qGboO8sFuWJUfst1Vhxt2ZZQWcbgILUjaBWlXyo8a38IRRaVFBxr56dGmyr2LDdVj
         XqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HiZ/f0eHV5aQFZa+Y8E8w0anBR8YlRAd0P5p11hd21Q=;
        b=jQL4d79RChg/kt0b/4DXMP9C8a7npdGbAdatWtmeWpPLzsd3B2G5Yv7q7oIxVZqtCQ
         QTpxSjCFb4BkNXzKifsajtNWsf9hti1Y7asplc18BesoifRW/LmwMoeHhZ+8XpeYOeJS
         CjY6cZFvQTE68td3vQf3od/n8yJA7KZMwWg5ZHEV3F4Hl5Iq/yEuOVNzfmJvQgkwwI1P
         +aFVyNC+BNtzllkUkhiu3GYE9FAu56vbndPhZklI2sOKG06nH4cBLWim4jR63JXjk+o+
         qJvYHvmego6965hcQVlFui8qnSoMoccoOmtURyosmdgfq+gmKJFBsawVh3oesocVKaHL
         Y6Jg==
X-Gm-Message-State: AOAM531RcjcMeB55D+y67LooT54Ts0Yrqzkn8i+32T6xRwRHYRBPhGpN
        AAq6GM9ZJJiTLTckII7YxeA3zQ==
X-Google-Smtp-Source: ABdhPJxn7aD4n6NGnZR2YanSnANfePYBUaScug0tpdv9ckw4F2oMe0QIzJmRZiToQH06QxVoMbaKow==
X-Received: by 2002:a92:6403:: with SMTP id y3mr1248404ilb.72.1610062447746;
        Thu, 07 Jan 2021 15:34:07 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o195sm5648521ila.38.2021.01.07.15.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 15:34:07 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        agross@kernel.org, ohad@wizery.com
Cc:     evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] net: ipa: support COMPILE_TEST
Date:   Thu,  7 Jan 2021 17:34:00 -0600
Message-Id: <20210107233404.17030-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the IPA driver as a possible target when
the COMPILE_TEST configuration is enabled.  Two small changes to
dependent subsystems needed to be made for this to work.

Version 2 of this series adds one more patch, which adds the
declation of struct page to "gsi_trans.h".  The Intel kernel test
robot reported that this was a problem for the alpha build.

David/Jakub, please take all four of these patches through the
net-next tree if you find them acceptable.

Thanks.

					-Alex

Alex Elder (4):
  remoteproc: qcom: expose types for COMPILE_TEST
  soc: qcom: mdt_loader: define stubs for COMPILE_TEST
  net: ipa: declare the page pointer type in "gsi_trans.h"
  net: ipa: support COMPILE_TEST

 drivers/net/ipa/Kconfig               | 10 +++++---
 drivers/net/ipa/gsi_trans.h           |  1 +
 include/linux/remoteproc/qcom_rproc.h |  4 +--
 include/linux/soc/qcom/mdt_loader.h   | 35 +++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 6 deletions(-)

-- 
2.20.1

