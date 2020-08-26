Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04C252F99
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 15:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgHZNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 09:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728276AbgHZNW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598448144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CHp29HAS07vWUIoTCsxgobszhTbIxk61EdZKCoFcLHI=;
        b=Nm7mN4ONvkwO0e0IA3GXb8GXxilDlTkMlhnpNbPJpgF9fnuGqAFIii07MWDR4ExYkOLgKw
        FXIaqq4LgSmlGYxfRLHtCTkmFCTw/yMbo9lgKFQFTY1rCxNe+LghVFkT6yedwT06zLeDpn
        iuZb9Y3ANQfNEELQZdgl9twhDRdMu+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-nNYGLMeoN76hkrRQlpxCvQ-1; Wed, 26 Aug 2020 09:22:20 -0400
X-MC-Unique: nNYGLMeoN76hkrRQlpxCvQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1483710ABDBF;
        Wed, 26 Aug 2020 13:22:16 +0000 (UTC)
Received: from treble (ovpn-117-128.rdu2.redhat.com [10.10.117.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5533A5D9E8;
        Wed, 26 Aug 2020 13:22:12 +0000 (UTC)
Date:   Wed, 26 Aug 2020 08:22:10 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     X86 ML <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Avi Kivity <avi@scylladb.com>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>, robketr@amazon.de,
        amos@scylladb.com, Brian Gerst <brgerst@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/irq: Preserve vector in orig_ax for APIC code
Message-ID: <20200826132210.k4pxphxvxuvb2fe6@treble>
References: <20200826115357.3049-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200826115357.3049-1-graf@amazon.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 01:53:57PM +0200, Alexander Graf wrote:
> -.macro idtentry_body cfunc has_error_code:req
> +.macro idtentry_body cfunc has_error_code:req preserve_error_code:req
>  
>  	call	error_entry
>  	UNWIND_HINT_REGS
> @@ -328,7 +328,9 @@ SYM_CODE_END(ret_from_fork)
>  
>  	.if \has_error_code == 1
>  		movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
> -		movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
> +		.if \preserve_error_code == 0
> +			movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
> +		.endif

When does this happen (has_error_code=1 && preserve_error_code=0)?  I
don't see any users of this macro (or idtentry) with this combination.

-- 
Josh

