Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0534302C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbhAYT64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732240AbhAYTyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:54:39 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30A9C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XPc5xOyQBf5tFzS0CqIJXhJ1xLqNqWS/ktX5J0cuAxI=; b=nI4byitjmCyoAR3ZJaXwq6DTDg
        0rq+ByCeITPyNXFZXQ4DNStS27wJowO44jFJ9tsveEaWXtNWBAvfcZfFO7wHYXHjF77Zg2mcd3DjN
        MfIj12EcuPe/BQWdUbz1W9KrknfzV9nFc/60t1TnBWpDIfvQwKyvq6F8NlQI2QqFGFEXBlpvneTNL
        eRCa/EVbknDmNaUMvuWNBshi/Q5FvqspVmJ0zwv6kyWJD5Jcpx+q6LoRD3nKAsBWI9v1aXs/vp9lX
        BbkDopSmIFEVcNb7/9TQWKU+NUrZUX7G7q5QeZ6ZWkV+UQ3sL0AqPv4q7Qu2AQtNQVkC0TzSFqZbh
        53kTWerw==;
Received: from [2601:1c0:6280:3f0::7650] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l47vw-0007Ov-AB; Mon, 25 Jan 2021 19:53:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Johansen <john.johansen@canonical.com>,
        apparmor@lists.ubuntu.com, Seth Arnold <seth.arnold@canonical.com>
Subject: [PATCH RESEND] security: apparmor: file.h: delete duplicated word
Date:   Mon, 25 Jan 2021 11:53:50 -0800
Message-Id: <20210125195350.24845-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the doubled word "then" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: apparmor@lists.ubuntu.com
Reviewed-by: Seth Arnold <seth.arnold@canonical.com>
---
 security/apparmor/include/file.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/security/apparmor/include/file.h
+++ linux-next-20200717/security/apparmor/include/file.h
@@ -167,7 +167,7 @@ int aa_audit_file(struct aa_profile *pro
  * @perms: permission table indexed by the matched state accept entry of @dfa
  * @trans: transition table for indexed by named x transitions
  *
- * File permission are determined by matching a path against @dfa and then
+ * File permission are determined by matching a path against @dfa and
  * then using the value of the accept entry for the matching state as
  * an index into @perms.  If a named exec transition is required it is
  * looked up in the transition table.
