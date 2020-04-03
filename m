Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD07019DAD2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 18:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404022AbgDCQGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 12:06:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39966 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403978AbgDCQGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:06:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id s8so7030222wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5wsPxhq1mJxEXsc3bjOm6GGwt7zL846SQGSdLJV2/U=;
        b=mIYU87FChto9yFjZ8upQyAg2v1264aUW55Ng0Pr1TqO6cLmLHoof4pU9gyHSeS0DLV
         QZZhV1Tw/Zn4KGnNOlG90LtTmWlF48IASJF1nWhM1ZlP4MBWdt+yE2UGdjzABZ/PIo87
         WPkTzTAvPZumqlxUajKalhI0niVYyOOreH0hrC1lag3/cQs6Dh7+m6KP2CzvsZ8xionJ
         dakAxkPdHmQhhmzCFMfA6Myah2lZXL13XWYhcvMc8olC8wvNCeEXF2HEOsOU4RLeyZpY
         gtVh5aD3t9loGG4a0reP0F96ePRo8a1VQKBa+DYhfZb7p60zksZifBCTYkADyH642h9v
         x4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5wsPxhq1mJxEXsc3bjOm6GGwt7zL846SQGSdLJV2/U=;
        b=Z8O2pGar8n1W+harj7sIRAJkpnyY37mFGT9lGu5HjPCuPeDX1Xwsf8hoaNpiQ3LuJc
         0VOjjCyqbG9qiyhjhmRAtO6PFJX7/G01QSnTibeaRQT2uFKTxYgDO1/2+oeNewQn+3fV
         pXb0SQLru5WAHKYf4ut2tuaa5pbl8Jn/9mmt0atoHzGWrVAqR9GrzvIcHiwWS1uxwaLe
         1P4bmUhOXNBobRIv8P8Iqn496FCgm0FnSfmhibFv4eSWGpfhmv0fYCGI0ndhOpBD0aYP
         pg32S4BqhS/q3Ra/wZaVb4vixV1HqcO9l2oIlwAnbfuobtE9zksqu7EI48/8ol8tHag7
         lNBQ==
X-Gm-Message-State: AGi0PuaeZ84r989C540/BoyTbnrrw8uT0iW3CwsCmDpigb3A0JDP5y05
        Y9BbwJAlXNEFyOUkjBW9bB3bxuTyUsJL
X-Google-Smtp-Source: APiQypJOKUMA+QJfGmwI0Gz9oX3d6VZZXXE08S3jjf3kizRYWvUG9R9mdHxa4az51O2xQXfcsIYrVw==
X-Received: by 2002:adf:f401:: with SMTP id g1mr9449471wro.140.1585929960516;
        Fri, 03 Apr 2020 09:06:00 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id l12sm12351426wrt.73.2020.04.03.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 09:06:00 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gang He <ghe@suse.com>, Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aditya Pakki <pakki001@umn.edu>, ChenGang <cg.chen@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        ocfs2-devel@oss.oracle.com (moderated list:ORACLE CLUSTER FILESYSTEM 2
        (OCFS2))
Subject: [PATCH 3/5] ocfs2: Add missing annotation for dlm_empty_lockres()
Date:   Fri,  3 Apr 2020 17:05:03 +0100
Message-Id: <20200403160505.2832-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403160505.2832-1-jbi.octave@gmail.com>
References: <0/5>
 <20200403160505.2832-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at dlm_empty_lockres()

warning: context imbalance in dlm_purge_lockres() - unexpected unlock

The root cause is the missing annotation at dlm_purge_lockres()

Add the missing __must_hold(&dlm->spinlock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/ocfs2/dlm/dlmmaster.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 900f7e466d11..8cbd46b3509a 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -2762,6 +2762,7 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
  * Returns: 1 if dlm->spinlock was dropped/retaken, 0 if never dropped
  */
 int dlm_empty_lockres(struct dlm_ctxt *dlm, struct dlm_lock_resource *res)
+	__must_hold(&dlm->spinlock)
 {
 	int ret;
 	int lock_dropped = 0;
-- 
2.24.1

