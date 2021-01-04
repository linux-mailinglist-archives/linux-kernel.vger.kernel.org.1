Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066F72EA071
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbhADXJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:09:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbhADXJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609801664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5yhsPzKCS64Ym9MievqPZFkfrX4PHb4luBL7gT8eRhE=;
        b=dyW/x3cu1+ypli8rIBbSWu6oiRmmWJYRRz8vPsoVo1IyJX9nMzEBHr68p/SJgwTaws4/6X
        VbAjNiGZqs6jjljLUgW2pjPn9pXIhx0JMmAyS41Jlej2RdLsjW/4VJ3ZebNjuB4I59bz3k
        7/OoSvwCqZ5SUkgqJDZ8Yqg6Z4TulF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-rtRqDYBVNau_mGlI3AI-kg-1; Mon, 04 Jan 2021 18:07:40 -0500
X-MC-Unique: rtRqDYBVNau_mGlI3AI-kg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D416801B33;
        Mon,  4 Jan 2021 23:07:37 +0000 (UTC)
Received: from treble (ovpn-113-48.rdu2.redhat.com [10.10.113.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 439575D9C6;
        Mon,  4 Jan 2021 23:07:34 +0000 (UTC)
Date:   Mon, 4 Jan 2021 17:07:32 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Olof Johansson <olof@lixom.net>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Windsor <dwindsor@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Rik van Riel <riel@surriel.com>,
        George Spelvin <lkml@sdf.org>
Subject: Re: [PATCH v2] bug: further enhance use of CHECK_DATA_CORRUPTION
Message-ID: <20210104230426.ygzkhnonys4mtc7z@treble>
References: <1491343938-75336-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1491343938-75336-1-git-send-email-keescook@chromium.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2017 at 03:12:11PM -0700, Kees Cook wrote:
> This continues in applying the CHECK_DATA_CORRUPTION tests where
> appropriate, and pulling similar CONFIGs under the same check. Most
> notably, this adds the checks to refcount_t so that system builders can
> Oops their kernels when encountering a potential refcounter attack. (And
> so now the LKDTM tests for refcount issues pass correctly.)
> 
> The series depends on the changes in -next made to lib/refcount.c,
> so it might be easiest if this goes through the locking tree...
> 
> v2 is a rebase to -next and adjusts to using WARN_ONCE() instead of WARN().
> 
> -Kees
> 
> v1 was here: https://lkml.org/lkml/2017/3/6/720

Ping?  Just wondering what ever happened to this 3+ year old series...

-- 
Josh

