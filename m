Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685662AAAB8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 12:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgKHLho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 06:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgKHLhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 06:37:43 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DEFC0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 03:37:43 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q5so2413884pfk.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 03:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZtQivcQ+AZubSIg46b9m4DEOzL0fiKWbinL/KFoggA=;
        b=CaoihXbx23aeFZpxtNy7GTt3o+aBGBdyZlNtc35S0IPP0zW4umWFCe6d3/3HWqgRTx
         Nup857PQXsKuNwQ/WxQCEngwlATThEUyPZRiSNueccU2gnnrIBG9NlIwIJkZhAsJVTHY
         H4ShPEqR4II9BqZGn2d+2p9MPhv4t0URYbkWYqV+RisPhX/tuOB/iw7svZo+T8JheyQp
         mCGcJnh7bDSxYhAVQ+spkz2qSHb/zR5HVvWhi368ldiew1KIxzLsVJfn1PFXTysvMm2Y
         XNkwu5AhfAq37hwN7CAbOZqlYPDvFhEeo5Y3l538lQyQR3NTkHIOhIuPaTPBmKkBZlHY
         BToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZtQivcQ+AZubSIg46b9m4DEOzL0fiKWbinL/KFoggA=;
        b=ODFhdZvAFbm13wla32f5uq/d+5rLiQnSwNl3mJFK1ts+1Pc+kkx9Qp7tYc/yynEJZn
         BWLXwFPGTz/gYEmMS7wKUA+CPvVgXWLZ+OojXAEg+XTBvJlp6Q9gJg+iIiTzZDvNoVL4
         xavh1hIiy2grkwxj//V2p//FUplTh6NQk7psk/Pb49nHjYsfCRckCqikdrhgMwibG/YU
         daNv2aa1ZX9xtw6dpMb7XM2lHTmTbgCqihwjVD9Ud5mdDe3Go5eGLYZKHQBFqv0A7vCA
         UsjQxHSDeUU9JbYc7QadaO/A60Rt0RcD/WUQJKdtQFLGSDIDXHJvndVjXyVqxGwhGYQe
         o9dQ==
X-Gm-Message-State: AOAM533Zn90jkAIt3M5ab1W/SGvlx7HVc7HWLQqp9GOsNfKSNjXXWSh7
        d2G3s4usuTsxr+n/bIJCoa0=
X-Google-Smtp-Source: ABdhPJywGga5A++IlHOh+wzruJpPJXt/uQ8cIH1WYVoYxBgFTHkaCuSe8xncy4byXhIzP63Dq87VZQ==
X-Received: by 2002:a05:6a00:2292:b029:156:8913:e424 with SMTP id f18-20020a056a002292b02901568913e424mr9626833pfe.56.1604835463114;
        Sun, 08 Nov 2020 03:37:43 -0800 (PST)
Received: from IGL6397W.cw01.contiwan.com ([27.104.143.83])
        by smtp.gmail.com with ESMTPSA id t85sm7230263pgb.29.2020.11.08.03.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 03:37:42 -0800 (PST)
From:   Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Subject: [PATCH v7 0/2] Add support for micron SPI NAND MT29F2G01AAAED
Date:   Sun,  8 Nov 2020 19:37:33 +0800
Message-Id: <20201108113735.2533-1-nthirumalesha7@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for Micron SPI NAND MT29F2G01AAAED device and generalised
the structure names as per the review comments

v7: Reverted to the v4 except ECC structure related changes

v6: Reverted the SPINAND_OP_VARIANTS() as they were in v4 for
MT29F2G01AAAED device

v5: As per the review comments, the changes were reverted to the v2,
except the MT29F2G01AAAED device related (including the review comments)

v4: Split patch into two parts,
    1. Generalise the oob structure name & function names as show in v3
    2. Add support for MT29F2G01AAAED device
       a. Add oob section check in micron_ooblayout_free function
       b. Rename mt29f2g01aaaed_* to generic name micron_4_*

v3: As per the review comments,
     1. Renamed read_cache_variants as quadio_read_cache_variants,
write_cache_variants as
      x4_write_cache_variants/x1_write_cache_variants,
update_cache_variants as
      x4_update_cache_variants/x1_update_cache_variants,
read_cache_variants as x4_read_cache_variants
     2. Renamed micron_8_ooblayout as micron_grouped_ooblayout &
mt29f2g01aaaed_ooblayout as
      micron_interleaved_ooblayout
     3. Generalized page size based oob section check in
mt29f2g01aaaed_ooblayout_ecc function
      and separate case check for two bytes BBM reserved in
mt29f2g01aaaed_ooblayout_free function
     4. Removed mt29f2g01aaaed_ecc_get_status function &
MICRON_STATUS_ECC_1TO4_BITFLIPS

v2: Removed SPINAND_SELECT_TARGET as per the comments & fixed typo
errors

v1: Add support for Micron SPI Nand device MT29F2G01AAAED

Thirumalesha Narasimhappa (2):
  mtd: spinand: micron: Generalize the structure names
  mtd: spinand: micron: Add support for MT29F2G01AAAED

 drivers/mtd/nand/spi/micron.c | 124 ++++++++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 30 deletions(-)

-- 
2.25.1

