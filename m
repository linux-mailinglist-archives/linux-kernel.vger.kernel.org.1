Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4282A8A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbgKEWvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732293AbgKEWua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:50:30 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF42C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 14:50:30 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id v12so2496303pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 14:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITyVVyrjBjMsKXUPqKEIMGOz26VLuknXtLKpEuuWCZ8=;
        b=hSedokPEjbLaB+xoEyp9IKJX7h+IgmIn/2R9U/Uc8qtN0+33DCYTMId1JCLh0vtR4b
         ep/7qqGt5LoAVnlN/RnQvrFTF+koK3m1IGCphLW5QZKhI+kHzX6tbFYn4A7aP+zIlDr4
         /3N+Qy2QrGEskI2piogI9XBDl5dmqNoHd9TnTvgkLqiUraNUWRqAthchNTw6wIRIsoZj
         k8iRptooi5Dk4/S3rsW2G0FxuUk4Yj2llR/+/wwEC/JJIbTcCDJkEuszrLYW8wRBuD9Z
         YAV6I9V0Eq3FhfBi8l5BNhL/WKDIpwtcRLdpcgZiihkoNa4JdFC0emSd3UiuHBNRyK8G
         UKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITyVVyrjBjMsKXUPqKEIMGOz26VLuknXtLKpEuuWCZ8=;
        b=n9UTWuWPaSxbUdNBSvL4zkWbbBD376ux+z3uEamzGxhKFyPwmCU1+jIvmxydorIVN1
         eXdtJf/wBU+DpFdrjjEp8hZbia8J3H/5MRRpZcZBz3/tNsFn2yM0PJ1eO6Mr/SVeV5a0
         CrxZdDyBuFR357S3wIFyB/e41nSECRKqeBtlhQLhTGzx7uzd9+Hj//5ITzZ72QG4TA0p
         ReWeQIH6eSuure+nBosWbfRMSfUcQl0+Q8V986Rfp0Gs0J4+M5QvWHopu0qrZV9jg7DD
         XzjYouwvsxSNaPv/MEVEQUct6H+5/5pzMe5DLYOFF00Cgq1XdxEKroZ9OSLwlDA4LyPJ
         oPZw==
X-Gm-Message-State: AOAM533h26qfHHiavsorhpt5JhOF6Rf8pSVxDImHzjRqecu8bB1OCA8W
        YHs8hA4gKNKmxN7Ixa9OmQuF8KUSVo7WuA==
X-Google-Smtp-Source: ABdhPJwFdF36DAICwXal1BEoZqFCs+jClw7rlQTBQ6jQCFdGCF8TgLztW8qFU6394PKklhqZ2S6e2Q==
X-Received: by 2002:a17:90b:1058:: with SMTP id gq24mr4569893pjb.29.1604616629903;
        Thu, 05 Nov 2020 14:50:29 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d145sm3854501pfd.136.2020.11.05.14.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:50:29 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] rpmsg: Make RPMSG name service modular 
Date:   Thu,  5 Nov 2020 15:50:20 -0700
Message-Id: <20201105225028.3058818-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This revision addresses comments received from the previous revision,
i.e V4.  Please see details below.

It starts by making the RPMSG protocol transport agnostic by
moving the headers it uses to generic types and using those in the
current implementation.  From there it re-uses the work that Arnaud
published[1] to make the name service modular.

Tested on stm32mp157 with the RPMSG client sample application.  Applies
cleanly on v5.10-rc2.

Thanks,
Mathieu

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=338335

-------
New for V5:
- Moved include/linux/rpms_ns.h to include/linux/rpmsg/ns.h
- Moved include/linux/rpmsg_byteorder.h to include/linux/rpmsg/byteorder.h
- Sorted header files alphabetically in ns.h
- Added include for rpmsg.h in ns.h
- Rebased to v5.10-rc2

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

 drivers/rpmsg/Kconfig            |   8 ++
 drivers/rpmsg/Makefile           |   1 +
 drivers/rpmsg/rpmsg_core.c       |  44 ++++++++
 drivers/rpmsg/rpmsg_internal.h   |  14 ++-
 drivers/rpmsg/rpmsg_ns.c         | 108 ++++++++++++++++++
 drivers/rpmsg/virtio_rpmsg_bus.c | 185 +++++++++++--------------------
 include/linux/rpmsg.h            |  63 ++++++++++-
 include/linux/rpmsg/byteorder.h  |  67 +++++++++++
 include/linux/rpmsg/ns.h         |  60 ++++++++++
 include/uapi/linux/rpmsg_types.h |  11 ++
 10 files changed, 434 insertions(+), 127 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_ns.c
 create mode 100644 include/linux/rpmsg/byteorder.h
 create mode 100644 include/linux/rpmsg/ns.h
 create mode 100644 include/uapi/linux/rpmsg_types.h

-- 
2.25.1

