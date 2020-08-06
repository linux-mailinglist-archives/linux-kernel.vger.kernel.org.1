Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F423E3E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 00:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgHFWN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 18:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHFWN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 18:13:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBABEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 15:13:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596752006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mZLBLAIbdKaiA3wdTA7rUL51TgNpJlVhkmQwVAv+Fpc=;
        b=jHeJAU7zIWXrh2+ZOasvYTXuLcZhYmCUOgyeo1eRhsIFMUUQw70XQsWm6SR+Skq7e6a0RA
        ViYz1juf3L4fm1uriNYy9zlTKDY2NhbbjBO4K0asgdBDFdnM3z0PTM4tiER4mgvqO9F7To
        GaEuI89OqzR11TMuT+PGJS0egpkfBqdT4waNUAbol0jrLdorkjnCZvQcwzTntasQjJO2TA
        F6lp4geby+8lbfKrtPI3KRyQHBUsJTY/VM3atNbuOYubugnPFlm4Bq3HFuuNmbAutYGneV
        jwkdBFyn1B51jUBvq+kaYeoLAnNLQYl+X9ltCM5DxUs1uwiTKNzDEKGJUhvosw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596752006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mZLBLAIbdKaiA3wdTA7rUL51TgNpJlVhkmQwVAv+Fpc=;
        b=qIYoe7J1jyyDzLLkZQjLHTJMkee1TnwY8Nihzj6WkJCiFEa1xTZWxf7yD8xB+pwZP5S8Jb
        6AcSoOixylfKpBBw==
To:     sedat.dilek@gmail.com, Arnd Bergmann <arnd@arndb.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
In-Reply-To: <CA+icZUUcH91QDDEin9GyEoD8kqrQSPAnkZJyMnXU40Sk5FAo3A@mail.gmail.com>
References: <20200527135329.1172644-1-arnd@arndb.de> <CA+icZUUcH91QDDEin9GyEoD8kqrQSPAnkZJyMnXU40Sk5FAo3A@mail.gmail.com>
Date:   Fri, 07 Aug 2020 00:13:25 +0200
Message-ID: <875z9vh18a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sedat Dilek <sedat.dilek@gmail.com> writes:
> what is the status of this patch?

Just looked at it.

> I needed this one to be able to build VirtualBox via DKMS as an
> out-of-tree kernel-module.

Not being able to build the vbox rootkit is a feature, not a bug.

Thanks,

        tglx
