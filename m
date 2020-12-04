Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21E22CE470
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 01:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgLDAZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 19:25:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726356AbgLDAZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607041429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=du/u2v1/DxvufjA15mfH4Eua6kZGexaeRkZxBRj4seA=;
        b=DkXOoc8Zq/k+XAjigqpmZeJ71GCTHUsqQmPHPSrz5QvPqmtgO29S8uNxG9s+lfWmkQerlJ
        /TMzgKZVQjzNoGh0IeBiT21W0XsFy1/W1hbjPKt3NxUhh5AdLLV+LIOLSl7ensxC0mH5rD
        ROsWGrfORUylZu5+A/iYhq8810Q36XQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-Xui1FmsmNcqUjPJDcRvZiw-1; Thu, 03 Dec 2020 19:23:45 -0500
X-MC-Unique: Xui1FmsmNcqUjPJDcRvZiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F6DBA0C04;
        Fri,  4 Dec 2020 00:23:43 +0000 (UTC)
Received: from ovpn-112-36.rdu2.redhat.com (ovpn-112-36.rdu2.redhat.com [10.10.112.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BDEF60861;
        Fri,  4 Dec 2020 00:23:34 +0000 (UTC)
Message-ID: <e17c3fb24cdad2fec1dc10da5ef6f5e37cfe7c03.camel@redhat.com>
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU
 hotplug cooperative
From:   Qian Cai <qcai@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Date:   Thu, 03 Dec 2020 19:23:33 -0500
In-Reply-To: <jhjpn4bwznx.mognet@arm.com>
References: <20201023101158.088940906@infradead.org>
         <20201023102347.067278757@infradead.org>
         <ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com>
         <jhjpn4bwznx.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, it did crash on arm64 (Thunder X2) as well, so I'll re-run to gather more
information too.

.config: https://cailca.coding.net/public/linux/mm/git/files/master/arm64.config

[20370.682747][T77637] psci: CPU123 killed (polled 0 ms) 
[20370.823651][  T635] IRQ 43: no longer affine to CPU124 
[20370.828862][  T635] IRQ 49: no longer affine to CPU124 
[20370.834072][  T635] IRQ 60: no longer affine to CPU124 
[20370.839517][  T635] IRQ 94: no longer affine to CPU124 
[20370.845778][T77637] CPU124: shutdown 
[20370.861891][T77637] psci: CPU124 killed (polled 10 ms) 
[20371.425434][T77637] CPU125: shutdown 
[20371.441464][T77637] psci: CPU125 killed (polled 10 ms) 
[20371.984072][T77637] CPU126: shutdown 
[20372.000057][T77637] psci: CPU126 killed (polled 10 ms) 
[20372.223858][  T650] ------------[ cut here ]------------ 
[20372.229599][  T650] kernel BUG at kernel/sched/core.c:7594! 
[20372.235165][  T650] Internal error: Oops - BUG: 0 [#1] SMP 
[20372.240643][  T650] Modules linked in: vfio_pci vfio_virqfd vfio_iommu_type1
vfio loop processor ip_tables x_tables sd_mod mlx5_core firmware_class ahci
libahci libata dm_mirror dm_region_hash dm_log dm_mod efivarfs 
[20372.259814][  T650] CPU: 127 PID: 650 Comm: migration/127 Tainted: G             L    5.10.0-rc6-next-20201203+ #5 
[20372.270152][  T650] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.16 07/29/2020 
[20372.280579][  T650] Stopper: multi_cpu_stop+0x0/0x390 <- 0x0 
[20372.286230][  T650] pstate: 20400089 (nzCv daIf +PAN -UAO -TCO BTYPE=--) 
[20372.292923][  T650] pc : sched_cpu_dying+0x198/0x1b8 
[20372.297879][  T650] lr : sched_cpu_dying+0x68/0x1b8 
[20372.302748][  T650] sp : ffff00001076fba0 
[20372.306747][  T650] x29: ffff00001076fba0 x28: 0000000000000000  
[20372.312751][  T650] x27: 0000000000000001 x26: ffff800011db3000  
[20372.318753][  T650] x25: ffff000e7bdd16a8 x24: 000000000000005a  
[20372.324754][  T650] x23: 000000000000007f x22: 0000000000000080  
[20372.330756][  T650] x21: 000000000000fab7 x20: ffff000e7be63818  
[20372.336757][  T650] x19: ffff000e7be63800 x18: 1fffe001cf7cb3ed  
[20372.342758][  T650] x17: 0000000000001308 x16: 0000000000000000  
[20372.348759][  T650] x15: 000000000001053f x14: 000000000001053f  
[20372.354761][  T650] x13: ffff6000020edf65 x12: 1fffe000020edf64  
[20372.360763][  T650] x11: 1fffe000020edf64 x10: ffff6000020edf64  
[20372.366764][  T650] x9 : dfff800000000000 x8 : ffff00001076fb23  
[20372.372766][  T650] x7 : 0000000000000001 x6 : 0000000000000001  
[20372.378767][  T650] x5 : 1fffe000020b9a0a x4 : dfff800000000000  
[20372.384769][  T650] x3 : dfff800000000000 x2 : 0000000000000003  
[20372.390770][  T650] x1 : ffff000e7be63840 x0 : 0000000000000002  
[20372.396771][  T650] Call trace: 
[20372.399905][  T650]  sched_cpu_dying+0x198/0x1b8 
[20372.404514][  T650]  cpuhp_invoke_callback+0x208/0x2bf0 
[20372.409730][  T650]  take_cpu_down+0x11c/0x1f0 
[20372.414165][  T650]  multi_cpu_stop+0x184/0x390 
[20372.418687][  T650]  cpu_stopper_thread+0x1f0/0x430 
[20372.423557][  T650]  smpboot_thread_fn+0x3a8/0x9c8 
[20372.428339][  T650]  kthread+0x3a0/0x448 
[20372.432253][  T650]  ret_from_fork+0x10/0x1c 
[20372.436517][  T650] Code: d65f03c0 911a82a2 140004fb 17ffffd9 (d4210000)  
[20372.443298][  T650] ---[ end trace c51d5b6889ec29a8 ]--- 
[20372.448602][  T650] Kernel panic - not syncing: Oops - BUG: Fatal exception 

