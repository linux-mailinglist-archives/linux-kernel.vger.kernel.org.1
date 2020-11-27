Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E8C2C6B22
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbgK0R6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgK0R6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:58:02 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D0C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:58:02 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id z6so2047747wrl.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zbpGVgr8tNKDgthNqGrhordV2MhrhuH8IzD17QyNfdQ=;
        b=Cp+XgwyL/DQSmzZ1190ENwLk/KCOR1R/9fKDea7XXBnGJQKHwda/BkhBDsSBnP6+Gz
         b0dV/egvQo3YKiLXVOcjivnl4oW4rtubUUAnheZSrnGy08WoTHfHe4B0G1iIavdKtzaO
         Xo1E5o0R9ww4ZMpvHa+mpZDFY8crVQQAD+JGbhLm/AozjZQHti6pYWMLMaqpJy/K4/0q
         LEm/it1Oz0OnPFnXDh1TUDq9LHmrGOxl+7g1fauQ3CXxn+KSp7Po46OJwYlc2g6yE6Az
         EV++zDfV7Z13674e7QYD64BC67as9iD2sUwY6j+4YON+7sryWrC68j9MDqe8qXV6xri+
         MyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zbpGVgr8tNKDgthNqGrhordV2MhrhuH8IzD17QyNfdQ=;
        b=ejhQ6Iwg0T50p9zVh+qauuT6dF0Npe5thRBIw74KjLkKHycjGUxa1kSMlexHlyQA+V
         JB7vp+4zJI1pCdOa5pdvIJVYnnu6YrmTpvl+sGIfLj5VrmovAbVa6Dl2kCrjkTOFsT7w
         rsd1EsboptToWCGbBgLRRAW8HSjzred5NfrpFyzlCxton9LBOih0umhfe/lChzzZCY5W
         8GQ0TLP9fWVcsvC3G5m2xUkuq/2e+dLryjgUF1GyabFmPAHLvN7ahsvISrcvwourbGbN
         k/FpOtjIj0MlkhOfIVlpKTlmyqUWCGdJa4kypnTZByUFHUwHTjBiXpUqh3tiOO3sivs3
         QoHw==
X-Gm-Message-State: AOAM5324gjFVYpJOhj5Nw1L4Q8OPyz/KWzsdR3O7f3zqXA4BmfpnblE3
        41GxuZkr58OLvvYSQPx2GzBNocPmBmLZ8w==
X-Google-Smtp-Source: ABdhPJwho6pXFG+DscRnKoutGBvwveNAK3yEza+jlSdM3GLTU4mqPS7QfoiniQ696oYgBA4QlL5MYEPj++kEhA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:791a:: with SMTP id
 l26mr1857691wme.1.1606499880798; Fri, 27 Nov 2020 09:58:00 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:57:31 +0000
In-Reply-To: <20201127175738.1085417-1-jackmanb@google.com>
Message-Id: <20201127175738.1085417-7-jackmanb@google.com>
Mime-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 bpf-next 06/13] bpf: Move BPF_STX reserved field check into
 BPF_STX verifier code
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can't find a reason why this code is in resolve_pseudo_ldimm64;
since I'll be modifying it in a subsequent commit, tidy it up.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 kernel/bpf/verifier.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1947da617b03..e8b41ccdfb90 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9501,6 +9501,12 @@ static int do_check(struct bpf_verifier_env *env)
 		} else if (class == BPF_STX) {
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
 
+			if (((BPF_MODE(insn->code) != BPF_MEM &&
+			      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
+				verbose(env, "BPF_STX uses reserved fields\n");
+				return -EINVAL;
+			}
+
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 				err = check_atomic(env, env->insn_idx, insn);
 				if (err)
@@ -9910,13 +9916,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			return -EINVAL;
 		}
 
-		if (BPF_CLASS(insn->code) == BPF_STX &&
-		    ((BPF_MODE(insn->code) != BPF_MEM &&
-		      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
-			verbose(env, "BPF_STX uses reserved fields\n");
-			return -EINVAL;
-		}
-
 		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
 			struct bpf_insn_aux_data *aux;
 			struct bpf_map *map;
-- 
2.29.2.454.gaff20da3a2-goog

