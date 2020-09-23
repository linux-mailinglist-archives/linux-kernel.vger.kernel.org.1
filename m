Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17181275879
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIWNOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWNOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:14:46 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D700C0613CE;
        Wed, 23 Sep 2020 06:14:46 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g29so14387897pgl.2;
        Wed, 23 Sep 2020 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lq7P4em5oOEEGsVeTMXTgpUywtWAmtx3DAz7/cgxfa0=;
        b=iLCxQBHPziNEon+vxShYYozSGipdEybIhqYoFr1ku1zCaZYrhLXItCNbLn09vVo5am
         PNcmssnR1Ud5EPHf9vOzxI7V3GnLL0PwpYuOUnE8lsdVXE/++/j+ik1EsVGXnTAOeOgx
         pWd4JSSAKJ0YEq65fO+5a8XxRcB09T1V/hMvE0qMZS5EZW1JpNRa9wLxyV4IjuLAprp8
         cwsB0cT4OoVpZYh3qhaD5RlP5nRJ10nnus3c7oazmIXONm3DQBx/LrPvpq3jHqjFLOrw
         FyIkirf/cABRnjApD7sJdqsYtlqPQppo+DBaFPd1P4QmVC2KxO1K5ydWokjIIxxmdFzK
         TZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lq7P4em5oOEEGsVeTMXTgpUywtWAmtx3DAz7/cgxfa0=;
        b=j9keX8sbX9v65jmyqguVU8fYDuopPbDzHE9QxPkTu/+GL1zmWvBynyDAO4sQoqeG2W
         c9Xd2FFBWyOWiRrP5bljEa/7RqLhzl4a6JrMQJDZLlM7GsD73op8/weQDG/vhbKlNRDx
         NLCOvHkshkc/LYXJEtiLNZCEoOzKr7MmI1Yl5JTchoy3KKHzHvfCp/yLxSr2mr1KUeyn
         pYEIQXxOoZLE2TXyetnuCD3xfRO63jcR0ARoh345luM7AeSIkhOb2dUkvN4Tnya4Iiqc
         VP5Jre1C9SfiRoc7QwZbdAYlTEtE6ev5LQjSuoWRjKiUZFhOJas0HcE8oAQWDldjAg/C
         QmMg==
X-Gm-Message-State: AOAM532oOj+Ud6BvFH219tcPC2Y9ZCow+33XSYEDFR8X90VbJHSp2QJG
        BEYEIkxYBzKmjpoD1GRknM1qkMzXAqOVplWP
X-Google-Smtp-Source: ABdhPJwxSj40aOAyVrAEW2cP5r7qN6duwoQwF3+6PrLsvfRUpyhdnN2Lk3WxofEYh48o/mOC++4E+Q==
X-Received: by 2002:a05:6a00:7ce:b029:142:2501:35ea with SMTP id n14-20020a056a0007ceb0290142250135eamr9028775pfu.74.1600866885869;
        Wed, 23 Sep 2020 06:14:45 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id kf10sm5045280pjb.2.2020.09.23.06.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 06:14:45 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, art@khadas.com, jbx6244@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        nick@khadas.com, gouwa@khadas.com
Subject: [PATCH v2 0/2] arm64: dts: rockchip: add spiflash and  ir-receiver nodes to rk3399-khadas-edge
Date:   Wed, 23 Sep 2020 21:14:22 +0800
Message-Id: <20200923131424.1612960-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add missed spiflash and ir-receiver dts nodes to Khadas Edge Board

Artem Lapkin (2):
  arm64: dts: rockchip: add spiflash node to rk3399-khadas-edge
  arm64: dts: rockchip: add ir-receiver node to rk3399-khadas-edge

 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
2.25.1

