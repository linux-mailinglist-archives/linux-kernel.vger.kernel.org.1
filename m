Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422331EE9F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 19:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgFDR7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 13:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbgFDR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:58:59 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E1DC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 10:58:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so6796781ljm.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ke3Q3IrQeyEZTnLG9bUCuuMoRX7XeInSOniRN9QrWyw=;
        b=dMSTxduor75B36dsm5lF9BdhoZTWK4g1WCBYjsGcF4rH1IXuRZggRQdr2L8j36g92/
         ujsCRblCF0VuBQtFBpaILEOp1bhrR+4g/VkJtTvxd/KR1A9yCwxIBjwyNi2tjIwXhCBm
         5EggjScaRgNpKYNBveyn3lBp4sOgrTffF+pRGbRbMocLMz5kLhoBDlNwZINl31aDc8rG
         0gt3pOnKQxAmImVYVFBR5SXGrd4X8zV03C9txoofqjsY7+QEBxQ8OV28zGKFbYcDBwnS
         6O/eytJRxBC1PI987lky1URpfSArBu6wqQBE6GznsYXRfaHpA/pHg7i4dTeP3a0sBU+T
         OWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ke3Q3IrQeyEZTnLG9bUCuuMoRX7XeInSOniRN9QrWyw=;
        b=Un2BtYVfqWptFo1+o+bjCJm9j3DE+IgYJmhloJ3Vo29aDoOFtwBmefDMkkTlm9ssV4
         MpCwXdoEqXBHRWsUKaRBQswbiBPwRwybpPtfmbozsOMbikOjUpTKkkRRPhbKE4rhLegA
         dQ7rQeOujyfNwOlz1WkIUNbXbMJem8LSSSMgzSqTPkHcWfiq6Celjc07ijPZkb8KNcig
         CdfvFcs/m/98SaCd9uD0b3lqzoiiBuFIs9J33US8QCmE7mQDqzzVpPZ+eg6nkc8GclQp
         sXk4v6x2kW0RuJwEcBGYZk35iMnJX8hYhy6kR0NHljpLS7T8B2RL1xdkH5csZ6TuhAek
         g4cw==
X-Gm-Message-State: AOAM5312Wbf/IV0+O/28Y9Xl7H80peaOtAy3hTGDdOBHdWwqMUaWlEj+
        gaO0ZRXSBOtXFXatIDHrM03yBB+H5V0=
X-Google-Smtp-Source: ABdhPJyXtDReEdUGVRWF6bduD+Zt+lORttxj9OlsLpivIBNj2COer68yLoqIPKpG/wYvgAqZwdLhPA==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr2802442ljl.360.1591293535880;
        Thu, 04 Jun 2020 10:58:55 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id y17sm72404lfa.77.2020.06.04.10.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:58:55 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv8 0/3] optee: register drivers on optee bus
Date:   Thu,  4 Jun 2020 20:58:48 +0300
Message-Id: <20200604175851.758-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v8: - fix v7 check.
v7: - check return value of dev_set_name() (Jarkko Sakkinen)
v6: - description, comments, patches reorder and destroy workqueue (Sumit Garg)
v5: - removed pr_err and fix typos in description (Jarkko Sakkinen)
    - added missed kfree in optee_open()
v4: - sysfs entry is optee-ta-uuid (Jerome Forissier, Sumit Garg)
    - added Documentation/ABI/testing/sysfs-bus-optee-devices (Greg Kroah-Hartman)
v3: - support tee-suppicant restart (Jens Wiklander)
    - description and comments (Jarkko Sakkinen)
    - do not name optee drivers by index in sysfs (Sumit Garg)
v2: - write TEE with capital letters.
    - declare __optee_enumerate_device() as static.

Maxim Uvarov (3):
  optee: use uuid for sysfs driver entry
  optee: enable support for multi-stage bus enumeration
  tpm_ftpm_tee: register driver on TEE bus

 .../ABI/testing/sysfs-bus-optee-devices       |  8 +++
 MAINTAINERS                                   |  1 +
 drivers/char/tpm/tpm_ftpm_tee.c               | 70 ++++++++++++++++---
 drivers/tee/optee/core.c                      | 27 ++++++-
 drivers/tee/optee/device.c                    | 38 +++++-----
 drivers/tee/optee/optee_private.h             | 10 ++-
 6 files changed, 119 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

-- 
2.17.1

