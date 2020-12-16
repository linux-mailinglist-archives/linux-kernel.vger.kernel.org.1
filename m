Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA862DC3F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 17:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgLPQWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 11:22:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbgLPQWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608135670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FoIl4Q1DJa5TWq3jj96hpxrV/VIXlC9iooz3P5PXBQ4=;
        b=jWhfUcPRaTl+p1JGUGAguTby1UsgBrWZst6hcO9LXpRwOJpIAfpG8lMab/ACBsE9hGCMmT
        EVys1182X7YRp8hWju+B0swEEctsvY2bWR7WEh0p2T5ZoMwJ+5PYU9VXNTb3IkCl9/W5HC
        a2AuDw1N5U5RAEJfA/ElQJICLmF2tic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-Q78KJcLoMAq9ez_xn5fK_g-1; Wed, 16 Dec 2020 11:21:09 -0500
X-MC-Unique: Q78KJcLoMAq9ez_xn5fK_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00AC86D55D;
        Wed, 16 Dec 2020 16:20:31 +0000 (UTC)
Received: from treble (ovpn-112-170.rdu2.redhat.com [10.10.112.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AEB95D9CC;
        Wed, 16 Dec 2020 16:20:30 +0000 (UTC)
Date:   Wed, 16 Dec 2020 10:20:28 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New objtool warning..
Message-ID: <20201216162028.q45qi5zo3nak6c2s@treble>
References: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
 <20201216044918.jdmi32dz75uboybv@treble>
 <CAHk-=wiGq=ZfYN1VOrFpX=2JzfPkB34HfxeXV0K8FJbMz-iY3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGq=ZfYN1VOrFpX=2JzfPkB34HfxeXV0K8FJbMz-iY3Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 09:31:50PM -0800, Linus Torvalds wrote:
> On Tue, Dec 15, 2020 at 8:49 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > But yeah, it _might_ be possible to make objtool a little smarter here.
> > Gimme the .o file and I can take a look tomorrow.
> 
> Hmm. I tried to send it to you, but then I get a bounce with
> 
>   554 Email rejected due to security policies
> 
> because apparently your redhat address doesn't allow object files.
> 
> Annoying.

Well that's embarrassing.  You're the second person to complain about
that in as many days...

/me goes open a ticket

-- 
Josh

