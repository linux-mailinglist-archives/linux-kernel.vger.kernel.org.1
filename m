Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6B1B4E91
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 22:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgDVUuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 16:50:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25681 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbgDVUuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587588600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/1vr35dl6rIWKET2/rPlEUGJkBbv71RXL+Mb7YtFvE=;
        b=cpeEKzDZ5lchnEqp+7mCLGAgr3snQ4TUh6lU8D4YTjQCPRBuULoYzvfWivCcPybVYyHA28
        zTz7QpD0gysNCekSsHdOTBoFMDtXhqLxXzFSjkjrG35Sb5nKmDyenk/aBeUtcpgMXlHhp+
        memxg92Bp8iUFAt+gNSDPAO921+fc0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-gRM27__wN_a6PPxT6jwX9w-1; Wed, 22 Apr 2020 16:49:56 -0400
X-MC-Unique: gRM27__wN_a6PPxT6jwX9w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC979107ACC9;
        Wed, 22 Apr 2020 20:49:54 +0000 (UTC)
Received: from treble (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01D636084B;
        Wed, 22 Apr 2020 20:49:53 +0000 (UTC)
Date:   Wed, 22 Apr 2020 15:49:52 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/3] objtool: Constify most of the instruction decoding
 loop
Message-ID: <20200422204952.ct54cxbp7c2kbppf@treble>
References: <20200422103205.61900-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422103205.61900-1-mingo@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:32:02PM +0200, Ingo Molnar wrote:
> Constify some of the decoding primitives, to ascertain and enforce that
> arch_decode_instructions() is a read-only consumer of the various ELF data
> structures. (Which it is.)
> 
> This is in preparation to parallelize the most expensive parts of objtool,
> but makes sense independently as well.
> 
> These bits can also be found at:
> 
>   git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.core/objtool

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

