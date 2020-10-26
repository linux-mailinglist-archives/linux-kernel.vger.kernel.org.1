Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B5E2991C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784785AbgJZQEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1774040AbgJZQCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:02:50 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF89222265;
        Mon, 26 Oct 2020 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603728170;
        bh=/ep5fRQ3cXsDaglk7g3bLJ2D08WYwFuAAN0xUQbcjo0=;
        h=From:To:Cc:Subject:Date:From;
        b=BTfvdDFKrwTYELUJZSZBsQIfvx4s0TDaVG/4ZrmmwKB5sMr/Z8JXz09mTECaMAGTn
         VRloV8txZkHw6HZRgRkqex/1B22gU7NcZZQdQgROonzDNoPxnwzyNQ7Ch8MpwvVjI1
         sCDXITzHfQzmFMwaJa3z++yuz5B/NSRHlgfv33Xk=
From:   Arnd Bergmann <arnd@kernel.org>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] staging: wfx: avoid uninitialized variable use
Date:   Mon, 26 Oct 2020 17:02:22 +0100
Message-Id: <20201026160243.3705030-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Move the added check of the 'band' variable after the
initialization. Pointed out by clang with

drivers/staging/wfx/data_tx.c:34:19: warning: variable 'band' is uninitialized when used here [-Wuninitialized]
        if (rate->idx >= band->n_bitrates) {

Fixes: 868fd970e187 ("staging: wfx: improve robustness of wfx_get_hw_rate()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/wfx/data_tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wfx/data_tx.c b/drivers/staging/wfx/data_tx.c
index 41f6a604a697..36b36ef39d05 100644
--- a/drivers/staging/wfx/data_tx.c
+++ b/drivers/staging/wfx/data_tx.c
@@ -31,13 +31,13 @@ static int wfx_get_hw_rate(struct wfx_dev *wdev,
 		}
 		return rate->idx + 14;
 	}
+	// WFx only support 2GHz, else band information should be retrieved
+	// from ieee80211_tx_info
+	band = wdev->hw->wiphy->bands[NL80211_BAND_2GHZ];
 	if (rate->idx >= band->n_bitrates) {
 		WARN(1, "wrong rate->idx value: %d", rate->idx);
 		return -1;
 	}
-	// WFx only support 2GHz, else band information should be retrieved
-	// from ieee80211_tx_info
-	band = wdev->hw->wiphy->bands[NL80211_BAND_2GHZ];
 	return band->bitrates[rate->idx].hw_value;
 }
 
-- 
2.27.0

