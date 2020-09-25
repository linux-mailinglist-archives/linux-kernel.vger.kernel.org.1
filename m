Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D07278481
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgIYJ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYJ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:56:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EB3C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:56:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e2so2606342wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xM5gUTG5YNhi56jc9AEoov6VfEV/W29OCfIKcalBgOE=;
        b=pmXJ4k5CiHNWnta5bkfcVqcwRbkCRUCs0cZQoI9Xk3qb53xXqFOhp9aOPfuDoFQh7r
         EUTyJSKNtjCM0wdTs4Io2ZZAHzFtp3WcczdQr3++3IbXqh6RnJRnT9t9XdN8W0xIRvRT
         +G+d6KLd6df0Q1tVhfFFXoWDEHfl4V06UMYzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xM5gUTG5YNhi56jc9AEoov6VfEV/W29OCfIKcalBgOE=;
        b=XkzBRnUX4RlGK09WhkZ+k6/XkQ6KlGbWj81hM3mFOnTIiLbiMC4LRMZ7AaILXspTZD
         NhIyOIGU2vi/JebPJOnJXaIaVKUEoGQLaGWaf1xwiIwihx7W8liCvpa5pQQ8P1uhP4Yt
         j3bcxuKadG84oh5Fm+uxAMN9CYWCSZb0vY5E4bU4ubR8c58RUtb7O0e1kk+I/E6tnV2Z
         dMwG0lplXeH3QAzI9q/twJIJqg9FjaKiEG6a/lDjNy3Igxs14kRk9GhDKSmR7QxQeqex
         mxVDFYVi4lEEA1Ibo+uuerbtcLk+tWbBiEOuFYdfxzbdnz8tnRYsCvFJ23CGcpajDBcg
         fqzQ==
X-Gm-Message-State: AOAM532T5NVl9O0/KAbtMdIud9RnYJnEJu+diJ9E283PLCQRwh+7hOsh
        yi8/AwdzKlNHvGjhZSWqO0rBYQ==
X-Google-Smtp-Source: ABdhPJwURdG6NAF1pgFm1GTvUOQ5ogglm8gSd79fhyPbv95dBUQs5edWEuP2J1BkOWNUxXmlD4LUng==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr2178705wmi.19.1601027806934;
        Fri, 25 Sep 2020 02:56:46 -0700 (PDT)
Received: from antares.lan (e.0.c.6.b.e.c.e.a.c.9.7.c.2.1.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:12c:79ca:eceb:6c0e])
        by smtp.gmail.com with ESMTPSA id l10sm2225084wru.59.2020.09.25.02.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 02:56:46 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/4] bpf: sockmap: enable map_update_elem from bpf_iter
Date:   Fri, 25 Sep 2020 10:56:27 +0100
Message-Id: <20200925095630.49207-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925095630.49207-1-lmb@cloudflare.com>
References: <20200925095630.49207-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow passing a pointer to a BTF struct sock_common* when updating
a sockmap or sockhash. Since BTF pointers can fault and therefore be
NULL at runtime we need to add an additional !sk check to
sock_map_update_elem. Doing this allows calling map_update_elem on
sockmap from bpf_iter context, which uses BTF pointers.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 2 +-
 net/core/sock_map.c   | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d4ba29fb17a6..5bd0239da8b6 100644
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
index e1f05e3fa1d0..497e7df466d4 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -610,6 +610,9 @@ static int sock_map_update_elem(struct bpf_map *map, void *key,
 	struct sock *sk = (struct sock *)value;
 	int ret;
 
+	if (unlikely(!sk))
+		return -EINVAL;
+
 	if (!sock_map_sk_is_suitable(sk))
 		return -EOPNOTSUPP;
 
-- 
2.25.1

