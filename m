Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AD82F571F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbhANB7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:59:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729537AbhAMXj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610581111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3DQqCrREcFVkOqJrkpEUnMgT2qx/NPUh57vedl2uZZ8=;
        b=OV2Iek6QAw7rsWZ6iaEtsiqMJwjuiIPGtekS14XYgB7guekGjgcsfDYrxICwv8xWdfSe4K
        CDerCi6451grd5U7pp8XPCLKS1yoiVj5fbBxAzLcJawRhtuznhddm/jP0iKUVwMj4kCtbS
        MUbdz41GiRbxjIsHCUJfirG0kt/tFZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-Bq6h0pFkPKKxPvptqUKWAg-1; Wed, 13 Jan 2021 18:27:12 -0500
X-MC-Unique: Bq6h0pFkPKKxPvptqUKWAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B96F9100F342;
        Wed, 13 Jan 2021 23:27:10 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB4895F708;
        Wed, 13 Jan 2021 23:27:09 +0000 (UTC)
Date:   Wed, 13 Jan 2021 17:27:04 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        dvyukov@google.com
Subject: Re: [PATCH] mm/uaccess: Use 'unsigned long' to placate UBSAN
 warnings, again
Message-ID: <20210113232704.66hqq4o5oes4up76@treble>
References: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
 <20210104151317.GR3021@hirez.programming.kicks-ass.net>
 <202101061536.C4A93132@keescook>
 <d5b192b2-b216-57d1-4505-06233ae2b882@infradead.org>
 <202101071306.5A39AAC3A7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202101071306.5A39AAC3A7@keescook>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 01:07:21PM -0800, Kees Cook wrote:
> On Wed, Jan 06, 2021 at 04:06:57PM -0800, Randy Dunlap wrote:
> > On 1/6/21 3:37 PM, Kees Cook wrote:
> > > On Mon, Jan 04, 2021 at 04:13:17PM +0100, Peter Zijlstra wrote:
> > >> On Tue, Dec 22, 2020 at 11:04:54PM -0600, Josh Poimboeuf wrote:
> > >>> GCC 7 has a known bug where UBSAN ignores '-fwrapv' and generates false
> > >>> signed-overflow-UB warnings.  The type mismatch between 'i' and
> > >>> 'nr_segs' in copy_compat_iovec_from_user() is causing such a warning,
> > >>> which also happens to violate uaccess rules:
> > >>>
> > >>>   lib/iov_iter.o: warning: objtool: iovec_from_user()+0x22d: call to __ubsan_handle_add_overflow() with UACCESS enabled
> > >>>
> > >>> Fix it by making the variable types match.
> > >>>
> > >>> This is similar to a previous commit:
> > >>>
> > >>>   29da93fea3ea ("mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions")
> > >>
> > >> Maybe it's time we make UBSAN builds depend on GCC-8+ ?
> > > 
> > > I would be totally fine with that. The only thing I can think of that
> > > might care is syzbot. Dmitry, does syzbot use anything older than gcc 8?
> > 
> > I use UBSAN successfully with GCC 7.5.0.
> > However, I can revert whatever future patch someone adds for this...
> 
> Peter, which GCC version specifically are you seeing this on? (i.e. can
> I just make in 7.5+ instead of 8+ to make Randy's life easier?)

I don't think that would help, we saw this bug on GCC 7.5.

-- 
Josh

