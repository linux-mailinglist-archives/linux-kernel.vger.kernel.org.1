Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868442F9B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbhARIYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733226AbhARIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:24:34 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE34C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:23:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m187so6495570wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=M2czl7AdXkeiTJE6+fnFESw8QQNDAv21y8gTRe13G3s=;
        b=SewdvCuVtGMVvQa+3LWuDIOjAtprDaXDN8yaxSzOVZKUBuqZW28dnBlMA7IjH6h6EP
         O7HydD212ho94Nbe8iV33BxENkJHznH7g1twrxWqp8+7/rj1d4p2sI2PrjeQXhj/POXh
         pouFhJnmQPPzvezRbAXe97S18WUEBAbAbsFoqRXhDqEqAYZ734l3nO6QZ389dGtY0mR8
         /lJNXV9lEMpZCku+BnLJdpxo9jAhE1kKXOMM//3fe8geKIWTNF8I7VCvXzIkGcEZ7pS6
         qmPZqUiRl1aIKG1KP8CKOOFdDOYyXLyGAaxwvsu3JRr6RxHlhlwjkC3Gv+PASs3jHq4P
         Hjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M2czl7AdXkeiTJE6+fnFESw8QQNDAv21y8gTRe13G3s=;
        b=Ujmjb703Z9MElavAfmStKdbbO7nAoxpM0VEZGKSk1+T7i+t7eJGP84vsJ+/+I3f/MM
         O4lUNJV80CSJNC+4G+arsEBc92/5N16hTGI+zbmLIfA4DUctKJQv+R/Qf7Y6GbFGPFIY
         HjAUYl4kdFlAhfTNZuQEM+PBklm2pZ6jDBn1Rpvy2O3AomnVf0feb45+2RkIrpeOjM5T
         urIIcUWjhSx7WhST7x4x0845xXZScxB2tNwleGvYphnjbIuwkX5iWkgdKLCNDQFtKAlR
         h5UCOm0qEVQPXo8hbcW9RVZ5OizDwjDXWM+Fd2czljNCe1DIbl26R/IOr6OZFolDM37e
         /A0A==
X-Gm-Message-State: AOAM533ZYwiS9MD8USacV3J1ZzUtU+Diq4ISCILRQcI8XwRHklgkba/B
        f8PFN88pYUwpYkIW1wq2i05a9kJcEuLaFQ==
X-Google-Smtp-Source: ABdhPJzUIdERXVaNzWyi/T2hRfvLw85RB8089LN9Z6eORPK4jumPEfOAhsKk1UA7NLCNPRJ/5XNctw==
X-Received: by 2002:a05:600c:3551:: with SMTP id i17mr19401993wmq.140.1610958231178;
        Mon, 18 Jan 2021 00:23:51 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id b7sm27292961wru.33.2021.01.18.00.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 00:23:50 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2] sparc: sparc64_defconfig: add necessary configs for qemu
Date:   Mon, 18 Jan 2021 08:23:45 +0000
Message-Id: <20210118082345.16163-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparc64 qemu machines uses sunhme network hardware by default, so for
simple NFS boot testing using qemu, having CONFIG_HAPPYMEAL is useful.
And so we need also IP_PNP_DHCP for NFS boot.
For the same reason we need to enable its storage which is a PATA_CMD64.
And finally, we need CONFIG_DEVTMPFS for handling recent udev/systemd.

All those options will permit to enable boot testing in both kernelCI
and gentoo's kernelCI.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- Added CONFIG_DEVTMPFS for udev
- Changed PCNET32 to HAPPYMEAL, as the default netword card is sunhme

 arch/sparc/configs/sparc64_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index bde4d21a8ac8..439ec8bc6dca 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -236,3 +236,9 @@ CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRC16=m
 CONFIG_LIBCRC32C=m
 CONFIG_VCC=m
+CONFIG_ATA=y
+CONFIG_PATA_CMD64X=y
+CONFIG_HAPPYMEAL=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_DEVTMPFS=y
-- 
2.26.2

