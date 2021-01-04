Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81122EA096
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbhADXQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:16:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727230AbhADXQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609802091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4x3lXJdyPdQU4TGNRz3ba3RWfFt5IfZSTXq4TSow9u0=;
        b=fAQWOwuo9WZrNbye1PAa5iWf3CGwtu1OQdkXKrfuOegahjhe3+e/2pMiByaWpdy3mYuwaG
        1SlZ+zfDehYbcmG46IS7bi2z6+un7WQL/M5+qqeDzKBDtzT5V17RlnUx2Mthsny7kZTZ3p
        /juECayu88s1sd2Ii2LDXzPAUgjjkIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-QvYDd2EPO9WwA1FZ66iwlg-1; Mon, 04 Jan 2021 18:14:49 -0500
X-MC-Unique: QvYDd2EPO9WwA1FZ66iwlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62BF115720;
        Mon,  4 Jan 2021 23:14:48 +0000 (UTC)
Received: from treble (ovpn-113-48.rdu2.redhat.com [10.10.113.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BEC21001281;
        Mon,  4 Jan 2021 23:14:47 +0000 (UTC)
Date:   Mon, 4 Jan 2021 17:14:42 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        x86@kernel.org
Subject: Re: [PATCH] x86/compat: Pull huge_encode_dev() outside of UACCESS
Message-ID: <20210104231442.s4fdemacapnsqxse@treble>
References: <984353b44a4484d86ba9f73884b7306232e25e30.1608737428.git.jpoimboe@redhat.com>
 <20210104122825.GM3021@hirez.programming.kicks-ass.net>
 <20210104153127.e44uchjhlgg3hq2g@treble>
 <20210104155347.GC3040@hirez.programming.kicks-ass.net>
 <20210104172423.guiqwovibivcrqum@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104172423.guiqwovibivcrqum@treble>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 11:24:23AM -0600, Josh Poimboeuf wrote:
> On Mon, Jan 04, 2021 at 04:53:47PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 04, 2021 at 09:31:27AM -0600, Josh Poimboeuf wrote:
> > > Peter, care to submit a proper patch?
> > 
> > Here goes..
> > 
> > ---
> > Subject: x86/compat: Pull huge_encode_dev() outside of UACCESS
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Mon, 4 Jan 2021 13:28:25 +0100
> > 
> > Fixes the following warning:
> > 
> >   arch/x86/kernel/sys_ia32.o: warning: objtool: cp_stat64()+0xd8: call to new_encode_dev() with UACCESS enabled
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Actually the other patch was already merged into Linus' tree.

Maybe add a revert of the other patch to this one?

-- 
Josh

