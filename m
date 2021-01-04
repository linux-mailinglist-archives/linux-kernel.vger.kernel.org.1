Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22902E9BF6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 18:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbhADRZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 12:25:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbhADRZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609781072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AYDoGYYsrDK1t/G3YVPE9AU2KDCVZEp4GtDzq+/QuJg=;
        b=Nm/whcGijKoAmtWgWrxmoEN2bA7t9KV510RHVTecHPXikmVVu3A9jYvhO4rSxMnLLwv4W0
        xyFny9MJx5nKBi+0IIxXcGGbUIUFVL4p6D32TP2zWoHO/JA9lyjjQpplOIyVZYgYgDKTIQ
        6kpt0hXRx1nV18RVAhs8ahU52A4uLig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-1_c1JL3cOPK0ao1rJjNMhg-1; Mon, 04 Jan 2021 12:24:30 -0500
X-MC-Unique: 1_c1JL3cOPK0ao1rJjNMhg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41A17801817;
        Mon,  4 Jan 2021 17:24:29 +0000 (UTC)
Received: from treble (ovpn-113-48.rdu2.redhat.com [10.10.113.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AF7360BE5;
        Mon,  4 Jan 2021 17:24:28 +0000 (UTC)
Date:   Mon, 4 Jan 2021 11:24:23 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        x86@kernel.org
Subject: Re: [PATCH] x86/compat: Pull huge_encode_dev() outside of UACCESS
Message-ID: <20210104172423.guiqwovibivcrqum@treble>
References: <984353b44a4484d86ba9f73884b7306232e25e30.1608737428.git.jpoimboe@redhat.com>
 <20210104122825.GM3021@hirez.programming.kicks-ass.net>
 <20210104153127.e44uchjhlgg3hq2g@treble>
 <20210104155347.GC3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104155347.GC3040@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 04:53:47PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 04, 2021 at 09:31:27AM -0600, Josh Poimboeuf wrote:
> > Peter, care to submit a proper patch?
> 
> Here goes..
> 
> ---
> Subject: x86/compat: Pull huge_encode_dev() outside of UACCESS
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon, 4 Jan 2021 13:28:25 +0100
> 
> Fixes the following warning:
> 
>   arch/x86/kernel/sys_ia32.o: warning: objtool: cp_stat64()+0xd8: call to new_encode_dev() with UACCESS enabled
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

