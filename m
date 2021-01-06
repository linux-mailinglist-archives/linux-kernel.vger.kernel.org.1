Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC72EBBD3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbhAFJsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbhAFJsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:48:04 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94552C061358
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 01:47:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a6so1908702wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 01:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJSwIphCVwOW/tTThBFWU4Mg8HDbFeNcaqnTC9vxPYg=;
        b=vVSHvExsLffQo0+lGintZzkKgbnvy945SzF1cGWlNen1Q7XKYjyA9iH8Kc1LNNhDam
         Al+fstebmz240N995+8Lo/jSBwGsecMIho2eW/isnwJ3Ft+pFvzG2gzqLA0CrCYzXaRX
         aE1FUNdD6CzWtx7EE0K2DxbkX0nMfp/fiY6tWNWp0sjqQZo+LnzMuTxp8cYH2fP8VD5O
         i0mh4A+QbCaUpwM8mcnzvVC0zo8tclEK0NWJ+zjd392K2fpM4bK4nvbfeXqJgI+JUO9E
         29IuQ5QD4rwDuGQ5ILyAenQRFjJUrMuKAtLvLFCmJ7sWcSl59R6Id7RIeZKW8tcxfFCM
         HHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJSwIphCVwOW/tTThBFWU4Mg8HDbFeNcaqnTC9vxPYg=;
        b=PJwijizru5PG7V4S0QR2LbEcCnWcVOvfQsISImt9GrqxUMUS6W/aYQ20uaUraUXLHA
         0UcuqNdAxJ2Y1p/fdGgqIlMxqrZ88Anxe+v2H6a/vQ5fSfN5XS1vdGh17qCnNMHlKnjT
         Q+sblpvbzlbyU5Zvp/FjWcwwrinRPTfKbYwYg/1NQwgQZZN1DaZvuSwQ4Y+PAm77Bzm+
         n1j24STY0gepYvvq+BoPhnPTprIZMJkbSwTFW7fx+DSlmK+gK4NRkfzuZ5zhq0XJ8qjt
         19C2HS9kwhLzjn+65cDPIowGHrsN6xdgBM3mumCRyyK21EYOKInxuwRsEOyUI1t90KIm
         10jA==
X-Gm-Message-State: AOAM533DWK9JBxsWnHxKWf2lmPTUHiSqB1J7BtLYsRZ8uQb/Zm4eI2ks
        GJa9wWoAzShqJSqfQd3sFPVtdzzZC3nd1Q==
X-Google-Smtp-Source: ABdhPJyCyDMe7jKJn1vlNAIy47Tah/DZCC0RVM6QQ1LlleE6mgrMInyqvKxmVuuomv0VlaRYAjrk7Q==
X-Received: by 2002:a7b:ce02:: with SMTP id m2mr2804615wmc.111.1609926442237;
        Wed, 06 Jan 2021 01:47:22 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h14sm2394125wrx.37.2021.01.06.01.47.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 01:47:21 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [GIT PULL] interconnect fixes for 5.11-rc
Date:   Wed,  6 Jan 2021 11:47:23 +0200
Message-Id: <20210106094723.563-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Here is a pull request with a few interconnect fixes for 5.11-rc.
More details are available in the signed tag. Please take them into
char-misc-linus when possible. The patches have been in linux-next
during the last few days.

Thanks,
Georgi

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.11-rc3

for you to fetch changes up to 4b1a60a1bb8f03d82c3f6da424adc96667b59f2a:

  MAINTAINERS: Update Georgi's email address (2021-01-04 16:29:45 +0200)

----------------------------------------------------------------
interconnect fixes for v5.11

This contains a few fixes for iMX and Qualcomm drivers and also
updates my email to my kernel.org address.

- qcom: Fix rpmh link failures when compile test is enabled
- imx: Add a missing of_node_put after of_device_is_available
- imx: Remove a useless test
- imx8mq: Use icc_sync_state

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      interconnect: qcom: fix rpmh link failures

Christophe JAILLET (2):
      interconnect: imx: Add a missing of_node_put after of_device_is_available
      interconnect: imx: Remove a useless test

Georgi Djakov (1):
      MAINTAINERS: Update Georgi's email address

Martin Kepplinger (1):
      interconnect: imx8mq: Use icc_sync_state

 MAINTAINERS                       |  2 +-
 drivers/interconnect/imx/imx.c    |  3 +-
 drivers/interconnect/imx/imx8mq.c |  2 +
 drivers/interconnect/qcom/Kconfig | 23 +++++---
 4 files changed, 20 insertions(+), 10 deletions(-)
