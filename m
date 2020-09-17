Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745FE26E31F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgIQSBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIQRjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:39:32 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D2C06178C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:39:31 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r25so3161392ioj.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ZxAUcAmt6npTzXXqhjeGo2zTumi5Cj+Gk+e9dSx3UM=;
        b=cShgdx+JpWGQOxPqOVDTlma/AMvctg37njScDQ5XzSxzgIIimXiwGWPSI03EJxaIPj
         LX/9UKfkW/hSE0dxk70r3/CbNRUbVVc/1gIIRJ92pRk/yjrw/7fcY2mCO7dWlhcLRNEY
         LD8ZQZQpIln1joA2lEXC18vgLW0kTatul0Q3PUdy9H60ZEjzZChTHOBmyolPoR3WnRuA
         Ea3F3zinJ5ruO4J6csoTMHxxAM2TEQgAUeRe4w8bTVW9MKAEVvtRK+EHE7Qbou39Rtmi
         in/ATnGVmAbpQZPSxerSlarCL6ASTbeeznRn93R9t9WafZLwVrt/hmNTxx2fGQ3NJ1mv
         H2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ZxAUcAmt6npTzXXqhjeGo2zTumi5Cj+Gk+e9dSx3UM=;
        b=CdJ74lZhQ1XT4iFt++clZwnhbC5s/LfrcHz9BSHPqU+sr6idQgvIfI2YNh2y9STyYq
         dN7dCDHmWjG5qJeXuUKq2y6obN/k9kDaRzKLVXCVnf8TN/gCCCw+afJlo8JxfIu1x32a
         x2ju8z0T9rLSH9sB2U9+C4fp9fkTRB+eyXT7uNe8ltPV/Vp1Kkzi5JJ9lwbzKFtG2OTP
         NQ/INk/e+micbVB09XNv1yD66njLttH8kqgjMhGPi+i+OWSYV0UiNnsQaNaujqObD0Wr
         o6/LHkLoWbLBRfb8kRpYRG4EGttWcN/OpkoeZnPU2E5hqqsC1VJDnGvkV5pEvRfBKCn/
         7GbQ==
X-Gm-Message-State: AOAM530hj9NHHCVt0tqP54sW0z4cdPHMJ7GjLSfWuerZ34IpwAgf771L
        QGZoD2GLey3iskD1hEAu8FcD/w==
X-Google-Smtp-Source: ABdhPJypMoW15gdVtEqB9xDXyHPrAfTthEFyW2SbFOwrIMod4BCI0p/Av/DlgxXkEyfSCsGOnx2d/g==
X-Received: by 2002:a6b:b7cf:: with SMTP id h198mr24360700iof.55.1600364370637;
        Thu, 17 Sep 2020 10:39:30 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id l6sm192725ilt.34.2020.09.17.10.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 10:39:29 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/7] net: ipa: wake up system on RX available
Date:   Thu, 17 Sep 2020 12:39:19 -0500
Message-Id: <20200917173926.24266-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series arranges for the IPA driver to wake up a suspended
system if the IPA hardware has a packet to deliver to the AP.

Version 2 replaced the first patch from version 1 with three
patches, in response to David Miller's feedback.  And based on
Bjorn Andersson's feedback on version 2, this version reworks
the tracking of IPA clock references.  As a result, we no
longer need a flag to determine whether a "don't' suspend" clock
reference is held (though an bit in a bitmask is still used for
a different purpose).

In summary:
    - A refcount_t is used to track IPA clock references where an
      atomic_t was previously used.  (This may go away soon as well,
      with upcoming work to implement runtime PM.)
    - We no longer track whether a special reference has been taken
      to avoid suspending IPA.
    - A bit in a bitmask is used to ensure we only trigger a system
      resume once per system suspend.
And from the original series:
    - Suspending endpoints only occurs when suspending the driver,
      not when dropping the last clock reference.  Resuming
      endpoints is also disconnected from starting the clock.
    - The IPA SUSPEND interrupt is now a wakeup interrupt.  If it
      fires, it schedules a system resume operation.
    - The GSI interrupt is no longer a wakeup interrupt.

					-Alex

Alex Elder (7):
  net: ipa: use refcount_t for IPA clock reference count
  net: ipa: replace ipa->suspend_ref with a flag bit
  net: ipa: manage endpoints separate from clock
  net: ipa: use device_init_wakeup()
  net: ipa: repurpose CLOCK_HELD flag
  net: ipa: enable wakeup on IPA interrupt
  net: ipa: do not enable GSI interrupt for wakeup

 drivers/net/ipa/gsi.c           | 17 +++------
 drivers/net/ipa/gsi.h           |  1 -
 drivers/net/ipa/ipa.h           | 16 ++++++---
 drivers/net/ipa/ipa_clock.c     | 28 ++++++---------
 drivers/net/ipa/ipa_interrupt.c | 14 ++++++++
 drivers/net/ipa/ipa_main.c      | 64 +++++++++++++++++----------------
 6 files changed, 74 insertions(+), 66 deletions(-)

-- 
2.20.1

