Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFFA2260E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgGTNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTNbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:31:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD9EC061794;
        Mon, 20 Jul 2020 06:31:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j19so10269184pgm.11;
        Mon, 20 Jul 2020 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2j7F1HjD2jzSyI51YBZeo083TYMZE0e0Hdg/cz2X4VI=;
        b=D32GZ2Bp4Ly7Go7cvCAa/xliGYDiUIQ4KG5Td0C3myu4gUz1tzMvJX5VRRqY118d6B
         pq3MkAD/iR270VcfmMjcFOw0iA2cfmsUX07KUGICTcEpH7SZoMS9uae1bQ71rjJ22mLG
         oKWeKgu3JvKlpQhTCFOzeDjrkIpPP+aJqGvfl2XxoMEw9/w6TFt0WSFQbl+CJ5bW0PAg
         9mKfPwHtt4gEafsuexAMoFrfYvjYXCkTTtE+sisxLiduORIt6VU9et34NOaUFK96RgdT
         voISzaGZ03r9LW7pSejyHSQ+RnCQ9NAWbdSfqS0T8KurChe9IfV0J4WHIlAJV47DrwSd
         yEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2j7F1HjD2jzSyI51YBZeo083TYMZE0e0Hdg/cz2X4VI=;
        b=VvqS8Uv6WWuDCv1ZFHBF/LSBh0gCUFBdnvQpMVhNvOR4ba/+DH7xP+LsvWrkNjDLYN
         7lR5qkUctG6g4OPkSjyph36PTd4EStXSugfCDK09nQwEdf2lI68yiEPrK2OF8uOV0KeJ
         NVtmZllYpJf5GiOkje63BRioDzOP6pl6law5Ol74UBr97fJpinqE1zvqwYPeK2O8/wL/
         hwbOgPbz/KumjRDtHxh4cmnaMhYfE+jRxEu+ERz8HewlvmJmKIcjs+ljQCC1lPKzJTN4
         QcmCi4iW1jM8UChNw/DwMGMLHMXp+Hb8YyojWnMoBCR3eGivuHI0kQbUDWnhCKf0ONki
         Jq2A==
X-Gm-Message-State: AOAM533tO05XH5mEJRKCPZSLUuTWzCmlV49wQCAkT2Oz7b9LtTQ/5XAE
        ba4Ej8TDGPyt8yECcNgPkCNpISi96dPR7w==
X-Google-Smtp-Source: ABdhPJxRfPYOZ2kQOUeqsklFhHcGfFshgBoge8E4hL44dnX+aeo2UlHAwFo7JebDMKfTrr7sUzEXcA==
X-Received: by 2002:a63:8f18:: with SMTP id n24mr18024912pgd.432.1595251905596;
        Mon, 20 Jul 2020 06:31:45 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id t5sm14814356pgl.38.2020.07.20.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 06:31:44 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 0/3] block: use generic power management
Date:   Mon, 20 Jul 2020 18:59:59 +0530
Message-Id: <20200720133002.448809-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CY4PR04MB37516C5544A7DCAD84921937E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <CY4PR04MB37516C5544A7DCAD84921937E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mentee: Remove Legacy Power Management.

The purpose of this patch series is to upgrade power management in block
drivers. This has been done by upgrading .suspend() and .resume() callbacks.

The upgrade makes sure that the involvement of PCI Core does not change the
order of operations executed in a driver. Thus, does not change its behavior.

In general, drivers with legacy PM, .suspend() and .resume() make use of PCI
helper functions like pci_enable/disable_device_mem(), pci_set_power_state(),
pci_save/restore_state(), pci_enable/disable_device(), etc. to complete
their job.

The conversion requires the removal of those function calls, change the
callbacks' definition accordingly and make use of dev_pm_ops structure.

All patches are compile-tested only.

Test tools:
    - Compiler: gcc (GCC) 10.1.0
    - allmodconfig build: make -j$(nproc) W=1 all

Vaibhav Gupta (3):
  mtip32xx: use generic power management
  rsxx: use generic power management
  skd: use generic power management

 drivers/block/mtip32xx/mtip32xx.c | 54 +++++++------------------------
 drivers/block/rsxx/core.c         |  9 ++++--
 drivers/block/skd_main.c          | 30 +++++------------
 3 files changed, 27 insertions(+), 66 deletions(-)

-- 
2.27.0

