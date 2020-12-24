Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99C72E27CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 15:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgLXOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 09:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgLXOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 09:47:36 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8208EC061573
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 06:46:56 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l23so1279801pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 06:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Rb0QaH0oE60Cddz2pv1KRIEuviEFeA1HK5jD7OD84js=;
        b=Pi4AYcwjjo3XJyzHtWdJsg3AkQ03vN927yE21ToCEDgfPZG8+QpQIkt012nv5fLCmT
         +syc/fYejHu3ld7LRT/5pKE/ysql2tX2widELwkt+bTUZeb9ilh6mjX0O2wworR90oS6
         MKfa/kjxmVe+VqrD3CRZUAP3A+c19hWX8/U28jH7uJ6asfP73yUHOUo0qlRSU6KjSZtO
         jrCorAgrHN/TR4M7R6bPg9/ZA3qzVJsWvuEAKOhXBj4G61tnqK57LUzj2emlN78AdwTt
         IZA6Or2NaLA560G3//+HTT6L4CilQpXw5aiiTml0NR+O+iMQZ4cmrRp1/W4V7FAMsUki
         Nxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rb0QaH0oE60Cddz2pv1KRIEuviEFeA1HK5jD7OD84js=;
        b=YWDNctt8BXEk2vC8WyQz7gZWB3RSK4B1dfLxKHXENPV/HYzUjfFkJh3wDS9ZdGa0fR
         Bftk45DSbU6MNecheWCYJTY+qxAvUg61SokQ+davBIhJBRYkkJA98ySUDdIOtgHxiEVJ
         EgCKGptubEkP8054MJNReaaw6h9kdZyGuC926XTtscQYJ5vE9tKUFw7RNqZOr8Aap78A
         dDQE1tAP0mOArOAJOxnJaVb+FIi5kYLQRjiQwsGlmf2yo6sih0GddWIZPZPEXMYR4d5e
         CADMriqdA0EDfE4BeRrjaPfnZp2vUROqG7xkG//TJBjNF/GZETFF6artSgOoUDdCt+tH
         F+mg==
X-Gm-Message-State: AOAM530OIOfDRhpMR6C0iGtVKF2+/ZVwVge6Epzfs1z6/1qSg6tOYGDn
        /yfiNCiWkZIBVouIkuhS7fc=
X-Google-Smtp-Source: ABdhPJz3DGUNd/fpOkrjB5zhXMX9omY91OdGX31ZDyAdVILYWhytjfkNeIAf4sLDS7lRHDRLh/gWvw==
X-Received: by 2002:a17:902:ac90:b029:da:fd0c:53ba with SMTP id h16-20020a170902ac90b02900dafd0c53bamr30014400plr.23.1608821216153;
        Thu, 24 Dec 2020 06:46:56 -0800 (PST)
Received: from localhost ([13.94.42.177])
        by smtp.gmail.com with ESMTPSA id c3sm24420483pfi.135.2020.12.24.06.46.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Dec 2020 06:46:55 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] ring-buffer: Drop unneeded check in ring_buffer_resize()
Date:   Thu, 24 Dec 2020 22:46:34 +0800
Message-Id: <20201224144634.3210-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the cpumask check, as we has done it at the beginning of
the function.
Also fix a typo. s/also the on the/also on the/

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/ring_buffer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ec08f948dd80..b8213581e119 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2062,10 +2062,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 
 		put_online_cpus();
 	} else {
-		/* Make sure this CPU has been initialized */
-		if (!cpumask_test_cpu(cpu_id, buffer->cpumask))
-			goto out;
-
 		cpu_buffer = buffer->buffers[cpu_id];
 
 		if (nr_pages == cpu_buffer->nr_pages)
@@ -2583,7 +2579,7 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
 			 * have filled up the buffer with events
 			 * from interrupts and such, and wrapped.
 			 *
-			 * Note, if the tail page is also the on the
+			 * Note, if the tail page is also on the
 			 * reader_page, we let it move out.
 			 */
 			if (unlikely((cpu_buffer->commit_page !=
-- 
2.17.1

