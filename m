Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD8822FFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 05:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgG1DPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 23:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgG1DPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 23:15:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CDBC0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 20:15:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k1so10742079pjt.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 20:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqvPFptaXrqNLR/xpVd6gqyLWNSPgfU8K5sYlQ8u1qk=;
        b=MfTig2D+aYwwa+XQpMSjtudJi6GMDOHV1l6mBKV7hAMMghTpxbq478ZNPNMlVsOeWi
         yLsYPYGtEXOT2mrDzUb6BJx5lUg1V3gn6YdRJKKv1GUHL90KDPfHOfGINlaagEi/0hPC
         3llxQQkuycFFeX7edCokUFbc5zSCiBKd6eZAYpIxPbCyYoxtGOgHWataeD38y9F14qGQ
         TNx3jvz+sVvHBP3oT7jwF69qV4NA0tNRv9f7FZnUTKAJqTgSVNlfLdh+R3poOjPBqXzR
         3BtmMml7SQBYhiG/ZFMCZ4nIZ1kIPOjvT/OAUchfyurXVgTWk856aYaZCf0zYEsHaXnv
         OLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqvPFptaXrqNLR/xpVd6gqyLWNSPgfU8K5sYlQ8u1qk=;
        b=K8lLfB48zCUA/Sa7p5hGpc0E6noq0x58yW70eodtBhsxHWrTAxzdB2PbulLiyEVCSF
         gwfJcSX/CrPJuY4esti2CSVxCcjM93BKI/FvMbQMQm6GRWvCvNYeO3/D7Zexp4nGTNQX
         zH+UYpN+MDaHE58hie1L4hUJP+9AZwGepJ/yL7VzkkU+5UiLM8wjquPmP15ihWQ3ac/u
         zGlB7H336P69HZtQtF4BRqB00qODh1D69ggFvXKgcw8eKrRZ1yVpzVh7ODZQTUb5ckgh
         yJo+I9Kbew/eZT6LowhTGLCrsnKvr4PsLk35zdqsN+N3wVwEuLCd0BItlmEuwk6kmcHN
         mujA==
X-Gm-Message-State: AOAM5335IkTY83gtAv9lcpg1lFsFspXMoZr63P69gZdELNHR0TRJeUF2
        tEkGhu7IbRT7MJ2ZbcWNxRy4x4TBVH3cyA==
X-Google-Smtp-Source: ABdhPJxs1jdMEm+AIUYt11RFJG6KlKTFv/6nraFuHw6vmYq4NWdqisr5zlsOqt5+h+EYMaUvuXwCvQ==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr21796119plr.152.1595906101384;
        Mon, 27 Jul 2020 20:15:01 -0700 (PDT)
Received: from debian.flets-east.jp ([2400:2411:502:a100:c84b:19e2:9b53:48bb])
        by smtp.gmail.com with ESMTPSA id s10sm3895285pjf.3.2020.07.27.20.14.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 20:15:00 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     masahisa.kojima@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: [PATCH v5 0/2] synquacer: add TPM support
Date:   Tue, 28 Jul 2020 12:14:30 +0900
Message-Id: <20200728031433.3370-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for driving the TPM on Socionext SynQuacer platform
using the driver for a memory mapped TIS frame.

v5:
- modify multi-line comment style
- remove MODULE_AUTHOR() and MODULE_VERSION()

v4:
- add ACPI support
- modify function and structure name

v3:
- prepare new module to handle TPM MMIO access on SynQuacer platform

v2:
- don't use read/write_bytes() to implement read/write16/32 since that uses
  the wrong address

Cc: jarkko.sakkinen@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: ardb@kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: peterhuewe@gmx.de
Cc: jgg@ziepe.ca

Masahisa Kojima (2):
  tpm: tis: add support for MMIO TPM on SynQuacer
  dt-bindings: Add SynQucer TPM MMIO as a trivial device

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 drivers/char/tpm/Kconfig                      |  12 +
 drivers/char/tpm/Makefile                     |   1 +
 drivers/char/tpm/tpm_tis_synquacer.c          | 208 ++++++++++++++++++
 4 files changed, 223 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_tis_synquacer.c

-- 
2.20.1

