Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5332B29D334
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgJ1Vlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgJ1Vlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:41:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE79C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:41:44 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j129so445546qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYJByRHMFm7d3rnuGtDQ0bsC4ppOIDZCGwtSE2xp/Zg=;
        b=zoADobpW0XteTjyGN+dbeom+s+0NSVnJIq35xkFBIEy2WWd07G2MJoiJfDcc8EccgU
         /K4jmD8dUhslurWwExe/gmM/1ixn6e3VHfhAdw2hc/ekN6G4ha66Eim6lNhv0pTO31D1
         qU2hYtXmCfvVXIx2NacpIuVfJUue0zYL1OGloEFCR4qfQiiO0d10NmRDpzOoaxuJw3nF
         DeOJNpVwDwQjMjp+ZgeeIFLOrgDsySY6PCTV6IMsYICCkX0Vc4yJQjZ2/vKQ4KHrc6qX
         XODGnY45tIEVynLiSlN9Pc7RgyDKD8BmCb2mkUlzPEn2mFwSFfrIGmgBM1eRWsWxnIS6
         8DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYJByRHMFm7d3rnuGtDQ0bsC4ppOIDZCGwtSE2xp/Zg=;
        b=ssHPII3N00pML72VmzVOnMurwbPOLBOucHYO4AoJdo2UgPCsfQ99rvjyifD5489WqZ
         CtE9kSu1vgu5kBCWM6rOvdSjn8AOcdhq7X5HXx83Y+PomI4Q2/wRWrvR4Pv+tXXbPoAs
         RA2uxopQ3gegj+1BtmZZmcQ4rj8jCRKHVOGRYKvb6MO6fCZAqHqrley28iQavkn62S7s
         3ZvS1Q9EufQMPrjMB+5//IcXvmdq8lyGJLfK6YT7csS+4PYZM4xItaI2MqHuy2V6Ik1m
         m7TzZ++xbWKaveH2UFUJ646VuvfEVV1j2AjhMxZFDluuE4pvPIcPU0PM03zHQG5+D1Am
         M9Eg==
X-Gm-Message-State: AOAM531fcE5L23INeFVQPDBORPOf6HkJDtgBup+kNUwbPpv7+XMYT1DA
        BK16vRfgBV8yqcn791Dh93d0n2JJbOAfozH1
X-Google-Smtp-Source: ABdhPJwRJf1fbzux1MxHDO4rL3dpJNipUdVsNYXh03Kn2EO+GzRfePD8gOzoRgQMRnKGKW580mrGSQ==
X-Received: by 2002:a02:3f59:: with SMTP id c25mr699137jaf.17.1603914113353;
        Wed, 28 Oct 2020 12:41:53 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m66sm359828ill.69.2020.10.28.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 12:41:51 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        sujitka@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 0/5] net: ipa: minor bug fixes
Date:   Wed, 28 Oct 2020 14:41:43 -0500
Message-Id: <20201028194148.6659-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes several bugs.  They are minor, in that the code
currently works on supported platforms even without these patches
applied, but they're bugs nevertheless and should be fixed.

Version 2 improves the commit message for the fourth patch.  It also
fixes a bug in two spots in the last patch.  Both of these changes
were suggested by Willem de Bruijn.

					-Alex

Alex Elder (5):
  net: ipa: assign proper packet context base
  net: ipa: fix resource group field mask definition
  net: ipa: assign endpoint to a resource group
  net: ipa: distinguish between resource group types
  net: ipa: avoid going past end of resource group array

 drivers/net/ipa/ipa_data-sc7180.c |   4 +
 drivers/net/ipa/ipa_data-sdm845.c |   4 +
 drivers/net/ipa/ipa_data.h        |  12 +--
 drivers/net/ipa/ipa_endpoint.c    |  11 +++
 drivers/net/ipa/ipa_main.c        | 121 +++++++++++++++---------------
 drivers/net/ipa/ipa_mem.c         |   2 +-
 drivers/net/ipa/ipa_reg.h         |  48 +++++++++++-
 7 files changed, 136 insertions(+), 66 deletions(-)

-- 
2.20.1

