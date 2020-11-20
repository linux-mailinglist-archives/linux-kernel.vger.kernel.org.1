Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12732BB880
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgKTVms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgKTVmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:42:47 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA11C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:42:47 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 10so9154225pfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dGx7nkSRSOVB3yrhS2MIzy8whpUJXJfKVaIkI4vsSM8=;
        b=nP0XcB/EoAS0ZTzM1sPdQQyChokGsEwcZHuGmkGuwR1gvwVRsEVlEZwpZNREwVL4Mg
         5XOL5/gmF4nfcspINYHLVuBIaoBqiBUwfJEfGTuE3fL9A/fQVUP4rcJv8wNEWMUsb123
         uw+QVdjQAoUA+1oR335Deo7n8p1FJtqn8MXo6Vi+xr2rUICOtvMIAZKxo8ov0ruu1y8z
         62bU9XHeeSXQlp8MUUEchmafjS/9DqTdjFlAJCmvPOgQ2F/5AOCH4dJtLXiSYgpemNf2
         eHoJ/eMourfaXNx8+EFvdJeFpnlJgo77Bor3SExtPzLfv8RT82qvDOWNFwpvESS3P0NQ
         PMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dGx7nkSRSOVB3yrhS2MIzy8whpUJXJfKVaIkI4vsSM8=;
        b=VScmtdf9Nm4cwnzldLNYGTynM9Q/gDdtzqFI035EaVDjBZ6dvQ+tdSRaWLQdzmI29W
         jXzSwuh2ikZ8hH7RB5MIkdYj5rewA3o8e1vbFJsDF1MKg2NsxHTV/SZx/+4c4wDD23Ni
         0LynIPY4x0j2jYEJ80tcEzmfY27y43316Lx0YsSN2sEM43mWHmf3SbrQYFG9w1Ahw1Tu
         Gxc8lVK87A6MFYYw5IYQehaKVXHwhxLVORUK9a7ErNTFNJpuuwEm1GaQxpd48EiR+Mo5
         RB+zGGJA5zBl52OmH/7/lHyNyxxFbUCO1kIx+pZvCIP05h8KQ7u8TG/eQz6MEtRo48Nd
         ZBcA==
X-Gm-Message-State: AOAM532yUQAW4IVDY1mq/a7GuixYM1/AA37ddc7sZiFebXI4WXKk55Wb
        Ood7yP8br+lmjUT9xndq0wpY4mB+LIF2eg==
X-Google-Smtp-Source: ABdhPJwpkmxeXoiY32/7plx/oiEDwJxxdXvmxvBuYauPRqc7zCnt0e5sO1YG2uK0hI85rwdSFr9RiA==
X-Received: by 2002:a17:90a:eb04:: with SMTP id j4mr6482430pjz.103.1605908566588;
        Fri, 20 Nov 2020 13:42:46 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm4713197pfj.157.2020.11.20.13.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:42:45 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/8] rpmsg: Make RPMSG name service modular 
Date:   Fri, 20 Nov 2020 14:42:37 -0700
Message-Id: <20201120214245.172963-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This revision addresses comments received from the previous revision,
i.e V6.  Please see details below.

It starts by making the RPMSG protocol transport agnostic by
moving the headers it uses to generic types and using those in the
current implementation.  From there it re-uses the work that Arnaud
published[1] to make the name service modular.

Tested on stm32mp157 with the RPMSG client sample application.  Applies
cleanly on rpmsg-next.

Thanks,
Mathieu

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=338335

-------
New for V7:
- Fixed error path in rpmsg_probe() as reported by Guennadi

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
 drivers/rpmsg/rpmsg_core.c       |  44 ++++++++
 drivers/rpmsg/rpmsg_internal.h   |  14 ++-
 drivers/rpmsg/rpmsg_ns.c         | 126 +++++++++++++++++++++
 drivers/rpmsg/virtio_rpmsg_bus.c | 186 +++++++++++--------------------
 include/linux/rpmsg.h            |  63 ++++++++++-
 include/linux/rpmsg/byteorder.h  |  67 +++++++++++
 include/linux/rpmsg/ns.h         |  45 ++++++++
 include/uapi/linux/rpmsg_types.h |  11 ++
 10 files changed, 439 insertions(+), 127 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_ns.c
 create mode 100644 include/linux/rpmsg/byteorder.h
 create mode 100644 include/linux/rpmsg/ns.h
 create mode 100644 include/uapi/linux/rpmsg_types.h

-- 
2.25.1

