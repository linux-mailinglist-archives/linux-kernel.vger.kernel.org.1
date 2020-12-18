Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544BC2DE811
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbgLRRdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgLRRdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:33:11 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E67C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:30 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t8so1933742pfg.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fPY+6zn3CRK+yrW/S/jc5rhwI6oFcz+6g11nN4QUqk=;
        b=X+DPUFxUuphTyYgif05i8n82F6RIxnwTf4JXGkS9hGnWQWAFLPD7Y5fsHygSK1UX6t
         cj4ZeDM6VXKPRhjJw2c44KiwUaJB/rwosxHYAahLWap0fxYqIFDpJg9xiBKbPoCO8FD2
         0iNn/LAfKrXBj5hWu6RxjZt0H7n4s06KV/hj2I+bb63HoyjfFlbD+NuUWygSlhnWqynV
         B/y2JvZClwUQyB8suxNXZAhcewXDNKUFmWnvIdEKv821HY1JVMMAVvv7x4NwurqZqLXA
         1xzc4+QxzdKRfAJA9kyf72QZvpDctJnaNEtvS4T4lARxsjS0he9WIW9kghxR3Rn1GBDN
         T+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fPY+6zn3CRK+yrW/S/jc5rhwI6oFcz+6g11nN4QUqk=;
        b=ilZj8riofYcZmavCQCrRRSOPCEIvKQYHNOyfcsX/jyJvz1mmcJtgkeMHtMSnGn7m/G
         M6DKQVE7c+ribI/LhiYPNcUJJb4Xn6kM4mnLlv2CWq4RFnlbX8oZQCNEcSJjErdzmqSR
         u/OErfVDHo4EYmC2Hg76LgknrkkRddOSAgURTRqHi2ElrvfKh9sXJNR75n6zDfjBDr1E
         NLWiK0iGqSS9bT/JQyz4owSvBTszI/mZlJv+PMQAlMWRrxbzzdyAFX+xOCIdZbTOz6w6
         ZyT8oJBed8yZ3V2Q4xVgabvgjgpB8Un2gNTqo51f7sy35b1qOxdN0v6+yg4TqvpKwumo
         j2NQ==
X-Gm-Message-State: AOAM530gAFV+gwmbwdfqBg5h594zGGWLnW7RUtISmqERtKChq7cCfdbp
        M0GmUwYKSNB32mkV6/FezSI/gg==
X-Google-Smtp-Source: ABdhPJyEi49San20wggF2PHMhE+7t1PfPlTsjiQdxh+omJKbTyHygaUcY7nupQpPU31caUpyahH/Kg==
X-Received: by 2002:a05:6a00:2384:b029:19a:eed3:7f42 with SMTP id f4-20020a056a002384b029019aeed37f42mr4976255pfc.4.1608312750240;
        Fri, 18 Dec 2020 09:32:30 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l11sm9892957pgt.79.2020.12.18.09.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 09:32:29 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/17] remoteproc: Add support for detaching a rproc 
Date:   Fri, 18 Dec 2020 10:32:11 -0700
Message-Id: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the work done here [1], this set provides support for the
remoteproc core to release resources associated with a remote processor
without having to switch it off. That way a platform driver can be removed
or the application processor power cycled while the remote processor is
still operating.

Of special interest in this series are patches 5 and 6 where getting the
address of the resource table installed by an eternal entity if moved to
the core.  This is to support scenarios where a remote process has been
booted by the core but is being detached.  To re-attach the remote
processor, the address of the resource table needs to be known at a later
time than the platform driver's probe() function.

Applies cleanly on v5.10

Thanks,
Mathieu

[1]. https://lkml.org/lkml/2020/7/14/1600

----
New for v4:
- Made binding description OS agnostic (Rob)
- Added functionality to set the external resource table in the core
- Fixed a crash when detaching (Arnaud)
- Fixed error code propagation in rproc_cdev_relase() and rproc_del() (Arnaud)
- Added RB tags

Mathieu Poirier (17):
  dt-bindings: remoteproc: Add bindind to support autonomous processors
  remoteproc: Re-check state in rproc_shutdown()
  remoteproc: Remove useless check in rproc_del()
  remoteproc: Rename function rproc_actuate()
  remoteproc: Add new get_loaded_rsc_table() remoteproc operation
  remoteproc: stm32: Move resource table setup to rproc_ops
  remoteproc: Add new RPROC_ATTACHED state
  remoteproc: Properly represent the attached state
  remoteproc: Properly deal with a kernel panic when attached
  remoteproc: Add new detach() remoteproc operation
  remoteproc: Introduce function __rproc_detach()
  remoteproc: Introduce function rproc_detach()
  remoteproc: Add return value to function rproc_shutdown()
  remoteproc: Properly deal with a stop request when attached
  remoteproc: Properly deal with a start request when attached
  remoteproc: Properly deal with detach request
  remoteproc: Refactor rproc delete and cdev release path

 .../bindings/remoteproc/remoteproc-core.yaml  |  27 +++
 drivers/remoteproc/remoteproc_cdev.c          |  32 ++-
 drivers/remoteproc/remoteproc_core.c          | 211 +++++++++++++++---
 drivers/remoteproc/remoteproc_internal.h      |   8 +
 drivers/remoteproc/remoteproc_sysfs.c         |  20 +-
 drivers/remoteproc/stm32_rproc.c              | 147 ++++++------
 include/linux/remoteproc.h                    |  24 +-
 7 files changed, 344 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml

-- 
2.25.1

