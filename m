Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20C2E2CB8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 01:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgLZARh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 19:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgLZARh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 19:17:37 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF345C061757
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 16:16:56 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c14so3666190qtn.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 16:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJAyRovyA5lMfjBA/9YKQC9QKzP/98ccBVdn1aaW2lg=;
        b=JxBbGeIjKhbEvFPy6U7ed7+GnnU3H7STzaocIRJpDw209PuSa6/PEazCNBtN7liF6M
         gtdGz3jOLU7Zp/CziTqF4OL90nVUb4HSOYNxV8ApvwQ+QUJ52bx5b0NiqsEHoi/1X5WF
         MtIuqbePjlL8qRa8TCgSCfp7dQDB/xX1k+gef6+mnICIWSl8F8523LAgYFYohy2HnlQr
         NNN7m+zA1kaf8biy1An86Aj9K55LjPydAhUFsJX0gSYZAI5XgubNfkoIU2sfKf8Ill/L
         8VfsdLej8XwL7HqXIbdF3A30p6oVUf+DrBdDwzTrU0dlfvQsuTRjsT3sFHwVX2z/gXZP
         hfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJAyRovyA5lMfjBA/9YKQC9QKzP/98ccBVdn1aaW2lg=;
        b=XP32EIwaR32GQ72nAnL0x6A2S6IskwE7ctn18GJQwq1jRp919oTvODZ4Q0Qf1BlM63
         ipToZtGRee208IvVKcoT0PNAyJWYhk+6h397BdcVzljYrjk/PbNs2LFHq+IgQT5ZF3kq
         KFMKAWBt5RP6U18q2XhUrY6lz0A7CV1aHsvamfBJLMi+3DvjVhgk+6+4fBIcS2Qx+CWu
         gf77bm8vm8OrmceHOyJAjfEcfE+GgZd1bLXGp9gJ5JhgIrY8pV47U5jSG8fmrWVN3DZu
         Pksbw17l2xk+XHEfFQOgAayd1Kl/dyr5R+0lisSMd9rauGYRgYmKY0MaycgJWOyNRXvh
         t0zg==
X-Gm-Message-State: AOAM531Q5PIqNsp3c5PdPlVj88e3WW1v/R8rWOwBiiBz0E0wvAqzXhpU
        +Yvo9iVnR39Iufii9QdZQmXF1ViIGG9KRQ==
X-Google-Smtp-Source: ABdhPJwGph8gVR8PrkOyd+9CLMxliMsYmZvfEtVFPlMaRPyC/vs6GrbFaiAZcggaOvt0Gr2/SadRtQ==
X-Received: by 2002:ac8:488e:: with SMTP id i14mr34567722qtq.372.1608941815946;
        Fri, 25 Dec 2020 16:16:55 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id h1sm18645425qtr.1.2020.12.25.16.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 16:16:55 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v4 0/3] drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
Date:   Fri, 25 Dec 2020 19:16:46 -0500
Message-Id: <20201226001649.2061703-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series expands on commit 22447a99c97e ("drivers/soc/litex: add LiteX
SoC Controller driver"), adding support for handling both 8- and 32-bit
LiteX CSR (MMIO) subregisters, on both 32- and 64-bit CPUs.

Notes v4:
	- improved "eloquence" of some 3/3 commit blurb paragraphs
	- fixed instance of "disgusting" comment style :)
	- litex_[get|set]_reg() now using size_t for 'reg_size' argument
	- slightly tighter shift calculation in litex_set_reg()

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
 include/linux/litex.h              | 151 +++++++++++++++++++----------
 3 files changed, 115 insertions(+), 124 deletions(-)

-- 
2.26.2

