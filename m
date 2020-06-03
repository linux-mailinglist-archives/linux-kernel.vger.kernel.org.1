Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40831ECB22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 10:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgFCIMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 04:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCIMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:12:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5236C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 01:11:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gl26so1167664ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 01:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxW2WKbu5+yJ2UGLVOyAkV6S1g7Xw1rS2dpKIEl2moA=;
        b=AsfRgRAM3v4V/Iq7E5u55S0caQmYzDGH2eudDD7JZu/9r3hTveIkdfX4SRf0N3piVc
         rRgkc+7/cW75LsvRZBBqTc0kHOm+vr2SbsNgVFAlqWtH9i1iLEu9CGIvfkiV8kFVT4Jk
         6wlpAzIBhfyLe+9pKt34mGO+4rIIGjoxFM5fEHKuW4DzS7OLo/k4DzyCoUbQ3Kul/Yp+
         O7T3X8tFYsl66mMQwKQY8sOAdkSbY4jdDMkOCW36wAgNtfMSgzXOgqQ2DF1JCB4F9EPa
         YuNeSimZbtLW+C9DGIZiAYx6ilvd614hJEvKaGmgjTev5TnP+1OCmXkpVLvN8mr3b0pg
         xwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxW2WKbu5+yJ2UGLVOyAkV6S1g7Xw1rS2dpKIEl2moA=;
        b=hzgzriqmkbA4xs+lmL5w7v3Gfm4zNd+ORW3qP+SiM2bEnTbzoJu7stQFNx7QTQSijK
         BBgWFZ41zA9fc0xKyZUHsxB8d3Luo6yKY7AHOHgrzlPwDAh2JQvJHS+bmNBbLPbt74NZ
         tMlr42xmObngqQzqSxMzDfDSAOGshRD3WCjMWUg89l0byiKd3HjrB6nKr4Cdyc0AJjxg
         3ZymAiUXTDsvxjv/u+3Y8f9CbvwYxJbYW9DXuTHrTKaMNvEVz5OMviwmMhx6hqWJdjVp
         V3LAdGug1qf1KOQ3/hV65xeUrOQuUCBbY20852W/Dmm+TEk5pkrxZ1geNFs3s0wHheOg
         PIiA==
X-Gm-Message-State: AOAM532Lc6nKHkLB6+w7/BjbuPJijhOhas29a2SHTGqdFqxp4u+VTVH8
        aljcxjzBebi8X/a5e2jAHbGd2A==
X-Google-Smtp-Source: ABdhPJwiF29+IoyaIV667de4V6PVVZ7iRMBJhgklglZoPuUXGivSxyDjUznTXiIfOw/u4qUW5+braA==
X-Received: by 2002:a17:906:d111:: with SMTP id b17mr17295858ejz.267.1591171917420;
        Wed, 03 Jun 2020 01:11:57 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id r16sm748803edv.95.2020.06.03.01.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 01:11:56 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     netdev@vger.kernel.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Ferenc Fejes <fejes@inf.elte.hu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: fix unused-var without NETDEVICES
Date:   Wed,  3 Jun 2020 10:11:23 +0200
Message-Id: <20200603081124.1627600-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit added new variables only used if CONFIG_NETDEVICES is
set. A simple fix is to only declare these variables if the same
condition is valid.

Other solutions could be to move the code related to SO_BINDTODEVICE
option from _bpf_setsockopt() function to a dedicated one or only
declare these variables in the related "case" section.

Fixes: 70c58997c1e8 ("bpf: Allow SO_BINDTODEVICE opt in bpf_setsockopt")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    This fix currently applies on net-next and bpf-next only. Except that
    net-next is now closed and -net will get commits from net-next after
    Linus' pull.
    
    I hope it is fine to have picked [PATCH bpf] and not bpf-next (or net).

 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index d01a244b5087..ee08c6fcee1a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4286,9 +4286,11 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
 static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 			   char *optval, int optlen, u32 flags)
 {
+#ifdef CONFIG_NETDEVICES
 	char devname[IFNAMSIZ];
 	struct net *net;
 	int ifindex;
+#endif
 	int ret = 0;
 	int val;
 
-- 
2.25.1

