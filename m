Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4433F2B7284
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgKQXgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgKQXgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:36:52 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B029C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:36:51 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id l10so288976lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0kv/TGZCBjgkfEmVlmQGbddq7Vuqk22W0hkuqKhgPg=;
        b=ZfCK9fE5KEx2c6LJVDvCKbk18EHOGfANhut79KLdPiY11VCpPSw0vPYJaLCzYbWfN7
         rxR97+wOKkrhlTSFjVmx0Ens33MZNx+ydmyDkcSx3o5aSc4rS+WnAeqjoTEjOy+8p4IX
         mcTfZ1lbMzrFtnx5GPNlU5oqnxJmpNU4bc8o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0kv/TGZCBjgkfEmVlmQGbddq7Vuqk22W0hkuqKhgPg=;
        b=bZVWgxl8qlIo14IdZIB5dBDWcDGsBaUlaNsoS23hyRdWBEB6yNxeRRheJLID7eHPvY
         5SBt3CpLZaO0bJpYPmZNV/l0UGIe3o9+AJ3KbOOzpLQo45V7mC3d/2ZwH2taWjYKvZSb
         Dni5V55gH1u9jwdHh55cp1quOHa/OqmS4THSezmq/mRmyTjZtaspU7o7iTKPbw2xHgAK
         Mm5tWmSnQdBEX7bLi1fbN+HfC6Sb453iuPs9whVxhcHPXb1v3kN8pw1eVBmzdJJXipT2
         HphH1bjzUmMEjBN2Unl5CAGV9MrWNTVzDxBOjLCBIzQwXhI0WdNoAs7Dy8gEtMJxHOgE
         10zw==
X-Gm-Message-State: AOAM532XS6VSRzpYArWGzsUdgQslhUNxLhZyyQiGmEnNmCGMNpJTcmp2
        rmWFDU2wIJBcqYuBi8mnjmPBnevY4G9sLQ==
X-Google-Smtp-Source: ABdhPJxp/AbQhcANv51gioGSEbj46Gz9en+yUkF3kLKD4Otw8fX91HipR5nA/q5VieILZyw/2m6x8Q==
X-Received: by 2002:a2e:8e76:: with SMTP id t22mr2942401ljk.10.1605656209724;
        Tue, 17 Nov 2020 15:36:49 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id r19sm1535218lfi.41.2020.11.17.15.36.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 15:36:47 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id y16so311876ljh.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:36:47 -0800 (PST)
X-Received: by 2002:a2e:80c7:: with SMTP id r7mr1059615ljg.285.1605656206837;
 Tue, 17 Nov 2020 15:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
 <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
 <20201116174127.GA4578@infradead.org> <CAHk-=wjd0RNthZQTLVsnK_d9SFYH0rug2tkezLLB0J-YZzVC+Q@mail.gmail.com>
 <3f8cc7c9462353ac2eef58e39beee079bdd9c7b4.camel@linux.ibm.com>
 <CAHk-=wih-ibNUxeiKpuKrw3Rd2=QEAZ8zgRWt_CORAjbZykRWQ@mail.gmail.com>
 <5d8fa26d376999f703aac9103166a572fc0df437.camel@linux.ibm.com> <CAHk-=wiPfWZYsAqhQry=mhAbKei8bHZDyVPJS0XHZz_FH9Jymw@mail.gmail.com>
In-Reply-To: <CAHk-=wiPfWZYsAqhQry=mhAbKei8bHZDyVPJS0XHZz_FH9Jymw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Nov 2020 15:36:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjinHpYRk_F1qiaXbXcMtn-ZHKkPkBvZpDJHjoN_2o4ag@mail.gmail.com>
Message-ID: <CAHk-=wjinHpYRk_F1qiaXbXcMtn-ZHKkPkBvZpDJHjoN_2o4ag@mail.gmail.com>
Subject: Re: [RESEND][PATCH] ima: Set and clear FMODE_CAN_READ in ima_calc_file_hash()
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 3:29 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Nov 17, 2020 at 3:24 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > I really wish it wasn't needed.
>
> Seriously, I get the feeling that IMA is completely mis-designed, and
> is doing actively bad things.
>
> Who uses this "feature", and who cares? Because I would suggest you
> just change the policy and be done with it.

Another alternative is to change the policy and say "any write-only
open gets turned into a read-write open".

But it needs to be done at *OPEN* time, not randomly afterwards by
just lying to the 'struct file'.

Why? Because the open has told the filesystem that it's only for
writing, and a filesystem could validly do things that make reading
invalid. The simplest example of this is a network filesystem, where
the server might simply not *allow* reads, because the open was for
writing only.

See? IMA really does something fundamentally quite wrong when it tries
to read from a non-readable file. It might "work" by accident, but I
really do think that commit a1f9b1c0439db didn't "break" IMA - it
showed that IMA was doing something fundamentally wrong.

           Linus
