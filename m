Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394A8300BED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbhAVSyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:54:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbhAVOWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:22:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADF8723B54;
        Fri, 22 Jan 2021 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611324973;
        bh=pimP6n21U/JGJRQ910aCkQFtVX5QrplC560wCofPJnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hYT3J4EfvpPGFA9Qpuk08wejxE0uqidb6UIrDfkeX+wacQw2S4smK+eO2gDbxPned
         g0ZJA2BuUrlF+M8OCh9x1z1qj4akI6BIhr+Ztt6cUVnCPELU2B0IScHyw5IIY7H70f
         1CXbZtUOm+wdQtf9FgkU6uZcD2ruogpwCJnbzxDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Baptiste Lepers <baptiste.lepers@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 06/22] udp: Prevent reuseport_select_sock from reading uninitialized socks
Date:   Fri, 22 Jan 2021 15:12:24 +0100
Message-Id: <20210122135732.172920223@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210122135731.921636245@linuxfoundation.org>
References: <20210122135731.921636245@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baptiste Lepers <baptiste.lepers@gmail.com>

[ Upstream commit fd2ddef043592e7de80af53f47fa46fd3573086e ]

reuse->socks[] is modified concurrently by reuseport_add_sock. To
prevent reading values that have not been fully initialized, only read
the array up until the last known safe index instead of incorrectly
re-reading the last index of the array.

Fixes: acdcecc61285f ("udp: correct reuseport selection with connected sockets")
Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20210107051110.12247-1-baptiste.lepers@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/sock_reuseport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -299,7 +299,7 @@ select_by_hash:
 			i = j = reciprocal_scale(hash, socks);
 			while (reuse->socks[i]->sk_state == TCP_ESTABLISHED) {
 				i++;
-				if (i >= reuse->num_socks)
+				if (i >= socks)
 					i = 0;
 				if (i == j)
 					goto out;


