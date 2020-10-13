Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0058128DDA5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgJNJab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgJNJTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C50C08EA6C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:25:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b19so774155pld.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/j9uq6f/xFO4LJp1BRi8dZQn9ht1b53g1oDJg2kWTw=;
        b=h2rK0/FFMVeOpvDVT97kysRBfjSH7eTLbIW26t+7Xg5dBg4XBaBYjc0hQv+mputbfP
         tt8PECXhxw82ijir68HsLk1YmB8AtZYty9Tel/13uJwBodg6x9InGlN4Zg+lp76QUJom
         /10MGaLUxzXBhDHqvPo3t7Yepj1KuHtSsOhS+y9R25YZpost3vsi5xZ3Okr/diybTDS5
         mQ8hOe39wwTo8F6msu9Lq/1VXEvSqR6ThFEq/RK/p/3ugyi7d1h1O+1CtvWJ1ec3TiFy
         /iRmrWmy+DmDj4EBEc7QlbaHth/Xv/eXUa14kFlYwH7DQybk4dqUvjLYk+g+nkzBA/2b
         gHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/j9uq6f/xFO4LJp1BRi8dZQn9ht1b53g1oDJg2kWTw=;
        b=dW2A5CwFx0vnps0GUiK1hHwco3IvtqVQZyso5x0c9MHHmTw7caBOaDTulcM2xZY5pe
         2DDbF3Exxb09VZFntLwemWI7aBNMF/0IPrr9Xm3EehHUVE5TtWApaJY3OJ0L05h6UIZ3
         SFzsBC0Zv5XqY9v3AYFKXZ0ykpU5sANi/t6b6H+yNiSFWYWgQlhp3jTiTkVKVtyerRk6
         5EjAY6yUSQAkR3fdhcA388+6Gp76FO5eraePfd06BvsiasOKjZKKK+8Eoqhig9odzK27
         plTacBOdVTLX9vZOxh+tnHvqKAnyqhzYo9B4/kjacdj4dME3tLPlq/5MgtKiQkwxT66G
         DFQg==
X-Gm-Message-State: AOAM530h1e476eoEjDBVabEAYjOHOT8sk2nozP8Z7F1aP7I4HbtwEuUV
        FfivNrg/++I7ctJsfzSzkLqcsQ==
X-Google-Smtp-Source: ABdhPJxxNdGgvFDUUyt6x/OG39E4RiwYPmag4zZ2l5CsD+N+TjAp0/4/hes+yHI9xaF+lURc0oJrdw==
X-Received: by 2002:a17:90a:1149:: with SMTP id d9mr691859pje.227.1602631521380;
        Tue, 13 Oct 2020 16:25:21 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b8sm791871pfr.159.2020.10.13.16.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:25:20 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] rpmsg: Make RPMSG name service modular 
Date:   Tue, 13 Oct 2020 17:25:10 -0600
Message-Id: <20201013232519.1367542-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon,

This set starts by making the RPMSG protocol transport agnostic by
moving the headers it uses to generic types and using those in the
current implementation.  From there it re-uses the work that Arnaud
published[1] to make the name service modular. 

Tested on stm32mp157 with the RPMSG client sample application.  Applies
cleanly on v5.9.

Thanks,
Mathieu

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=338335

------
New for V2:
- Created new RPMSG types (Guennadi).
- Re-worked byte conversion functions(Guennadi).
- Added a single ->is_little_endian() operation (Arnaud).
- Fixed byte conversion before making name service modular.

Arnaud Pouliquen (4):
  rpmsg: virtio: Rename rpmsg_create_channel
  rpmsg: core: Add channel creation internal API
  rpmsg: virtio: Add rpmsg channel device ops
  rpmsg: Turn name service into a stand alone driver

Mathieu Poirier (5):
  rpmsg: Move rpmsg_endpoint_ops to rpmsg.h
  rpmsg: Introduce __rpmsg{16|32|64} types
  rpmsg: virtio: Move from virtio to rpmsg byte conversion
  rpmsg: Move rpmsg_hr and rpmsg_ns_msg to header file
  rpmsg: Make rpmsg_{register|unregister}_device() public

 drivers/rpmsg/Kconfig            |   8 ++
 drivers/rpmsg/Makefile           |   1 +
 drivers/rpmsg/rpmsg_core.c       |  44 +++++++
 drivers/rpmsg/rpmsg_internal.h   |  27 +---
 drivers/rpmsg/rpmsg_ns.c         | 110 +++++++++++++++++
 drivers/rpmsg/virtio_rpmsg_bus.c | 206 ++++++++++---------------------
 include/linux/rpmsg.h            |  93 ++++++++++++--
 include/linux/rpmsg_byteorder.h  |  67 ++++++++++
 include/linux/rpmsg_ns.h         |  79 ++++++++++++
 include/uapi/linux/rpmsg.h       |   3 +
 include/uapi/linux/rpmsg_types.h |  11 ++
 11 files changed, 481 insertions(+), 168 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_ns.c
 create mode 100644 include/linux/rpmsg_byteorder.h
 create mode 100644 include/linux/rpmsg_ns.h
 create mode 100644 include/uapi/linux/rpmsg_types.h

-- 
2.25.1

