Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B222649B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgIJQ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 12:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgIJQ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:28:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7A5C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:07:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a8so1057630plm.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CkdZTgPQtli4HqKjoybGJC69i/K2eo+/Y/ueOVTU/uQ=;
        b=eS8OmoytThC7KUY/Rbjn9+OdhHCTAxZHZhtO9Ll397opaMxtZwThboa+C2O8ZFCyZO
         3yO7BFlQAHn+yHQOjTkSFxrGQT55I8zRk+ACqC8mUlAGEgaJBYVxdtDOeJYvRXY7OjD1
         qoTqm7lymwBPWk5HvlxgcsMnJSmrWwc/CDEf5vU234aNsYZC/feumKaSOaVQM1oeg2rp
         5mn5icPj2L2oVd+okglM+aUogVgHmTvRe+DoweL0N0v4d2/lpxJ7oBj1ZuDkqyJtw+x2
         MyX0f8gzheaFJLMAEkWsyGR+2G8QUbr85wv/70bydcasoZ+1oXcDIR0JEbGlmuon6m7C
         zqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CkdZTgPQtli4HqKjoybGJC69i/K2eo+/Y/ueOVTU/uQ=;
        b=tsO7ep0xWexoaopznKcYzPyhasWh5nU7ythVOQXNr82btDkbPAd6rbIkxNXRZqxdhh
         2yRz8R3Dm+5U6roRXn2LiLP0nBfY3jhT1MgO3wwNTWb01bbSidCOZstAPbnmm/5Ai/+S
         Af6iXZVOgIjLQmoX7My0QwPMe+iLAUMmh8BXiiZNz+lsBL9so0SkPoMfjKGbtO+rrdYh
         MH2bT/2Vlk92LMfaOejfs/wPebISyJzfM5jMknSj62oXXJOTIwcMupV+OMe09fDq2zhJ
         Uc8VpS+DMfFyx2+uz97y+T3yV9WSWeP8445KdCKX1MVbWEqMPsNhh1EUQLRuj5vEs9jx
         7YDw==
X-Gm-Message-State: AOAM530HuKV7/gguy21EpEP56K8DdQF1FGHNRv4gg8WeMvCjBfD/mCtp
        p3uNJEwSQqW+u140Nx66oXKDTw==
X-Google-Smtp-Source: ABdhPJzgkkNJGQRPeFg7lZtu3UZBjQBkf2nGy3Om/c9n+Dj7KFkAAjDpg1xpd04kYgbe9qjhwsW3RQ==
X-Received: by 2002:a17:902:82c1:: with SMTP id u1mr6062512plz.38.1599750430560;
        Thu, 10 Sep 2020 08:07:10 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id p5sm5097827pgm.66.2020.09.10.08.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:07:09 -0700 (PDT)
Date:   Thu, 10 Sep 2020 08:07:04 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 15/28] init: lto: ensure initcall ordering
Message-ID: <20200910150704.GA2041735@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-16-samitolvanen@google.com>
 <5f45f55340cf54f5506a50adf61e49b27b904322.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f45f55340cf54f5506a50adf61e49b27b904322.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:25:40AM +0100, David Woodhouse wrote:
> On Thu, 2020-09-03 at 13:30 -0700, Sami Tolvanen wrote:
> > With LTO, the compiler doesn't necessarily obey the link order for
> > initcalls, and initcall variables need globally unique names to avoid
> > collisions at link time.
> > 
> > This change exports __KBUILD_MODNAME and adds the initcall_id() macro,
> > which uses it together with __COUNTER__ and __LINE__ to help ensure
> > these variables have unique names, and moves each variable to its own
> > section when LTO is enabled, so the correct order can be specified using
> > a linker script.
> > 
> > The generate_initcall_ordering.pl script uses nm to find initcalls from
> > the object files passed to the linker, and generates a linker script
> > that specifies the intended order. With LTO, the script is called in
> > link-vmlinux.sh.
> 
> Is this guaranteed to give you the *same* initcall ordering with LTO as
> without?

Yes. It follows the link order, just like the linker without LTO, and
also preserves the order within each file.

Sami
