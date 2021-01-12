Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DC12F373B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390291AbhALRcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387717AbhALRcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:32:31 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3EDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:31:51 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id 2so2067198qtt.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zjx3/LiMGAYPnDegQb+uMAhjW6hE3F/ETI3bW5nmzg=;
        b=YNnxezCX2onJSEI5/+TvLtF8n8bnTmgRCUP/jWZoMcUaP4BBZeIRQQQfE8xcVk3OLC
         GM++XK13FstnX6BTO8JMf3oC75aUvl5GBfaydDvbCYpKz7LYBPQgMH9uGE9oyMt7aDN/
         7ZjyTTDRbQepSHRXdEktzZJ0MpuPSqsSe/c7BnOgp8rGKFRZ+O8vT2wm9Z6Y2Ln5/6o2
         xq5RVGmlMGxhIqL4V000cUEKdckClx9OOm0WzAx9C18aWEzMj8DPNPAFcqCkA8FpSG9U
         wbikeEC7QyJ6oFMGsQ2oOscBCyg145uh2n6jgQR3MSJ7+siB2W8IGK+hN3LZJnlaDBEe
         r+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zjx3/LiMGAYPnDegQb+uMAhjW6hE3F/ETI3bW5nmzg=;
        b=mahptJ7CXzfkGPx3inVeJiIKy70bMe+91hJeBq5HWQaC7GOXWUiiiHCtEE0NfmqsQ3
         b3NGShZqG8yXYxdHVV8OqqRvPA0DgS/t566cNnqkVxkl7PxLOeIHZwOe+N87wxl6tBSX
         VqByvONB9obqqfN5gaahb9JGWYZrquIjksCOIcXCIjUWFb8LgMa2kRJCTnQ92m4hJ6Ah
         ZsqdFdvZyewerklMj9eNyDDORJNLIxisxEdcpZ92AjP/quIVOITCnP2H4/5jv1vQqL1s
         SI7t/7VgDAV29R55TKfOFDuBykTpEBOsHl7Sts5wjoGLvggE9IiAo+TO3pGPYkvwFdd7
         euPA==
X-Gm-Message-State: AOAM531CTNcZTNZi87vM4Xw1u6dllhbyB6b0H1mq4SsHv1iWC1yCtrDW
        DQgIEsmP7XP2XAADFBEb/8M=
X-Google-Smtp-Source: ABdhPJwczDNr/BhkzhP+138wDhh80o2IC/nxqNCbbUKT8+YbLU9UpLcBd2bwoSVE5L/JypSRQelxJA==
X-Received: by 2002:ac8:1184:: with SMTP id d4mr18950qtj.103.1610472710791;
        Tue, 12 Jan 2021 09:31:50 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id k7sm1453512qtg.65.2021.01.12.09.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:31:49 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v6 0/5] drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
Date:   Tue, 12 Jan 2021 12:31:39 -0500
Message-Id: <20210112173144.4002594-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series expands on commit 22447a99c97e ("drivers/soc/litex: add LiteX
SoC Controller driver"), adding support for handling both 8- and 32-bit
LiteX CSR (MMIO) subregisters, on both 32- and 64-bit CPUs.

Notes v6:
	- split out s/LITEX_REG_SIZE/LITEX_SUBREG_ALIGN/g change
	  into its own dedicated (cosmetic-only) patch (3/5).
	- fixed typos in "main patch" (now 4/5) changelog.
	- fixed typos in comments added via patch 5/5.

Notes v5:
	- added patch (4/4) taking 'litex_[set|get]_reg()' private
	- additional optimization of [_]litex_set_reg() in 3/4

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

Gabriel Somlo (5):
  drivers/soc/litex: move generic accessors to litex.h
  drivers/soc/litex: separate MMIO from subregister offset calculation
  drivers/soc/litex: rename LITEX_REG_SIZE to LITEX_SUBREG_ALIGN
  drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
  drivers/soc/litex: make 'litex_[set|get]_reg()' methods private

 drivers/soc/litex/Kconfig          |  14 ++-
 drivers/soc/litex/litex_soc_ctrl.c |  76 +-------------
 include/linux/litex.h              | 154 +++++++++++++++++++----------
 3 files changed, 119 insertions(+), 125 deletions(-)

-- 
2.26.2

