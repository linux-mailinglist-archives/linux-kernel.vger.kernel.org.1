Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE561AD954
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgDQI7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 04:59:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50474 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729890AbgDQI7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587113953;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=uHyoeCfhh0GMnSjf+OUTSeJqWjAVQ0tVBciKvtGhIOc=;
        b=B+/KHfDoyA0XmljPNMtJiHCtPzFY7ICjJ/eTIpRVv4+Tql2+ibv3c6UjmNwZb0bMkx0cbb
        V8Vi7CQkEaVaot+qyPA8PfmQb1/MhBGek4nO9rWwfaf/C7Q87LUbqX8xN775N61K0mw+yn
        Ma6Ed9eEbUk9FuSgtWzN7s15WdOc6hw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-jQjnlL5OMDCxpbdJdQm9iA-1; Fri, 17 Apr 2020 04:59:07 -0400
X-MC-Unique: jQjnlL5OMDCxpbdJdQm9iA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 080FC801A07;
        Fri, 17 Apr 2020 08:59:06 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9685960BE0;
        Fri, 17 Apr 2020 08:59:05 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.15.2/8.15.2) with ESMTP id 03H8x2pF004556;
        Fri, 17 Apr 2020 10:59:02 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.15.2/8.15.2/Submit) id 03H8wxRp004555;
        Fri, 17 Apr 2020 10:58:59 +0200
Date:   Fri, 17 Apr 2020 10:58:59 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Michael Matz <matz@suse.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200417085859.GU2424@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20200326223501.GK11398@zn.tnic>
 <20200328084858.421444-1-slyfox@gentoo.org>
 <20200413163540.GD3772@zn.tnic>
 <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de>
 <20200415074842.GA31016@zn.tnic>
 <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de>
 <20200415231930.19755bc7@sf>
 <20200417075739.GA7322@zn.tnic>
 <20200417080726.GS2424@tucnak>
 <20200417084224.GB7322@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417084224.GB7322@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 10:42:24AM +0200, Borislav Petkov wrote:
> On Fri, Apr 17, 2020 at 10:07:26AM +0200, Jakub Jelinek wrote:
> > If you want minimal changes, you can as I said earlier either
> > mark cpu_startup_entry noreturn (in the declaration in some header so that
> > smpboot.c sees it), or you could add something after the cpu_startup_entry
> > call to ensure it is not tail call optimized (e.g. just
> > 	/* Prevent tail call to cpu_startup_entry because the stack
> > 	   protector guard has been changed in the middle of this function
> > 	   and must not be checked before tail calling another function.  */
> > 	asm ("");
> 
> That sounds ok-ish to me too.
> 
> I know you probably can't tell the future :) but what stops gcc from
> doing the tail-call optimization in the future?
> 
> Or are optimization decisions behind an inline asm a no-no and will
> pretty much always stay that way?

GCC intentionally treats asm as a black box, the only thing which it does
with it is: non-volatile asm (but asm without outputs is implicitly
volatile) can be CSEd, and if the compiler needs to estimate size, it
uses some heuristics by counting ; and newlines.
And it will stay this way.

> And I hope the clang folks don't come around and say, err, nope, we're
> much more aggressive here.

Unlike GCC, I think clang uses the builtin assembler to parse the string,
but don't know if it still treats the asms more like black boxes or not.
Certainly there is a lot of code in the wild that uses inline asm
as optimization barriers, so if it doesn't, then it would cause a lot of
problems.

Or go with the for (;;);, I don't think any compiler optimizes those away;
GCC 10 for C++ can optimize away infinite loops that have some conditional
exit because the language guarantees forward progress, but the C language
rules are different and for unconditional infinite loops GCC doesn't
optimize them away even if explicitly asked to -ffinite-loops.

	Jakub

