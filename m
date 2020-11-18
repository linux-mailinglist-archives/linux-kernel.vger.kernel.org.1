Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D83A2B72DF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 01:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgKRAII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 19:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgKRAIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 19:08:07 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE26C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:08:07 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id t141so173641qke.22
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C4I5cnBVqMLHEBaHI22ejtAYmddqM1FCT8jQvlcDxTA=;
        b=i2Z+6bK8sQT/LD35GZCjASBYHSNR71pjgf/dFX2mj+wejv4WQZSV8dXYopDAEnbyLV
         tP9lwzf/d8Axb7WQqrDftInZoBU3+Z1VHg1kYdeoeC4d7Y4cgYLI/V/d4PsC7t/wWP93
         mn/nAxWmcy85p/gzi5kOs0+z0+oMnDDtWRudfayWjXVBh2lRECTqzf0Fy91ISZPopgDm
         MQYtDYRYUIxg3md+IXfbs9vMgD6GJ35lk5ZGEZylLtiRXdlqBfnpfN8C65INtDLOwKHI
         bHiCcKhjbOKexN/kP0/8Y2lKFwcbf2KgFSCXBCxLG6oox2QQSHTaacfa4RYo2T8yL5Z7
         qwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C4I5cnBVqMLHEBaHI22ejtAYmddqM1FCT8jQvlcDxTA=;
        b=uAttqgcUZLiiMSFVArGVfvx3o0kUHgNHbeh5a5oN8oauZJfjLdkDe4H/EHZxLC8D0y
         2cpNUsysjsVSxi0OEJy1hf5bum0W/UPRfbQC9myX2SljdGmXLmrWuX5/MiuA7yrgqsKl
         Z71GhgCzQvZW0D0I96uai+JlyT3ztksWtjjtIvB3kBdeuD8FhXMao9/fLFwFYh40gnjz
         zrn7uabDizk7gCdzZ1JEpUV8lgytNKpTP8a8YNRnSEvI+gPjim5d6Ql5sjrJcl4XcC0x
         aFAnBBQQZonwPtBuhOlvVLEqisfYjBtKLdTXjfpIb3QfbbySdGefSiVuW6cN0C/8HVft
         Brhg==
X-Gm-Message-State: AOAM531YXnH3cQ8QTCh7v3es3ShPz8c2Sn+QLcO2PyysWiwI4DvZYhPc
        uJnlsdr5roVukemvhPvi1P4fHtaD/cdOipoKmhs=
X-Google-Smtp-Source: ABdhPJws0sTD/WzUblHs71JHfu9LRYWbxQILKXAAf4F1fOuoGSfcfleh5j1il/JmAjvv7ZyhxRfoYbuU1EOTAOVUu7c=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:44b3:: with SMTP id
 n19mr1968835qvt.56.1605658086294; Tue, 17 Nov 2020 16:08:06 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:07:51 -0800
In-Reply-To: <20201118000751.845172-1-ndesaulniers@google.com>
Message-Id: <20201118000751.845172-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20201118000751.845172-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2 3/3] powerpc: fix -Wimplicit-fallthrough
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "fallthrough" pseudo-keyword was added as a portable way to denote
intentional fallthrough. Clang will still warn on cases where there is a
fallthrough to an immediate break. Add explicit breaks for those cases.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://github.com/ClangBuiltLinux/linux/issues/236
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

