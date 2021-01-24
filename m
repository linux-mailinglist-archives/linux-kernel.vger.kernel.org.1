Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661FA301F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 00:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbhAXXV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 18:21:57 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:46958 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbhAXXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 18:21:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id D4ECC1809AD39;
        Mon, 25 Jan 2021 00:21:00 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pR6BHobZVkWu; Mon, 25 Jan 2021 00:21:00 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B8rN2csFaLzK; Mon, 25 Jan 2021 00:21:00 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        boris.brezillon@collabora.com, rminnich@google.com,
        sven@narfation.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, fuse-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/8] fuse: Export fuse_simple_request
Date:   Mon, 25 Jan 2021 00:20:00 +0100
Message-Id: <20210124232007.21639-2-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210124232007.21639-1-richard@nod.at>
References: <20210124232007.21639-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MUSE will use this function to issue requests,
so export it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/fuse/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 588f8d1240aa..8b7209537683 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -522,6 +522,7 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, st=
ruct fuse_args *args)
=20
 	return ret;
 }
+EXPORT_SYMBOL_GPL(fuse_simple_request);
=20
 static bool fuse_request_queue_background(struct fuse_req *req)
 {
--=20
2.26.2

