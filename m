Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03731EE73C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 17:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgFDPD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 11:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgFDPDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:03:55 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA9C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:03:54 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r125so3770932lff.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mvYq5u2MuHjycn6hYvFmkcMBPwMkF7OiyTcLEldoKI=;
        b=Y+qvhynKYSHX8BiDFkP/S4vohEDVw08HK7v0lcnvCMfaGvYH1AK4t29iooALuPlEl/
         dUXhszVNyTEBEyURpfaENunG4yCA/TI4K2iN0A0ZTaGB4aMvM91PDr6M7ZwHxD6bkePP
         /xciGEAWGG2mZ2Z7gtaGbqD43ptaZ5jxaMUzg39rD2HaGMweoDIEIKd3i/GYXzcT9wZu
         wRJJq9suE3fsNqs/5KiB3eqcJLZK7R6Oej4hnCo3dHJA9njIASKHuStAybkBVYGAcqko
         riBweyZUQS7l7hUZiE9s90RmVzx9hh5iAIGanlL0uaHoV5FseARBu/U10lC5YmVGfZR+
         7LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mvYq5u2MuHjycn6hYvFmkcMBPwMkF7OiyTcLEldoKI=;
        b=WZ/pluurYLVU05YVPrjBrYzkn0ftgbZlulT+ZKbazbwupKRU6AiOOamI+IJqIMAN/l
         NKpR1n76KJX4zqBs5sAXUmA5ErCRZIkwKEmgAjQB8JC9+KpxvLHGxFbRMxKdfzIvsvX6
         rVxrMJpX5Iq0lPK2CXN4TRC7Gz+M7j3I7f8xZuVUheAZNHbTD87cHcz/5bUWzGRdlrKw
         rfSCdz7Pq/RV8eRJcnYhm2Z2jQK/y5j05orjgwdgw+EHCWwWdUOn1Hs+NUcOMWeP6tmy
         g36wyWrd6BlbNt/YKsourZH7pgO7fiP1pwQZCWJNyHg0QJ0oFk7nrtPEPFs2dOuoU8St
         sYjg==
X-Gm-Message-State: AOAM5338T3Aavet6/vpgHhGa6n8TBBQLGIBd3Zg96arkAlzVtnx3fSiN
        RXrlyxYUHI3fOztYVW28/RV4XbLthQg=
X-Google-Smtp-Source: ABdhPJyjUtNMiJfQCO+6pwW7PpNiXMf463lCpuTEqvxbiXuHw13DlR9CNHnNDe/wZgfZbFie2jnMBg==
X-Received: by 2002:ac2:5094:: with SMTP id f20mr2852735lfm.128.1591283032156;
        Thu, 04 Jun 2020 08:03:52 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id m15sm1514619lfk.65.2020.06.04.08.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 08:03:50 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 0/3] optee: register drivers on optee bus
Date:   Thu,  4 Jun 2020 18:03:45 +0300
Message-Id: <20200604150348.27996-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

