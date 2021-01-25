Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B664E3039CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391785AbhAZKFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731377AbhAYSzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:55:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 167A52100A;
        Mon, 25 Jan 2021 18:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611600908;
        bh=Znwk8YSnWv2sD6LgBWbsjahVfYOLquD92q7Qq2Nq9G8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhGvD3BKxybtJSqr1UOqsSgVVuDgomrrrsHxep5Ul6+yQo3CwEl7kiR8I8TpYJiLN
         Cl5DBDi6vQaRJ78p1DwzTRDiW82eBDhU5EOY53vj5935bj0BVnmeHmO0i9UsqqJcLX
         ktf6GCKFqTUHsN3cokKryhzpImsnXfSl3WnL4wXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Siddharth Gupta <sidgup@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.10 198/199] kernfs: wire up ->splice_read and ->splice_write
Date:   Mon, 25 Jan 2021 19:40:20 +0100
Message-Id: <20210125183224.530014072@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125183216.245315437@linuxfoundation.org>
References: <20210125183216.245315437@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit f2d6c2708bd84ca953fa6b6ca5717e79eb0140c7 upstream.

Wire up the splice_read and splice_write methods to the default
helpers using ->read_iter and ->write_iter now that those are
implemented for kernfs.  This restores support to use splice and
sendfile on kernfs files.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Reported-by: Siddharth Gupta <sidgup@codeaurora.org>
Tested-by: Siddharth Gupta <sidgup@codeaurora.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20210120204631.274206-4-hch@lst.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/file.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -949,6 +949,8 @@ const struct file_operations kernfs_file
 	.release	= kernfs_fop_release,
 	.poll		= kernfs_fop_poll,
 	.fsync		= noop_fsync,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= iter_file_splice_write,
 };
 
 /**


