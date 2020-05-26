Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886471ABC13
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 11:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503027AbgDPJDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 05:03:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34310 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503331AbgDPJDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587027796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=FgRMAeZTRnCv/1+3solCzy3IyPcrmkQx0MVaWIgfZRg=;
        b=NfjvQQON+p9lOK+Fg9MJ0jiu7cTq90mMjaMT9vljTTBQhTwAzwP1TT8eOdwJyd6BCUFOr0
        gfdlQ5qhchV2B22g3N2PrSymFTklPs2WxDBpDEvblZjRhLPlfwdAZhhj00g8gbtySLbHhd
        RPizbTlrcNi0qiTuNAG/XXdh4pNtk9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-nEEonNe8NdaVXIcIwAM0lg-1; Thu, 16 Apr 2020 05:03:11 -0400
X-MC-Unique: nEEonNe8NdaVXIcIwAM0lg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2F361408;
        Thu, 16 Apr 2020 09:03:10 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB6ED7E7CD;
        Thu, 16 Apr 2020 09:03:04 +0000 (UTC)
Date:   Thu, 16 Apr 2020 17:02:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     John Garry <john.garry@huawei.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Regression] No IO interrupt is generated before CPU is offline
Message-ID: <20200416090108.GG2723777@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

When I run test script [1] in KVM guest[2], and disk is virtio-scsi,
IO hang can be triggered easily. Most times, it can be reproduced
by running './cpuhotplug_io 400 /dev/sda' once, and sometimes it
needs one more run.

After I checked blk-mq debugfs log, I found these requests have
been queued to virtio-scsi hardware, but interrupts aren't be
generated.

The issue is firstly found when John and I test the patchset[3][4] for
draining IO in cpu hotplug handler before CPU and managed IRQ becomes
shudown. And IOs are found not completed even though the CPU responsible
for dealing with this hw queue is still online, but going to shutdown.

git-bisect shows that the issue is introduced by the following commit:

	60dcaad5736f ("x86/hotplug: Silence APIC and NMI when CPU is dead")


The issue can't be triggered any more after applying the following change:

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 69881b2d446c..c5e9f005fbb2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1596,7 +1596,7 @@ int native_cpu_disable(void)
         * it. It still responds normally to INIT, NMI, SMI, and SIPI
         * messages.
         */
-       apic_soft_disable();
+       clear_local_APIC();
        cpu_disable_common();
 
        return 0;


[1] test script
http://people.redhat.com/minlei/tests/tools/cpuhotplug_io

[2] virtio-scsi is MQ by passing 'num_queues=3' to qemu virtio-scsi
command line, meantime set cpu number as 8, so one queue can be covered
by more than one CPU

[3] https://lore.kernel.org/linux-block/20200407092901.314228-5-ming.lei@redhat.com/

[4] latest patches for stop & drain IO before shutdown irq/cpu
https://github.com/ming1/linux/commits/v5.6-blk-mq-improve-cpu-hotplug



Thanks,
Ming

