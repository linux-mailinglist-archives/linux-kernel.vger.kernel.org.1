Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD6A2E31C8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 17:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgL0QOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 11:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgL0QOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 11:14:07 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8B4C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 08:13:26 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id az16so4041483qvb.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 08:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3TiIaK0S9G8P0JYXQg7aEMjLKJ1FltrLfs8BvVahHZk=;
        b=aY/wCPi5capYXTQL9JTAgt7YJEih9wpvX1psp4wBz93+o4EmR6PWZ7CG9+9hBLtTLT
         Vgs4Wx8o+nWDtm1iUK82qgyf5BzkqyBzYxhrQIbKAw4MAB7AazSsLeQ7008IWXuTlDjz
         ZnCMAlsYbRDjsdtw3K6YKMqwad96G6UIV2pfUYE/w3NKrPeVdMUm010iLhG3rsv1qPfL
         34TIzDq1n8QpcEzGAQs/NCeMqYujournqKDe9J4dnkkFzQ3N/eC7QfOPI/3tuWhLgNBC
         dLMsBh+R8+g8PA8Bd7qwu+ZK1IUrTfjKeP6fJqygXQYLruCyug+qYPAGfjFEqh6zuD8f
         I3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3TiIaK0S9G8P0JYXQg7aEMjLKJ1FltrLfs8BvVahHZk=;
        b=H9luxQES66Y4uwcGf85fNpX7Uhca7E/v/uH7ptQYB9XRRqGvyrD5gQvXnLgM2dffZ8
         HOgeNvU4rICFyWAyuDi9GMGwBOIxJwKWvlaC5tEPHxw4CJfBslz7w3W6NSFgliIpDz2K
         uNDJoCGSLAtgCs7glHWH7f3HWp+2K2OGVMS/MvVhFzzaR2t/pHdZkVTbwp3BpmVHX9Vx
         T+2Ozj0RwNRnVNd3Z50jIf1u7Up2AAh2FR2L4bcWURRodMfasFSh9ELOL0NktlIGknBE
         0Xzps3XO3o4IVICEOPlUoveQELXAYGNVv8efzXZbHc7bUwFyI8D50jsNCXYWtZA5WDhR
         WqWQ==
X-Gm-Message-State: AOAM533Ow3myxyEaJvbgRUk4KWQymGRQVxgVSep2H35kF5kPlR93NVhu
        qk3iv7P7O1hhRYUTOt8G62U=
X-Google-Smtp-Source: ABdhPJw9yAgENnqhvO6RwEQ8jNVRTRRzkch1MBy0Y3uanu+mK2xMPXNskGuxRwRFlXtHtu5D09hRHg==
X-Received: by 2002:ad4:4e8a:: with SMTP id dy10mr43569796qvb.14.1609085605974;
        Sun, 27 Dec 2020 08:13:25 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id h75sm13088873qke.130.2020.12.27.08.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 08:13:25 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v5 0/4] drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
Date:   Sun, 27 Dec 2020 11:13:16 -0500
Message-Id: <20201227161320.2194830-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series expands on commit 22447a99c97e ("drivers/soc/litex: add LiteX
SoC Controller driver"), adding support for handling both 8- and 32-bit
LiteX CSR (MMIO) subregisters, on both 32- and 64-bit CPUs.

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

Gabriel Somlo (4):
  drivers/soc/litex: move generic accessors to litex.h
  drivers/soc/litex: separate MMIO from subregister offset calculation
  drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
  drivers/soc/litex: make 'litex_[set|get]_reg()' methods private

 drivers/soc/litex/Kconfig          |  14 ++-
 drivers/soc/litex/litex_soc_ctrl.c |  76 +-------------
 include/linux/litex.h              | 154 +++++++++++++++++++----------
 3 files changed, 119 insertions(+), 125 deletions(-)

-- 
2.26.2

