Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B362C86AF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgK3O2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbgK3O2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:28:51 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD52C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:28:11 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i2so16477428wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvXhZgU2xMEzW9xUafEpy+bHmn3Gc8NAD102F5oHAyA=;
        b=1EcvxvJc4mbZdHxqfftJrVKOTIK9BH+eVgl5TW6c7R7lbRF0+OhsYHL1L0kYvA8TMv
         Qlrg8Ct1Vd8H+6AgLIu3Tlr4p6ZfserFewRmMX59gDUoFzpqikZPd7M14D25TvT588b6
         bCv1TSxGSOxIs0SYhrwQTiaR+cWLZLelbISBNasBqxPp7nLhcA7+l4T6yyUYRfPu3cVB
         TJOPOPrqV/0JNmFtZN+P6rcx5sBVu2gNuJ7Bes6zHIv+dCAfJ9Ed4a8dJ1guN9MG9Eog
         y21E9pkM6Jd8E1sb//+7xcvDw58/mMxxvkB104Y11UVYXgEtWxBT282XlWhk05E+uFC+
         qsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvXhZgU2xMEzW9xUafEpy+bHmn3Gc8NAD102F5oHAyA=;
        b=o/yw8N8xAegrUn7WJ3YvzPQAQjoWz3fMPXvNezRUrYrTbriR0VDQni9zDWSDzTPA4E
         G3xmH3rCNMQ309Fo3Bet918uTa60stvxNKX2Py7HK63xh1LcPeyTpCaRgCOLqf+YXXK5
         Zv5Hc0QxIXzqtWyTRRfyzMB3lydrGXokr0ZsfN81h5TNsGvlz7GO5pKzJkKa1tb9qAYT
         3dkhe82+B2H/KVB79DPIfoPoQRq+gcXPdXfmTuD2pzgKsa2VhqUOZtBqlOUCErog2mVq
         5V24nYEIPMBxbgg+CFatp7RpE2rz873B4oYrCw3/GHGE1NaD5pClfBr29h7QxhtFZZEw
         Sd/A==
X-Gm-Message-State: AOAM531gBASGuen3anETfEdrikhBoKRPhISr1H0YrePvIbuIkMHgJUWP
        QP8BGMJivDNYloIIhxBAw4V2Mw==
X-Google-Smtp-Source: ABdhPJzJyK1+fOpoEEjpFkrOW4BnKluQ8G36C3Y9PDwLN5GySBcQ+LJP4HL+Boasaj6KbkpQ1Fbnig==
X-Received: by 2002:a5d:570d:: with SMTP id a13mr27858154wrv.193.1606746490088;
        Mon, 30 Nov 2020 06:28:10 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id p19sm29446044wrg.18.2020.11.30.06.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 06:28:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATH v3 0/3] iio: adc: xilinx: use even more devres
Date:   Mon, 30 Nov 2020 15:27:56 +0100
Message-Id: <20201130142759.28216-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a follow-up to commit 750628c79bb1 ("iio: adc: xilinx-xadc: use
devm_krealloc()"). I noticed we can use even more devres helpers and entirely
drop the remove() callback.

v1 -> v2:
- squash three patches adding more devres calls into one for easier review
- don't insist on the 80 characters limit
- add a new helper: devm_krealloc_array() and use it

v2 -> v3:
- drop the devm_krealloc_array() helper

Bartosz Golaszewski (3):
  iio: adc: xilinx: use helper variable for &pdev->dev
  iio: adc: xilinx: use devm_krealloc() instead of kfree() + kcalloc()
  iio: adc: xilinx: use more devres helpers and remove remove()

 drivers/iio/adc/xilinx-xadc-core.c | 157 ++++++++++++++---------------
 1 file changed, 74 insertions(+), 83 deletions(-)

-- 
2.29.1

