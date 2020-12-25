Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C14C2E2BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 15:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgLYOWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 09:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLYOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 09:22:11 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5D2C061573
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 06:21:30 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id f26so4108934qka.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 06:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EP0f+Obu9oO6n6MrIwwsuNPKBHihMnRjSb674G/FMbY=;
        b=mVHZGQMh1dKAtJA1DMXGoR4eI2GWGmEzu1ieD5yIqUB0cQlBvpafan7zJOPDhXnswF
         1ApSP9wZvVJJVAub9R8wtZwlFbvUK9KB23kHJlPHo1GstTMobYC5XhgFUx9z5T4Qz/tw
         z8TiXuPGq8dkMlxl1qCymLgWpQX8elc1iPigCbS1AckPGXJpe1tzj1Zpunb7EtRXPfEJ
         gmIlG2qXqlbbmTC4mfoaAA4THb/Zn3XWiqmpxBfP58qcHjaKdCQnWXR2RuIRdMoUyqU9
         sd041yXeNgnWgfw6ErpE+ZXXrB5dF8+tKHunXiIzxH/aqLSZl9FXp3n+cZESWYnRJyV/
         tBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EP0f+Obu9oO6n6MrIwwsuNPKBHihMnRjSb674G/FMbY=;
        b=oO5j0JhBSI69AYlq/76/j9V4dFJn4RZvEPOd18iG9kvu5HPluALMxGrZY1egdBK/Wi
         +WB+lNDkaklYnCLD6a1+JLnbKgAxZny8XAya4phkM+j8pWSLzUb7y+/SYBct40SNktau
         tfbgexif+29oA8OpAxp8f+3U1gSQP+l0qBPI1O3/DOAPKgWcXrvGsOY5rjwj1x1HYVaS
         HdoWMXv/Z+6ZBEcApl2GDa3MxcBx2uQG4E/O6yp9E4TSBs0LBN8H4/E9t7900j39OSPb
         U5aNJTqD+XnlbHhkhRm/GWyarNjya5JvyKvJ6JC/o8VwCcoWIZ/ESnSxuXaSfgLwoemn
         luUg==
X-Gm-Message-State: AOAM531/THKCH74yDZmE+vEKPFSHxLnoAl6ydDSIiXPAZF0xVu5kAXbg
        w2Z0e40JMR+F1piWq33RIcE=
X-Google-Smtp-Source: ABdhPJzESk1WZ4b70xacwW+JtxTiqAM9vBmJgBa/RjFhETVjJa6F1FnCbBMRZby2lpsqLwAPMPXkjg==
X-Received: by 2002:ae9:eb10:: with SMTP id b16mr34416494qkg.29.1608906090216;
        Fri, 25 Dec 2020 06:21:30 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id l191sm18279039qke.7.2020.12.25.06.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 06:21:29 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v3 0/3] drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
Date:   Fri, 25 Dec 2020 09:21:17 -0500
Message-Id: <20201225142120.2018222-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series expands on commit 22447a99c97e ("drivers/soc/litex: add LiteX
SoC Controller driver"), adding support for handling both 8- and 32-bit
LiteX CSR (MMIO) subregisters, on both 32- and 64-bit CPUs.

Notes v3:
	- split into smaller, more self-explanatory patches
	- more detailed commit blurb for "main payload" (3/3) patch
	- eliminate compiler warning on 32-bit architectures

Notes v2:
	- fix typo (s/u32/u64/) in litex_read64().

Notes v1:
	- LITEX_SUBREG_SIZE now provided by Kconfig.
	- it's not LITEX_REG_SIZE, but rather LITEX_SUBREG_ALIGN!
	- move litex_[get|set]_reg() to include/linux/litex.h and mark
	  them as "static inline";
	- redo litex_[read|write][8|16|32|64]() using litex_[get|set]_reg()
	  (compiler should produce code as efficient as hardcoded shifts,
	   but also automatically matching LITEX_SUBREG_SIZE).

Gabriel Somlo (3):
  drivers/soc/litex: move generic accessors to litex.h
  drivers/soc/litex: separate MMIO from subregister offset calculation
  drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs

 drivers/soc/litex/Kconfig          |  12 +++
 drivers/soc/litex/litex_soc_ctrl.c |  76 +--------------
 include/linux/litex.h              | 149 +++++++++++++++++++----------
 3 files changed, 113 insertions(+), 124 deletions(-)

-- 
2.26.2

