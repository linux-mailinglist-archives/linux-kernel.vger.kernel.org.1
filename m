Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15D0289228
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 21:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbgJITrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 15:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729280AbgJITrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 15:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602272874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=lgXKGmJY8FuTXCXdpAoSLX4NBWkvEFcm38oteYITDlM=;
        b=B/PrO2PP8cZgrPiIkUU3nlbGGnHQo87k6YMmSm3fcqgV0rVK20m5IrfThZGhIFXCle82Cx
        8xS1KgEG3vfyoyxT/G3FHPMeSvEcbsBAC4+to03y4F6w7ER4OKiQkWVcw9y0e6Jteg2xgF
        cxou2MHUiuhhO+p8we5y53BmZe9VAyA=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-jpYKowfDPlGdEG6AFjW4ag-1; Fri, 09 Oct 2020 15:47:44 -0400
X-MC-Unique: jpYKowfDPlGdEG6AFjW4ag-1
Received: by mail-oo1-f69.google.com with SMTP id g13so4453243ooo.20
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 12:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lgXKGmJY8FuTXCXdpAoSLX4NBWkvEFcm38oteYITDlM=;
        b=NNGqYf+C3xCAVDmEA9inCtVo1PcFYLJrNlSgV9oYuec23omPkHfRhtauFYjwaGFz9A
         1fTHJ4W9hExGX7q6EJFr3CXIlvLlq1IdNUVqTF6XvcwV6rgVgOlDQ9H9cBERASK5P7Wz
         lxdGgBQ5niMEYJ53rskG7aWu2nEh7q5ausRocyDlpjVghwZBj75+3BZS4rDpHnjkvv93
         /+1lCh21w2l0DkWogwAoEhzhL1BAtnkVmd2O3f8NkaxiXQ+fzzEY2Zoku0AK0FZjwYLY
         WoAPMByJEsxipNBzpK+AG9saPC7bWbZ+NHkXXdedInJvo8zOVJO1hWt+nH5UTeaV3iE1
         e45A==
X-Gm-Message-State: AOAM531BnYnPw/UEE4n7/7ioN9CFuj3ScjK/NHXc9D6DOXmk0nLjQhJE
        Rcl6JV1XyAGASHCJpg/PzOpBpyh2aaU5NCgiY0rEnTHlWsfhGT93lD5XR4BIegSmYFN83O364lU
        3dnX/XMrSJm23IAynXuLpdLut
X-Received: by 2002:a4a:e08a:: with SMTP id w10mr10404069oos.18.1602272863906;
        Fri, 09 Oct 2020 12:47:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQflYEfbzuxtLITg+Up9jg2c8kNCLAPz8wTSQCn0w7U0e6jYxqCjicPoPfd05rsY6eO5cFCQ==
X-Received: by 2002:a4a:e08a:: with SMTP id w10mr10404056oos.18.1602272863697;
        Fri, 09 Oct 2020 12:47:43 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s20sm8164861oot.15.2020.10.09.12.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 12:47:43 -0700 (PDT)
From:   trix@redhat.com
To:     dave@stgolabs.net, paulmck@kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        natechancellor@gmail.com, ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] rcutorture: remove unneeded check
Date:   Fri,  9 Oct 2020 12:47:36 -0700
Message-Id: <20201009194736.2364-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem:

rcutorture.c:1999:2: warning: Called function pointer
  is null (null dereference)
        cur_ops->sync(); /* Later readers see above write. */
        ^~~~~~~~~~~~~~~

This is a false positive triggered by an earlier, later ignored
NULL check of sync() op.  By inspection of the rcu_torture_ops,
the sync() op is never uninitialized.  So this earlier check is
not needed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index beba9e7963c8..6efc03a1d623 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1989,7 +1989,7 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
 	unsigned long stopat;
 	static DEFINE_TORTURE_RANDOM(trs);
 
-	if  (cur_ops->call && cur_ops->sync && cur_ops->cb_barrier) {
+	if  (cur_ops->call && cur_ops->cb_barrier) {
 		init_rcu_head_on_stack(&fcs.rh);
 		selfpropcb = true;
 	}
-- 
2.18.1

