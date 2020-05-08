Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17C31CB1C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 16:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgEHO1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 10:27:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38106 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgEHO1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588948035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qsxDzgvbReRs6FEUYI/0tptRVxJkwWsr/H3/Vzt8py4=;
        b=JpCSGe+GyVouQyONQ3e9NxQ4nhsUHTMm6/m2NBblNFC/p6TaBKINvpkWcwtCQptmOJ5Xn6
        lQYUAQ1xtEn0tYI0EbivDOsStRqM6BMaFyYZUbDet44oS3DZ6SOimSZdiwzsbk+T7JLTHW
        wrPBs68qwWXQ1Sx8WdKCiCjlqDv+4q4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-IYsvLEcwO9KUgbG35d3Q8g-1; Fri, 08 May 2020 10:27:14 -0400
X-MC-Unique: IYsvLEcwO9KUgbG35d3Q8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 684B18730ED;
        Fri,  8 May 2020 14:27:11 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2B225D9CA;
        Fri,  8 May 2020 14:27:05 +0000 (UTC)
Date:   Fri, 8 May 2020 09:27:03 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 16/18] static_call: Allow early init
Message-ID: <20200508142703.44ggcccdunchamro@treble>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.706674211@infradead.org>
 <20200506211547.2vnuhkfzhgbi27dm@treble>
 <20200508133156.GC3762@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200508133156.GC3762@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 03:31:56PM +0200, Peter Zijlstra wrote:
> New version below.
> 
> ---
> Subject: static_call: Allow early init
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri, 4 Oct 17:21:10 CEST 2019
> 
> In order to use static_call() to wire up x86_pmu, we need to
> initialize earlier; copy some of the tricks from jump_label to enable
> this.
> 
> Primarily we overload key->next to store a sites pointer when there
> are no modules, this avoids having to use kmalloc() to initialize the
> sites and allows us to run much earlier.
> 
> (arguably, this is much much earlier than needed for perf, but it
> might allow other uses.)
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks good, I'll try to do some more testing today-ish.

-- 
Josh

