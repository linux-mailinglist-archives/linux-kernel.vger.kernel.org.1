Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F952B7231
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgKQXU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgKQXUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:52 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6216EC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:52 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id a15so112078qvk.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3fHch99jqHexf8ELMflOi+vYlHHWLr5MUIuOKUC+7v8=;
        b=wnFZvyupplTu6/MkWq8GfsCFKvXem5LUAekMD+BUcrc+FOBPknQW99s1zRVuNqfwa8
         0II+ih8ORrG7Bcho8DCooWjQeJctC82cd5KNxwdPiuF6qV3Mh+I0RzJ0Fic4AdCPX1+e
         igWDyrdvxpwRE9TOsfDLWBetS2T5WCrzUrgWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3fHch99jqHexf8ELMflOi+vYlHHWLr5MUIuOKUC+7v8=;
        b=ZWCYXAnEje34qMnHbD78c3yfoDZQ7qpSzfIlUFfekoACntkRKTWMrnaZNTpwm4/TNn
         g7YJgK/pcRxHq7+WopRJ/NVyw1F6x//fyDYECyRFsxbrhONu0K0qXxBe9WzbkgDv5JKm
         HaXloB7Rfz6b9jVcDBd4yE15gu6Wx2JzYxByZPTbvanEG4j3LROoDIRMmK/LjnvwugRm
         WMr7j00/DEYLSOgO5vRIjcuvNzukoXq1V5ZAdrSanrRWnh8ycpDM4Hytyr0ccsj5dUkg
         l3DPKRVtqB95V5jv8WN88RWQacdtN/iTmGGKMhIGtBQyj1D4FtTXAUy2P/MGiFD9LItd
         Clsg==
X-Gm-Message-State: AOAM533rDkFu7x2Wl71/OGeU8zczf5UUembnRpKV7BYp9LoFmgcTaAp1
        ilbQlHd+kZo+1JlIDIJjJnoo/w==
X-Google-Smtp-Source: ABdhPJzJeYfdBhLkfeyuk7SbTCrpszGdD+QalTn87dwi5s0c/r4qhW91eV96k0AHhVo5T14+I7K/fg==
X-Received: by 2002:a05:6214:32f:: with SMTP id j15mr2235450qvu.35.1605655251608;
        Tue, 17 Nov 2020 15:20:51 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:51 -0800 (PST)
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH -tip 20/32] entry/kvm: Protect the kernel when entering from guest
Date:   Tue, 17 Nov 2020 18:19:50 -0500
Message-Id: <20201117232003.3580179-21-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com>

Similar to how user to kernel mode transitions are protected in earlier
patches, protect the entry into kernel from guest mode as well.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/x86/kvm/x86.c        |  2 ++
 include/linux/entry-kvm.h | 12 ++++++++++++
 kernel/entry/kvm.c        | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 447edc0d1d5a..a50be74f70f1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8910,6 +8910,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 */
 	smp_mb__after_srcu_read_unlock();
 
+	kvm_exit_to_guest_mode();
 	/*
 	 * This handles the case where a posted interrupt was
 	 * notified with kvm_vcpu_kick.
@@ -9003,6 +9004,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	kvm_enter_from_guest_mode();
 	local_irq_enable();
 	preempt_enable();
 
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 9b93f8584ff7..67da6dcf442b 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -77,4 +77,16 @@ static inline bool xfer_to_guest_mode_work_pending(void)
 }
 #endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
 
+/**
+ * kvm_enter_from_guest_mode - Hook called just after entering kernel from guest.
+ * Caller should ensure interrupts are off.
+ */
+void kvm_enter_from_guest_mode(void);
+
+/**
+ * kvm_exit_to_guest_mode - Hook called just before entering guest from kernel.
+ * Caller should ensure interrupts are off.
+ */
+void kvm_exit_to_guest_mode(void);
+
 #endif
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 49972ee99aff..3b603e8bd5da 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -50,3 +50,36 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
 	return xfer_to_guest_mode_work(vcpu, ti_work);
 }
 EXPORT_SYMBOL_GPL(xfer_to_guest_mode_handle_work);
+
+/**
+ * kvm_enter_from_guest_mode - Hook called just after entering kernel from guest.
+ * Caller should ensure interrupts are off.
+ */
+void kvm_enter_from_guest_mode(void)
+{
+	if (!entry_kernel_protected())
+		return;
+	sched_core_unsafe_enter();
+}
+EXPORT_SYMBOL_GPL(kvm_enter_from_guest_mode);
+
+/**
+ * kvm_exit_to_guest_mode - Hook called just before entering guest from kernel.
+ * Caller should ensure interrupts are off.
+ */
+void kvm_exit_to_guest_mode(void)
+{
+	if (!entry_kernel_protected())
+		return;
+	sched_core_unsafe_exit();
+
+	/*
+	 * Wait here instead of in xfer_to_guest_mode_handle_work(). The reason
+	 * is because in vcpu_run(), xfer_to_guest_mode_handle_work() is called
+	 * when a vCPU was either runnable or blocked. However, we only care
+	 * about the runnable case (VM entry/exit) which is handled by
+	 * vcpu_enter_guest().
+	 */
+	sched_core_wait_till_safe(XFER_TO_GUEST_MODE_WORK);
+}
+EXPORT_SYMBOL_GPL(kvm_exit_to_guest_mode);
-- 
2.29.2.299.gdc1121823c-goog

