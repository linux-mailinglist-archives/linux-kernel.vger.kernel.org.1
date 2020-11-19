Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFB42B973E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgKSQCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:02:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727762AbgKSQCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605801728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=gfcSfWuzLrD9SijmafEfAdUeDPupEiDhjQNw30FxyxU=;
        b=MjVyncsQ2xGjSJE9tjKcQuqAl7wDRDdPArrRvK6NOHX4sVCZdEFWLogAHDU+yY9ZpEPkzU
        eeQ3Lii7OehV+2+bFuPPQ9Ve7GJBJekF80YHCoh/6cVRua/82mI6I/SbcmCF8tMH82xUv/
        wkzQiNXfQNqrLU5aib17w8WsCuJLvSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-eDEA2GMSMfCin-lOUXq_wg-1; Thu, 19 Nov 2020 11:02:05 -0500
X-MC-Unique: eDEA2GMSMfCin-lOUXq_wg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EECF1842140;
        Thu, 19 Nov 2020 16:02:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.164])
        by smtp.corp.redhat.com (Postfix) with SMTP id 455415D6AC;
        Thu, 19 Nov 2020 16:01:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 19 Nov 2020 17:02:02 +0100 (CET)
Date:   Thu, 19 Nov 2020 17:01:54 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] powerpc/ptrace: Hard wire PT_SOFTE value to 1 in
 gpr_get() too
Message-ID: <20201119160154.GA5183@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can we finally fix this problem? ;)

My previous attempt was ignored, see

	https://lore.kernel.org/lkml/20190917121256.GA8659@redhat.com/

Now that gpr_get() was changed to use membuf API we can make a simpler fix.

Sorry, uncompiled/untested, I don't have a ppc machine.

Oleg.

 arch/powerpc/kernel/ptrace/ptrace-tm.c   | 21 ++++++++++++---------
 arch/powerpc/kernel/ptrace/ptrace-view.c | 21 ++++++++++++---------
 include/linux/regset.h                   | 12 ++++++++++++
 3 files changed, 36 insertions(+), 18 deletions(-)

