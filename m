Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858D725CE4F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 01:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgICX0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 19:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgICX0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 19:26:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72592C061246
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 16:26:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r13so5823753ljm.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 16:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eoc+5mie1+ZuNTuaPcGzSI2qJ6owz7A4Ofr10ghZJJ4=;
        b=gWGJKo5xiJNWPTtwqGkQlOlOwg3GjNMHWAbbLf6G2umLeN+ziH7HLU4o7mqfu6xrQX
         0nqy/1qDWFPlTHlbUl4hIrosGA73uytx27UrMGezo0ol7EOlqSXT8KqCo6mWmcDs1cwA
         at576v5S6IW6A1SwuGUswjPYeT1mwL3S6Pfko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoc+5mie1+ZuNTuaPcGzSI2qJ6owz7A4Ofr10ghZJJ4=;
        b=QiwGeQv9ATBy5dkILFj95qidpKHCUQvpklrqKTbITx89DYjH1UkL0eA3shTPe8frNG
         mHIAIUsiUk+msnZjrgl38XKYydIya+s4N8fAHzGPcvW4UyQfi7O6vtCdNuH09eGqpP2K
         hEUYjWFzqPRvHdysCcvw/ezumMHc7YnfP4z0YDzQ1bTDyIwlUHQ0kcs2Fjk6zMIwCu7k
         stbzaMVNKGNnuak53iLGu/n6zySCEbivvnzPo+mTPgV7nGupOTqPe3pdeOP55KJyk9AW
         wsZd/eCxjMwkylQGYiR45MVQSd4h+3UjuJAfK7uUvjlrLYFotH39KIx/I2a3idxsjP2t
         CpSw==
X-Gm-Message-State: AOAM532sV01KNeIPhaEeL8OYTS8h94LYmlZSuYZctEPitgNVzbxKDM5a
        ltmMyjle0GF1A+NEyvgA5KNZrjHuNKG7jA==
X-Google-Smtp-Source: ABdhPJxd4U7iZ5C4dc/7Li9mZ0PgdHKvOue3oPpnJrD7a1k5kPqUgLpOHYZcFW9hHqD0+Pg4NDIS6A==
X-Received: by 2002:a2e:7615:: with SMTP id r21mr2312830ljc.371.1599175573240;
        Thu, 03 Sep 2020 16:26:13 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id l16sm901224ljb.72.2020.09.03.16.26.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 16:26:11 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y17so2853200lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 16:26:11 -0700 (PDT)
X-Received: by 2002:a19:4a88:: with SMTP id x130mr2429205lfa.31.1599175570612;
 Thu, 03 Sep 2020 16:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de> <20200903142242.925828-13-hch@lst.de>
 <9ab40244a2164f7db2ff0c1d23ab59a0@AcuMS.aculab.com>
In-Reply-To: <9ab40244a2164f7db2ff0c1d23ab59a0@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Sep 2020 16:25:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDtnudkbZ8-hR8HiDE7zog0dv+Gu9Sx5i6SPakrDtajQ@mail.gmail.com>
Message-ID: <CAHk-=whDtnudkbZ8-hR8HiDE7zog0dv+Gu9Sx5i6SPakrDtajQ@mail.gmail.com>
Subject: Re: [PATCH 12/14] x86: remove address space overrides using set_fs()
To:     David Laight <David.Laight@aculab.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "x86@kernel.org" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 2:30 PM David Laight <David.Laight@aculab.com> wrote:
>
> A non-canonical (is that the right term) address between the highest
> valid user address and the lowest valid kernel address (7ffe to fffe?)
> will fault anyway.

Yes.

But we actually warn against that fault, because it's been a good way
to catch places that didn't use the proper "access_ok()" pattern.

See ex_handler_uaccess() and the

        WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in
user access. Non-canonical address?");

warning. It's been good for randomized testing - a missing range check
on a user address will often hit this.

Of course, you should never see it in real life (and hopefully not in
testing either any more). But belt-and-suspenders..

              Linus
