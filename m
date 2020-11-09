Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164342AC35F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgKISLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbgKISLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:11:21 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:11:20 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id g11so5110040pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7QBOVA7GIk/o3k4EBaXjrFkoULA4iFCPhcP7O/ZYy8=;
        b=M/inRhVgR3/j21UaRwj7aTsS/EFwbQnRQSywF0J09v6rY4+t1C1kRG+93F2U6lOyna
         7R7jX/bcHiI+1Fx1YdoXrjUqCKhuXBUsAnLHX7DuJGKqIfecvSJiJmQYGydvbcSSQNHW
         C/xbd0NQ9aXpme/M+hTa9OxCl8Fi/AqTh3yps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7QBOVA7GIk/o3k4EBaXjrFkoULA4iFCPhcP7O/ZYy8=;
        b=oFcuY6QYQVi2Mb5YjMQy3djeK63Bl//gZ3oOAKLjAsm0ctEhOdpdfKTrKnd3eUfbIc
         JbqOlm1BwHa9in5P5Se1wJ0NBR2+nGQ8aHPx5/bVD7hkxZ+DiFLKzCh5iFpvPrlFOJ8p
         tduCnGvoQd5repawMO/QEsq9psXpnLjDyvvHvO43dkpP2tzFzr9jFvpPfPNtJT2J9MHv
         UzhKAVV7piJO54OH/ByIf/55EHvJWbbocWgi6UjbVF9+wcwdExpoI7GiW92mjHExx3Ek
         GKeTZn7KpLJp0JP8iZkomWZmSuqlxbF2maL/BzNW/MtHw41SzKrVavOFijx8Or+trPvJ
         Q7Rw==
X-Gm-Message-State: AOAM533osbDC3Tf3s+GQcuOj3bTLdm/zsVHpzYIXp64QPcRnwt8314he
        +RCTppunzA0O1stAay81KadgIKZ5QWC9VN6f
X-Google-Smtp-Source: ABdhPJx1KRgz1DZDJU5pu08jnng7+auZjv0H/qX0ms2l5dNkqqxnMWAFZxwZx1QbwHOiwgULkGlTuw==
X-Received: by 2002:a17:902:820e:b029:d6:e802:75aa with SMTP id x14-20020a170902820eb02900d6e80275aamr13333320pln.51.1604945480277;
        Mon, 09 Nov 2020 10:11:20 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7a4:c0f0:b8ab:4687:594d])
        by smtp.gmail.com with ESMTPSA id 136sm12027685pfa.132.2020.11.09.10.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:11:19 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 9/9] arm64: defconfig: Enable USB_SERIAL_CP210X
Date:   Mon,  9 Nov 2020 23:40:17 +0530
Message-Id: <20201109181017.206834-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109181017.206834-1-jagan@amarulasolutions.com>
References: <20201109181017.206834-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some hardware platforms required CP20x USB to Serial converter
in order to work onboard functionalities like Bluetooth.

An example of such a platform is from Engicam's PX30 (ARM64).

Mark it as module in defconfig.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8d205f0a3a0a..14bed4a41bf0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -758,6 +758,7 @@ CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_ISP1760=y
 CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_CP210X=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_HSIC_USB3503=y
 CONFIG_NOP_USB_XCEIV=y
-- 
2.25.1

