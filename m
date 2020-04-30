Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AEB1C0A28
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 00:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgD3WNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 18:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgD3WNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 18:13:30 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE7AC035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 15:13:30 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m67so7510722qke.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 15:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttGbMYEidP9RHX/uRxBhRpBjy6W2hzcyfjV0O4d9WKE=;
        b=OYotSsTtHP+CBwwxAdzanXjajY7QgCa6QOqGYZPriul6ZVPJK5U5/E0VwCnhG7cQdH
         SdalMlBPs9omH4/Tor3sCeR1u2sR/KHFz/Holj3bcb4FXKawcwa/YjB+DAQeth022G52
         BuXNuqecz43dY+ArXWMoswU9u6rR0liAkTlsKwyzVA3TGJxRPxiO4XvcpfNCx6J//iVu
         ydG1il5bpb5dVme8BoROP1AULIJqOrj/e911s4L0RsyaRJDCG9YXoM7mKv2JaIW9INrd
         lk/H4sSjvK8nvpiVIwospoSac8TFUbNPNoLFqfRsolnxOJOFbBh01oh5Ow0QVZFXQGDd
         pzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttGbMYEidP9RHX/uRxBhRpBjy6W2hzcyfjV0O4d9WKE=;
        b=Px6VONsdXOaU4vRQFo5Do/lPoXlDGLiHkhNSaKzT0pevFryG9NwsRHSqJKsrT2D8pc
         FFc1IydqSgFG6+4VrFzXy9LDWwHUrRSmVWCX6+z1bNjhM/yh67WH83Jv+ayDLBFk4WyJ
         1zsULJbvBrM75e2cdJHCXUjgtrXxhccmG4A1rGC0M2Ua6CMzLK03yyu6ky+KpBxD97dg
         LAjrY3/TJCXz//vAtO+vFLiIwt+3gVXVcSHPCgt6crGi69Tn5zC16uqCn6HtShAwD2Ou
         f4JSBJJut1XnavDl/hT2Mh/KB2WDa4KGBr7TEcZFtQQKBSYhxTHvTrp9vnveySejWNkR
         exuQ==
X-Gm-Message-State: AGi0PuYn4YmJZnuoC0XDLmdDp0yey/vGaXaAlkufkKX/WV6ilgnuXrmW
        g4189jDd3Mmo1vOpqY85BCC73g==
X-Google-Smtp-Source: APiQypLS3j9JDzaf4aBXWYPqgZVhNCxPiqrapIFT2F2Ddh6UfXilZ4yDsHgp3H2ARYLBhTiKWS7ISg==
X-Received: by 2002:a05:620a:13b9:: with SMTP id m25mr741199qki.456.1588284809197;
        Thu, 30 Apr 2020 15:13:29 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id w42sm957028qtj.63.2020.04.30.15.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:13:27 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: ipa: don't cache channel state
Date:   Thu, 30 Apr 2020 17:13:21 -0500
Message-Id: <20200430221323.5449-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes a field that holds a copy of a channel's state
at the time it was last fetched.  In principle the state can change
at any time, so it's better to just fetch it whenever needed.  The
first patch is just preparatory, simplifying the arguments to 
gsi_channel_state().

					-Alex

Alex Elder (2):
  net: ipa: pass channel pointer to gsi_channel_state()
  net: ipa: do not cache channel state

 drivers/net/ipa/gsi.c | 94 ++++++++++++++++++++++++++-----------------
 drivers/net/ipa/gsi.h |  3 +-
 2 files changed, 59 insertions(+), 38 deletions(-)

-- 
2.20.1

