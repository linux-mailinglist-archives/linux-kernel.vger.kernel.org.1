Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CDE2E7A89
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgL3Pnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgL3Pnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:43:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDD1F20725;
        Wed, 30 Dec 2020 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609342989;
        bh=RgCdwo79oX9AX/HZWofDnlRT6UBxCbYnV4jmsyma3T0=;
        h=From:To:Cc:Subject:Date:From;
        b=bKxeAX1e8hMsEkf8JXE0A37wDH03wJp5JaovJSKjAWRe4aN+LrEsByQ6fKonOKlU8
         cwi4dSh/+alGMmflfVNrmQEblGwoVx9/6tsfcShwshV3HkuSkMtm0z179bTrFdnNjD
         xHgEtCvVvKkIlFiNkO1bkoBis1IFUQSN6Pt5oKn6QNcCPoAYtKy+zmKsXcxlEK86zY
         3oHoqTKIKOe2uEUG3N9qzp6wdck2QJ7tsPTQutUvpkMQgcA8bKYbBEr5Xtv8WweUwZ
         3vYtLnoUwRfFhJigeb55j9o2rg6AVZMoJyfHtPlarOthxdIhIPW0p6hi7+Hsy+y6wr
         g7Nn71Bn7VOnA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Nicolas Pitre <npitre@baylibre.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] i3c/master/mipi-i3c-hci: re-fix __maybe_unused attribute
Date:   Wed, 30 Dec 2020 16:42:50 +0100
Message-Id: <20201230154304.598900-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang warns because the added __maybe_unused attribute is in
the wrong place:

drivers/i3c/master/mipi-i3c-hci/core.c:780:21: error: attribute declaration must precede definition [-Werror,-Wignored-attributes]
static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
                    ^
include/linux/compiler_attributes.h:267:56: note: expanded

Fixes: 95393f3e07ab ("i3c/master/mipi-i3c-hci: quiet maybe-unused variable warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 500abd27fb22..1b73647cc3b1 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -777,7 +777,7 @@ static int i3c_hci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
+static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 	{ .compatible = "mipi-i3c-hci", },
 	{},
 };
-- 
2.29.2

