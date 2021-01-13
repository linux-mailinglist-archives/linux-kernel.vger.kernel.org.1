Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3642F56CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbhANBxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:53:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729707AbhANABN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610582340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RG9xUUlRmA1xz/NHX//EJP2iaG6jgVRLD9TcXfS/a5U=;
        b=K/GSOXLQ68fsxA4osjABmBp6/HvFQ28uU3OWUO4jiR2n1CahtIlM2jLrYXJ/Vqaaz5P5WA
        BsU8o6gsV4Rt42JCVqknuztF3eUisP3ygHvxHFqAfPQeyWily8DXW4A9M9LqwK7cLn7wDi
        ArKMSZyUPOMQPuOaVXqaTmaBV11lM0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-k8Mfz5PGNbGEiLFsWRogyA-1; Wed, 13 Jan 2021 17:45:30 -0500
X-MC-Unique: k8Mfz5PGNbGEiLFsWRogyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA6B7107ACFA;
        Wed, 13 Jan 2021 22:45:29 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBAA960BD9;
        Wed, 13 Jan 2021 22:45:28 +0000 (UTC)
Date:   Wed, 13 Jan 2021 16:45:26 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "vanessa.hack@fau.de" <vanessa.hack@fau.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: objtool/ORC generation for noreturn functions
Message-ID: <20210113224526.64d244e7a4szftpj@treble>
References: <daf04159-a458-4f0d-9f29-d8ef5a63fae6@email.android.com>
 <20210113184131.yh4zh4olfkdpydv7@treble>
 <8bfda75985c4429297afce9340303e34@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8bfda75985c4429297afce9340303e34@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 10:39:53PM +0000, David Laight wrote:
> > On Wed, Jan 13, 2021 at 11:44:22AM +0100, vanessa.hack@fau.de wrote:
> > >    Hi,
> > >    I am currently writing my final thesis at university on the topic of stack
> > >    unwinding. My goal is to implement and evaluate stack unwinders for
> > >    research operating system ports to x86 32 and 64 bit architectures and
> > >    SPARC V8.
> > >    For the x86 ports I chose ORC as unwinding format due to its simplicity
> > >    and reliability. So far, it works quite well (although I've ran into some
> > >    minor issues with objtool as the research OS is written in C++).
> > >    But now I have some problems with functions that are explicitly marked as
> > >    noreturn with the [[noreturn]] attribute, all following unwinding steps
> > >    are unreliable. I have read in the objtool documentation that such
> > >    functions have to be added to the objtool global_noreturn array.
> > >    Unfortunately, I do not understand the purpose of that array and the
> > >    intended ORC behaviour for noreturn functions. Are the unwinding steps
> > >    that follow a noreturn intended to be unreliable?
> 
> There was an 'interesting' unwinder I saw a few years ago.
> (Which couldn't handle 'noreturn' functions.)
> 
> The idea is to follow forwards through the code while keeping
> track of %sp and %fp until a return instruction is found.
> You need to be able to detect loops, and then continue from
> the other target of an earlier conditional branch.
> Provided function calls don't change %sp they can be ignored.
> If the %fp isn't used as a frame pointer it won't get reloaded
> into %sp so it doesn't matter
> 
> This works (most of the time) with no debug info and no symbol
> table.

Almost sounds like an in-kernel version of objtool :-)

-- 
Josh

