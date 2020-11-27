Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC642C74AC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbgK1Vtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730084AbgK0Tuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606506615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=D0OEsjTfxMqFMhB+/LyY+jMVTgPWufB5Fsh8HmQS8Ic=;
        b=XzQPv35NwJH5uUAut8rXe0DviCj9ZojNyswmynRXd7KR74KUDXVgLN1yFZDxEk9zcTebiF
        AFr4dB5UL/b03KxQbjdiQul73EvSZjxrcTO4GAxpSPsz53LfkMkIC9IUoW1SCKyhPoEFRm
        C1a09Ot/MzcXZcJmKVB35wA+2vpYz2Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-QKwHNqeZPq-Cq7MwxHWzlg-1; Fri, 27 Nov 2020 14:37:33 -0500
X-MC-Unique: QKwHNqeZPq-Cq7MwxHWzlg-1
Received: by mail-qt1-f197.google.com with SMTP id x62so363301qtd.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:37:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D0OEsjTfxMqFMhB+/LyY+jMVTgPWufB5Fsh8HmQS8Ic=;
        b=gGfU4n3reacHf9OwziNJ2Rc5SpgZj9BQi/5Cj9Q41ACr9288zxL+fRTOygFPvcl4+J
         sOuRmW1uOUJlZkJunvkUtg7BJZlwX7YjuZ6NvECRO3ZRU3/lBMofB3rWGRgBJDaUmDpE
         Y6wYwLhOMoGrcNAPC9PlacggAz6zSkwTm2QABrgRd6mM9Pg6p9Y7QYmaTfwS78txfzNV
         B2u6/nsJlcmsX7s2x0/gBCWHEGKisEWxQpo7XXbf9cYN/vZV+l+O/I3/1BWlF1pKfG8l
         vpoLAxYUmLjAJqb+twvLZa4YN/hfDI7Y0P4MxSiEcXwqFUacRmjONAU2ei6Xp1ZXTZ+T
         jkqg==
X-Gm-Message-State: AOAM5332zwcSmH9gkboKSuWqzX+rF2lFm4+Jturv/vJEJj36homUoDGb
        Rw0NfcVxR8btgZkvVeDLhZ6i3ZuP1/40uzANbMumn3U/EsqUETPsXPEJ89pQbj7Vn5o58v3VdJm
        CL09N/NI9bB7EzdOCkai0ppmI
X-Received: by 2002:a05:620a:11a4:: with SMTP id c4mr10274490qkk.8.1606505853160;
        Fri, 27 Nov 2020 11:37:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6uM7SBGwqmsudiKO/+tm/yXrc9q7QmiVxYTb6LM/G0g5REpKZV4lvXkCCThByWIkgggqM3g==
X-Received: by 2002:a05:620a:11a4:: with SMTP id c4mr10274470qkk.8.1606505852952;
        Fri, 27 Nov 2020 11:37:32 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q7sm6821053qkb.22.2020.11.27.11.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:37:32 -0800 (PST)
From:   trix@redhat.com
To:     davem@davemloft.net, kuba@kernel.org, wenxu@ucloud.cn,
        pablo@netfilter.org, jiri@mellanox.com,
        herbert@gondor.apana.org.au, paulb@mellanox.com,
        john.hurley@netronome.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: flow_offload: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:37:27 -0800
Message-Id: <20201127193727.2875003-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/core/flow_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index d4474c812b64..59ddfd3f3876 100644
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -32,7 +32,7 @@ EXPORT_SYMBOL(flow_rule_alloc);
 	struct flow_dissector *__d = (__m)->dissector;				\
 										\
 	(__out)->key = skb_flow_dissector_target(__d, __type, (__m)->key);	\
-	(__out)->mask = skb_flow_dissector_target(__d, __type, (__m)->mask);	\
+	(__out)->mask = skb_flow_dissector_target(__d, __type, (__m)->mask)	\
 
 void flow_rule_match_meta(const struct flow_rule *rule,
 			  struct flow_match_meta *out)
-- 
2.18.4

