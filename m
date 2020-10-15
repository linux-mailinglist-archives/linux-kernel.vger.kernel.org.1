Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CFA28F451
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgJOOGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:06:22 -0400
Received: from m12-17.163.com ([220.181.12.17]:40720 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgJOOGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=stzCj
        44piycQ93b9gKxTr0jRV1BpnU5k9OyOPURNcxE=; b=jJVD7yBDezz+RvKYSJDEx
        XDdj72wmM7ASUiFyt90OAx9b1vQvVaRVs7sK95ieMFs3lZ+ZevZdwQpHLGBraXKc
        y+8ZzOoIuQ+9+DlLmN6n+82z4xEl712LRTWpH4lUbto4yLx/U+taeWEx4JGSxBCw
        ScPw92ddQ1PJtkaB6E6aFY=
Received: from localhost (unknown [101.228.30.83])
        by smtp13 (Coremail) with SMTP id EcCowABH7XkWV4hfC1FMNw--.60761S2;
        Thu, 15 Oct 2020 22:05:11 +0800 (CST)
Date:   Thu, 15 Oct 2020 22:05:10 +0800
From:   Hui Su <sh_def@163.com>
To:     sh_def@163.com, leon@kernel.org, jgg@ziepe.ca,
        keescook@chromium.org, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] async.c: reduce the critical region in lowest_in_progress()
Message-ID: <20201015140510.GA19561@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EcCowABH7XkWV4hfC1FMNw--.60761S2
X-Coremail-Antispam: 1Uf129KBjvdXoW5Kr4rGFW7Cw1rAry5JFyfXrb_yoWxXrb_Cr
        y8Zr95Kr98GrW3ta15C3yfWr42qws5W3WI934UtFWDXr90qa1rXw15XFn3X398Gr4xGrW3
        Aw1Dur9FyrnF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjM5l7UUUUU==
X-Originating-IP: [101.228.30.83]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbByx2+X1PAPRrvTQABsg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The judgement of first do not need to be in the critical region.
So move it out.

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/async.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/async.c b/kernel/async.c
index 33258e6e20f8..9d33ffcc84c7 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -96,10 +96,10 @@ static async_cookie_t lowest_in_progress(struct async_domain *domain)
 					struct async_entry, global_list);
 	}
 
+	spin_unlock_irqrestore(&async_lock, flags);
 	if (first)
 		ret = first->cookie;
 
-	spin_unlock_irqrestore(&async_lock, flags);
 	return ret;
 }
 
-- 
2.25.1


