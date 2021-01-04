Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14FA2E9834
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbhADPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbhADPOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:14:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405DBC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 07:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YpDUHurETXnbwAv5Csd3J2yCBg+qIHwWG+OP1AFi31I=; b=dXuZoGMR1+lh5DHlVphhfT4+95
        h/LU+ksW+vGcmMaWeK+mv03KN3Hq6Ru+6dYbsWetWJVOoeFKATfy0f1wW3JZljLdF0qW47NAQo6AD
        NoFYacYtyutNXz5U6glNcu7gWIyZb66u04alyoOOC4e0w7ZyPxMmWhdwSGrtoB2oDUBd2TCKjOa1j
        QxRiZZqSsDtSJxSGnDtfY3L6Hh+ounwjBkhCkclp9A1ZMQnRBYGWOFSX+BmmV8GTK6qfVjKZZrj/5
        yrTzfUM6o+8U2SAafSbfLj4zUL8TbwVt7iCOGOJz6YFCIHtaQNrUfIvdThs7YSkg/UHAJRd0u3zXk
        Y8QD4TTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kwRXs-000ELy-5c; Mon, 04 Jan 2021 15:13:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60158305C10;
        Mon,  4 Jan 2021 16:13:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BF362072C989; Mon,  4 Jan 2021 16:13:17 +0100 (CET)
Date:   Mon, 4 Jan 2021 16:13:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        aryabinin@virtuozzo.com, dvyukov@google.com, keescook@chromium.org
Subject: Re: [PATCH] mm/uaccess: Use 'unsigned long' to placate UBSAN
 warnings, again
Message-ID: <20210104151317.GR3021@hirez.programming.kicks-ass.net>
References: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 11:04:54PM -0600, Josh Poimboeuf wrote:
> GCC 7 has a known bug where UBSAN ignores '-fwrapv' and generates false
> signed-overflow-UB warnings.  The type mismatch between 'i' and
> 'nr_segs' in copy_compat_iovec_from_user() is causing such a warning,
> which also happens to violate uaccess rules:
> 
>   lib/iov_iter.o: warning: objtool: iovec_from_user()+0x22d: call to __ubsan_handle_add_overflow() with UACCESS enabled
> 
> Fix it by making the variable types match.
> 
> This is similar to a previous commit:
> 
>   29da93fea3ea ("mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions")

Maybe it's time we make UBSAN builds depend on GCC-8+ ?
