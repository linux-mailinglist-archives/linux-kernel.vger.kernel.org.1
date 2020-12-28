Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EDA2E3A17
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 14:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391002AbgL1NcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:32:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390636AbgL1NbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:31:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F299207CF;
        Mon, 28 Dec 2020 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609162232;
        bh=Y0LL7qt1zdF2B36mASs7Gs+y/szMlZJH4FqeIwJqcL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bh3c+FxAfXxvsBxQLcle8GJmoGuFO1k29R9YwtWafb6aayQ7QsAbjnAx37S56GhNF
         2Lku5KIt93xMIq4p95mesZcEXXx1axkWIfbjQPwlJtv/djN7r/sieEqfvCb7dpK0PW
         1sag1ktBFpwMEbIe+T/pLYeoufElr5W68s3aB5qY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 233/346] um: tty: Fix handling of close in tty lines
Date:   Mon, 28 Dec 2020 13:49:12 +0100
Message-Id: <20201228124931.043356903@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228124919.745526410@linuxfoundation.org>
References: <20201228124919.745526410@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

[ Upstream commit 9b1c0c0e25dcccafd30e7d4c150c249cc65550eb ]

Fix a logical error in tty reading. We get 0 and errno == EAGAIN
on the first attempt to read from a closed file descriptor.

Compared to that a true EAGAIN is EAGAIN and -1.

If we check errno for EAGAIN first, before checking the return
value we miss the fact that the descriptor is closed.

This bug is as old as the driver. It was not showing up with
the original POLL based IRQ controller, because it was
producing multiple events. Switching to EPOLL unmasked it.

Fixes: ff6a17989c08 ("Epoll based IRQ controller")
Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/chan_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 3fd7c3efdb18d..9cffbbb15c569 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -26,10 +26,10 @@ int generic_read(int fd, char *c_out, void *unused)
 	n = read(fd, c_out, sizeof(*c_out));
 	if (n > 0)
 		return n;
-	else if (errno == EAGAIN)
-		return 0;
 	else if (n == 0)
 		return -EIO;
+	else if (errno == EAGAIN)
+		return 0;
 	return -errno;
 }
 
-- 
2.27.0



