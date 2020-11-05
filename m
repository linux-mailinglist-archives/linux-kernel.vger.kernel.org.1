Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1E52A7EA6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgKEMeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKEMeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:34:09 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F397C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 04:34:09 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a3so1410287wrx.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 04:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YPXD5S4xLV51P6wwfMTdN27yHB1Bn9d7ZcN0H9u1frs=;
        b=dqPVVhNrpMXm7tI5lhasI13P4Iv5sCLD6W6FUk53xSj4uV95IJEsgd6zqVUVogrWsU
         I2O05TEnnYENcaVpVvaqQ6hWH+PFlWFol37gLRu6NNp4epkAUOZs2w7N58rn7alzGuuu
         foEN5ZoXroa2ENnKNP39xL0ZlJ3Cw7KeKnlr0BYEd1vsFHAm+K2UZwn/TVNTRigyiFh/
         u6Bf09F3Kh3rDlu7YNTEDQSQW8fbBPd4BcQKZ79vMjzxWC3jv9Zo+UDqpLlz2B6M/ibR
         ADi/w1eLKRFSVcweDcq5S7r5sGunMQ2fSuWiwNPvfqMtRYEsPk+GEOqxTXUWSem7Bm0u
         6zAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YPXD5S4xLV51P6wwfMTdN27yHB1Bn9d7ZcN0H9u1frs=;
        b=X1KTXGIvM/zMj+wySujJp3C+xnxk/+70/FNyNlizK1+Tybz0gG9hAzUdLQriZbvWtS
         GDZkAnW0U9F7TpAONxf8l640k6C1lIGonm2FlaBOKlUJqMUSory8rDnp20nseIJPZiRW
         tZQ4B08y7amsbyHXKVWmX4doK4fMozeNmn/xnoxlo/94iV+uaKGK7Mv94vzItG+13DXs
         pqjDQ1ZWQtqHd2Gcrf8dZIlU4FOskOoXCb4on1KZia66Skxq9A33l2vueYamBOBe+NlE
         xrmwvsSlfTctnh5HV8Dw825kHrPcBwL+8P5KXp7dRXAnynOI97jy7MPQJ063tJ5M0ich
         TucQ==
X-Gm-Message-State: AOAM5310v2cGsHbfezZyUwNwMMti1Hb5pKTPl2fptkFRo3dgO+1UWQVc
        BDvXfpBpVHsGCC5L38iFdqZU/g==
X-Google-Smtp-Source: ABdhPJy+iGM2R6xUkANRTzhmdBseiBipUpDHy5WA/L3w1f4u2lkmfi3LA6Cr52fv80ZVHxOv3kW50w==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr2681828wrr.361.1604579645757;
        Thu, 05 Nov 2020 04:34:05 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o7sm2346689wrp.23.2020.11.05.04.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 04:34:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/2] tty: Remove obsolete drivers
Date:   Thu,  5 Nov 2020 12:33:55 +0000
Message-Id: <20201105123357.708813-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the vendor's request.

Lee Jones (2):
  tty: Remove redundant synclink driver
  tty: Remove redundant synclinkmp driver

 arch/powerpc/configs/ppc6xx_defconfig |    2 -
 drivers/tty/Kconfig                   |   27 -
 drivers/tty/Makefile                  |    2 -
 drivers/tty/synclink.c                | 7899 -------------------------
 drivers/tty/synclinkmp.c              | 5580 -----------------
 5 files changed, 13510 deletions(-)
 delete mode 100644 drivers/tty/synclink.c
 delete mode 100644 drivers/tty/synclinkmp.c

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
-- 
2.25.1

