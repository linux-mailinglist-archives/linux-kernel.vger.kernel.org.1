Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BC42A4D73
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgKCRrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:47:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727706AbgKCRrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604425674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WgRi4ilnni8Y9F1p1LpA7qgU7oPkykAPZ77JfJ1gB88=;
        b=JydzMmaQMY1j/c8CgWv0wXl/qNl6bcHdDG638ak0TVRKlqyggnku3X+moG/d83qYvtNVlb
        xYBXAKsbyQIZxxQN2uEuPWdh9zvEWXrL0k+lgYOkqXW3cVpAW/fivYHxLw0Wp/xd4lP4vy
        5EnIXKiv5VI2cAxaLDpu5pdRY+GY7x0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-ZxEiFgO3O8KveyTxj8puLg-1; Tue, 03 Nov 2020 12:47:50 -0500
X-MC-Unique: ZxEiFgO3O8KveyTxj8puLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C10F7186DD33;
        Tue,  3 Nov 2020 17:47:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4B5876CE53;
        Tue,  3 Nov 2020 17:47:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Nov 2020 18:47:48 +0100 (CET)
Date:   Tue, 3 Nov 2020 18:47:44 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mark Mossberg <mark.mossberg@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jannh@google.com, kyin@redhat.com
Subject: Re: [PATCH v2] x86/dumpstack: Fix misleading instruction pointer
 error message
Message-ID: <20201103174744.GB23992@redhat.com>
References: <20201002042915.403558-1-mark.mossberg@gmail.com>
 <20201103125034.GA30391@redhat.com>
 <20201103171537.GC4111@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103171537.GC4111@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03, Borislav Petkov wrote:
>
> On Tue, Nov 03, 2020 at 01:50:34PM +0100, Oleg Nesterov wrote:
> > Another problem is that show_opcodes() makes no sense if user_mode(regs)
> > and tsk is not current.
>
> Because if not current, we would access *some* user address space but
> not the one to which regs belong to?

Yes, because if not current, copy_from_user() will access the current's
user address space at address = foreign process's regs->ip.

> > Try "echo t > /proc/sysrq-trigger".
>
> What am I looking for?
>
> I see a bunch of:
>
> [   37.622896] Code: Unable to access opcode bytes at RIP <user address>

this means that foreign_regs->ip is not mmapped,

> and three Code: lines with opcode bytes, as expected:
>
> [   37.148693] Code: 11 0d 00 48 89 c6 4c 89 ef e8 98 07 00 00 48 83 f8 ff 0f 84 3e 02 00 00 48 3b 05 b7 28 0d 00 48 89 c3 0f 83 b5 00 00 00 48 8b <0d> e7 10 0d 00 48 83 f8 0d 76 13 48 b8 28 75 6e 72 65 61 63 68 48

I'd say this is NOT expected and adds the unnecessary confusion.
./scripts/decodecode reports

	...

	Code starting with the faulting instruction
	===========================================
	   0:	0d e7 10 0d 00       	or     $0xd10e7,%eax
	   5:	48 83 f8 0d          	cmp    $0xd,%rax
	   9:	76 13                	jbe    0x1e
	   b:	48 b8 28 75 6e 72 65 	movabs $0x68636165726e7528,%rax
	  12:	61 63 68
	  15:	48                   	rex.W

and this is because foreign_regs->ip happens to be a valid address in current->mm.

> I'm thinking this should not use the atomic variant if it can get called
> in !atomic context too.

For what?

Oleg.

