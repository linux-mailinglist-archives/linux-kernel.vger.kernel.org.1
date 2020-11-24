Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C632C2894
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388560AbgKXNox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:44:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34843 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387958AbgKXNo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:44:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id r18so7289822ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 05:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3kc1wXa18BDFunWKfOTVH49kwkIDZe5FcAUUmoO1ss=;
        b=UEG/4ExMq2+VrigU8nz8w5D06sEHdPEikvj6JATzPuA9T6q97kdZee40NhDCw557Oo
         lrzJK+q5xSH6eguqEO7LZK62kUbs8DdhUxBp1itIkUzBghmkXQiPkfjkqOTETdwm0axd
         pQObxd1zbYOkTbdCLjHrmtLqppU0S1M/4GeZ4zbxlwVjI/lPCGDjv9E5+DjAX/cWzGor
         WYhL4PjbaLLEcfkO37fpCowqOyW/j/2NuduxBlgI2+FwWCe3F0/NYroFuwTgdy78OO8E
         JTLQknlYhqMeAwZ/OgIrjbWlm6XICmcK2DOP689dw5jnjKL8pBWJrYmYFy5bnTrybG6Q
         bM4A==
X-Gm-Message-State: AOAM531F+QX3SCn3sqLDFg/v0Auzf1V48sqnpR777ULvU8xvZl/n6n9O
        lLXPTHS+eJOvCaq/CBmi3Fs=
X-Google-Smtp-Source: ABdhPJzVi1v2lHsckFXBOFxn/v30wn5xFmw4vU3BplxG3XuhsHqIxZ1rMHEmbVjjhf1q3sKNhNrY3A==
X-Received: by 2002:a2e:544e:: with SMTP id y14mr1993474ljd.9.1606225467228;
        Tue, 24 Nov 2020 05:44:27 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x9sm1737310lfg.93.2020.11.24.05.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 05:44:26 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1khYcY-0000i9-B2; Tue, 24 Nov 2020 14:44:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] x86/apic: Fix CPU devicetree-node lookups
Date:   Tue, 24 Nov 2020 14:42:47 +0100
Message-Id: <20201124134247.2668-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix CPU devicetree-node lookups by implementing
arch_match_cpu_phys_id().

This allows using of_get_cpu_node() and of_cpu_device_node_get() to look
up CPU devicetree nodes and specifically makes sure that CPU struct
devices are linked to the correct devicetree nodes.

Note that CPUs are described in devicetree using their APIC ids and
that those do not generally coincide with the logical ids (e.g. used by
the default arch_match_cpu_phys_id() implementation).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/x86/kernel/apic/apic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b3eef1d5c903..19c0119892dd 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2311,6 +2311,11 @@ static int cpuid_to_apicid[] = {
 	[0 ... NR_CPUS - 1] = -1,
 };
 
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+	return phys_id == cpuid_to_apicid[cpu];
+}
+
 #ifdef CONFIG_SMP
 /**
  * apic_id_is_primary_thread - Check whether APIC ID belongs to a primary thread
-- 
2.26.2

