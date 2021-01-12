Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E118F2F2F45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbhALMkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbhALMj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:39:58 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4314CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:39:18 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id z8so1107332wrh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=cd88PZYioyCzHHKMFonziFg/jnmE70xrn0dgHm2km3k=;
        b=TzAvlCGGlQ+J9NrqFbrScSC7TakMIWh2ybIIr5nC9dcgjeGuJU53u6b/Jmme6C5JYo
         0oL/UDqvroaKC1rIFJRwdutaz8EWIaH0vTOpIJqMVxmPAQgV6I2VJ5+bs+7yrd5ysr/3
         0/mxidw4zwMPHlEIwpEdnAnowFPAPJ+3fVmyMSr5ToXwx4ZgB7iDbPgRAPlnLwaduUfo
         U2ncMuTnku2hCqYzVdyOfZXsRCaBZwItPDlIGe5f3GBvy6tj79WbJoR55h5zztQfUr+q
         neLIDh08dAz13aT+vGCjC1W2WjLC1dIb1EdxbqufhGYiqWwUU1U6KTj9qpvz0/uz1GH7
         bgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=cd88PZYioyCzHHKMFonziFg/jnmE70xrn0dgHm2km3k=;
        b=FIA1f/bb6+QteGPCSFtx+bkONRscHvAsvUDIWgse7cDC5rUUJnVZh+viD090Of7LAm
         vy/uyroj/udLHixf3sCMu8LWwLn92XAtTOIToqDZefU6x1Fxla4zN31lSQmP4oMPbbcA
         FK73yZC/GV/aNsZnXpDWyX+kKChvQw2KHEkXExTY1TVFYrpMTNWy2LTsN/Q9JYCflps2
         a+l7IWPJ0+yKTKP72tNjBGqYWDmefGqK1l2zNPs+Kn1R5D4/xsnloJtEZxr1w65Lo0XB
         hs8IndmKCb/Z80ABzsPqXMJYh/XD6r/wa/bn0rirEa7CxxCfI736MTtVdBRN0W7CLYFP
         ObMw==
X-Gm-Message-State: AOAM531zBpjw1m7aouwNPzGFwSNowwGFCDQ/VnTmUDUSj/rVFEaXMTXk
        0X6Eg/IsJrWp4yb/2dvIcZfiO0QMJD5RpQ==
X-Google-Smtp-Source: ABdhPJxhpPBjKLmukSE9qxCHkBXBmVQtB6aOwBOqS+g2Vy1EUDyFX5XFK0NPQZMSp7n2hvAquvKsZV3JeBGN5g==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:cc19:: with SMTP id
 h25mr3485213wmb.124.1610455156789; Tue, 12 Jan 2021 04:39:16 -0800 (PST)
Date:   Tue, 12 Jan 2021 12:39:13 +0000
Message-Id: <20210112123913.2016804-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next] bpf: Fix a verifier message for alloc size helper arg
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error message here is misleading, the argument will be rejected
unless it is a known constant.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 17270b8404f1..5534e667bdb1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4319,7 +4319,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			err = mark_chain_precision(env, regno);
 	} else if (arg_type_is_alloc_size(arg_type)) {
 		if (!tnum_is_const(reg->var_off)) {
-			verbose(env, "R%d unbounded size, use 'var &= const' or 'if (var < const)'\n",
+			verbose(env, "R%d is not a known constant'\n",
 				regno);
 			return -EACCES;
 		}

base-commit: e22d7f05e445165e58feddb4e40cc9c0f94453bc
-- 
2.30.0.284.gd98b1dd5eaa7-goog

