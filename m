Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507E02DB349
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgLOSJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbgLOSI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:08:57 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E10C061282
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:07:51 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id j8so5052092oon.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=awpfnaoCuOfpiA9hFwy8M6uoUGEHYcKA+Gcyax3vkEU=;
        b=SLdbi27kWMyEok3alqZe20qkyd4B3CnVaAdIyEDPHD2vz0Gv0dwKJ1Gm6MFxx1DDSM
         xncXwtmCZPUcRw17HtC/OXEwXsiw/QOPLw37/d14RQHEO3Z0H6hRPFdfOhaQ45GmZrwf
         tztIUBHriOjGYSSWbU++5Qm1xQdFd/AkinC0U+ggnaoYezEIq2YYUYCw9RRltVip/+HX
         lhMeZd1XZ+t529RAHdoZJU3ubhgmeqA2qqM+QrBVNNJyq6wsSThMWO1B2NKXgOML8LBc
         T8mtEvl9YkZFt4yh/mOYFTMO3Vi5+ulrXmqmGJx3Gy82+FzLc3bK9up90bEBVBtk/40X
         2L5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=awpfnaoCuOfpiA9hFwy8M6uoUGEHYcKA+Gcyax3vkEU=;
        b=Ba53Fw1v7F5K9EBKHvQ3CLnvRB53i+disrdk4cMD7e4AzyBlH5pSbOxUYYJUKc1qgp
         etHA01ZmCQ6IjwzZptf2JaQvnKkT7qakgY6zrktofIf/Ng/7794vjuWRLsV8TeepcqN+
         rfPtBAehltyryM1fkGg7+MXkrt2D7cOBJbk7lIGZtowjAcG1rbMZxi3JTdVZeFgSs5OJ
         g/vIySQxH9NUn2/N6Fdp+LAsT6fTt0hIZJ2wRBzuJpFdEWWrLm32c771DYtJHqfq1Nvr
         93hlClzwxPsIWnxw/FrWe28Y0TiKAd6pnGCIDklSfXHYzwTtXtdryZGphGorOnCT1rZa
         8ctw==
X-Gm-Message-State: AOAM530UAUC93xVal5KKpsdiPRXy13ybmPWpj14ClGuC4WdYuIladNGX
        3Vz5rX8gPb87GBXiD+v0C2aaVA==
X-Google-Smtp-Source: ABdhPJwTB7icEqbXpYRJR956FFUcB0QEiMvrok0dKNuzUQl6DCJ4w/MCFiEArZdT1/cuajSh7cNQXQ==
X-Received: by 2002:a4a:97a3:: with SMTP id w32mr5262043ooi.81.1608055670983;
        Tue, 15 Dec 2020 10:07:50 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z38sm4437434ooi.34.2020.12.15.10.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:07:50 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [GIT PULL] rpmsg updates for v5.11
Date:   Tue, 15 Dec 2020 12:07:49 -0600
Message-Id: <20201215180749.1528593-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.11

for you to fetch changes up to 950a7388f02bf775515d13dc508cb9d749bd6d91:

  rpmsg: Turn name service into a stand alone driver (2020-11-24 10:11:59 -0600)

----------------------------------------------------------------
rpmsg updates for v5.11

This extracts the "nameserver" previoiusly used only by the virtio rpmsg
transport to work ontop of any rpmsg implementation and clarifies the
endianness of the data types used in rpmsg.

----------------------------------------------------------------
Arnaud Pouliquen (4):
      rpmsg: virtio: Rename rpmsg_create_channel
      rpmsg: core: Add channel creation internal API
      rpmsg: virtio: Add rpmsg channel device ops
      rpmsg: Turn name service into a stand alone driver

Mathieu Poirier (4):
      rpmsg: Introduce __rpmsg{16|32|64} types
      rpmsg: virtio: Move from virtio to rpmsg byte conversion
      rpmsg: Move structure rpmsg_ns_msg to header file
      rpmsg: Make rpmsg_{register|unregister}_device() public

 drivers/rpmsg/Kconfig            |   9 ++
 drivers/rpmsg/Makefile           |   1 +
 drivers/rpmsg/rpmsg_core.c       |  44 +++++++++
 drivers/rpmsg/rpmsg_internal.h   |  14 ++-
 drivers/rpmsg/rpmsg_ns.c         | 126 ++++++++++++++++++++++++++
 drivers/rpmsg/virtio_rpmsg_bus.c | 186 ++++++++++++++-------------------------
 include/linux/rpmsg.h            |  63 ++++++++++++-
 include/linux/rpmsg/byteorder.h  |  67 ++++++++++++++
 include/linux/rpmsg/ns.h         |  45 ++++++++++
 include/uapi/linux/rpmsg_types.h |  11 +++
 10 files changed, 439 insertions(+), 127 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_ns.c
 create mode 100644 include/linux/rpmsg/byteorder.h
 create mode 100644 include/linux/rpmsg/ns.h
 create mode 100644 include/uapi/linux/rpmsg_types.h
