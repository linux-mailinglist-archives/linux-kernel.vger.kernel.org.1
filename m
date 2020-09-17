Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF9826E81E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 00:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIQWSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 18:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbgIQWSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600381081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ziYgXqbocOD7j0uxO/EAGepHJEfgOW1DX4mZklNm150=;
        b=W1JMB8oMIH5x3Le7r9XPnQGti29vGIga2AizrSWKr0Uw+pJ9/Hy+MO7bMTH/wx/VnI8Uvf
        F9bmjp6057DskVJDW+ewdgKYhtvMxcb3QiCoMr4rErnLSCYUurb030KNP/1ERorpJ4TBCI
        rWJiPuugRy7lVbjX1DNDDvaD0ObMM+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-E3V8NLmqPlSNE6AuXh-rRQ-1; Thu, 17 Sep 2020 18:16:26 -0400
X-MC-Unique: E3V8NLmqPlSNE6AuXh-rRQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 152641008558;
        Thu, 17 Sep 2020 22:16:24 +0000 (UTC)
Received: from treble (ovpn-112-136.rdu2.redhat.com [10.10.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87C5855761;
        Thu, 17 Sep 2020 22:16:22 +0000 (UTC)
Date:   Thu, 17 Sep 2020 17:16:20 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Marco Elver <elver@google.com>,
        Philip Li <philip.li@intel.com>,
        Borislav Petkov <bp@alien8.de>, kasan-dev@googlegroups.com,
        x86@kernel.org, clang-built-linux@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] objtool: ignore unreachable trap after call to noreturn
 functions
Message-ID: <20200917221620.n4vavakienaqvqvi@treble>
References: <20200917084905.1647262-1-ilie.halip@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917084905.1647262-1-ilie.halip@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:49:04AM +0300, Ilie Halip wrote:
> With CONFIG_UBSAN_TRAP enabled, the compiler may insert a trap instruction
> after a call to a noreturn function. In this case, objtool warns that the
> ud2 instruction is unreachable.
> 
> objtool silences similar warnings (trap after dead end instructions), so
> expand that check to include dead end functions.
> 
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Rong Chen <rong.a.chen@intel.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Philip Li <philip.li@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: kasan-dev@googlegroups.com
> Cc: x86@kernel.org
> Cc: clang-built-linux@googlegroups.com
> BugLink: https://github.com/ClangBuiltLinux/linux/issues/1148
> Link: https://lore.kernel.org/lkml/CAKwvOdmptEpi8fiOyWUo=AiZJiX+Z+VHJOM2buLPrWsMTwLnyw@mail.gmail.com
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>

The patch looks good to me.  Which versions of Clang do the trap after
noreturn call?  It would be good to have that in the commit message.

-- 
Josh

