Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AAD27371A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgIVAKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgIVAKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:10:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538DDC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d9so10792488pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pplI8lBFdqylD+9AB3kyxEb1yGakx0V/9od+sbt5zHA=;
        b=VksqWvA/jtwTVb3pd4p2bpDzqb5GG5Cqe1SKMbq1w3xn22KN/e4wonpFslbspRSxKX
         G/BS/H0xhhE2HScngb6aDAAQLR+9hmVJ/2ncacKOFXNKvM/Yf4tlYKgJsmGL0Y6IJSej
         UOlSn9PqA7k4rQSwp1UhkI9VrGl8ezyMnqehv3B2ZHGGdKN2yDNGwXaS9SxFUte6PBMy
         J3Uua4vTQzz/JWhlUcP8+2EqNMquj6eh+rPCCfkCdlWdB0FGj5jGFcEjPGQhf6HGtsK7
         Vq8qlOWo9qbc5p28kkt1c92eu8qj04wGoRO2OmA1ENxEmILcBVlRqfdQ3JqeTuiBRit3
         uhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pplI8lBFdqylD+9AB3kyxEb1yGakx0V/9od+sbt5zHA=;
        b=sUW15jU3bt78Gch3ymWQdM7FFhMtf2xJHm28BJOqg7ldR/02UqmZ08GCS9G4TohmW9
         XkiyZmpmX1wQX7g1dl9P1nSPofuO2wsk1ta5uxObo2XmlvdF5lmO6ZbAl61OiLlYgAU2
         vpR9aGLGBBDoC7IYbToEybAxK0fLh8zLvObjNoLbIW3pw9bgeU+8SsAwll3MGuq/Gajv
         CPS4aNY+91m/zuSf9bfT/r0+1C1+uMVpS4TL3l3h3X5bb1FomBBCJnH1Q8b7pauBlUAY
         y54g9+H+YxQ5F1/8I3dwgSD3v9TGHS3FrIr2+ly06Rr6oXdvnEXT8Op3djS8dKsANH0b
         FuBQ==
X-Gm-Message-State: AOAM533n5bzGIbym3+5hBTFMIJScqWKNr9s4n/ctI5rzUQ04DLeJ/JUS
        rT/iWI461pXVXNJsv0SbW7hQtbt3Jjl+YQ==
X-Google-Smtp-Source: ABdhPJw5x3351y0RIzkxGyGNg4O6s7LFFkcabpH6zjb4HSBoqXG4rJMLX3u3+qi8aAVG5gWfb3n5Qw==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr1509418pgp.45.1600733401833;
        Mon, 21 Sep 2020 17:10:01 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c9sm12807953pfn.78.2020.09.21.17.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 17:10:01 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        guennadi.liakhovetski@linux.intel.com
Cc:     loic.pallardy@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] rpmsg: Make RPMSG name service modular 
Date:   Mon, 21 Sep 2020 18:09:50 -0600
Message-Id: <20200922001000.899956-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After looking at Guennadi[1] and Arnaud's patchsets[2] it became
clear that we need to go back to a generic rpmsg_ns_msg structure
if we wanted to make progress.  To do that some of the work from
Arnaud had to be modified in a way that common name service
functionality was transport agnostic.

This patchset is based on Arnaud's work but also include a patch
from Guennadi and some input from me.  It should serve as a
foundation for the next revision of [1].

Applies on rpmsg-next (4e3dda0bc603) and tested on stm32mp157. I
did not test the modularisation.   

Comments and feedback would be greatly appreciated.

Thanks,
Mathieu 

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=346593
[2]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=338335

Arnaud Pouliquen (5):
  rpmsg: virtio: rename rpmsg_create_channel
  rpmsg: core: Add channel creation internal API
  rpmsg: virtio: Add rpmsg channel device ops
  rpmsg: Turn name service into a stand alone driver
  rpmsg: virtio: use rpmsg ns device for the ns announcement

Guennadi Liakhovetski (1):
  rpmsg: Move common structures and defines to headers

Mathieu Poirier (4):
  rpmsg: virtio: Move virtio RPMSG structures to private header
  rpmsg: core: Add RPMSG byte conversion operations
  rpmsg: virtio: Make endianness conversion virtIO specific
  rpmsg: ns: Make Name service module transport agnostic

 drivers/rpmsg/Kconfig            |   9 +
 drivers/rpmsg/Makefile           |   1 +
 drivers/rpmsg/rpmsg_core.c       |  96 +++++++++++
 drivers/rpmsg/rpmsg_internal.h   | 102 +++++++++++
 drivers/rpmsg/rpmsg_ns.c         | 108 ++++++++++++
 drivers/rpmsg/virtio_rpmsg_bus.c | 284 +++++++++----------------------
 include/linux/rpmsg_ns.h         |  83 +++++++++
 include/uapi/linux/rpmsg.h       |   3 +
 8 files changed, 487 insertions(+), 199 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_ns.c
 create mode 100644 include/linux/rpmsg_ns.h

-- 
2.25.1

