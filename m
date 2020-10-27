Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C23129A35F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505097AbgJ0DdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:33:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35418 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505088AbgJ0DdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:33:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so113509pfo.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G4xNL92zEwek75JEZnuVm7wEX2RUSFWgIzAKX127/i0=;
        b=FT1fUxARInreCkClfkfJwx+MHtjATGuw+PchmD7R6yvYSgz2bBJrIOuCk3bU3ADjOK
         pEKlYc+wcYSxQvyjiZCbRPbs0uvzewnHYQEfSy1NcCA+Y3vdYF3lIOj/i+lqqSwyytxw
         TrX+Y4zxkZ4ksowtcEpGeRCS9yJ5aUibW0ZFDJRF2qmQAP4es66Dod11qi61t0IC89Ky
         c+tAs9GBNrt/Y73lZ+90Bof5IePEoYCqYKdNUJC4j/m0DmFeGLQbvBl8m+wHJV/IMdmD
         ZYjz7nJm4k6FVUFQdiR3RCjhENJeDxun9GZOIfeSnfXAY4mQfVwlU7bWG9o2AWFzp2+5
         5r4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G4xNL92zEwek75JEZnuVm7wEX2RUSFWgIzAKX127/i0=;
        b=RpQyWH3MMez2e3u0Acf8Z14eS1xAPGv2stH0p/AS+VSV486pJEouh5cB2Jua/W88J1
         HbCUzanVGsOblm04SFgGrEE0tOqaYDaJgW2Y3mO89TR4gnA4XSdCb7iNAu3yRZzMEJOQ
         l7Ne48KXKGqKjbSv+JTqfoJRyqRIwgTSOQkHjRWAhLz7HdTsLUfNFbHR14EkFbeSRIAt
         PtK50ptoxhiCD1avDRN4pWZHds/w0dZmflljN8UYHsCLdC1IRN/GSQ+eFnwgs/+1MSjX
         ZruUA/pM8nt/Va33TDlIDn78HRYh+UzZ8oytnaSCii9dP0KasSTgLe2X675XExEAshTz
         zBWQ==
X-Gm-Message-State: AOAM532yTV3HVKzCUP4hlQ2ji+G0odLd/s+fTYGFh18PIvAqL7h2nLBD
        jXC952Q1p0BX6uzl+jAJWzA=
X-Google-Smtp-Source: ABdhPJw5UXToqfgZiGxU7xLIBntzbXC2CTfdRd/jbSNa5kl4vwtxAwPjj488KLf8SFYFbdnSTuj1ew==
X-Received: by 2002:a62:a10a:0:b029:154:fd62:ba90 with SMTP id b10-20020a62a10a0000b0290154fd62ba90mr259460pff.62.1603769595803;
        Mon, 26 Oct 2020 20:33:15 -0700 (PDT)
Received: from bj10918pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t9sm206009pjo.4.2020.10.26.20.33.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 20:33:15 -0700 (PDT)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
To:     xuewen.yan@unisoc.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        Xuewen Yan <xuewen.yan94@gmail.com>
Subject: [PATCH v2] sched: sched_domain fix highest_flag_domain function
Date:   Tue, 27 Oct 2020 11:32:52 +0800
Message-Id: <1603769572-8193-1-git-send-email-xuewen.yan94@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the highest_flag_domain is to search the highest sched_domain
containing flag, but if the lower sched_domain didn't contain
the flag, but the higher sched_domain contains the flag, the
function will return NULL instead of the higher sched_domain.

For example:
In MC domain : no SD_ASYM_CPUCAPACITY flag;
In DIE domain : containing SD_ASYM_CPUCAPACITY flag;
the "highest_flag_domain(cpu, SD_ASYM_CPUCAPACITY)" will return NULL.

Signed-off-by: Xuewen Yan <xuewen.yan94@gmail.com>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6..2c7c566 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1427,7 +1427,7 @@ static inline struct sched_domain *highest_flag_domain(int cpu, int flag)
 
 	for_each_domain(cpu, sd) {
 		if (!(sd->flags & flag))
-			break;
+			continue;
 		hsd = sd;
 	}
 
-- 
1.9.1

