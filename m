Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23B32B3C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 05:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbgKPEfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 23:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgKPEfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 23:35:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473F8C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 20:35:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n186so19123584ybg.17
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 20:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ewLDtC1Ll1+KhSOjBeNvFZ/A9hKRZKnELHCa/fqKz8w=;
        b=l7DYaprbrYkeTfMwB9mrFYRhtwuwHnco7Fx6vSdDEY0XYSeLpNgDuo/LHBNJTtiXwS
         E9iO3krRelNApZKP2J7I70NN2lMSbnGdb+pHezFtoykV+h+pXJPr2AyrHCCjf5dLXlzA
         NF9+J1jPTZeU+5cwhV/wFDZrVfqB9hXH2FvTG/+W4hZFS4L2qY2gJEmP9fXUVRIIM52v
         CC6iVX6QH2RlIcdOSf6Zc7hTIiWrnNieDal+kt8bgJTtFBcAmlF/wiGl/wqjC/hOULTm
         B+DOiS2aPaQ62GFRUgn5ySeOH1U+s9x3Bb4vgE1fUskYPiPPF5tuKLIodkoijn+0rkbb
         y8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ewLDtC1Ll1+KhSOjBeNvFZ/A9hKRZKnELHCa/fqKz8w=;
        b=aG9R6+QtADI9qKlNlR6aeCc+pLgbPLOb+/95zMCxtL7Qk1lFkzl6q6SpIl6wpAbm0q
         B5LmEloePXR6oQCb6r0RMabiX/5XJSPn+n7W53U9AFL4zq/u/wWeRFOYzeMVFSP9TW6e
         +NGd9hTOlJZdUsDm4Czx2TeHT4vFVsnaXCk5VC8mlWVn0yQfAHHQxxmVMmzEVyxDmYVC
         fp0PVaoN2FxiXz7v7I9J07kfy5BumVkU9MgAbdLB3mla2KvDO67IOl06eXThndr6wj1d
         q3f5qVxBlbRPV8nn5OHHh0h7a8PUZDd13HMlmGank2O1unHY+8YufXw35NMYxAtwjpCV
         BPwg==
X-Gm-Message-State: AOAM531Ga8Q2j+Ej+EWM7QK4fya3DcEvTjzZzmJcp4NdGxlDBD94l2mt
        g6GUYhkVcOyjTs4ymWgIOWqmBvCEecbQkV3u5B4=
X-Google-Smtp-Source: ABdhPJwhO5z2Pqzn/A0lC0EOrZIbFY6C29RzyDQuoXNnccDtufkc4j26zv5fuWU7sn4h3tucDDcegRuw4YD2Ik0ivj4=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:640e:: with SMTP id
 y14mr15191892ybb.446.1605501343478; Sun, 15 Nov 2020 20:35:43 -0800 (PST)
Date:   Sun, 15 Nov 2020 20:35:32 -0800
In-Reply-To: <20201116043532.4032932-1-ndesaulniers@google.com>
Message-Id: <20201116043532.4032932-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20201116043532.4032932-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH 3/3] powerpc: fix -Wimplicit-fallthrough
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "fallthrough" pseudo-keyword was added as a portable way to denote
intentional fallthrough. Clang will still warn on cases where there is a
fallthrough to an immediate break. Add explicit breaks for those cases.

Link: https://github.com/ClangBuiltLinux/linux/issues/236
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/powerpc/kernel/prom_init.c | 1 +
 arch/powerpc/kernel/uprobes.c   | 1 +
 arch/powerpc/perf/imc-pmu.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 38ae5933d917..e9d4eb6144e1 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -355,6 +355,7 @@ static int __init prom_strtobool(const char *s, bool *res)
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
index d200e7df7167..e8a63713e655 100644
--- a/arch/powerpc/kernel/uprobes.c
+++ b/arch/powerpc/kernel/uprobes.c
@@ -141,6 +141,7 @@ int arch_uprobe_exception_notify(struct notifier_block *self,
 	case DIE_SSTEP:
 		if (uprobe_post_sstep_notifier(regs))
 			return NOTIFY_STOP;
+		break;
 	default:
 		break;
 	}
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 7b25548ec42b..e106909ff9c3 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1500,6 +1500,7 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 		pmu->pmu.stop = trace_imc_event_stop;
 		pmu->pmu.read = trace_imc_event_read;
 		pmu->attr_groups[IMC_FORMAT_ATTR] = &trace_imc_format_group;
+		break;
 	default:
 		break;
 	}
-- 
2.29.2.299.gdc1121823c-goog

