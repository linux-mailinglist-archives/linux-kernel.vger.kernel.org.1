Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98C41A2F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 08:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDIGoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 02:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgDIGoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:44:19 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D444C2084D;
        Thu,  9 Apr 2020 06:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586414660;
        bh=kqQXaKXcW2eZZvO7tXIHCzJAD9OrkfQ2Pb5eypMAIIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f19YeHzQtSsKwFfeN5uvHwXjeK4edNxUbHBG/gqUYhCc1n7HTx2b7kIGTSbEw6CT+
         7o4n2vK59myk+N51QiIFVn8/9/AZm0WJ45PfpYbueIrQzFlESPsccGAdkBC2Ag2Dvc
         IR971p90Zt2IkHS77EhPXMANk19AbKyzX/Cfqov4=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 04/10] h8300: Remove redundant CLKDEV_LOOKUP selects
Date:   Wed,  8 Apr 2020 23:44:10 -0700
Message-Id: <20200409064416.83340-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200409064416.83340-1-sboyd@kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The h8300 architecture selects COMMON_CLK already, and the COMMON_CLK
config option already selects CLKDEV_LOOKUP so it's redundant to have
this selected again.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/h8300/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index ec800e9d5aad..d11666d538fe 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -13,7 +13,6 @@ config H8300
 	select GENERIC_CPU_DEVICES
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CLOCKEVENTS
-	select CLKDEV_LOOKUP
 	select COMMON_CLK
 	select ARCH_WANT_FRAME_POINTERS
 	select OF
-- 
Sent by a computer, using git, on the internet

