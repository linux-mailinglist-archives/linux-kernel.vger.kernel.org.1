Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D634221FE02
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 22:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgGNUEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 16:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbgGNUEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:04:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBFEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so8078294pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LjzGXptWS/l0yG6s3mnPFGJ9K+cv+bp4hvQ+18wjBOc=;
        b=pSWmdrIlDHbS9EiuzX5lEL+nl6cwEFKhWNqXr24ppucg3KUIEItrCqgIaY2CfWl5Sb
         VXCPBw9smvPY9q5wN2FjPisBSw/oMoLzsdE3mUlNlMnIJrtSGiPWAQ8qFoBUwS9hLECt
         stXm8A+QYTxXLKJ8xPOpARtEIRygLfZrzqSUk32OQC9+EnRMfrGDd9O+8uiHIgkWAqI9
         fRKIwqRUabJDEGXhMj+fBvuMe26diJ7knaDmPQsIdNAvmJGr5ipTt5Iv1KtzvJgdD5hP
         GdlvcmzYywX8JcOuLydc3CI+W3lrUd4maNGsBsu8XCh0mOoBftWAZHXFJQEo1B9BYKwS
         dykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LjzGXptWS/l0yG6s3mnPFGJ9K+cv+bp4hvQ+18wjBOc=;
        b=glVc3cr93h56uLNuj/mAZmI1He2V3r1rIvyAI+Bz8ZuwvPhKpfx0nchum98wKoV8Df
         xo+AJ6J36eAnhw5AYuEGXJjVrt4MtSMXa8zQAtztsFxhKr+1+yVA/5U4+YuX3gOLlouJ
         WzixHNaaQz5dGKdaoccnMMfdDZ9nRE+YEBUxMrlCTYsABC5ttcdsk4ktqpvSmEhn+aWt
         Clns+NlR756R72j1y0axWGJt4wT6UF3w+FYRoutd6x9Yj5URD1SLlC4fUokKnIrQaXMc
         AT691ZoJ5PteqdIwtKbU+FmmA4j05wIF6iSmLH2MF94UB+Xdgv0LmbPopUSi0UvK3st4
         MAXg==
X-Gm-Message-State: AOAM531msewIBmjHU5DJ2152RBrQqP/aA83zZVNmn46LkDSm6G0Xyv3k
        04iwlBy5akFjRsh/aps+D6k7mA==
X-Google-Smtp-Source: ABdhPJzCWJ6LvA6aca6tiDqN7zYn4kfS9K/PQYq6jFFANS1a+sv1tJBiB1G33DS7mXamhMqGfm7uDQ==
X-Received: by 2002:a63:2146:: with SMTP id s6mr4602907pgm.411.1594757087541;
        Tue, 14 Jul 2020 13:04:47 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t13sm3262959pjs.17.2020.07.14.13.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:04:46 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 00/11] remoteproc: stm32: Add support for attaching to M4
Date:   Tue, 14 Jul 2020 14:04:34 -0600
Message-Id: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set applies on top of [1] and refactors the STM32 platform code in
order to attach to the M4 remote processor when it has been started by the
boot loader.

New to V6:
1) Removed extra newline in patch 06. 
2) Re-worked title and changelog of patch 08 to better reflect
   what is done by the patch.

Tested on ST's mp157c development board.

Thanks,
Mathieu

[1].https://patchwork.kernel.org/project/linux-remoteproc/list/?series=318275 

Mathieu Poirier (11):
  remoteproc: stm32: Decouple rproc from memory translation
  remoteproc: stm32: Request IRQ with platform device
  remoteproc: stm32: Decouple rproc from DT parsing
  remoteproc: stm32: Remove memory translation from DT parsing
  remoteproc: stm32: Parse syscon that will manage M4 synchronisation
  remoteproc: stm32: Properly set co-processor state when attaching
  remoteproc: Make function rproc_resource_cleanup() public
  remoteproc: stm32: Parse memory regions when attaching to M4
  remoteproc: stm32: Properly handle the resource table when attaching
  remoteproc: stm32: Introduce new attach() operation
  remoteproc: stm32: Update M4 state in stm32_rproc_stop()

 drivers/remoteproc/remoteproc_core.c |   3 +-
 drivers/remoteproc/stm32_rproc.c     | 214 ++++++++++++++++++++++++---
 include/linux/remoteproc.h           |   1 +
 3 files changed, 198 insertions(+), 20 deletions(-)

-- 
2.25.1

