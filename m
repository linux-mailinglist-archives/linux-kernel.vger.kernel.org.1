Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017C927015C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgIRPvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41501 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgIRPvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600444310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wN2Lonk3fGag+MhygRATrzJGxu02WDrFo0smM6EKPM0=;
        b=BXezf2PjKKo2VGIpVTB97dtjMPE7B2I6jWvUQUbJJDuBGZgZRpOvCjfQCveciR88pfs0i4
        TyYX6AyOJ+GZi2HZoa2/yLPso/AykoR1dXO/9XZj66iJUpBa2bJZ8V1dC1UdjQDgDaHtgQ
        3k4D2z0+89IogB+N0IbmmSbhPSrXgHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-WN-K92OLM3CSA5U4WeuAyw-1; Fri, 18 Sep 2020 11:51:48 -0400
X-MC-Unique: WN-K92OLM3CSA5U4WeuAyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 810D7188C12D;
        Fri, 18 Sep 2020 15:51:46 +0000 (UTC)
Received: from treble (ovpn-116-15.rdu2.redhat.com [10.10.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0B5555771;
        Fri, 18 Sep 2020 15:51:44 +0000 (UTC)
Date:   Fri, 18 Sep 2020 10:51:43 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Marco Elver <elver@google.com>,
        Philip Li <philip.li@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] objtool: ignore unreachable trap after call to noreturn
 functions
Message-ID: <20200918154840.h3xbspb5jq7zw755@treble>
References: <20200917084905.1647262-1-ilie.halip@gmail.com>
 <20200917221620.n4vavakienaqvqvi@treble>
 <CAHFW8PTFsmc7ykbrbdOYM6s-y1fpiV=7ee49BXaHjOkCMhBzhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHFW8PTFsmc7ykbrbdOYM6s-y1fpiV=7ee49BXaHjOkCMhBzhQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 08:35:40AM +0300, Ilie Halip wrote:
> > The patch looks good to me.  Which versions of Clang do the trap after
> > noreturn call?  It would be good to have that in the commit message.
> 
> I omitted this because it happens with all versions of clang that are
> supported for building the kernel. clang-9 is the oldest version that
> could build the mainline x86_64 kernel right now, and it has the same
> behavior.

Ok.  It should at least mention that this is a Clang-specific thing,
since GCC's version of UBSAN_TRAP doesn't do it.

> Should I send a v2 with this info?

Yes, please.

-- 
Josh

