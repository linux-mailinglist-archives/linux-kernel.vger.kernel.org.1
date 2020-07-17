Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE742235EF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 09:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgGQHbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 03:31:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26158 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727834AbgGQHbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594971091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=O4tbDPVMhV3D2xNSTppLYaS5mFJOOOObQ/aku8/zju0=;
        b=ENE5EP58VusZvHJ9nYDLF61QLfn16Hu83MdgN+pRlwIOOLxbij+2QJE2AyHA7RbQ0oGuZp
        KdmjVN3y8VZXWRUfu0rcDdtBiFsCZDiYrHPN+nPbnk2ZX3aZswQwclhfAtktwsFcpu0e83
        cgczc/ch2HkE2CgJ5IrgMggaE00BU+M=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-euZqQAuaNcyigh0M3VrhnA-1; Fri, 17 Jul 2020 03:31:30 -0400
X-MC-Unique: euZqQAuaNcyigh0M3VrhnA-1
Received: by mail-pl1-f197.google.com with SMTP id f2so6081760plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O4tbDPVMhV3D2xNSTppLYaS5mFJOOOObQ/aku8/zju0=;
        b=t1MtNyLu+No0+5hlnvDBS2rA/5BTs/WhUuhbJLFQqXwyfa5043UhXkfh6oNlwcOEMq
         3KOijI1HjO4C6ulEhL7a22n/F5RVXFJ8Cp84nivpO2jFjP/I9aRMnhjw2ceiRD0q79pm
         K0G48NMPEDgknpJDciRn3Megq3kMT6gADuOkll56Bzb5jDVUG2qOxlBcoQixHxEw4xKH
         e0/XUfH+UQU5H2aaeOf/y2chFrv728t3UeC1WPEQNwRUTH1/pKJA4PE2A/Wz0/b4rgCO
         mvDDd00G4QNvQNno2e8WXvWa2G2o8cTbSBu0HfBADF8QZGzpt+QIZuj2EuRH0zyMIQaK
         9a/Q==
X-Gm-Message-State: AOAM530Om927YjyLMKikR18yXN6TdE6H7BDnSoQZlfU+wMwgQ3jgFRmD
        CNs+qMQbHK9HUkxqTuTUmzbyTkl5qd3w53sSR/zNI70XplXYPEmPzm+CTNiPCvlnpx/N257DEsj
        RRm6G+4v/B7gTvjVGpaTxRg86
X-Received: by 2002:a17:90a:d306:: with SMTP id p6mr8018032pju.25.1594971088797;
        Fri, 17 Jul 2020 00:31:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvorDhB6qT0+Oqx3qbVvAeLAlBfbxKkbAytZj7md5EYRYzaP86fn4CeCfURjw9aE7QYARVsA==
X-Received: by 2002:a17:90a:d306:: with SMTP id p6mr8018007pju.25.1594971088436;
        Fri, 17 Jul 2020 00:31:28 -0700 (PDT)
Received: from localhost ([182.69.195.232])
        by smtp.gmail.com with ESMTPSA id o42sm1969718pje.10.2020.07.17.00.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 00:31:27 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH] hw_breakpoint: Remove unused '__register_perf_hw_breakpoint' declaration
Date:   Fri, 17 Jul 2020 13:01:00 +0530
Message-Id: <1594971060-14180-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b326e9560a28 ("hw-breakpoints: Use overflow handler instead of
the event callback") removed '__register_perf_hw_breakpoint' function
usage and replaced it with 'register_perf_hw_breakpoint' function.

Remove the left-over unused '__register_perf_hw_breakpoint' declaration
from 'hw_breakpoint.h' as well.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
- Resending with Acked-by from Mark added and maintainers Cc'ed
 include/linux/hw_breakpoint.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index 6058c3844a76..fe1302da8e0f 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -72,7 +72,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    void *context);
 
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
-extern int __register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
 
@@ -115,8 +114,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    void *context)		{ return NULL; }
 static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
-static inline int
-__register_perf_hw_breakpoint(struct perf_event *bp) 	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
 unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)	{ }
-- 
2.7.4

