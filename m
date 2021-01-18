Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C02FA811
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436709AbhARRzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:55:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407287AbhARRzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610992434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IhIQFSef6xQsm2RYtUZFG04are7fA83Sxz47gDbqsgA=;
        b=CF6BfLh+gqXv86yLrSikXDGXYB5KrcrwqhbP2zpG95OsxfAOLT6UEpmdWWGCMurVH2db+J
        qBV93oFItChMYCYpLtG+W+BlNj5INxFV/T4OyO2t+afWXEbFu9Q9vD3xOvxQ6wEhZk4afN
        +EaYUQIl1/djv/lhq8WhbkGrTUQLGQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-x3_c4nDEMMChGXP42vfu9Q-1; Mon, 18 Jan 2021 12:53:47 -0500
X-MC-Unique: x3_c4nDEMMChGXP42vfu9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1B9F1800D42;
        Mon, 18 Jan 2021 17:53:45 +0000 (UTC)
Received: from treble (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF85619C66;
        Mon, 18 Jan 2021 17:53:43 +0000 (UTC)
Date:   Mon, 18 Jan 2021 11:53:37 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        dvyukov@google.com, keescook@chromium.org
Subject: Re: [PATCH] ubsan: Require GCC-8+ or Clang to use UBSAN
Message-ID: <20210118175337.rnh2b6vdnqw3ue63@treble>
References: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
 <20210104151317.GR3021@hirez.programming.kicks-ass.net>
 <YAAj9aAcPsV9I6UL@hirez.programming.kicks-ass.net>
 <e291008b-6b4d-9da4-1353-0762bc68e8ea@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e291008b-6b4d-9da4-1353-0762bc68e8ea@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 02:09:28PM +0300, Andrey Ryabinin wrote:
> 
> 
> On 1/14/21 1:59 PM, Peter Zijlstra wrote:
> > On Mon, Jan 04, 2021 at 04:13:17PM +0100, Peter Zijlstra wrote:
> >> On Tue, Dec 22, 2020 at 11:04:54PM -0600, Josh Poimboeuf wrote:
> >>> GCC 7 has a known bug where UBSAN ignores '-fwrapv' and generates false
> >>> signed-overflow-UB warnings.  The type mismatch between 'i' and
> >>> 'nr_segs' in copy_compat_iovec_from_user() is causing such a warning,
> >>> which also happens to violate uaccess rules:
> >>>
> >>>   lib/iov_iter.o: warning: objtool: iovec_from_user()+0x22d: call to __ubsan_handle_add_overflow() with UACCESS enabled
> >>>
> >>> Fix it by making the variable types match.
> >>>
> >>> This is similar to a previous commit:
> >>>
> >>>   29da93fea3ea ("mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions")
> >>
> >> Maybe it's time we make UBSAN builds depend on GCC-8+ ?
> > 
> > ---
> > Subject: ubsan: Require GCC-8+ or Clang to use UBSAN
> > 
> > Just like how we require GCC-8.2 for KASAN due to compiler bugs, require
> > a sane version of GCC for UBSAN.
> > 
> > Specifically, before GCC-8 UBSAN doesn't respect -fwrapv and thinks
> > signed arithmetic is buggered.
> > 
> 
> Actually removing CONFIG_UBSAN_SIGNED_OVERFLOW would give us the same
> effect without restricting GCC versions.

Is that preferable?  Always happy to remove code, just need some
justification behind it.

-- 
Josh

