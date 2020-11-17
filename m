Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65F12B6BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgKQRcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:32:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726584AbgKQRcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605634325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SGZGeqqCDX1Imat9Iy5LGNxhmW0zyFz9BQ7qmjd6cBg=;
        b=RsXquIOWHEQLm057GewOnAP08A89aAYH54muxE/SYwz0QwzSPxO3NBzYEIwZ8E2sC6Rm2Z
        wxg9FPvBnPwL+5PAbSngDKW9vV/OYLDFOcrX9HcFZCk4nWMUc34INXfD0QWKuixYDa0Qro
        QHRwwFBjd9qtPA6qlVWCVqAE5LO8mHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-6_TJoNg9NsSr8pi6a1G67w-1; Tue, 17 Nov 2020 12:32:01 -0500
X-MC-Unique: 6_TJoNg9NsSr8pi6a1G67w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 726B5873113;
        Tue, 17 Nov 2020 17:32:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id 026995D9CD;
        Tue, 17 Nov 2020 17:31:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 17 Nov 2020 18:32:00 +0100 (CET)
Date:   Tue, 17 Nov 2020 18:31:53 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mark Mossberg <mark.mossberg@gmail.com>, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        jannh@google.com, kyin@redhat.com
Subject: Re: [PATCH v2] x86/dumpstack: Fix misleading instruction pointer
 error message
Message-ID: <20201117173152.GA26898@redhat.com>
References: <20201002042915.403558-1-mark.mossberg@gmail.com>
 <20201103125034.GA30391@redhat.com>
 <20201103171537.GC4111@zn.tnic>
 <20201103174744.GB23992@redhat.com>
 <20201103175237.GD4111@zn.tnic>
 <20201103181114.GC23992@redhat.com>
 <20201103182018.GE4111@zn.tnic>
 <87blfxx8ps.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blfxx8ps.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16, Thomas Gleixner wrote:
>
> Subject: x86/dumpstack: Don't try to access user space code of other tasks
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Mon, 16 Nov 2020 22:26:52 +0100
> 
> sysrq-t ends up invoking show_opcodes() for each task which tries to access
> the user space code of other processes which is obviously bogus.
> 
> It either manages to dump where the foreign tasks regs->ip points to in
> currents mapping or triggers a pagefault and prints "Code: Bad RIP
> value.". Both is just wrong.
> 
> Add a safeguard in copy_code() and check whether the @regs pointer matches
> currents pt_regs. If not, do not even try to access it.
> 
> While at it, add commentry why using copy_from_user_nmi() is safe in
> copy_code() even if the function name suggests otherwise.
> 
> Reported-by: Mark Mossberg <mark.mossberg@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Oleg Nesterov <oleg@redhat.com>

