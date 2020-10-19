Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D380D292F77
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbgJSUem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731695AbgJSUel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:34:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B45C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:34:41 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id h7so676242pfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mfnEqIWjnStVS39u224NPlh0all/sUjbgbmWpMbtiK8=;
        b=ml72EHlmhiQZ2yFzn5mcqEMJhqBRGUO0pOgz9F5pIr0on6nzdwfTnFhBwwnjQsOJs+
         n1C1QhCj9ioD/KpIGidC/qisdX4k9GI7jH+jaBLNQSloDCQneMafdD2nyBFKxRIQHGKn
         0/6ch6+ciby8CQ38NxvBaCxq+KxrF/VjPaZARe1b8SAhAS0L4ugGItOtwkoTCsKIqR24
         ZGiBlvR3D/q+KS1n3sk7vJMcEAdkweBIR5jxmugESl06VRAjfeEAywRMe84MFLAmUC+7
         eQdgZQmSF9Qtg9+J/LQgws0YhjhrqKOx1nm35D1V0vcJLiGUMO/BDT9ub77ssy6Nztsl
         5Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mfnEqIWjnStVS39u224NPlh0all/sUjbgbmWpMbtiK8=;
        b=PMW237q5dg9gk1JxWZC9iLywyNlKomAIHNE2fEMhp/XNM2zxrHvVKqOu4lVK80hyIi
         TF+tKr9/3TDFiq44VnngD2gKveBkWNYbcLSwhbT7l3eNUa9Djkvty3gOGGgIEQRhd/Es
         2qllUZPeocKK+EU9S0u2vI1G9VUwVbrgY0KP3B+31FN2ThCVNhQ390i0ZB+b53BZAKxY
         5R4OpUfgEvVd7IjdZN68ib4sDzKHwCCAJV0TxV1sztcPDmB9/UGMxckwhhvTah2We9wM
         XiA0CVRji2WqAtSUtyDHJc2xmCUHj5n/uWS4H0SunYDTMPItNUC4teyGNSGZrmhB/6JB
         K87A==
X-Gm-Message-State: AOAM53316+xT7d7bBnOh1u5I2oWqiZDKESNFOIv1VUI28CjPfIGr+bcq
        iBP8wFi4DHO/MsKChrbWGCiRKQ==
X-Google-Smtp-Source: ABdhPJw+R2ewljVcPNS7X9eyA9xVhuwUTKVxDgPNgCShMcG0cvJpzOPyasPBX2U/ZenVbJuLITKL0Q==
X-Received: by 2002:a05:6a00:8c3:b029:159:53cd:86df with SMTP id s3-20020a056a0008c3b029015953cd86dfmr1874874pfu.0.1603139680733;
        Mon, 19 Oct 2020 13:34:40 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q123sm631847pfq.56.2020.10.19.13.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:34:40 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] rpmsg: Make RPMSG name service modular
Date:   Mon, 19 Oct 2020 14:34:30 -0600
Message-Id: <20201019203438.501174-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set starts by making the RPMSG protocol transport agnostic by
moving the headers it uses to generic types and using those in the
current implementation.  From there it re-uses the work that Arnaud
published[1] to make the name service modular.

The main difference with this revision is the usage of a variable
(rpmsg_device::little_endian) rather than an operation to determine
the byte representation of the transport layer.  It is also
addressing a problem that would have prevented git bisect to work
properly in rpmsg_ns_cb() where the rpdev was used.

In short patches 1 to 3 and patch 7 have to be reviewed again.  They
changed enough that I did not add RB tags to them.  Patches 4 to 6
have not changed from the previous revision.

Tested on stm32mp157 with the RPMSG client sample application.  Applies
cleanly on v5.9.

Thanks,
Mathieu

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=338335

-------
New for V3:
- Using rpmsg_device::little_endian variable rather than an operation
- Fix an implementation problem that would have prevented git bisect to work


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
 include/linux/rpmsg_byteorder.h  |  67 +++++++++++
 include/linux/rpmsg_ns.h         |  59 ++++++++++
 include/uapi/linux/rpmsg_types.h |  11 ++
 10 files changed, 433 insertions(+), 127 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_ns.c
 create mode 100644 include/linux/rpmsg_byteorder.h
 create mode 100644 include/linux/rpmsg_ns.h
 create mode 100644 include/uapi/linux/rpmsg_types.h

-- 
2.25.1

