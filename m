Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971942ADF24
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgKJTPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731085AbgKJTNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:13:02 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2C0C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:13:02 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c66so6590510pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:organisation:user-agent;
        bh=jIiFCm/12r8A6uZLzWSaqbi54qTYKrAUqW2h/pwF6fY=;
        b=Zzr+Zbc7EdNqtTGMc8Qo5bUJp9qm+QrT6VogTSBHu/Vmt0SZ9gsJmP9sLLAwFIGpOQ
         vT9F3Ynffyju710WDkAgoS5EvQ7u+huDI3beoYNB2iLlumBj54dvdz2vgcMp8UF+LKP3
         8I1/hSPVHYGTouCCOUplzRVaCH4265IbRnE+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:organisation
         :user-agent;
        bh=jIiFCm/12r8A6uZLzWSaqbi54qTYKrAUqW2h/pwF6fY=;
        b=sXKC+6quky+d9XVN8RJSnrPaiWC2HevrWNNNZjRQaQZPrGey319Dp8pAXzzGKRUrv8
         GGjlic2xcmaEwKjwK8nylN/7ZeanZ9Jk5j3kpEzfuGOKqyVcO5JTfLFEmEMZIFghffrc
         TKmJDItdyBkEfAwizQJsw+k+ndZxW58vDvcVDsMVduOZU5Hiyg86ap/+kpW34LAr/Ga4
         eGP3YDBSSqCycjwh7BbD5vnb7kc/yepJLBnHU8gV1qSptVzKaG5Tc48Adnio2e9cSdVj
         QBgLvPZ7WTONEYVNq8UlqsXVJ0plQzxuNUBso6ezm06elJ/G0t210T7DroF/pIO+XRvS
         rrKw==
X-Gm-Message-State: AOAM5311HmZ35dYTYrsNoWuaWALOM9Ye1Hb+V/rZzTc5xfTTCoeqD+iP
        t4tfiA5xxgQbR+2yhhNvNZzir3XjsN6Wlw==
X-Google-Smtp-Source: ABdhPJz63Nz3TMyPhaSF8saycNXABBSGP2dWemJoCrxImGtVZATXqOV5Io2wPRLFPIuO4Z5NflcNSg==
X-Received: by 2002:a65:50c9:: with SMTP id s9mr18343754pgp.20.1605035582486;
        Tue, 10 Nov 2020 11:13:02 -0800 (PST)
Received: from mariadb.com (173-160-235-21-Washington.hfc.comcastbusiness.net. [173.160.235.21])
        by smtp.gmail.com with ESMTPSA id s21sm13623526pgk.52.2020.11.10.11.13.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 11:13:01 -0800 (PST)
Date:   Tue, 10 Nov 2020 11:12:59 -0800
From:   Sidney Cammeresi <sac@mariadb.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt: fix incorrect comment about non-migratable tasks'
 priority
Message-ID: <2dc57331a47ea56c6cb0d155eb323bb42667630e.1605034896.git.sac@cheesecake.org>
References: <cover.1605034896.git.sac@cheesecake.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605034896.git.sac@cheesecake.org>
Organisation: MariaDB Corporation Ab
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sidney Cammeresi <sac@mariadb.com>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 49ec096..6197c9e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1560,7 +1560,7 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 	 *
 	 * - the newly woken task is of equal priority to the current task
 	 * - the newly woken task is non-migratable while current is migratable
-	 * - current will be preempted on the next reschedule
+	 * - current will not be preempted on the next reschedule
 	 *
 	 * we should check to see if current can readily move to a different
 	 * cpu.  If so, we will reschedule to allow the push logic to try
-- 
2.7.4


-- 
Sidney Cammeresi
Staff Software Engineer, MariaDB Corporation Ab
