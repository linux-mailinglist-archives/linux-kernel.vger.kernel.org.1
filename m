Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6222A281662
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbgJBPS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:18:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgJBPS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601651938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z6EUHBkqVW4A4asmEIKfV9etkeKueHKWkFuO9+VAbxk=;
        b=EX000Tc6LUzQSyXiiN3lyjLZdvUu2n9mk11573pEZ7huUsBXSBe2qf9F3F6bqfVVb0c+xm
        S+ngX7jh8EHepFcpNPKOGpn6w1ul7wfbtwqOoj3pCNzTzPeavtMsdAo7hnjfZt4JF1C1gK
        snNdpBePCnLwVR4XRA27dDXW70WnZiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-pY_T4ZhEP9e783VyIblwTQ-1; Fri, 02 Oct 2020 11:18:56 -0400
X-MC-Unique: pY_T4ZhEP9e783VyIblwTQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D737C104D40D;
        Fri,  2 Oct 2020 15:18:49 +0000 (UTC)
Received: from treble (ovpn-114-202.rdu2.redhat.com [10.10.114.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4FD973699;
        Fri,  2 Oct 2020 15:18:44 +0000 (UTC)
Date:   Fri, 2 Oct 2020 10:18:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/4] objtool: x86 instruction decoder and big
 endian cross compiles
Message-ID: <20201002151841.4ojt45mtcpkylvdq@treble>
References: <cover.thread-6ec90b.your-ad-here.call-01601502173-ext-7769@work.hours>
 <patch-2.thread-6ec90b.git-f1af53789d02.your-ad-here.call-01601502173-ext-7769@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <patch-2.thread-6ec90b.git-f1af53789d02.your-ad-here.call-01601502173-ext-7769@work.hours>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 12:17:25AM +0200, Vasily Gorbik wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Currently objtool seems to be the only tool from build tools needed
> which breaks x86 cross compilation on big endian systems. Make the x86
> instruction decoder of the objtool usable on big endian machines.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Since this changes the decoder (which is shared with the kernel), please
prefix the subject with "x86/insn:" instead of "objtool".

This patch is a bit ugly, but I don't necessarily have a better idea.

Masami?

-- 
Josh

