Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ABD2729CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgIUPT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727171AbgIUPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600701566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=78VYwFftorgadheBNYzJKmL144uRfgx6TOEZIwj+BGo=;
        b=IOBjkXZUjYSh8HDHu/5BsAS16smU/N9pOZaioK7T3L0PlzKSf1aC4OEAqHEc9Y2Ikj3kaX
        O091zFNLigHTj009mk9OzF38hjcbjv9AkvcS0wH4Ha9jFgJIHomO4uL5Yh4V73IKWjmzZ+
        2Px45NgrlOiQ5M0Qgar2eWzWhVpCymc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-gNN5vVhCM7KoxqTm9vt0JQ-1; Mon, 21 Sep 2020 11:19:18 -0400
X-MC-Unique: gNN5vVhCM7KoxqTm9vt0JQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 567BE801AE2;
        Mon, 21 Sep 2020 15:19:16 +0000 (UTC)
Received: from treble (ovpn-119-131.rdu2.redhat.com [10.10.119.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECE9655778;
        Mon, 21 Sep 2020 15:19:14 +0000 (UTC)
Date:   Mon, 21 Sep 2020 10:19:13 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Marco Elver <elver@google.com>,
        Philip Li <philip.li@intel.com>,
        Borislav Petkov <bp@alien8.de>, kasan-dev@googlegroups.com,
        x86@kernel.org, clang-built-linux@googlegroups.com,
        kbuild test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] objtool: ignore unreachable trap after call to
 noreturn functions
Message-ID: <20200921151913.rrfbqfnrhfmb26w4@treble>
References: <20200918154840.h3xbspb5jq7zw755@treble>
 <20200919064118.1899325-1-ilie.halip@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200919064118.1899325-1-ilie.halip@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 09:41:18AM +0300, Ilie Halip wrote:
> With CONFIG_UBSAN_TRAP enabled, the compiler may insert a trap instruction
> after a call to a noreturn function. In this case, objtool warns that the
> ud2 instruction is unreachable.
> 
> This is a behavior seen with clang, from the oldest version capable of
> building the mainline x64_64 kernel (9.0), to the latest experimental
> version (12.0).
> 
> objtool silences similar warnings (trap after dead end instructions), so
> so expand that check to include dead end functions.
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
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> ---
> 
> Changed in v2:
>  - added a mention that this is a clang issue across all versions
>  - added Nick's Reviewed-by, Tested-by
>  - added Reported-by

Thanks.  Queued.

-- 
Josh

