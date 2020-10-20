Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AB62932D8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390276AbgJTBon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390144AbgJTBoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:32 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC5CC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:31 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id g7so274539ilr.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJ13MDUW9MMRHtOkQofTGOGJvsIORCj9T6F6FUaxXLo=;
        b=JLCE90v77jdAP9mhtr4peUNu8gOJ9stLjdHuV31ZS829hr1WrHdIgutHp9sOVdXx+R
         FnWE/UOea3zPuP0ZrLSqD2a6h5OueQVZSCgYEmdDa5SSrbKAHzCT2NvBMP8WLaZ8mB2p
         tGt+6b91KJ4dXP/B4FHUMR0PEQ2MQasYbip2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJ13MDUW9MMRHtOkQofTGOGJvsIORCj9T6F6FUaxXLo=;
        b=RKl++QZB0m+64WfSWQ2B8lbrNkas8zkkiO/FujV+4CGlnnKEy8eUEdqsY9SG3y3Yqj
         z4A6HJS4/0gWJfRD41VLoI9eFXSR1qYUNlpz/xnLvJyIaUDFF2hb2bm4VV45z0zkT03d
         YbZqVwl+ajSTLaRa4mQNUtLNLa9KH9ffH3IlUhY6GEApCVpQFX1a9ffdAqPksQqpxxyX
         iCDe6/UZy7QzTTYKV22WMxL4syLsqgCUqPd5wi/8oTwGPzIy4TDokr0q0Zyw8ycesymE
         mhASViNkIwh0lct1AXgZIe4inYPtvv7WTm5ydggHoPKs8bfxYHnZzuwI8SLHdO7Oh2UM
         87fw==
X-Gm-Message-State: AOAM530q8HLJtL5FObhOFPNitkGV982C+6ZIigxAMdaZ9Ey2Tjmb9FmN
        Fc8fVNIsrU30IM1DG+Y0eGGCAw==
X-Google-Smtp-Source: ABdhPJyDsM1n4Gw3V8mUt9nHaMxq7KUSTKQTERNB+dQLwYx+pGeZqjyoLTfYooR7jrChc7yXAaKfvw==
X-Received: by 2002:a92:ce45:: with SMTP id a5mr236844ilr.308.1603158270689;
        Mon, 19 Oct 2020 18:44:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:30 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 15/26] entry/kvm: Protect the kernel when entering from guest
Date:   Mon, 19 Oct 2020 21:43:25 -0400
Message-Id: <20201020014336.2076526-16-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com>

Similar to how user to kernel mode transitions are protected in earlier
patches, protect the entry into kernel from guest mode as well.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 arch/x86/kvm/x86.c        |  3 +++
 include/linux/entry-kvm.h | 12 ++++++++++++
 kernel/entry/kvm.c        | 13 +++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ce856e0ece84..05a281f3ef28 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8540,6 +8540,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 */
 	smp_mb__after_srcu_read_unlock();
 
+	kvm_exit_to_guest_mode(vcpu);
+
 	/*
 	 * This handles the case where a posted interrupt was
 	 * notified with kvm_vcpu_kick.
@@ -8633,6 +8635,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	kvm_enter_from_guest_mode(vcpu);
 	local_irq_enable();
 	preempt_enable();
 
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 0cef17afb41a..32aabb7f3e6d 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -77,4 +77,16 @@ static inline bool xfer_to_guest_mode_work_pending(void)
 }
 #endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
 
+/**
+ * kvm_enter_from_guest_mode - Hook called just after entering kernel from guest.
+ * @vcpu:   Pointer to the current VCPU data
+ */
+void kvm_enter_from_guest_mode(struct kvm_vcpu *vcpu);
+
+/**
+ * kvm_exit_to_guest_mode - Hook called just before entering guest from kernel.
+ * @vcpu:   Pointer to the current VCPU data
+ */
+void kvm_exit_to_guest_mode(struct kvm_vcpu *vcpu);
+
 #endif
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index eb1a8a4c867c..b0b7facf4374 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -49,3 +49,16 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
 	return xfer_to_guest_mode_work(vcpu, ti_work);
 }
 EXPORT_SYMBOL_GPL(xfer_to_guest_mode_handle_work);
+
+void kvm_enter_from_guest_mode(struct kvm_vcpu *vcpu)
+{
+	sched_core_unsafe_enter();
+}
+EXPORT_SYMBOL_GPL(kvm_enter_from_guest_mode);
+
+void kvm_exit_to_guest_mode(struct kvm_vcpu *vcpu)
+{
+	sched_core_unsafe_exit();
+	sched_core_wait_till_safe(XFER_TO_GUEST_MODE_WORK);
+}
+EXPORT_SYMBOL_GPL(kvm_exit_to_guest_mode);
-- 
2.29.0.rc1.297.gfa9743e501-goog

