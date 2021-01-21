Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00E82FE964
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbhAUL4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730769AbhAULtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:49:06 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDCDC061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:48:25 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id d81so3378358iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pgzMn/k8q2SpPgT62u+sa9vYo/2bqeDqsny+/wqvXnI=;
        b=KCTJPPWZrJ0zTy1H+SG6DCOf0FH+X6DrC8EUoRFmpYGlFUAa0DXvBlsVGTs+IpoJ3V
         h0SS1tzw6N/O26VsfkxyATuXInBXc3QRdVHUgztUU0XxD9zzh6JtzWl4BB8nVQy8Nc2p
         vOiUWRgcdBJT1QdltB3ho5ICJ7rti3tfUIaocSBC68wBDlIqi246BMgGD0SKLIA/dS9W
         1kE8teNFCAYB24+EvN90qpcIOXQWAdTTEEqUuqjM/B+lrUwx5UTgX8ZL2N5nbi6bPrJf
         CMnCfkfom2qA8d69kgcs6g+GiwGIA3yn1movkyOJb7vPDFc1V5dqCtu0ksPuJjsK8JnZ
         blrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pgzMn/k8q2SpPgT62u+sa9vYo/2bqeDqsny+/wqvXnI=;
        b=jB7Qr9MLlbr5s+aBKzeIoyEBTNxS/UWPGgroLMCH5U1AMnBj8T2LeQsURIdEGS0BDb
         g7FlmeJ2fEt/P15hgO5Zuio9qTXfCnMwZfIsNQBQaWy8c67h/CBO96QiRNAoBOcKfmM+
         W2QCGAnBoK2jlo8hednAdkhIaiUdZvDTqSC+AFcEcCE1XPr5Q6SHGd1Ma8T+lqRh9OxM
         lzuVUpb7er8YZ3ygVWoNIBxQVkdtq1fujWGg58wdGjsGq250c4RLCSBmJozEh0raFPZw
         7M5JLkC2lN8wxKpmTjow/9+zoxab3ej/RxL1+tS9FFG9TFvrb7rySKhjj4AXg4HPS+6H
         /c7Q==
X-Gm-Message-State: AOAM532e+JdB5pSuSNVHY4Lq/8iVsGaImQ+2Lz4DJI9Gr21Wt11nMMh/
        mALUERWV+kUppNZdkLQyfNB41Q==
X-Google-Smtp-Source: ABdhPJxzUz6DR6rGcz/VIUM/2sK+xmL9J7EJci3gxnMTRr6fEKLP9yblRLjHfzJVeVo0fyhPHC5iXw==
X-Received: by 2002:a92:404d:: with SMTP id n74mr10746398ila.88.1611229704756;
        Thu, 21 Jan 2021 03:48:24 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id p5sm2762766ilm.80.2021.01.21.03.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 03:48:24 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/5] net: ipa: NAPI poll updates
Date:   Thu, 21 Jan 2021 05:48:16 -0600
Message-Id: <20210121114821.26495-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 1 of this series inadvertently dropped the "static" that
limits the scope of gsi_channel_update().  Version 2 fixes this
(in patch 3).

While reviewing the IPA NAPI polling code in detail I found two
problems.  This series fixes those, and implements a few other
improvements to this part of the code.

The first two patches are minor bug fixes that avoid extra passes
through the poll function.  The third simplifies code inside the
polling loop a bit.

The last two update how interrupts are disabled; previously it was
possible for another I/O completion condition to be recorded before
NAPI got scheduled.

					-Alex


Alex Elder (5):
  net: ipa: count actual work done in gsi_channel_poll()
  net: ipa: heed napi_complete() return value
  net: ipa: have gsi_channel_update() return a value
  net: ipa: repurpose gsi_irq_ieob_disable()
  net: ipa: disable IEOB interrupts before clearing

 drivers/net/ipa/gsi.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

-- 
2.20.1

