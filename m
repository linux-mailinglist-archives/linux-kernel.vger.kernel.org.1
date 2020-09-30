Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A8027F186
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbgI3SnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3SnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:43:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D15C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 11:43:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e11so612905wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hgch/OU0fUgiG3/fTy3bhBDktVyr1lWgsfs92Fqm60E=;
        b=Gy4xqQj07MvJJi/1fgMrYLmwe96RaUqcWYCzIfzOjDedCQ54s1LDQ0WMennSf+Tvm4
         U0mjGZGoklNdXahK1oYoGCpAQlytuhQ41jhjNdiFaAx+eH1yZVU7JCpyKJiDgKGCmCWK
         x/eGs/YuSRHCnmRJpDh/O/h+fa+lckVhktl8SqdRkMSdxv85yZ/1jF65X88ZZBzhe6Sf
         TfTK9i3N5qiBdV1N/wc14dn7IGbmuZA2mBA7gPZ8kHieI0ZXWhQIxYEd4lDjYraV2A83
         NCGY5kyx88iMvrBeU2dQJ7UjQHTw6SXwP7DaJJYPEfGj9jkYW/NmbGTlQtvCn4D7jnDY
         wiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hgch/OU0fUgiG3/fTy3bhBDktVyr1lWgsfs92Fqm60E=;
        b=FKGYpzz0+5joIIrWx9ZMHLVPjkKIgCg/VR36HonoRQWD51jxgjo8/GV/HsyIlJDllF
         Du9eRYaiC17v/cFm1hyv3fBXYIkzjh5uSQs4NDpPkrTg/i3MnjSH43Zt8Vtw8XVUQ0b5
         jgRMfnexNSDk3/QYjrgZsIb4eCiULLt/4w7VFP6G4jErtLLakTLpmrXO5WU5oIWFGWBZ
         cg76UdF2ffwOkzlDc9YgRiRk+LgMMDlfu4NqPvN63WmWRYXvuB4/8FcX8q768DWyIKrO
         uWGuPPG93+mEM2kzhkUo/K8tf/BIVph9nl3pDMznlKcHuUyDkG33dloz2GrcxeAjSf7Q
         6i3w==
X-Gm-Message-State: AOAM531gpDHAsrYj71Dnj5vkAndy/heHe+Yto1Ta9jovOI2RMakIAHoQ
        eK6SLVjBnZ/l9UBdGUtESzqUa0AHSKa2bg==
X-Google-Smtp-Source: ABdhPJzGABrgVbqXqM0qsgciuACgzThRniFfbVtpTIiaUkUkhZ00iFN3+fVGYavAFupDn2rREYgquA==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr4407645wmi.5.1601491387204;
        Wed, 30 Sep 2020 11:43:07 -0700 (PDT)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id d13sm4318214wrp.44.2020.09.30.11.43.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2020 11:43:06 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] tracing: remove a pointless assignment
Date:   Wed, 30 Sep 2020 19:43:03 +0100
Message-Id: <20200930184303.22896-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'len' has been assigned a value but is not used after that.
So, remove the assignement.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 kernel/trace/trace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3c75aab44ad..e13cb3baeff0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6662,7 +6662,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 		written = -EFAULT;
 	} else
 		written = cnt;
-	len = cnt;
 
 	if (tr->trace_marker_file && !list_empty(&tr->trace_marker_file->triggers)) {
 		/* do not add \n before testing triggers, but add \0 */
-- 
2.11.0

