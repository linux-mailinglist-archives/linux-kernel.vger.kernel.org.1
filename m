Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD021C7689
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 18:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgEFQd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 12:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729443AbgEFQd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:33:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA15FC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:33:27 -0700 (PDT)
Received: from zn.tnic (p200300EC2F069600311A41E22EFEB62B.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9600:311a:41e2:2efe:b62b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79F0A1EC0350;
        Wed,  6 May 2020 18:33:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588782805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YNm4wPwn5AD+KVqpuy0HIU+w3Zi/C/bf5lJ0wCH+49A=;
        b=c5r2a6udE7GpIJy/1mD69GWL0RnvrXgxl4bVm+rW8mFor8CDfTLNaMCRuVhDBm2eGV1r7V
        EjHXKJWK+mUI4UJ9ASO86BgOZc9DBjrUbTJ0kbnydTFRF0kmAan6K7gRqHlkrILB/anVIz
        cV3/Tn6iO7ZIIV7j1may5VF3ULJNRnA=
Date:   Wed, 6 May 2020 18:33:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V4 part 1 06/36] compiler: Simple READ/WRITE_ONCE()
 implementations
Message-ID: <20200506163326.GE25532@zn.tnic>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.651504242@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200505134058.651504242@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:16:08PM +0200, Thomas Gleixner wrote:
> READ/WRITE_ONCE_NOCHECK() is required for atomics in code which cannot be
> instrumented like the x86 int3 text poke code. As READ/WRITE_ONCE() is
> undergoing a rewrite, provide __{READ,WRITE}_ONCE_SCALAR().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Subject needs a verb and patch needs From: Peter, judging by the SOB
chain.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
