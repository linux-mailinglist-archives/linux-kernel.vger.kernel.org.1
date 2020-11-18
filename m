Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FBE2B86D6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKRVhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 16:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgKRVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:37:02 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA13DC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:37:02 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id g7so2397269pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dmi4yivqaD4QCpDMbQpivJxjRzbYKk+YRlY9c6IFzHE=;
        b=Ih6b+trsTpeMoh74vvagERQEXlbd0ohQsWhYn5rV2bs+t7JT1506OEP9BlR5iVfdy2
         6RobQw+vNSNpuyf1nWz/hXSi3BRPC44qrVlXGmbNwcTHINsi51nC/C2YoTpilzNmvFHh
         muxHnCsvLMV6I1IA7JIPSb9trPi8pTVXDUXzd+5Lh7Un8Pdd13W6f6dPgykn4h8B6KbN
         /jmdKyXxkY2TMjHyMfdsXIy9jT8lm9lTLFXJ4AbbQl7ERSD3uqbyc3kA/c4TiY1rmbRs
         gvlTCKi5WZ83A2lnFQciDpjlLgqsnu2k0Px/DBHo0QPju4T1OcoLSqZTxi4ScBWR9uIe
         nGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dmi4yivqaD4QCpDMbQpivJxjRzbYKk+YRlY9c6IFzHE=;
        b=kC4+vbN3d1nxV9zl0x03V7EJSI/QYSt7bXD9qLpOv/VjZR8SOU4o6Fi8jP/U/KHIFu
         TRc6ziJwoHXcO8sPydp3gdHJ61co8Ck7sBY78wss2CY5vtmH3d5xY2Eu5XqpMpEAbTlA
         BFmN+r6Yd+XdMtIl7gEiCakJieznT08/5WJG9IfOS6JVV5Lc6i8jN9lJ2SwqdviBX2oz
         NiiAUOc4qqNqvQnAbPbBusTSTR25pI1ie5BUvHEYCbtw7JxuEEFmZM1aMqVDBMXYOasq
         Ga4LLsRNOb3rAstWjNEMdfgzKEansdgi3hyLU9NPfGr5h4q+y1KA7Jd7yTNOc4vn2+4T
         vmVw==
X-Gm-Message-State: AOAM531uQcostIt9YZgcQNgPVDBkn9nDYpQ96VuhYm8ftDxLV506j+4z
        BhweivcecmNteWpQdkJWEuORJWpV9+PKxA==
X-Google-Smtp-Source: ABdhPJylhq5uJ7aLmS+5BsPJ9u/V81SGCDOzhZFlfIqwmNbkCbptAM2GxIGhH6OKqHX9U3AEsvDUxw==
X-Received: by 2002:a63:ff5d:: with SMTP id s29mr10190022pgk.290.1605735422350;
        Wed, 18 Nov 2020 13:37:02 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e6sm26575694pfn.190.2020.11.18.13.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:37:01 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/8] rpmsg: Make RPMSG name service modular 
Date:   Wed, 18 Nov 2020 14:36:52 -0700
Message-Id: <20201118213700.74106-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This revision addresses comments received from the previous revision,
i.e V5.  Please see details below.

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
New for V6:
- Rebased to rpmsg-next
- Move rpmsg_ns_register_device() to rpmsg_ns.c for automatic module loading 

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
 drivers/rpmsg/virtio_rpmsg_bus.c | 185 +++++++++++--------------------
 include/linux/rpmsg.h            |  63 ++++++++++-
 include/linux/rpmsg/byteorder.h  |  67 +++++++++++
 include/linux/rpmsg/ns.h         |  45 ++++++++
 include/uapi/linux/rpmsg_types.h |  11 ++
 10 files changed, 438 insertions(+), 127 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_ns.c
 create mode 100644 include/linux/rpmsg/byteorder.h
 create mode 100644 include/linux/rpmsg/ns.h
 create mode 100644 include/uapi/linux/rpmsg_types.h

-- 
2.25.1

