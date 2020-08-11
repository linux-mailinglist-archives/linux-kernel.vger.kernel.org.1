Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F8B241CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgHKPBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 11:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbgHKPBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:01:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C1CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FGKdD+w4uCqJcdN9ztuakdLj9ZaFqNDwljGtIU98P8I=; b=KMfx+i0GlfqnZ5E2yG9J6lrnZF
        bX/g0MERGdZ/GfHGToliLqy+KErYA2Tw6gWFhadqBqwRHqnypeFqxAEGZm5OBQt2BcccNlLbLxZkr
        lMFyVU05VWKASV32crjQh6GBL3ZF9LyrKcWkdQ2gSm8lYvODDZdZ/WJVY/es6zXAaSmPB+VruSg/h
        TO+zoT85Qpl46lwxChrRlwXeKAmyMMqKwJwZ4hMSEo1X4T0sBsi5tA8gHde4hk1qUe2yDtj7K9+/a
        nZVF/NHK4SHr5WG9Zld9tNDaynWZDLBxy9pTGUDnqsGmoppNdIjUoORkSnM8rXwDjj0HcRcoPTWsM
        6ccWNK6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5Vlk-0004HG-Ej; Tue, 11 Aug 2020 15:00:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DBBC7300DAE;
        Tue, 11 Aug 2020 16:55:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37C4A2BB47D06; Tue, 11 Aug 2020 16:55:24 +0200 (CEST)
Date:   Tue, 11 Aug 2020 16:55:24 +0200
From:   peterz@infradead.org
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, keescook@chromium.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200811145524.GE2674@hirez.programming.kicks-ass.net>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
 <20200808101222.5103093e@coco.lan>
 <20200810092523.GA8612@linux-8ccs>
 <20200810150647.GB8612@linux-8ccs>
 <20200811163427.6edbf343@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811163427.6edbf343@coco.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 04:34:27PM +0200, Mauro Carvalho Chehab wrote:
>   [33] .plt              PROGBITS         0000000000000340  00035c80
>        0000000000000001  0000000000000000 WAX       0     0     1
>   [34] .init.plt         NOBITS           0000000000000341  00035c81
>        0000000000000001  0000000000000000  WA       0     0     1
>   [35] .text.ftrace[...] PROGBITS         0000000000000342  00035c81
>        0000000000000001  0000000000000000 WAX       0     0     1

.plt and .text.ftrace_tramplines are buggered.

arch/arm64/kernel/module.lds even marks then as NOLOAD.
