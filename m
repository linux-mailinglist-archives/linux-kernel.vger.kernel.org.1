Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0141D1E2D82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 21:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392324AbgEZTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392115AbgEZTUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:20:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095D0C03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:20:36 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w10so26006303ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JfF6l7LMx459ERvdO2nN2IW/+d2ZQx/5sEZb/9TJPe4=;
        b=gsPtEcFyaZ2rKhAoYUQ6j60QBCgFTXEiJEAUvn6qAIaSzREiIsPnFBLajsfwmrMLDo
         nxMGvK23w72VOgMobqIQk9bZ8LKvoCWGeUrmjFpyXjQJ8yP/UpQy5dDHwWKXXqWpAi/s
         Ywk6oawv1Pf58xHRhPLJiT9ciOw2Hq1yrbqh7ze/AQF805r4TIpw5kKn5R/aFnWbaRY/
         JO5EHJXnga7X2q5ipf0v/QGA+75vcNty9uLqyjLVcBe3F0td8Rw9uyeG9DzfB9q09IDI
         4EEFt3FyUfteoAnyM7Tisk8CuiMuWUudyEJpwDy5+kisRbsqcmNokxeV1nletpSoFEm/
         r8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JfF6l7LMx459ERvdO2nN2IW/+d2ZQx/5sEZb/9TJPe4=;
        b=mw1HDg5v5cJLdsMKO82OQnxc+rpuntS2zZI7EYXremx7sqktQ9A5cD2juuboD8xee2
         X8+NxpGUCHDEmKGRnv+Mf6AGgpL+/0sBHNG4W4L4s15bmLhrSw0TR6B0ak9L/LNyiYt7
         0tzxU3nZ8gcNhkmo7sn8CgoSMO9LszSMYKc7xOQfyMZLna4t1arzdKPCORxZNh7xi9Il
         HshOU212uQ6H/FWKrPanBqQCmyB3YjQHM4MYp/1eeFObZXy4o3x3KODu+Oor0t2QleHf
         EvvE+iPzY0fQIzrUhPfH/MJ+gX62+c4tPFHJ9c/8y9dqjmRvkn53NBfIGYgh/LSRIk+P
         3n4A==
X-Gm-Message-State: AOAM532TOE7zdiEH+znrrO75+9LMb67BiMHnYRKMLBs3r8iPeii1Vpzy
        ScGdl6LoqadSBvqLKEPaygHWUqgLMvA=
X-Google-Smtp-Source: ABdhPJzBG2M9RQOiO6jFCVOTGmhqxnYhcD27yu9YfRo3sjWafwiiyZ9QsdRlW49fl7rDD4rQ5Q3gxA==
X-Received: by 2002:a2e:b5cf:: with SMTP id g15mr1210420ljn.212.1590520834156;
        Tue, 26 May 2020 12:20:34 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id i8sm180483lfo.62.2020.05.26.12.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:20:33 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv4 0/3] optee: register drivers on optee bus
Date:   Tue, 26 May 2020 22:20:26 +0300
Message-Id: <20200526192029.863-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4: - sysfs entry is optee-ta-uuid (Jerome Forissier, Sumit Garg)
    - added Documentation/ABI/testing/sysfs-bus-optee-devices (Greg Kroah-Hartman)
v3: - support tee-suppicant restart (Jens Wiklander)
    - description and comments (Jarkko Sakkinen)
    - do not name optee drivers by index in sysfs (Sumit Garg)
v2: - write TEE with capital letters.
    - declare __optee_enumerate_device() as static.

Maxim Uvarov (3):
  optee: do drivers initialization before and after tee-supplicant run
  optee: use uuid for sysfs driver entry
  tpm_ftpm_tee: register driver on TEE bus

 .../ABI/testing/sysfs-bus-optee-devices       |  8 +++
 MAINTAINERS                                   |  2 +
 drivers/char/tpm/tpm_ftpm_tee.c               | 70 ++++++++++++++++---
 drivers/tee/optee/core.c                      | 28 +++++++-
 drivers/tee/optee/device.c                    | 23 +++---
 drivers/tee/optee/optee_private.h             | 10 ++-
 6 files changed, 118 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

-- 
2.17.1

