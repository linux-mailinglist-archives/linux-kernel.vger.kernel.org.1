Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8965B27C13E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgI2JbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgI2JbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:31:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A934C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:31:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so4565631wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTVgpGq4LLRpZSsnAEZ8quGTs1OVPgk5ISC/KzU0WmI=;
        b=wSf3pUEw/Xo8Yo4QcjUMz5uvYca/gasUtpYXNJ+HlLUHwJ2w47KOF7O2zbnmOp07s/
         xVDSkbUTexSgR365m7fe+s6QEwlg6Y5RjnNe6KvO3WncTS36hanrjZN4xC6nmuKTCc2D
         VYjzZGELIKPAbI5sgdqnKZgrV30We47veR+1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTVgpGq4LLRpZSsnAEZ8quGTs1OVPgk5ISC/KzU0WmI=;
        b=MuJiPDEljuyqiKsh7fs2lefiUWC6n7UL9JK5W876zahhofIHepeoM2np9OdXT40veQ
         3HMCpCYgIXbGbg67ibj+QCcBn1Xs5w6iP+BRgFZfyI0xX7aNeBqLlp3h3D1Ikc6d+c6O
         oIOWiMW9esm5pT7yTwVXn648IRbrM/rVkNiA8D7akq8MAiW0wdMb07UqMGEVk766p/f0
         MWmGcnY/7GLt2z8vZpRiJju5F9wOHVr58x7+CkETBxjFnFxWH05qz2zqazbLMq0tv6EI
         p0Z9oE11UOy3xdyWalPfCX+zRbCJCDyGQzh9RbagSJoH/7XbVA7iSpI5v0ZkvkgjGzGm
         4INg==
X-Gm-Message-State: AOAM530IrRDghld06IjFRmaGfPLfvAbPoJ9meRFGLedCCZewdj+EdsRD
        +vmHDIgwm6ORj31ZeVc619tfkg==
X-Google-Smtp-Source: ABdhPJzNBJUbFcS3QxH2peWbETwJQ7UhwILzJSiAYhpNbKbUOrFixUtOc7+Cc64raXOoQQqcANIbaw==
X-Received: by 2002:adf:b74a:: with SMTP id n10mr3081077wre.140.1601371867720;
        Tue, 29 Sep 2020 02:31:07 -0700 (PDT)
Received: from antares.lan (1.f.1.6.a.e.6.5.a.0.3.2.4.7.4.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:474:230a:56ea:61f1])
        by smtp.gmail.com with ESMTPSA id i16sm5246798wrq.73.2020.09.29.02.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 02:31:06 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     kafai@fb.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/4] bpf: sockmap: enable map_update_elem from bpf_iter
Date:   Tue, 29 Sep 2020 10:30:36 +0100
Message-Id: <20200929093039.73872-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929093039.73872-1-lmb@cloudflare.com>
References: <20200929093039.73872-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow passing a pointer to a BTF struct sock_common* when updating
a sockmap or sockhash. Since BTF pointers can fault and therefore be
NULL at runtime we need to add an additional !sk check to
sock_map_update_elem. Since we may be passed a request or timewait
socket we also need to check sk_fullsock. Doing this allows calling
map_update_elem on sockmap from bpf_iter context, which uses
BTF pointers.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/verifier.c | 2 +-
 net/core/sock_map.c   | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b25ba989c2dc..cc9c90d74dc1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3943,7 +3943,7 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKMAP:
 	case BPF_MAP_TYPE_SOCKHASH:
 		if (*arg_type == ARG_PTR_TO_MAP_VALUE) {
-			*arg_type = ARG_PTR_TO_SOCKET;
+			*arg_type = ARG_PTR_TO_BTF_ID_SOCK_COMMON;
 		} else {
 			verbose(env, "invalid arg_type for sockmap/sockhash\n");
 			return -EINVAL;
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index e1f05e3fa1d0..08bc86f51593 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -610,6 +610,9 @@ static int sock_map_update_elem(struct bpf_map *map, void *key,
 	struct sock *sk = (struct sock *)value;
 	int ret;
 
+	if (unlikely(!sk || !sk_fullsock(sk)))
+		return -EINVAL;
+
 	if (!sock_map_sk_is_suitable(sk))
 		return -EOPNOTSUPP;
 
-- 
2.25.1

