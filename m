Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A031E4559
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgE0OMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 10:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgE0OMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:12:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B457C08C5C1;
        Wed, 27 May 2020 07:12:19 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x10so10169554plr.4;
        Wed, 27 May 2020 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=We66kIGMrTaCnuQtcIJQeGN/sJ3B/1sOBKzRUBIfQgA=;
        b=Yv9N3dC83R49iaR5Fc+lwe+9USxD9sL8CisYiRTpbUHP1OgtAF/ZZ0L04a+iLnnPWN
         3hOvPreSdLy8BKaQkzOGDu/pot5wrIdFJdNBv+psJn0xBY7uTBj/kE58w56IckM/0GfI
         CN2CoNlebqr9KrMtITdFFw+cSWRCDqnPWNQ1h8SHqigvP0uXgOeikkA6UgKmcXSVd71s
         eRZ3jQzsRG4iSOEEGYDFAu3VjzxFMt8Q5VKoORPQkEqbrpaD0ss2o1+u4XB9mJnI2eCF
         dOBjpoSojg3jQvSjHRecP32HLF5+TROlXQprSOVmpEUcnczu4bsT9CsjvihLYx2KLBfK
         i/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=We66kIGMrTaCnuQtcIJQeGN/sJ3B/1sOBKzRUBIfQgA=;
        b=NAGQZi2HRT33w4B3K6yPh9K05yFUZd+vqvzJLG5+R/nhElans4iJmoCEEHsgmNdHzz
         DVq/u9rRcXgR8QjDJhqwpmfcfkJvM2fC5gp+4mdfKA5fg64/HN1nQHPHui3Ua99w/hzi
         FwyiOvImqcEISiSWbDiIDBuaaFPf0dMaPrQ+mtFocCYiKomHqF++bBvvPmNOcSnsEvd+
         +INsyJ4cW2ydy4OLPzIp+79PzFROR0YdkUhfVED9s4/q5bKOu9RCACD2cQoGbiIS0R26
         g69VkYiRh3Wv2tIxH3r+Ssj2Zbl9myVVNmUNCgHKDUNCPZgIMCss1Yttha7+h371B8Vp
         bxlw==
X-Gm-Message-State: AOAM532v9mu33qa184RwfCCcdgchAn4Q3TzWrRMnxqvOYye17OeOSpIH
        HOGf9HuIP9l5Vx6cFl9zvhuhgeWz
X-Google-Smtp-Source: ABdhPJxC7SGcYFRflzvW2QJRicTCmgs4zKhVh4LyLSmRdyrkyLy0+S0kxreXvLSPySELQBIQMhKpfw==
X-Received: by 2002:a17:90a:e30e:: with SMTP id x14mr5408544pjy.141.1590588739093;
        Wed, 27 May 2020 07:12:19 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w190sm2194684pfw.35.2020.05.27.07.12.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 07:12:18 -0700 (PDT)
From:   Kaitao Cheng <pilgrimtao@gmail.com>
To:     adobriyan@gmail.com
Cc:     christian@brauner.io, ebiederm@xmission.com,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com, guro@fb.com,
        walken@google.com, avagin@gmail.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [PATCH] proc/base: Skip assignment to len when there is no error on d_path in do_proc_readlink.
Date:   Wed, 27 May 2020 22:11:55 +0800
Message-Id: <20200527141155.47554-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we don't need {len = PTR_ERR(pathname)} when IS_ERR(pathname) is false,
it's better to move it into if(IS_ERR(pathname)){}.

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---
 fs/proc/base.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d86c0afc8a85..9509e0d42610 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1753,9 +1753,10 @@ static int do_proc_readlink(struct path *path, char __user *buffer, int buflen)
 		return -ENOMEM;
 
 	pathname = d_path(path, tmp, PAGE_SIZE);
-	len = PTR_ERR(pathname);
-	if (IS_ERR(pathname))
+	if (IS_ERR(pathname)) {
+		len = PTR_ERR(pathname);
 		goto out;
+	}
 	len = tmp + PAGE_SIZE - 1 - pathname;
 
 	if (len > buflen)
-- 
2.20.1

