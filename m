Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782FC2F7A97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbhAOMvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387742AbhAOMve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:51:34 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDA7C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:50:54 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id o6so17778078iob.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDHUO4MEuX+tZMwIcw55R/Dlc8/Cyt45IHiITIJj9Qo=;
        b=EL+jOdl5+XC0YfgY+/uV0wfn2boaD2cdnHfolEevx29xnLOIIBR2IsEQ/D9DeZtHTW
         SIowklpDYcevXbN9uQga4G1ZajzhtyRrMW1q41S05otkZZZADUKfxqcotw24cf+OBm9T
         +9plfL0ULuOyZ8LDhqsT6u5Ma1w38A/eI2jif5dLo2fYwW3BbMs71tPN3608qfGuj2jS
         w9CkwOrHmLZCy7Q/T4u7ojc0zTQY9qdflbHYmECOQwJauul+z4uhZ1XjMzN/9uyLK1t/
         CRxwD4Z4LA5ULSlON0fiMI6tQrXx/viNFhFJuJ2bXxY7WGKGnjHo12ObCUNhJG3rBdYA
         xURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDHUO4MEuX+tZMwIcw55R/Dlc8/Cyt45IHiITIJj9Qo=;
        b=mN4lBHfLh9odHfA0fOfsmUP0EE9es5fncVbLPgfSWUaS3SXmnc5zNiZbvHvPn7a2Hm
         l1OO36V80x4zdB8VanhNM/d7OHz0b7jvcLzXBlkEb1eOfhYKoDLRKJJohzu21+9KEIIn
         nsnwOhnPa2JB/bCrFj1HGtVxzdl6OfixbfrBiWzm4HcXTHG5Xk2KEmcqVlgMBD1SD2tR
         lX/4M319BtCIObjG/PViqKigMEshfkdTnZqns51R4i+3pvV07CRlkZQxmiSPPUp7c+vu
         ufuQwf4OjS40Eic33q4Phpf5KpZp/nLBR1m5fK3zS/oIiuvOgK4PK30ycJbVQ4EdN63F
         tNww==
X-Gm-Message-State: AOAM530mCdRQpeLtJOkeWfEk3J9rEQZrfemheoi4ACvEM1or15U/F6vy
        +JN1aB3JJ1rTT3DFgMTdt8F9nmIv3zO4Yg==
X-Google-Smtp-Source: ABdhPJy0qanQnkgMlp7j6BgexRzdZFlT16rf/RMegopbSjS972qvzEa3nEEwI45A0xhEmU36tD1guQ==
X-Received: by 2002:a05:6638:14d5:: with SMTP id l21mr10154007jak.54.1610715053724;
        Fri, 15 Jan 2021 04:50:53 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f13sm3952450iog.18.2021.01.15.04.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 04:50:53 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: ipa: interconnect improvements
Date:   Fri, 15 Jan 2021 06:50:43 -0600
Message-Id: <20210115125050.20555-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main outcome of this series is to allow the number of
interconnects used by the IPA to differ from the three that
are implemented now.  With this series in place, any number
of interconnects can now be used, all specified in the
configuration data for a specific platform.

A few minor interconnect-related cleanups are implemented as well.

					-Alex

Alex Elder (7):
  net: ipa: rename interconnect settings
  net: ipa: don't return an error from ipa_interconnect_disable()
  net: ipa: introduce an IPA interconnect structure
  net: ipa: store average and peak interconnect bandwidth
  net: ipa: add interconnect name to configuration data
  net: ipa: clean up interconnect initialization
  net: ipa: allow arbitrary number of interconnects

 drivers/net/ipa/ipa_clock.c       | 192 ++++++++++++++++--------------
 drivers/net/ipa/ipa_data-sc7180.c |  38 +++---
 drivers/net/ipa/ipa_data-sdm845.c |  38 +++---
 drivers/net/ipa/ipa_data.h        |  26 ++--
 4 files changed, 157 insertions(+), 137 deletions(-)

-- 
2.20.1

