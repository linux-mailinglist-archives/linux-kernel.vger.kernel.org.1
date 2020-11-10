Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA122ADF3E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbgKJTZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:25:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgKJTZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605036299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ds3e9bS6ZeLi4u5M03RjJgR+Da9+CJW2m9R0n+4X5pU=;
        b=iongoN7FF3DZ8kYLSsUS9Lgn4GBDG1ymvLt+pPkW5Euh7pjEGRAUreuHCWlvBA5kNjMOfR
        kUokA0FweulFb/hPluhb+sMWCpOXWOLypa1awgKFOtjBrZMblq6LaHBg7VuNkYHs6wjbOq
        8nGN0sJTog+6m0REjuXe4Do/4+2b3FI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-4ys4B_J1MHuCOskkY1vwDg-1; Tue, 10 Nov 2020 14:24:54 -0500
X-MC-Unique: 4ys4B_J1MHuCOskkY1vwDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 789FF100747A;
        Tue, 10 Nov 2020 19:24:52 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 320865B4CF;
        Tue, 10 Nov 2020 19:24:44 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
Subject: "irq 4: Affinity broken due to vector space exhaustion." warning on
 restart of ttyS0 console
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <maz@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Peter Xu <peterx@redhat.com>
Message-ID: <3ba26c8d-04ac-1822-d5c2-4a8906f7fd9a@redhat.com>
Date:   Tue, 10 Nov 2020 14:24:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Occasionally when logging out of the ttyS0 aka serial console I see that

	irq 4: Affinity broken due to vector space exhaustion.

is output to the console.

At boot the default smp_affinity is

/proc/irq/4/smp_affinity:000000ff,ffff0000,00ffffff

The irqbalance service runs and can change this value.  Depending on system load
and behaviour, the IRQ can be assigned to a cpu on socket 1 and the smp_affinity
is changed to socket 1.  In that case,

/proc/irq/4/smp_affinity:ffffff00,0000ffff,ff000000

When the user logs out of the serial console, the console is shut down and IRQ
is free'd.  The IRQ is immediately reacquired by the serial console when it
starts up again.

For example,

Red Hat Enterprise Linux 8.4 Beta (Ootpa)
Kernel 5.10.0-rc2+ on an x86_64

HOSTNAME: intel-whitley-07.khw1.lab.eng.bos.redhat.com
Activate the web console with: systemctl enable --now cockpit.socket

intel-whitley-07 login: root
Password:

Last login: Mon Nov  9 19:13:33 on ttyS0
[07:25 PM root@intel-whitley-07 ~]# exit

*** console shutdown, IRQ released for cpu on socket 1
*** console starts back up again, IRQ assigned to on cpu on socket 0

In this process, however, the smp_affinity is not cleared for IRQ4.  That is, it
remains as

/proc/irq/4/smp_affinity:ffffff00,0000ffff,ff000000

so that the check in activate_reserved() fails and

"irq 4: Affinity broken due to vector space exhaustion."

is output to the screen.

I am not sure of correct fix here.  It looks like the smp_affinity should be
reset to default at irq shutdown, however, I cannot determine if that should be
done for every IRQ, or (hopefully not) per driver.

Can anyone offer guidance on a fix?

P.

