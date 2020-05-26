Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0DCC1A2FC9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 09:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgDIHLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 03:11:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53031 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgDIHLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:11:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id t203so2767015wmt.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 00:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5eSqljophK3J9QMb2IVJwDYwOtfnnEmsDgtCr/TVwbc=;
        b=g+VdDocBUMc7YkfrlGnOBmSeZKLad8EJkluGT+HvtTsBY9v9IAnZKIblY/097oINC9
         rNn5X9eaApO/7mVS549G+9AITMdLt3Ew7DoL3kF3iYVQnaLR435jeL9iIXJ64jImPlfw
         MWj9JnS/tsD4Dl3/bgWvQHrh69WhL2jZCC5XpJscZM8HN6K4WwDtWfsIDkxcDzidO8/6
         yGYdYP+hJErvKs90X7Zfvdf/os7ciUKLKiN1yJ9294yzH75j1pRmDekN+JdsJSwKMe0v
         9jX7JMC6nu6nK1fwbvkIrzdTKdYYEq3jybVJvhvQZBVQIJx6F/J12cgzi1w95XB4JHYh
         evuw==
X-Gm-Message-State: AGi0PubVL2cN8BJcCAVw06wF4NU5ihNqRT9G3NaJW6fubC/AoXhd+31f
        jjI12VZh3BW6o06WCrWfy0s18BkO
X-Google-Smtp-Source: APiQypJ9YxTqJw7coXnf6Q2zGizMBjvKOUWP9ykWZFEHY+j0GH24P0x9faxr/NX2H95YcLo04gU1BA==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr8426305wmz.21.1586416300444;
        Thu, 09 Apr 2020 00:11:40 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id v186sm2570051wme.24.2020.04.09.00.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 00:11:39 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hillf Danton <hdanton@sina.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm, gup: return EINTR when gup is interrupted by fatal signals
Date:   Thu,  9 Apr 2020 09:11:33 +0200
Message-Id: <20200409071133.31734-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

EINTR is the usual error code which other killable interfaces return.
This is the case for the other fatal_signal_pending break out from
the same function. Make the code consistent.

ERESTARTSYS is also quite confusing because the signal is fatal and so
no handling will happen before returning to the userspace.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 6076df8e04a4..50681f0286de 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1088,7 +1088,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		 * potentially allocating memory.
 		 */
 		if (fatal_signal_pending(current)) {
-			ret = -ERESTARTSYS;
+			ret = -EINTR;
 			goto out;
 		}
 		cond_resched();
-- 
2.25.1

