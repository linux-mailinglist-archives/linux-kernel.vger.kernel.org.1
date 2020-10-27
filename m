Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3914D29C417
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1822753AbgJ0RwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:52:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46708 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1822745AbgJ0RwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:52:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id n16so1204011pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bnr9bCFH4BOnkHPYuyRH456jUmw7jY7AN38VGoSonfA=;
        b=Ic4R8eedZZIUVUac/9063eUF14JBhGhsEca21Ml2qGU3xaUKovtpXJTuqIdIGtdJVE
         T8IXkZrboxb3TlH1Q3ndc/sMxw/PcGpH8hR6LFqkIDM7nBkNwlfRPstbTnTyS5g0knyr
         6ubKo8zsF1O0a5wOgtrn2GQ3TFBI/Rvd96ui5fvYFadt4f0fPJPhRiSqwP+aI4ePD1Fe
         GsnGpdAnPROsZBK3TZBMuq2tehyqU3bQ5yd5ft6tAD8FQCoYFxdVGEx6E0OU5PMFOuYb
         YbT0jhXpFpGRceCBAt7B9DWsaFn1Hrzyd5IIlrjY7qqLtgFLKGRLwxy31ZGPC1i3QGH4
         ilYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bnr9bCFH4BOnkHPYuyRH456jUmw7jY7AN38VGoSonfA=;
        b=CUVcFoWBDXKsbYXnIS+xhZpwz4uH67eZ6Il9gPz0UZaH2R1ieNiwEAPeIZNDRPvoCI
         8+VzZWCpz8hCyc2D6JXDf7n6IygcY8U87CxxvgdCOtvZY7Ce6mjmu0D7IkrP+9HlLj28
         hgPueDyd+/fa3SzZyyx5MZ7zQOzQlHwKGqOQnUXzWJsSaBFfqbC4ncB7FmuiYrT2OMPR
         2ZMeu3jQicEnw3AfofB6EGfcuA20dlAPHiuZwCBSoEfK/I3Q1wCcshoXioaWq2Z47Mii
         T5SJgPdP/UUIwE22bxJ820m7H+FqSZHf2zCP3pzcwOhUcaRpyni+CueBAlFWTPzWvkoH
         mHfQ==
X-Gm-Message-State: AOAM533PRSTLrZ2njHJjKzYDs3zF1aMtSOyqYRd6CpAurfaz3hicbfcL
        WVUApT+z7GeZE0wigibL1ZJiBA==
X-Google-Smtp-Source: ABdhPJyP8J4pvzpRAmDmwOVXOsP5hqNyotIxr//y73L51aEOThv+GHLBGKpfDVRFwYv0JCGKO2uGSA==
X-Received: by 2002:a62:158c:0:b029:152:6669:ac75 with SMTP id 134-20020a62158c0000b02901526669ac75mr3344342pfv.5.1603821140430;
        Tue, 27 Oct 2020 10:52:20 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r8sm2761225pgl.57.2020.10.27.10.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:52:19 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] rpmsg: Make RPMSG name service modular 
Date:   Tue, 27 Oct 2020 11:52:10 -0600
Message-Id: <20201027175218.1033609-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This revision is a simple rebase and doesn't provide any new
functionality.

It starts by making the RPMSG protocol transport agnostic by
moving the headers it uses to generic types and using those in the
current implementation.  From there it re-uses the work that Arnaud
published[1] to make the name service modular.

Tested on stm32mp157 with the RPMSG client sample application.  Applies
cleanly on v5.10-rc1.

Thanks,
Mathieu

-------
New for V4:
- Added Arnaud's RB tags.
- Rebased to v5.10-rc1.

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

