Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3002CA8CD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404060AbgLAQxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388284AbgLAQxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:53:22 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F45C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:52:35 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id y10so1547250ejg.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=7J2rIU7NG1spfWolovEBqiTIkQod3FyymVw5u4J4xKA=;
        b=HMRWOVPawresJEri9vwe5OAQkAqTCsl6dlMR+u1UNoDoHH6RbQaUwdgAJ1SQv8Q5bU
         CqlJP8IK0+UOwr32kekS3X6pe1aKHWUwpycegjqqxbyWASoTk93WCwhUYmRAfGzBMYvf
         o5dc4oOfy7mUHyhaifj0uAXbH3wH9CSPcUWApGOgzaSE7PUejyhPwvMGLwY0T2DrTrm9
         o3UzWmtcFm7U+dXq1pK3QSkrrw8bbiR3resQdt9ATutmPjP5rhXFf2wrkdJCaaKHwL5J
         P9MlHaihMNzGKvVg3Tl8gYn+6ztJ65RBxTeQrBezks98OgZaJaArdZlQQz0LCrqta5WL
         Lohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=7J2rIU7NG1spfWolovEBqiTIkQod3FyymVw5u4J4xKA=;
        b=hVm6RrBIaa82ljIWRdSaaUz36JlgCtWYwQrCoe7qrZqNA6xi+1h0qEFIygDZbx3aJ6
         UDir2Cm+7YxO7WhrkokfNoJvJZj4Y3mdrfGpDZyrHnjCYPC4ZdRGQKxU87vqtt2Vf6Q3
         WKAMJGXJLQMshXRxz7xKfZ8JSroSg7tTNr+13quIaY/9NW5yR5+ygXmXYetxrddPjqe4
         7g3HWwP87qPKyfsuULRtkR2MmtXKM6gioquDK9swdPgLfhM9JKLEHysjAi1uOYVmFNJ9
         NrKHW3x8nyppsatLtw7MHp23d0G4ttfj+ua2hPOS+jtJwtoS2BlvaVOypC5oTGMPt6NW
         liWA==
X-Gm-Message-State: AOAM530FRaLvdlARjCwHfX2u8evr9LyCGlj0Cdpig7S2QAxiUxILH6Qi
        SL/4sROPa/k2XMaXtdQ9Cd/tXZSwtL+Y
X-Google-Smtp-Source: ABdhPJxcFEFb3HZPmb7f2rVe8+bDLBadD+Ea3YClzGi0bJXXWHPjBMwHyKyRbk6uMfZoP/zYg/0vOrHFEenm
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a05:6402:143a:: with SMTP id
 c26mr3846526edx.131.1606841554118; Tue, 01 Dec 2020 08:52:34 -0800 (PST)
Date:   Tue,  1 Dec 2020 16:52:22 +0000
Message-Id: <20201201165222.2001985-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2] modpost: turn static exports into error
From:   Quentin Perret <qperret@google.com>
To:     masahiroy@kernel.org, michal.lkml@markovi.net
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@android.com,
        maennich@google.com, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using EXPORT_SYMBOL*() on static functions is fundamentally wrong.
Modpost currently reports that as a warning, but clearly this is not a
pattern we should allow, and all in-tree occurences should have been
fixed by now. So, promote the warn() message to error() to make sure
this never happens again.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Matthias Maennich <maennich@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>

---
v2: now depends on 20201201103418.675850-2-masahiroy@kernel.org
---
 scripts/mod/modpost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 43e00867623a..5562526c8c32 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2648,9 +2648,9 @@ int main(int argc, char **argv)
 
 		for (s = symbolhash[n]; s; s = s->next) {
 			if (s->is_static)
-				warn("\"%s\" [%s] is a static %s\n",
-				     s->name, s->module->name,
-				     export_str(s->export));
+				error("\"%s\" [%s] is a static %s\n",
+				      s->name, s->module->name,
+				      export_str(s->export));
 		}
 	}
 
-- 
2.29.2.454.gaff20da3a2-goog

