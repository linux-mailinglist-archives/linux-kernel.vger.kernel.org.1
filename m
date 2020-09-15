Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B102426B31F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgIOXAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727397AbgIOPDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600182159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eX9ca3sOdwxPUqHEtXbarZcOrumB4Y8vbWJAomFihUM=;
        b=SL4qA0r3E/QI6ANCK1Td4N6cWoqyT0o3K3JUB5xLF0NbfzaXWtKOiqD6OjHPThlMvsg0Bp
        rR2UdaWv28Gjw8WBGOeQ4potAb1WSHESK1FKi91Lt8o6YHdyJhRtvsmTsU5hl40jXjI4/w
        HPGwtU+WFGOoeM5B0a38YlM5/2gxEq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-UDNZK_bYMJ6UegRhUYyrug-1; Tue, 15 Sep 2020 11:02:33 -0400
X-MC-Unique: UDNZK_bYMJ6UegRhUYyrug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C38828014D9;
        Tue, 15 Sep 2020 15:02:31 +0000 (UTC)
Received: from treble (ovpn-112-136.rdu2.redhat.com [10.10.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FA5B1992F;
        Tue, 15 Sep 2020 15:02:30 +0000 (UTC)
Date:   Tue, 15 Sep 2020 10:02:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Wielaard <mark@klomp.org>
Cc:     peterz@infradead.org, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: Static call dependency on libelf version?
Message-ID: <20200915150229.75ilnm32a5fnjbja@treble>
References: <alpine.LSU.2.11.2009142337530.1550@eggly.anvils>
 <20200915093016.GV1362448@hirez.programming.kicks-ass.net>
 <d02d57308d9e8febd569c3fd3757dbcc87b1c4a1.camel@klomp.org>
 <20200915141701.j5fnir63trpwqbfp@treble>
 <38388294c6ad7bf4abdb1b9a0bac9af5224c8fa6.camel@klomp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38388294c6ad7bf4abdb1b9a0bac9af5224c8fa6.camel@klomp.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 04:38:02PM +0200, Mark Wielaard wrote:
> Hi Josh,
> 
> On Tue, 2020-09-15 at 09:17 -0500, Josh Poimboeuf wrote:
> > On Tue, Sep 15, 2020 at 01:24:17PM +0200, Mark Wielaard wrote:
> > > But all this is for ancient versions of elfutils libelf. So it is hard
> > > to say and my memory might be failing. If someone can confirm 0.158
> > > (which is 6 years old) works fine I would pick that as minimum version,
> > > otherwise simply go with 0.168 which is 4 years old and should be on
> > > most systems by now.
> > 
> > I just discovered elf_version(), I assume that would allow us to check
> > and enforce the libelf version?
> 
> No, sorry. That is for the ELF file format version, which is and has
> always been  version 1 (and I suspect it will be for the next 20
> years).

Oh, right :-)

> There is /usr/include/elfutils/version.h which provides a
> _ELFUTILS_PREREQ(major, minor) macro if you need something during
> compile time.

Nice, I'll try that.

> Note that in theory libelf is a generic library (there are variants for
> Solaris and BSD with which we try to be [source] compatible), but the
> only actively maintained version is the elfutils one.

Yeah, we've occasionally had users using another variant of the library
which is 10+ years old.  Not surprisingly it didn't work well.

-- 
Josh

