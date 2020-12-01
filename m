Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78862C9424
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgLAAm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgLAAm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:42:27 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49112C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:41:47 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id w8so13202737ilg.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mfRCDG1DfZk0mjNm0yF+dvADx4aswh9w4XOl0WSoS98=;
        b=YNB6LrG4Z5CYoFDYin04fFtDEPl70OJ3GzPFIfG5KhjTqYCTqUYiWj+aDNsa39Nhmq
         d3by2k02FfvxKupn3JJXmkLqtuRCS1b8+U92ecjqr8xJT12zwW1YuFsEbdt0liCd9QDA
         WvTHXNBY9sB/2+7sXNdi0Mnhb0JuBaaLnPMoMGN++1kLWzBwVt3QJ1PZkpD6bmy4eiE+
         60GCM8fcEfwF5Ts7MJKQdsqYzOs85O3qdsW0j5Sf7kds3UBwYHljCDQHDSf+9QEVF67b
         4b4d53ZNFvNTEogc9SHBvK0NAfGPITs9skQm/rTCCPyaJ1m9dbyj1Kf/bzxrWXU4b2ag
         DyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mfRCDG1DfZk0mjNm0yF+dvADx4aswh9w4XOl0WSoS98=;
        b=Ov8PHKCy4R2wbc0wsjmH4QKlfhUFmXj3Gs41ds+xdajm9QX0sEGD4Z7ZRaU5qLwKQe
         GYCVq8uGmVgSC5fyDduAh6u+PvyYFHXlPB81TUFhsBABxyhi8t8FWVv887bDH7fqV9z5
         jJsXP9/whJ/3Ejave9qDn9LUesK80XTC9933N+wiFpbwednhXSrUU4ShDelhsLq76EE7
         uVyqkj9Oh7HCPh7pX+745zZDAfTRvCAS1E4Y7ukr/MakEmjEfjFI3WJrJtl8OQGAbtb0
         gUvV4wLoFrhSgTxISR9hb+iMm0CCPwv9yKrxb9hj2t1ahG49Q8MNRzGT5Tsde5DpBCO7
         MF0w==
X-Gm-Message-State: AOAM533YCDlgmWvL1LSauPB6wvuD+ym9k49VrFLzRq3hkaP84WpCFuvR
        Q1kwZWF9+kg5AZ8cq9qyJL2cWg==
X-Google-Smtp-Source: ABdhPJzLkOBwf05+96QUNHZdn5UgAMddI329mHbS8VAWuU9vin5os8cyhLbV/SdhIfDO2SbEyraiAg==
X-Received: by 2002:a92:8b12:: with SMTP id i18mr325439ild.278.1606783306662;
        Mon, 30 Nov 2020 16:41:46 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id p7sm138561iln.11.2020.11.30.16.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:41:45 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org, subashab@codeaurora.org
Cc:     evgreen@chromium.org, cpratapa@codeaurora.org,
        bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: ipa: IPA v4.5 inline checksum offload
Date:   Mon, 30 Nov 2020 18:41:41 -0600
Message-Id: <20201201004143.27569-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes one changed destined for a central header file
and a second (dependent on the first) that applies to the IPA driver.
If these should be posted a different way, please let me know.

The first patch introduces a new data structure defining the format
of a header that's used for "inline" checksum offload.  Changes to
the RMNet driver are required to fully support this feature, and
those will be provided separately.

The second patch implements changes to the IPA driver required to
support inline checksum offload for IPA version 4.5.  It uses only
the *size* of the new data structure.

					-Alex

Alex Elder (2):
  if_rmnet.h: define struct rmnet_map_v5_csum_header
  net: ipa: add support for inline checksum offload

 drivers/net/ipa/ipa_endpoint.c | 50 ++++++++++++++++++++++++++--------
 drivers/net/ipa/ipa_reg.h      |  1 +
 include/linux/if_rmnet.h       | 30 ++++++++++++++++++++
 3 files changed, 70 insertions(+), 11 deletions(-)

-- 
2.20.1

