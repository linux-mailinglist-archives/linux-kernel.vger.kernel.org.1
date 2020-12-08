Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD3C2D2B74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgLHMwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbgLHMwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:52:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CA4C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 04:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jPP/H9e2Iy2Z11xpklhUXCwXSKTIfsWCUPcUcREoAp8=; b=q3km6lEm5+8lRjX5Refq+pkPJO
        mNPu+lqKdJo91X23htSalt3YXWN3g2hkMTvJBm6QoaeGZPKqOIkqagnbb6lrJYhNdcR08M8Hh4sLJ
        N6Vh08I1bLW+1+rBBoRG/mRb4qCLDB+BAZ8xXoxPPL7BX7tDmYZOtFNH+l6K4Y89udMFBsKg4hUfA
        b/MuBagwPHZV9seNdOzccznr36+4bgoWPq1d4EBHxL5PeJn9/cJGKV+6DZi8E5TD9I3dsAiElSKxm
        hkaoOBijEVa7l/OrvZEQDFZN7v75NFIi9w6luVHSGiJMo4nUHZSvOK7zlBC2QFfgVc9A89SZUh93R
        WNs1aL9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmcSo-0004fi-Cl; Tue, 08 Dec 2020 12:51:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF22B304B92;
        Tue,  8 Dec 2020 13:51:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8AC3C200D1814; Tue,  8 Dec 2020 13:51:29 +0100 (CET)
Date:   Tue, 8 Dec 2020 13:51:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, keescook@chromium.org
Subject: Re: Are read-only static labels incompatible with kernel modules?
Message-ID: <20201208125129.GY2414@hirez.programming.kicks-ass.net>
References: <CAAeHK+xB0cdJxTvLzRRQuKQkStF+1AN179_8RUvDrpjZy+Utyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xB0cdJxTvLzRRQuKQkStF+1AN179_8RUvDrpjZy+Utyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 09:37:54PM +0100, Andrey Konovalov wrote:
> Hi,
> 
> I'm getting a crash when trying to load a module into a kernel that
> uses __ro_after_init static labels, see the crash below. The label is
> defined and initialized in the main kernel binary, and is used in the
> module. Is this not supported?

Clearly not, but also, the whole RO thing never went past the
maintainers (it also seems to be missing a MAINTAINERs entry).

>  static_key_set_linked kernel/jump_label.c:368
>  jump_label_add_module+0x1ec/0x2dc kernel/jump_label.c:658
>  jump_label_module_notify+0x40/0xa4 kernel/jump_label.c:736

This, it needs to modify the key, which is RO, to add a list of sites
from the module.

It could probably be fixed..
