Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AED1FA40E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 01:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgFOXWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 19:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgFOXWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:22:32 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA73C20739;
        Mon, 15 Jun 2020 23:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592263352;
        bh=yRenNfLGBx82R7EvFHNRnPyeS6IINAWAcDUdMCjxrNQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Nzn3Wgj9LiW6vn0Y4F5TMX86XXUeq6jo/rssL9AdopJ2o8J/qy658kHZ44Cu1J8b+
         T3dWfSuijn7yf84ocAorzN4rq2Au5EaA8xGYDalcpcBrM5xZcBFqTU84IeQHYe+QQ3
         hEuj4y7sN8Xehd43csympDErpLxK8fFnNl6Ad+mo=
Date:   Mon, 15 Jun 2020 18:27:51 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] afs: Use array3_size() helper in afs_extract_to_buf()
Message-ID: <20200615232751.GA22366@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use array3_size() helper instead of the open-coded version in
afs_extract_to_buf(). These sorts of multiplication factors need
to be wrapped in array3_size().

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/afs/cmservice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index bef413818af7..4d086f9c829e 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -268,7 +268,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 				       GFP_KERNEL);
 		if (!call->buffer)
 			return -ENOMEM;
-		afs_extract_to_buf(call, call->count * 3 * 4);
+		afs_extract_to_buf(call, array3_size(call->count, 3, 4));
 		call->unmarshall++;
 
 		/* Fall through */
-- 
2.27.0

