Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA3D2EE7BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbhAGVnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:43:31 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:30855 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbhAGVna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610055577;
        s=strato-dkim-0002; d=hypervisor.org;
        h=Message-ID:Subject:To:From:Date:From:Subject:Sender;
        bh=A86rKVckePq/Tp1JC9QmcGhKMBeceNIQ3Z3HXyDS7r0=;
        b=m/1zsXLT/82lLWQ10wqReSYUvpOwe2j5DXeK+woW3dZKiONDpWZGQkmtUQyRa8mTV3
        jSgUa4rt0Qg6t/WsV/YOpeIgWJPRHn7S8XmCUOxrrXiPUGpRO7T8kHO7XfjGCvKWBfbf
        UrJ3lr4+OaaLnz5z+Ot+PxSeJmf2NxGsRcBm6Q78wazVhI6puoKH5K3ljq9JKV8LGsKm
        +siPtHHPrM883d+owOKg5UqdSBQ/I29RJueQv+MOuZ6cMdZ5AiNfyW2X0FISE20vmH9H
        iyIVW2mmRx5Qy6YMBsH9W3nhFZ7HIBPA1Flx02LsApCtM6M0Es0vp5QuCrekx27l0w4s
        IqjA==
X-RZG-AUTH: ":OWgLVUixa/orYEjgByCmMbha6U0z53RZBchi0p8VsT1fAA5ylDfDuy2BlqsdF5Rpv7WUuLw="
X-RZG-CLASS-ID: mo00
Received: from X220.hypervisor.org
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id L0973bx07LZg8vi
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
        for <linux-kernel@vger.kernel.org>;
        Thu, 7 Jan 2021 22:35:42 +0100 (CET)
Date:   Thu, 7 Jan 2021 22:35:41 +0100
From:   Udo Steinberg <udo@hypervisor.org>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: Linux 5.10.5 hung task
Message-ID: <20210107223541.2d03619c@X220.hypervisor.org>
X-Mailer: X-Mailer 5.0 Gold
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

(Please CC: me as I'm not subscribed to LKML)

I'm getting frequent hangs under X11 with Linux 5.10.5 on a Lenovo X1 Carbon
6th Gen laptop with Intel KBL graphics.

Below is a trace of what hangs.

Any pointers for how to debug this further or any patches are appreciated.

Thanks,
Udo

[ 2602.016651] INFO: task kworker/3:1H:373 blocked for more than 20 seconds.
[ 2602.016653]       Not tainted 5.10.5 #1
[ 2602.016653] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2602.016654] task:kworker/3:1H    state:D stack:    0 pid:  373 ppid:     2 flags:0x00004000
[ 2602.016659] Workqueue: events_highpri intel_atomic_cleanup_work
[ 2602.016660] Call Trace:
[ 2602.016663]  __schedule+0x1d7/0x520
[ 2602.016665]  schedule+0x40/0xe0
[ 2602.016666]  schedule_preempt_disabled+0xf/0x20
[ 2602.016667]  __ww_mutex_lock.constprop.0+0x4a3/0x830
[ 2602.016668]  ? acpi_idle_do_entry+0x50/0x50
[ 2602.016669]  intel_unpin_fb_vma+0x20/0xa0
[ 2602.016672]  drm_atomic_helper_cleanup_planes+0x4a/0x60
[ 2602.016673]  intel_atomic_cleanup_work+0x54/0x100
[ 2602.016675]  process_one_work+0x1a8/0x2f0
[ 2602.016676]  ? rescuer_thread+0x410/0x410
[ 2602.016677]  worker_thread+0x48/0x3d0
[ 2602.016678]  ? rescuer_thread+0x410/0x410
[ 2602.016679]  kthread+0x136/0x160
[ 2602.016681]  ? __kthread_bind_mask+0x60/0x60
[ 2602.016682]  ret_from_fork+0x1f/0x30
[ 2622.496742] INFO: task kworker/3:1H:373 blocked for more than 40 seconds.
[ 2622.496744]       Not tainted 5.10.5 #1
[ 2622.496744] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2622.496745] task:kworker/3:1H    state:D stack:    0 pid:  373 ppid:     2 flags:0x00004000
[ 2622.496750] Workqueue: events_highpri intel_atomic_cleanup_work
[ 2622.496751] Call Trace:
[ 2622.496754]  __schedule+0x1d7/0x520
[ 2622.496756]  schedule+0x40/0xe0
[ 2622.496757]  schedule_preempt_disabled+0xf/0x20
[ 2622.496758]  __ww_mutex_lock.constprop.0+0x4a3/0x830
[ 2622.496759]  ? acpi_idle_do_entry+0x50/0x50
[ 2622.496760]  intel_unpin_fb_vma+0x20/0xa0
[ 2622.496763]  drm_atomic_helper_cleanup_planes+0x4a/0x60
[ 2622.496764]  intel_atomic_cleanup_work+0x54/0x100
[ 2622.496766]  process_one_work+0x1a8/0x2f0
[ 2622.496767]  ? rescuer_thread+0x410/0x410
[ 2622.496768]  worker_thread+0x48/0x3d0
[ 2622.496769]  ? rescuer_thread+0x410/0x410
[ 2622.496771]  kthread+0x136/0x160
[ 2622.496772]  ? __kthread_bind_mask+0x60/0x60
[ 2622.496773]  ret_from_fork+0x1f/0x30
