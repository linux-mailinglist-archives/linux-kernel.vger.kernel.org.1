Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AEB292F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgJSUGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40820 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgJSUGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603137997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Rwu5R4NP10oKRBKBebpuTTYEX193VHHXV9VzeeNDfYk=;
        b=dDaeLmMHn0GkfeJO2++KCiA25g1Zk8AyOs7n2llEGxdey6bF3wUfTXoLaLUyYb+MbZuQmQ
        FMqYctkmGZDcQzy6dvi1P8FLesBJi7uBRUqFsQDTPyogeEcFlJ8LonRLKgkmDR5ihieR3t
        iLpaZ4xww7QFelGeaVsu2xp9+w+0iqE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-SUwz40fWPF-zGveE4uW2iQ-1; Mon, 19 Oct 2020 16:06:35 -0400
X-MC-Unique: SUwz40fWPF-zGveE4uW2iQ-1
Received: by mail-qv1-f69.google.com with SMTP id eh4so666087qvb.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rwu5R4NP10oKRBKBebpuTTYEX193VHHXV9VzeeNDfYk=;
        b=l+75bz+AGcormNpQcj8p4fUtOEEXRzfCRmcWSpBsVA/57kBl/4J164GvIE7EaX1QRk
         dXL59Rq8amD8tqD7fEny22YL0HkKm2wxpdL8A5RqRciLX2GBor+ctqpEq8DmimwPzUk5
         b5onopoetKU38EnnnlVj0UDtKA2UYhjtTDABKm9nqKGgN0NxkMgroyB/hOpEtLRdL5yS
         /sbX76xfjVxn+UCpS2MZUOAOZrvRStPAkfcusr7KGVsZOWtba3dhUAwUfe6pNu8AMq3m
         xzaivporVt6ZtrMrLESPmodKbTfQ/Ghag/1aAOPlpjhyGbXlrHvf+EQ4i0hy7aKY35JU
         OyjQ==
X-Gm-Message-State: AOAM5327WNoNRSI2YQJOaW4TZ0cf5QwjwezegFItjKDMhw+BJBQ4zJs8
        osyfCDnVUNkLX3oTNeNvcAskqXNSRU48AMAs6zmTCDpPCf9RVSA5+8ly94zAYCMx1nnbC6/uiCH
        0z+NEUTdl5nvskpRht9siRQY4
X-Received: by 2002:aed:3325:: with SMTP id u34mr1177948qtd.263.1603137995355;
        Mon, 19 Oct 2020 13:06:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJ30gBjZQ66PUBOHzG44mIj676lzg8NzeLLpI4e6g+idi6K1hsn2QtzDa6004sKCAWPfMYmQ==
X-Received: by 2002:aed:3325:: with SMTP id u34mr1177928qtd.263.1603137995158;
        Mon, 19 Oct 2020 13:06:35 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e9sm476182qkb.8.2020.10.19.13.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:06:34 -0700 (PDT)
From:   trix@redhat.com
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] x86/microcode/amd: remove unneeded break
Date:   Mon, 19 Oct 2020 13:06:29 -0700
Message-Id: <20201019200629.17247-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 3f6b137ef4e6..3d4a48336084 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -215,7 +215,6 @@ static unsigned int __verify_patch_size(u8 family, u32 sh_psize, size_t buf_size
 	default:
 		WARN(1, "%s: WTF family: 0x%x\n", __func__, family);
 		return 0;
-		break;
 	}
 
 	if (sh_psize > min_t(u32, buf_size, max_size))
-- 
2.18.1

