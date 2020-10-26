Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C34B298EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781096AbgJZOSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:18:51 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:33578 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780405AbgJZOSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:18:50 -0400
Received: by mail-wm1-f47.google.com with SMTP id l20so5280318wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z+Ur3tsnJ+KtlVIulRUK2X+mhrHRJ7Kyj1OjwnScNJY=;
        b=Qf7qxzacM5hvP9R8srH4tT/f/UQA7msEy9Q2mhJ7bH2sSUpnk9C8lERQBVWH6ixJ34
         NItcsWgEl63+t7JNi47inAA8dMvl+vSMdzpTBZNJOKibU61KU6vaGXNHHOjObN1smpbQ
         ylqpvJp7b6vBi522IQQsQXxVBzyL83/w32Haw1k9HL8mrL8eXfspaGZ6zeVVDMBiLjMt
         +qNhuncc8IgoZunKQOsx9zGZ1hSmx8vweJH0omimOncB+nf39uMC6sQFywNo9WhSEyTM
         qm5gsnLpHiNz0m0cFojoC8g7FtRNzqSS0Ph16JMoEmXUDFm46t1T6kX6UrvxbbcoRQV3
         QfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z+Ur3tsnJ+KtlVIulRUK2X+mhrHRJ7Kyj1OjwnScNJY=;
        b=bGZAv5WNRv7WLqjwedd4Ls2udGR4sg3PSW2uzPkjxiq0D+wbvVmZ12KYoxjdPm4Oxx
         iPZ1Zex1VXFxG2049EjLJe3HFznHxUnopmsftPfEEdN6aZcAH/baQMahdLjUisOTdMnh
         QcG/P14jqxWGyCHu+BCjqAzJpInCXFLRxKUC46jiwYgEZlD1pH2z8NFuxcREG+KXgkGH
         JEgSXWB1xQ8SMMp2yeyxG2mKMZvSh1Pz8R/o4PvG+w5zkV7WhomwJRi94h5PpfeTPfp1
         KP7O9QoKnrms0kbjZyJb4jwm+rm7+Ok20cJk6qxOKZZIaUTIgOxV8LKOgTLzKRSX4ECg
         gkaQ==
X-Gm-Message-State: AOAM531fLrX6fOnF39yiX2WzeG4ln/888K5hzuk+UtsXEUhowA/hPe2D
        ErcspMUCjl2nNP4DLtosgtjzIQ==
X-Google-Smtp-Source: ABdhPJws0P1F8rgvW7RbcSNksmIk+bMZjjf3Ti8A7HbX9ywC9heO4KIxDuY9v6QbosaoTZS5YA9vsA==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr16132687wmc.8.1603721929378;
        Mon, 26 Oct 2020 07:18:49 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id e15sm21920841wro.13.2020.10.26.07.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:18:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/7] gpio: exar: refactor the driver
Date:   Mon, 26 Oct 2020 15:18:32 +0100
Message-Id: <20201026141839.28536-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I just wanted to convert the driver to using simpler IDA API but ended up
quickly converting it to using regmap. Unfortunately I don't have the HW
to test it so marking the patches that introduce functional change as RFT
and Cc'ing the original author.

Bartosz Golaszewski (7):
  gpio: exar: add a newline after the copyright notice
  gpio: exar: include idr.h
  gpio: exar: switch to a simpler IDA interface
  gpio: exar: use a helper variable for &pdev->dev
  gpio: exar: unduplicate address and offset computation
  gpio: exar: switch to using regmap
  gpio: exar: use devm action for freeing the IDA and drop remove()

 drivers/gpio/Kconfig     |   1 +
 drivers/gpio/gpio-exar.c | 155 +++++++++++++++++++--------------------
 2 files changed, 77 insertions(+), 79 deletions(-)

-- 
2.29.1

