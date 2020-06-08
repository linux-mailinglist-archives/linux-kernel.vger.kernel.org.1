Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21AC1F1EFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 20:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgFHS3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 14:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgFHS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:29:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F82DC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 11:29:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o6so9147086pgh.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AtU95d/mLDsHX64dIamJL4aE1CnFpCmhkczXPqyifoI=;
        b=gayhdD3WkYAf25JyFoJVQvX8QzkcwVV8CrhZ+egfs75qL6pM8D/rjtTUc4GhxDlADi
         Xl6GEczeW62hr53fEoQgfnDTFLCmdhflbgPsKPKmd9Ro87RHZeb9p0MaK3LUXi9X/hdM
         8lOC1MFwQnm8H11hBskwarSKUiQKfze1+Om2XuYZOcXDHMgbJu6Pw/N0M1TXNafuALD3
         g1/Ce0BcIbOUZk6CshWMDvY6pPKQsyqQJMRnbVh5b3Z7P3Y4cLkTsqZCGTb6eQuXlY7d
         7AH8ZFDzZNiVDcx+1DOY4bTzD/C6ON+ZVXxgwjgXJ1rVOLyeEMLMeKdT+2VTmXHRTuJQ
         pYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AtU95d/mLDsHX64dIamJL4aE1CnFpCmhkczXPqyifoI=;
        b=aTtOJB2a/VNfMezTz/vtHRDm0QXoDz9j+mx/MW4mxcd15fxY1eEVB+PJ4cuM4EJtl+
         xZhoHiGXlU0tyG4OK7aHbKnf1Xbg/RMRoA23dzgKAeuMvxQly8Uf62ZQp0qZT+fty9zg
         3Oh2y6bjxJrP0VKAhXDNI4k6b6fn8GiHr1+dN25osB9/dexm1Fd6yiXJYgLOHey300Xz
         HGakgFNZsVwNAvkYSJoZZ2ELMBnWmhE92ojEC/VXi7aIUgnFqxKZLDVbzPvc1DkzJo1r
         iKK371Zp8Kfjqm7J31Tx2XSG0eMMNn7qyCAOVkRa+JiYdUtR1EhHQwx/s700wxIxu4NF
         6/RA==
X-Gm-Message-State: AOAM531iKhggkmTKeM1EEeNVihBkH1LVKfppVuIxk1R7eOTjHPDfZmae
        5iHO5YeAa/stv1eYRf0UBa3y9zQfivw=
X-Google-Smtp-Source: ABdhPJxNIelEeuAtLp2kMOuBh5SJVOKzM6Fzo8ViNbw789dGdmNVHLTndBzXaX3rJw96B9BrEsnm2Q==
X-Received: by 2002:a63:9d0e:: with SMTP id i14mr20486241pgd.55.1591640982858;
        Mon, 08 Jun 2020 11:29:42 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e12sm7932922pfj.137.2020.06.08.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 11:29:42 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Wang Wenhu <wenhu.wang@vivo.com>
Subject: [GIT PULL] rpmsg updates for v5.8
Date:   Mon,  8 Jun 2020 11:28:56 -0700
Message-Id: <20200608182856.2302518-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.8

for you to fetch changes up to 4f05fc33bebdc7d69259c412dd21d09751827dbd:

  rpmsg: Replace zero-length array with flexible-array (2020-05-12 15:00:48 -0700)

----------------------------------------------------------------
rpmsg updates for v5.8

This replaces a zero-length array with flexible-array and fixes a typo
in a typo in the rpmsg core.

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      rpmsg: Replace zero-length array with flexible-array

Wang Wenhu (1):
      rpmsg: fix a comment typo for rpmsg_device_match()

 drivers/rpmsg/rpmsg_core.c       | 2 +-
 drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
