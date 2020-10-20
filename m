Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BA5281E84
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgJBWki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBWki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:40:38 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA0A206C9;
        Fri,  2 Oct 2020 22:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601678438;
        bh=uBStzRhx+6KQ0Ub4fEA/Ek5SMCPjVxZ96KKFGxqgGFc=;
        h=Date:From:To:Cc:Subject:From;
        b=ywHiejSFWuoEiRbZ0pv/OwmLItumGRyS1cl4aboSn+P6x+FI9lRly96qkTEgrE4jj
         k7TGr1+5OGN86vW056Ro444GekX9ZXGb5B42HjG2CNfMBjHKoKXKLhSeiXjwikQQLy
         2SPtYOjEpBIw6gz7YUWJjYjpUKWawLU9jNfnNaGA=
Date:   Fri, 2 Oct 2020 17:46:27 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] printk: Use fallthrough pseudo-keyword
Message-ID: <20201002224627.GA30475@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace /* FALL THRU */ comment with the new pseudo-keyword macro
fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1538df175aae..fe64a49344bf 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1617,7 +1617,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	/* Read/clear last kernel messages */
 	case SYSLOG_ACTION_READ_CLEAR:
 		clear = true;
-		/* FALL THRU */
+		fallthrough;
 	/* Read last kernel messages */
 	case SYSLOG_ACTION_READ_ALL:
 		if (!buf || len < 0)
-- 
2.27.0

