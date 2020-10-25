Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878C72982D4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 18:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417732AbgJYRql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 13:46:41 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:46929 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417704AbgJYRqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 13:46:38 -0400
Received: by mail-lf1-f46.google.com with SMTP id v6so8890303lfa.13;
        Sun, 25 Oct 2020 10:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0MBTRhTBvsyqduaPDlcHzj7Pu6u26Y6GGbYsif9UVUw=;
        b=XQ4nf72nwfw3X/ktgPZ3mODRWqYbbqAt+acjQHA7CXo4yhiE75Ig30IYKyHgEHX6eD
         fG1Aws8V20e+Y4b7saw9MvtIgme3NmODf4WBYm4/vj40YBcxPRG3v2+v4waU9gxU9bd2
         aVA3Y11WYrkFFOuh/QF2VCZ8bFsqa1SwpOrG1/ufNPdqu5FihpH1HVC/jZ1HLmw/ztKs
         DAwn+5RMDGOeXMbkH+nK+LE5NIJVFgtxbCvutg3xuQy/X+6Szcwc+C99LcnQIzYpozuH
         TU77a+VR22gojHuyzFcnJWlB/b5Vtqj3+21RnJvfrS9So4FBVK9F759oQXfaC9ecGfSb
         9wxA==
X-Gm-Message-State: AOAM531yTLoA1VvgyyZZ+kYv8LsBXG53BJwSEazpr5LJ24pDX62G4dxC
        rTNGa4ZN/LaSs8+ZF/RDvwShnPFhIL9VaA==
X-Google-Smtp-Source: ABdhPJy26bpwVLve4DtalMvpLwEQW9Or1LMJu+OKRTfYFjuWdB8MMtV0x4SWjElSgcbTOxH9SWd6Rw==
X-Received: by 2002:a19:c10:: with SMTP id 16mr3589986lfm.459.1603647995383;
        Sun, 25 Oct 2020 10:46:35 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f184sm794176lfd.253.2020.10.25.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 10:46:34 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kWk6H-0007H6-MS; Sun, 25 Oct 2020 18:46:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/14] USB: serial: keyspan_pda: fix up write implementation
Date:   Sun, 25 Oct 2020 18:45:46 +0100
Message-Id: <20201025174600.27896-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a number of long-standing issues with the keyspan_pda
driver and reworks its write implementation so that it can be used with
any line discipline or for a system console.

The last few patches cleans up the xircom device support and some style
issues.

Johan


Johan Hovold (14):
  USB: serial: keyspan_pda: fix dropped unthrottle interrupts
  USB: serial: keyspan_pda: fix write deadlock
  USB: serial: keyspan_pda: fix stalled writes
  USB: serial: keyspan_pda: fix write-wakeup use-after-free
  USB: serial: keyspan_pda: fix tx-unthrottle use-after-free
  USB: serial: keyspan_pda: fix write unthrottling
  USB: serial: keyspan_pda: refactor write-room handling
  USB: serial: keyspan_pda: fix write implementation
  USB: serial: keyspan_pda: increase transmitter threshold
  USB: serial: keyspan_pda: add write-fifo support
  USB: serial: keyspan_pda: clean up xircom/entrega support
  USB: serial: keyspan_pda: clean up comments and whitespace
  USB: serial: keyspan_pda: use BIT() macro
  USB: serial: keyspan_pda: drop redundant usb-serial pointer

 drivers/usb/serial/Kconfig       |  19 +-
 drivers/usb/serial/Makefile      |   1 -
 drivers/usb/serial/keyspan_pda.c | 548 +++++++++++++------------------
 3 files changed, 241 insertions(+), 327 deletions(-)

-- 
2.26.2

