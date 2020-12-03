Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822672CE03F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 21:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbgLCU5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 15:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387560AbgLCU5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:57:13 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55E6C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 12:56:26 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id hg11so1946985pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 12:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=S5ra3fFtwyrR4DBSDAkXB7bmFSTJjJvoJm1aScqSvD8=;
        b=LBTW4G1yq8Tlr8j60sdrqz5HWAARs1V+8aIMhV3V5AQLPx6JTlpixUJ5GfUFelcDwW
         wXHs1SeZdVZXtuID6Oekg9t3XeAP4+ILetytMukbpIbSjcIGt0KpUh7r5ihOA7uYlvcY
         jnb7iYbl4p7UsgRbX5OuBqAKSmm0x4WiiStX7RazsIyIWOfnXG6avJc44OEP48/9R/FI
         WHXpHTzUZKF35lQZHHryI4l7Up3rMNW6Rhz+YFgAY6Pf/AKrOYpY0k3maORqmuMNkB+9
         UeqK8C2XVnlf+XLCKB7Zfa+8p68DYcRLpmc5CQKVcQ53zzlquK/3bKdiJjp8cunqIhUt
         UYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=S5ra3fFtwyrR4DBSDAkXB7bmFSTJjJvoJm1aScqSvD8=;
        b=kSmqjqV2QDdzX4Vj/BH2HC/XZ344FLMKA5GQtu3vY7htSt7UNkXeplin9J9UtBKkzg
         VcX+Ai5Rpo7JRJyn0F+NnnQRK/eFizXy6WPDaQ0DODgeZg18Z2n75fOjDkHWbkTNVL2t
         zQyZB7z2kwZNYihqZxOeH0dNtRT4vRYwm0cF1bilmEeSKV7HKnm1ZQ3Dlt/0FsLq2cVQ
         OAOwH4/37bWh3X4dO5Se107IHeUG0aG0AXxc0E0Vy0xDX+SJOEHW3X9GhwcQMlVTi3VP
         GlTNKZW4zLia/HdEmIcv2vd7E/3Ae8zHiR1o+AAxYt3oy3+zdYwQAgogCebhi4iomw2Y
         bTUg==
X-Gm-Message-State: AOAM53253Mp8YJeknuou0U1m/SK7xeXX+1SRZubTnueu7TEQ0kcOCcqp
        6qILy4jjvAMtl1xEGnK6Jtlf5ZkpOa8Uqg==
X-Google-Smtp-Source: ABdhPJwsY5PNMZvpoZhrIaqeJ0b9FPlsxwsCuhz3fm3arOdqksu0Bt1ad3hJMyJCA0wd5j0AzpgGDqTjitcjcg==
Sender: "jacobhxu via sendmgr" <jacobhxu@mhmmm.sea.corp.google.com>
X-Received: from mhmmm.sea.corp.google.com ([2620:15c:100:202:f693:9fff:feef:a9a1])
 (user=jacobhxu job=sendmgr) by 2002:a17:90a:bc0a:: with SMTP id
 w10mr847025pjr.79.1607028986454; Thu, 03 Dec 2020 12:56:26 -0800 (PST)
Date:   Thu,  3 Dec 2020 12:56:19 -0800
Message-Id: <20201203205619.1776417-1-jacobhxu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] kvm: svm: de-allocate svm_cpu_data for all cpus in svm_cpu_uninit()
From:   Jacob Xu <jacobhxu@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacob Xu <jacobhxu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu arg for svm_cpu_uninit() was previously ignored resulting in the
per cpu structure svm_cpu_data not being de-allocated for all cpus.

Signed-off-by: Jacob Xu <jacobhxu@google.com>
---
 arch/x86/kvm/svm/svm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 79b3a564f1c9..da7eb4aaf44f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -530,12 +530,12 @@ static int svm_hardware_enable(void)
 
 static void svm_cpu_uninit(int cpu)
 {
-	struct svm_cpu_data *sd = per_cpu(svm_data, raw_smp_processor_id());
+	struct svm_cpu_data *sd = per_cpu(svm_data, cpu);
 
 	if (!sd)
 		return;
 
-	per_cpu(svm_data, raw_smp_processor_id()) = NULL;
+	per_cpu(svm_data, cpu) = NULL;
 	kfree(sd->sev_vmcbs);
 	__free_page(sd->save_area);
 	kfree(sd);
-- 
2.29.2.576.ga3fc446d84-goog

