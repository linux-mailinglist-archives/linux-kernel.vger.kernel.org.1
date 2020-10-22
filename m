Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B030D296325
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898292AbgJVQya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441442AbgJVQy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:54:29 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3324DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:54:28 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id c10so506042oon.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbmzpBTxspDnsuQ19KUiuNb2cB7WdjwRDDAzIPG8JG0=;
        b=a1KcChnAFb46+ymjgrkNkdR8r5nMx1GiGVe30CmnEJdRP4pio2earim6Cx+wcmMUGV
         wnLRcR0kiFRo/JApv5bPZX6xKIKz/506HwITrSf9f37iIq9Ngiu6YqPO0eyXCaXQLK34
         TDa8ug6XpulJky1dFtSj7amtI7ObXldMslyPI6NuTAx/b9HouwtCTFg18ESb0LriGL2t
         9STbAVLKjWYOo+fo66vdettIOkg5UUVTf3cUSQKReGVtarQhBubs+B7mMr8DF42A53Tt
         D/Rk2orLnnXes0NNUpXac6hkRZ73wGqddPIaAm3/xNPfWD01zoPuW2AjOzUFQoZnAubV
         1LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbmzpBTxspDnsuQ19KUiuNb2cB7WdjwRDDAzIPG8JG0=;
        b=SNYHVMnd3Npccjqak+Qlh32O+o9EeNPLU5voPKFILMpBUNS3kfgbkzQQlKdj0SiMEU
         Uft+iJRuy+XeG6oA7lkxLlDnsG4wDpWgIThSaRJE58DxHKBPTy4yASUIKhNpqhxbjB44
         uyWJ1/ePu2Ck2ap+SI+5MrlAxMp+cnIxwoRpUBjfnwJjUdYifEaXSRhb4Sww9Q7JbctS
         VTTrda9xBGN5fTdSZFEnxA26WJ082N8p4llcnp5bX2189PESKQsffogTcCh0kaZv81fI
         UWHSC4bVuDCEUZxY4TqcHbyMWmXUdZ8hUPFJFWklWIEUuRKe78I1c/3KQD2lFdMY6dWl
         8RCA==
X-Gm-Message-State: AOAM533qZN6KA4+uT7zSVlNeI5P/c2ZvMco0CBrka0XcqMRKO+JjbBtM
        PATCShwJPOOKrjrhzlNdKnFEkg==
X-Google-Smtp-Source: ABdhPJz8CZJIiuq9Chow25/cadtSsNotaRPgvcuFIfcF0hTRW414Ugw6ghkDwt5+uegyuD81I33edA==
X-Received: by 2002:a4a:b601:: with SMTP id z1mr2617084oon.83.1603385666245;
        Thu, 22 Oct 2020 09:54:26 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 33sm529443otr.25.2020.10.22.09.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 09:54:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Lew <clew@codeaurora.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Deepak Kumar Singh <deesin@codeaurora.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [GIT PULL] rpmsg updates for 5.10
Date:   Thu, 22 Oct 2020 11:54:24 -0500
Message-Id: <20201022165424.23320-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.10

for you to fetch changes up to 4e3dda0bc603c1ca84680a56bfc49e8fe2519c89:

  rpmsg: glink: Expose rpmsg name attr for glink (2020-09-15 03:51:13 +0000)

----------------------------------------------------------------
rpmsg updates for 5.10

This introduces rpmsg_char support for GLINK and fixes a few issues.

----------------------------------------------------------------
Arnaud Pouliquen (1):
      rpmsg: virtio: fix compilation warning for virtio_rpmsg_channel description

Chris Lew (3):
      rpmsg: glink: Use complete_all for open states
      rpmsg: Guard against null endpoint ops in destroy
      rpmsg: glink: Expose rpmsg name attr for glink

Dan Carpenter (1):
      rpmsg: smd: Fix a kobj leak in in qcom_smd_parse_edge()

Deepak Kumar Singh (1):
      rpmsg: glink: Add support for rpmsg glink chrdev

Nicolas Boichat (1):
      rpmsg: Avoid double-free in mtk_rpmsg_register_device

 drivers/rpmsg/mtk_rpmsg.c         |  9 +----
 drivers/rpmsg/qcom_glink_native.c | 70 +++++++++++++++++++++++++++++++++++++--
 drivers/rpmsg/qcom_smd.c          | 32 ++++++++++++------
 drivers/rpmsg/rpmsg_core.c        |  2 +-
 drivers/rpmsg/virtio_rpmsg_bus.c  |  7 +++-
 5 files changed, 97 insertions(+), 23 deletions(-)
