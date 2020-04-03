Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5376319DB62
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 18:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404339AbgDCQUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 12:20:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33590 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728020AbgDCQUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585930848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LluwbzYPZTeVhlFwEl3Fq8+v9AvRnqXZTrSsmeMHE2I=;
        b=T3Upy+I8SHtu52Xh4otZm/XKkqmSNJWGXsmp+sf5lZwOzuagmETuCHOcLmLbJVeoaZ9YfK
        Jh5Kcl09Qx8AL2oQQEGnF2mP3ptAV58ok3noTFGJtMPNsZna/sU9CTvBUY1ADdBP5zssaJ
        8SkcGYEqEXqv/xH6P3NwMXcbICNjpxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-oxMaVJn4NUuZOhmFbeg-Xg-1; Fri, 03 Apr 2020 12:20:44 -0400
X-MC-Unique: oxMaVJn4NUuZOhmFbeg-Xg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E58B1100550D;
        Fri,  3 Apr 2020 16:20:42 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 356CB18A85;
        Fri,  3 Apr 2020 16:20:41 +0000 (UTC)
Date:   Fri, 3 Apr 2020 11:20:39 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     peterz@infradead.org,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Raphael Gault <raphael.gault@arm.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] objtool: Documentation: document UACCESS warnings
Message-ID: <20200403162039.fubfeblv3x5pmphn@treble>
References: <20200326134701.GA118458@rlwimi.vmware.com>
 <20200326183707.238474-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326183707.238474-1-ndesaulniers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 11:37:06AM -0700, Nick Desaulniers wrote:
> Compiling with Clang and CONFIG_KASAN=y was exposing a few warnings:
>   call to memset() with UACCESS enabled
> 
> Document how to fix these for future travelers.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/876
> Suggested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Suggested-by: Matt Helsley <mhelsley@vmware.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes V1 -> V2:
> * fix typo of listing uaccess_enable() twice rather than
>   uaccess_disable() as per Matt and Kamalesh.
> * fix type of "should called" to "should be called" as per Randy.
> * Mention non-obvious compiler instrumentation ie. -pg/mcount
>   -mfentry/fentry via tracing as per Peter.
> * Add sentence "It also helps verify..."
> * Add potential fix "1) remove explicit..."

Thanks, adding this one to the queue for tip.

-- 
Josh

