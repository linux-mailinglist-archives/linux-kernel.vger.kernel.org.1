Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83887304AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 22:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbhAZEwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 23:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbhAYJRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:17:20 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB595C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:16:30 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l3xyv-00BMTE-H6; Mon, 25 Jan 2021 10:16:21 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] fs/pipe: allow sendfile() to pipe again
Date:   Mon, 25 Jan 2021 10:16:15 +0100
Message-Id: <20210125101615.efceefcaeae0.Ibe2d56dfaa49d7a366c835b5ae0f0a5c2d643ede@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAHk-=wgrkX4KM-kbEzs+Bap4v13RQ-ymwwAxgwjhTz6VVtp8Cw@mail.gmail.com>
References: <CAHk-=wgrkX4KM-kbEzs+Bap4v13RQ-ymwwAxgwjhTz6VVtp8Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 36e2c7421f02 ("fs: don't allow splice read/write
without explicit ops") sendfile() could no longer send data
from a real file to a pipe, breaking for example certain cgit
setups (e.g. when running behind fcgiwrap), because in this
case cgit will try to do exactly this: sendfile() to a pipe.

Fix this by using iter_file_splice_write for the splice_write
method of pipes, as suggested by Christoph.

Cc: stable@vger.kernel.org
Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Suggested-by: Christoph Hellwig <hch@lst.de>
Tested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
Mostly for the record, since it looks like we'll have a proper
fix without another intermediate pipe. However, this fixes the
regression for now.
---
 fs/pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index c5989cfd564d..39c96845a72f 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1206,6 +1206,7 @@ const struct file_operations pipefifo_fops = {
 	.unlocked_ioctl	= pipe_ioctl,
 	.release	= pipe_release,
 	.fasync		= pipe_fasync,
+	.splice_write	= iter_file_splice_write,
 };
 
 /*
-- 
2.26.2

