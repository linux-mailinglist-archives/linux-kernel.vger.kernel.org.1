Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C7B2A7D91
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgKELxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbgKELxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:53:11 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B8EC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:53:10 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so1399229wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXF1SqOriWJ7aOraSXefzzIqR43tkx0ONzj50WfCuDg=;
        b=zGTLcxiZZV78qsG3GcPQhbs6hZm9UW+qwSl1J9Rc4mi0VpXJEpe9I/xGZ+PmvUDj1Q
         eHQEBduQhpnLeffenHiQUpr7Psk+RKNcSMVhvUv/VE2CgLiGsalgOjAVXwPl3lzVxLgk
         ysd/6nRrijW0em5Tj92Aku24eVxfTorX8oNkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXF1SqOriWJ7aOraSXefzzIqR43tkx0ONzj50WfCuDg=;
        b=Fwdgp/2c9tXf4MhohC6E3z6xtegUb5y545Q+hbrYVikCG5/pv8LB4QGe95xxkMOW91
         zfaMKN+0wVg5dOheOO02QBzo1SN84xdNm2iMZjo5q0Ufqf+R6dKoaUuPkdTqYH6bsMzs
         rlTXgRIg+oEylgxFdBP1Z9QcXx/tKd496oh7Dl9M4c5LKnO6x/yVBHKWb0W7aCFdIMWD
         47TU8Y6S9ilgQg0EbPNz7KS3ajHzEXg7T3qOns3IcO/TQ8pP/hqYnQ2+WVgMQpk5gH/n
         Z8rTQeZu9YkhKT0Xjh/ekya/RqBDiuez2M2hejLZ2WnXReanzEVUqNbgyn9sKf5hZhYU
         HjVQ==
X-Gm-Message-State: AOAM5301eHwsrVJ4iONxVCECk8RF0a1aEIWjV1GTE5EKKSD6LF4eB0iK
        MBcAduR3vbkYAyvoq98XtsnUfg==
X-Google-Smtp-Source: ABdhPJzzNkmxfb9gJuURyKkFNJ0rPyrbz1mHyaZcFFdgejmsCf3LvQME3YFn2QGfmCcxQxs7+t/AEg==
X-Received: by 2002:a5d:4207:: with SMTP id n7mr2466805wrq.76.1604577189172;
        Thu, 05 Nov 2020 03:53:09 -0800 (PST)
Received: from antares.lan (b.f.7.4.3.0.f.a.d.b.3.c.e.c.d.3.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:3dce:c3bd:af03:47fb])
        by smtp.gmail.com with ESMTPSA id r10sm2264214wmg.16.2020.11.05.03.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 03:53:08 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Cc:     kernel-team@cloudflare.com, Jiri Benc <jbenc@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf] tools/bpftool: fix attaching flow dissector
Date:   Thu,  5 Nov 2020 11:52:30 +0000
Message-Id: <20201105115230.296657-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My earlier patch to reject non-zero arguments to flow dissector attach
broke attaching via bpftool. Instead of 0 it uses -1 for target_fd.
Fix this by passing a zero argument when attaching the flow dissector.

Fixes: 1b514239e859 ("bpf: flow_dissector: Check value of unused flags to BPF_PROG_ATTACH")
Reported-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index d942c1e3372c..acdb2c245f0a 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -940,7 +940,7 @@ static int parse_attach_detach_args(int argc, char **argv, int *progfd,
 	}
 
 	if (*attach_type == BPF_FLOW_DISSECTOR) {
-		*mapfd = -1;
+		*mapfd = 0;
 		return 0;
 	}
 
-- 
2.25.1

