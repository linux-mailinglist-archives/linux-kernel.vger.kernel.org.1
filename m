Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208BB2B04BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgKLMMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgKLMMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:12:01 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3A9C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:12:01 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id k1so5020356ilc.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fnoYpz56ibAMj1qjJjzVWCKsrD3fu7HOMcpzb6SFLQw=;
        b=gUqQZ2VPC1SYq3DSRL1Mev6Svu2VXswDHMQzJuxychcL/EmpCIhoGuqKjdrTNuqrc0
         WGCR55j22sMxj5TMPMUd60RWUdQU0Adj/y9zr0UPeXqjfNMPdqIyOjsi/UItyZ+Wx/cq
         K4gD5n8UTDH899lmjb1/szWtkPfdHM6Q6TSnr0ZP1ur3/isg7HfirvGJX8f/80qMre4g
         9EqQtn8asZON+70qSiL3xweNiVDbAMfzIYqA1VM7tX3egAkQWDqXmNJiAN3Tql84ORYD
         A+CxHlVTgkVuH3ZgOWgJpk6r9ghosV/DeKjn3ARF64qrNBIqTP03E0ICU7uaCO+PygMy
         rtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fnoYpz56ibAMj1qjJjzVWCKsrD3fu7HOMcpzb6SFLQw=;
        b=Gefn+e8WtD+cDANSRiv/BroTEMODGLBegZR1FtAdWDCLBIxxNcnjZ8ww0rmfnwN//i
         XTaEEqiZQduuwNaHG4pvNBBQLKGzUi89RnzS6oqwHCezx6j8oGF0Gk8xrHKEaoxnXyD7
         5MaB4UFE9AzWnw6F8JawUW8Q6ljJCQ6U8Hfuka2D0lrSn6Y2+QcSSMnmI/B2qF8Y9Ym/
         miTGUlLwmpQpXHVCj6/+zIPvY8sr4TP4aY06dUroz0o5sh7nbu7w62lmuEEPAQ4fJDXG
         l7uR26MyIx+Fca5rdUDV+5q7byJr+ey9iDx0LaWd3CbCLe3pzJABwboMQLkxUdZfBvcE
         Jopg==
X-Gm-Message-State: AOAM533GN3ZLqSkdGebtMUBY1EDCju+o0kvBBpaPmwDzhLZlQsrJUcqC
        XXKRvta+ztVParZRzDQDH7VGBA==
X-Google-Smtp-Source: ABdhPJwz9MFnm9EG7SSCZl1dWGVR12C9FHy/qqxm+kVm/Gg8RdjcALez3W2uf4wQg8xL5h5fgTSIbQ==
X-Received: by 2002:a05:6e02:926:: with SMTP id o6mr23467158ilt.287.1605183120861;
        Thu, 12 Nov 2020 04:12:00 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id i14sm2609563iow.13.2020.11.12.04.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 04:12:00 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: ipa: two fixes
Date:   Thu, 12 Nov 2020 06:11:55 -0600
Message-Id: <20201112121157.19784-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series makes two fixes to the IPA code:
  - While reviewing something else I found that one of the resource
    limits on the SDM845 used the wrong value.  The first patch
    fixes this.  The correct value allocates more resources of this
    type for IPA to use, and otherwise does not change behavior.
  - When the IPA-resident microcontroller starts up it generates an
    event, which triggers an AP interrupt.  The event merely
    provides some information for logging, which we don't support.
    We already ignore the event, and that's harmless.  So this
    patch explicitly ignores it rather than issuing a warning when
    it occurs.
     
    					-Alex

Alex Elder (2):
  net: ipa: fix source packet contexts limit
  net: ipa: ignore the microcontroller log event

 drivers/net/ipa/ipa_data-sdm845.c | 4 ++--
 drivers/net/ipa/ipa_uc.c          | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.20.1

