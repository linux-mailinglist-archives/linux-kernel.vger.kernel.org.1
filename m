Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D512C69A1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbgK0Qle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:41:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728406AbgK0Qld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606495292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=lnuam6t1dXzzELpLGRbQVXkdkYHVojrbstXmjNQiiAo=;
        b=FDoKSdmx4qa4PpILEMlSAfVdFoGqqnJgavD0lxvnjOHA51m9Bc8OYoVIINQzUqHtT5K771
        H/03n1QwuJKn3Whfu6u4+eNpK2l3/ylBVD23RafSc8wEPAUMfWv69A3D7tFDQxlAIzXEsU
        IjkP1cJnO1E0nzrgGtVDzADD4Oh+CEg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-n2KrbgC_OF68izI6vn6IVw-1; Fri, 27 Nov 2020 11:41:30 -0500
X-MC-Unique: n2KrbgC_OF68izI6vn6IVw-1
Received: by mail-qt1-f199.google.com with SMTP id x62so135082qtd.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:41:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lnuam6t1dXzzELpLGRbQVXkdkYHVojrbstXmjNQiiAo=;
        b=q+MVvOfLK+ykwBqS+7HUhT1kOOWw9nYlAcntUaeQjqogL3Dp99ohO22ipCU2giVEoT
         N8r6+IKs+GQ59o/nQjEVWhvuQNAUCY/PmXIIfZCquG49wLe9TwPmBI6W/p6vcy/n9UAY
         IX4fajNG3m3NIvnB5V1yQ+tvDBgU7k2rTCWOzRvIAN+d7D9Bb48yt5dMoONonb52Wb27
         XV7w6Ep6fpqOsIZ7SFEW7g4J6egcmaNPevsoVNOiK9eniVZ92/NnvEumPqEONM8alf4G
         iAlIeVQof2kRWFGs70DLN3FwWOMd4VI5qXYUxb5VKozddKQW00u6Bz1Y3ARNXL6A+2/v
         CtYw==
X-Gm-Message-State: AOAM533NwABlLODDXLE4kVpQsbShx3I/+wB74WBWWjXyqSzWW1Ij0NXT
        3ZUuS+oZLMdUNdUrmDdPZFDHtDkaatGgUVDdYOa356ZqQqFwZBLkH1RcjF8RravtEta5TLF+kpA
        pC4AbAEXHcObK9ZQxedBzQmwq
X-Received: by 2002:ac8:37e5:: with SMTP id e34mr9275443qtc.363.1606495289971;
        Fri, 27 Nov 2020 08:41:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGVoB1FnATLvFMiWzvnKfj4zWNscV10h/VlSxByCUq/xEQFr+dQD8NalIXyFGn5WsQrgOKMw==
X-Received: by 2002:ac8:37e5:: with SMTP id e34mr9275426qtc.363.1606495289793;
        Fri, 27 Nov 2020 08:41:29 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d82sm6166735qkc.14.2020.11.27.08.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:41:29 -0800 (PST)
From:   trix@redhat.com
To:     a.hajda@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] [media] s5k5baf: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 08:41:23 -0800
Message-Id: <20201127164123.2678983-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/i2c/s5k5baf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/s5k5baf.c b/drivers/media/i2c/s5k5baf.c
index ec6f22efe19a..6e702b57c37d 100644
--- a/drivers/media/i2c/s5k5baf.c
+++ b/drivers/media/i2c/s5k5baf.c
@@ -510,7 +510,7 @@ static void s5k5baf_write_arr_seq(struct s5k5baf *state, u16 addr,
 
 #define s5k5baf_write_seq(state, addr, seq...) \
 	s5k5baf_write_arr_seq(state, addr, sizeof((char[]){ seq }), \
-			      (const u16 []){ seq });
+			      (const u16 []){ seq })
 
 /* add items count at the beginning of the list */
 #define NSEQ(seq...) sizeof((char[]){ seq }), seq
-- 
2.18.4

