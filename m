Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE522EA9F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 12:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbhAELfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 06:35:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56800 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbhAELfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 06:35:00 -0500
Received: from zn.tnic (p200300ec2f103700516ef90d43f797fe.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:3700:516e:f90d:43f7:97fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A43621EC04DA;
        Tue,  5 Jan 2021 12:34:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609846458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=mcd0GnZTD7yKf4o7AZcBYWHV/EbCroJoKxi9hFfxfRE=;
        b=rgpf0HazWbHimvwacITVcTMQbPZmKZYzLw/ntJvoEETDQRNnP6h4WOo6xlgdTIrYy7dia0
        58GmNS8PYHhwz5ooueRggw6tgXlX16Qxz5E8LQJNjOJk+Wh00nWJmbKypEuKWwAbJnO4Ks
        AFs9VJpeO2uaxZdy1mh0U1UuIzvqHH8=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rafael Kitover <rkitover@gmail.com>,
        Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Subject: [RFC PATCH] x86/cpu: Do not check c->initialized in topology_phys_to_logical_die()
Date:   Tue,  5 Jan 2021 12:34:14 +0100
Message-Id: <20210105113414.3277-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

During boot, identify_secondary_cpu() calls at some point
validate_apic_and_package_id() which calls topology_update_die_map() to
update/verify the physical to logical DIE map of the CPUs on the system.

There's a call down that path to topology_phys_to_logical_die() which
maps a physical die to a logical one. The check in there looks at
cpuinfo_x86.initialized first before comparing die_ids and proc_ids.

And this is where the problem lies: both ->cpu_die_id and ->phys_proc_id
have been initialized as part of the identify_secondary_cpu() dance -
just the cpuinfo_x86.initialized thing hasn't been set yet (it gets set
as the last thing in smp_store_cpu_info()).

So what that means is that initialized fields are being compared but the
initialized flag says they're not, leading to:

  smpboot: topology_phys_to_logical_die: init: 1, cpu 7, cur_cpu: 8, cpu_die_id: 0, die_id: 2, phys_proc_id: 0, proc_id: 0, logical_die_id: 0
  smpboot: topology_phys_to_logical_die: init: 0, cpu 8, cur_cpu: 8, cpu_die_id: 2, die_id: 2, phys_proc_id: 0, proc_id: 0, logical_die_id: 0
  ...
  smpboot: topology_phys_to_logical_die: init: 0, cpu 127, cur_cpu: 8, cpu_die_id: 0, die_id: 2, phys_proc_id: 0, proc_id: 0, logical_die_id: 0
  smpboot: CPU 8 Converting physical 2 to logical die 1

On CPU8 and all the way up to all possible_cpus, boot_cpu_data is not
initialized yet even though

  cpu_die_id == die_id
&&
  phys_proc_id == proc_id

for that CPU 8.

As a result, topology_update_die_map() increments logical_die which gets
written into cpuinfo_x86.logical_die_id of that CPU.

Later, in the RAPL code, that logical_die_id is outside of the range of
maximum dies present on the system:

  int maxdie = topology_max_packages() * topology_max_die_per_package();

which leads to indexing into the rapl_pmus->pmus[] array out of bounds.
Boom.

Thus, drop the c->initialized check because the values it should protect
against checking, have been actually already initialized. (Yes, our boot
order is fragile. :-\).

Reported-by: Rafael Kitover <rkitover@gmail.com>
Reported-by: Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=210939
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8ca66af96a54..56d2ac8c54ab 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -319,7 +319,7 @@ int topology_phys_to_logical_die(unsigned int die_id, unsigned int cur_cpu)
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-		if (c->initialized && c->cpu_die_id == die_id &&
+		if (c->cpu_die_id == die_id &&
 		    c->phys_proc_id == proc_id)
 			return c->logical_die_id;
 	}
-- 
2.29.2

