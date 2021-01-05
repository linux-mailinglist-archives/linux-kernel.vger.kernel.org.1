Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459D02EB572
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbhAEWhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:37:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728229AbhAEWhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609886178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EZZnqZ7bOfUDFseawd2jueyjyFb8lfB/zNJXFRgDiL8=;
        b=cj/m0ghMR2+YDQmi5apCOYhZ/9QGIf5qzUr5Kpc1T6UC2mCFkkzfnZ5hET8uRoS7qOW/LW
        ZBliiC7+uvadfwSdV8iKPbD6fswO5U3LJLDAMMt31V96DYWpChAFy9Ik4wjdRt93pKCg3m
        J9gsoCXQU1OfaPuJZvje2KsPCLJq+/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-Bi46ccUIOT6eSv4xnZQ-Pg-1; Tue, 05 Jan 2021 17:36:14 -0500
X-MC-Unique: Bi46ccUIOT6eSv4xnZQ-Pg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06EF515720;
        Tue,  5 Jan 2021 22:36:13 +0000 (UTC)
Received: from ovpn-115-104.rdu2.redhat.com (ovpn-115-104.rdu2.redhat.com [10.10.115.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C44760BE5;
        Tue,  5 Jan 2021 22:36:12 +0000 (UTC)
Message-ID: <09f87692f844cdaac5b13a7b4ba25e658559f517.camel@redhat.com>
Subject: Power9 NV linux-next random process hang
From:   Qian Cai <qcai@redhat.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Date:   Tue, 05 Jan 2021 17:36:11 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.config: https://cailca.coding.net/public/linux/mm/git/files/master/powerpc.config

Today's linux-next starts to generate random process hang quite easily.
Yesterday's build seems work fine. Sometimes, the process stack seems corrupt
while the process is running 100% CPU with gdb shows it just entered a
subroutine that really can't see why it hangs.

[ 6732.309621][T11627] task:ranbug          state:R  running task     stack:24176 pid: 2893 ppid:  2867 flags:0x00040000 
[ 6732.309779][T11627] Call Trace: 
[ 6732.309826][T11627] [c00000006166fa30] [c00000006166fb60] 0xc00000006166fb60 (unreliable) 

Also, running LTP syscalls ended up hanging with lots of zombie process. Any idea?

root        2023  0.0  0.0      0     0 ?        Zs   14:10   0:00 [login] <defunct>
root       52052  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [recv01] <defunct>
root       52054  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [recvfrom01] <defunct>
root       52056  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [recvmsg01] <defunct>
root       52155  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [rt_sigtimedwait] <defunct>
root       52305  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [semctl01] <defunct>
root       52362  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [send01] <defunct>
root       52386  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [sendfile04] <defunct>
root       52387  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [sendfile04] <defunct>
root       52388  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [sendfile04] <defunct>
root       52389  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [sendfile04] <defunct>
root       52390  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [sendfile04] <defunct>
root       52392  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [sendfile04_64] <defunct>
root       52393  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [sendfile04_64] <defunct>
root       52394  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [sendfile04_64] <defunct>
root       52395  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [sendfile04_64] <defunct>
root       52396  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [sendfile04_64] <defunct>
root       52398  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [sendfile05] <defunct>
root       52400  0.0  0.0      0     0 pts/0    Z    15:03   0:00 [sendfile05_64] <defunct>
root       52415  0.0  0.0      0     0 pts/0    Z    15:04   0:00 [sendmsg01] <defunct>
root       53470  0.0  0.0      0     0 pts/0    Z    15:04   0:00 [sendto01] <defunct>
root       53763  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53764  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53765  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53766  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53767  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53768  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53769  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53770  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53771  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53772  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53773  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53774  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53775  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53776  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53777  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53778  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53779  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53780  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
root       53782  0.0  0.0      0     0 pts/0    Z    15:06   0:00 [setrlimit01] <defunct>
nobody     54290  0.0  0.0      0     0 pts/0    Z    15:07   0:00 [sysctl03] <defunct>
root       56813  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56814  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56815  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56816  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56817  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56818  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56819  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56820  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56821  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56822  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56823  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56825  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56826  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56827  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56828  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56829  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56830  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56831  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56832  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56833  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56834  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56835  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56836  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid03] <defunct>
root       56838  0.0  0.0      0     0 pts/0    Z    16:09   0:00 [waitpid04] <defunct>
sshd       58675  0.0  0.0      0     0 ?        Z    17:21   0:00 [sshd] <defunct>

