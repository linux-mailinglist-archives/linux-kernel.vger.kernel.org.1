Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EC42C9569
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgLACtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgLACtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:49:01 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147F0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 18:48:15 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id v1so326093pjr.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 18:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/sab8xCMw8RgjXjo/DVBc0lxpkXKlUbFmD4vJTwFtIA=;
        b=tJiOo+gqIKFS8oZKBOEAo2TGGZrVOY57aNEUiBDq+f42dXG2Ugh6GC961LFlhQ06tH
         69UjmZLZjylJdOXQPZYA0V/yHKRvMSWO1bl743KlXCFIYB8UVioguelr9OKwQiUhSS2x
         oxdTc4QnxrKhFqnemHVsMe5UgNhXB3GQuxA4ayH2Yxr6cSV+MlKMzdc5IVU7URAf0jRy
         iDSUIMGnW2X4sPMMvSG/MPrqLsfwYbB2I8dxEmPMmUgsIJp1be5HgHZPYPhLQMHysYKD
         rsxI5GmoxZjk9j0N375EHFiUNKF6L42EKhhmouw6jZjKkWWIqycZNS1X6FHs5O2YonpO
         gtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/sab8xCMw8RgjXjo/DVBc0lxpkXKlUbFmD4vJTwFtIA=;
        b=V2aycKE3KyOvJ8IDOlXBucAoTURTRiHuARh86tatep8A/Un/5/JCCI+qTIb/0daMK/
         6Qrp3J6M73IuD1aPO/C952PKtov1lk5dN63yDYsiSKPE8th2Ngi36VXoyY4Edo/DKv7f
         y6SEg2Z3qKgYRkosYZEEEcZIwheSU8FF6zGqeWPrndw/Apvsr6d8R7savJyFgOzD7sL1
         N4vdG2wIHQrohHHi0h8CZpXbtPqrDCoJMBiZevybhAeQAdr0bEhhRaRQhLvcEBVricrE
         SUcyGh67q9+ABygPXfS4Rzj7ZfYY6CJdERfXIvHHdsowamigsHbPn4IUBtN13puCxamw
         qS7A==
X-Gm-Message-State: AOAM532DqrMD3H43jJB+oPkMLmJEhmOI74Tee9TtkSltRDq/3NLSYENg
        s3e5ha2t6F1kqmEFbVW7GN0+nvbWBqsVQpeO
X-Google-Smtp-Source: ABdhPJzs1TBNX5078HV2nzTBlxK82aANmkQxDcHg2xrUjPWEQqrmU0rqxH7LPTYDDJHmHhXCkubMww==
X-Received: by 2002:a17:90a:664c:: with SMTP id f12mr482815pjm.94.1606790894314;
        Mon, 30 Nov 2020 18:48:14 -0800 (PST)
Received: from ip-172-31-62-0.us-west-2.compute.internal (ec2-44-230-211-174.us-west-2.compute.amazonaws.com. [44.230.211.174])
        by smtp.gmail.com with ESMTPSA id 184sm394733pfc.28.2020.11.30.18.48.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Nov 2020 18:48:13 -0800 (PST)
Date:   Mon, 30 Nov 2020 18:48:11 -0800
From:   Alakesh Haloi <alakesh.haloi@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Minchan Kim <minchan@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: [PATCH] pid: add null pointer check in pid_nr_ns()
Message-ID: <20201201024811.GA72235@ip-172-31-62-0.us-west-2.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been at least one occurrence where a null pointer derefernce
panic was seen with following stack trace.

 #0 [ffffff800bcd3800] machine_kexec at ffffff8008095fb4
 #1 [ffffff800bcd3860] __crash_kexec at ffffff8008122a30
 #2 [ffffff800bcd39f0] panic at ffffff80080aa054
 #3 [ffffff800bcd3ae0] die at ffffff800808aee8
 #4 [ffffff800bcd3b20] die_kernel_fault at ffffff8008099520
 #5 [ffffff800bcd3b50] __do_kernel_fault at ffffff8008098e50
 #6 [ffffff800bcd3b80] do_translation_fault at ffffff800809929c
 #7 [ffffff800bcd3b90] do_mem_abort at ffffff8008081204
 #8 [ffffff800bcd3d90] el1_ia at ffffff800808304c
     PC: ffffff80080c20ec  [pid_nr_ns+4]
     LR: ffffff80080c231c  [__task_pid_nr_ns+72]
     SP: ffffff800bcd3da0  PSTATE: 60000005
    X29: ffffff800bcd3da0  X28: ffffffc00691c380  X27: 0000000000000001
    X26: 00000000004ce8e8  X25: 00000000004ce8d0  X24: ffffffc00691c3e0
    X23: ffffffc004e8c000  X22: 0000000000000000  X21: ffffffc00b042ed2
    X20: ffffff800876a4f0  X19: 0000000000000000  X18: 0000000000000000
    X17: 0000000000000001  X16: 0000000000000000  X15: 0000000000000000
    X14: 0000000400000003  X13: 0000000000000008  X12: fefefefefefefeff
    X11: 0000000000000000  X10: 0000007fffffffff   X9: 00000000004ce8b0
     X8: 00000000004ce8b0   X7: 0000000000000000   X6: ffffffc00b042ed2
     X5: ffffffc00b042ed2   X4: 0000000000020008   X3: 53206e69616c702f
     X2: ffffff800876a4f0   X1: ffffff800876a4f0   X0: 53206e69616c702f
 #9 [ffffff800bcd3da0] pid_nr_ns at ffffff80080c20e8

Signed-off-by: Alakesh Haloi <alakesh.haloi@gmail.com>
Cc: stable@vger.kernel.org
---
 kernel/pid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index a96bc4bf4f86..3767b9e1431d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -474,7 +474,7 @@ pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
 	struct upid *upid;
 	pid_t nr = 0;
 
-	if (pid && ns->level <= pid->level) {
+	if (pid && ns && ns->level <= pid->level) {
 		upid = &pid->numbers[ns->level];
 		if (upid->ns == ns)
 			nr = upid->nr;
-- 
2.17.1

