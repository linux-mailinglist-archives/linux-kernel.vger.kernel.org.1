Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F1A1A3B64
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 22:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgDIUek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 16:34:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33136 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgDIUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:34:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id q22so1176904ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a17YufEga9jnk+rgyH4vzLPfXMVuVPsDZ6W27y5AWxI=;
        b=bcodf7k76qWbzKM2JNgsCzbqA1Xun50xmz3N3JshhB8QIIESOoi69MIBaCB91pvyt7
         M7bvuW47x/pN2V6IJxSyeInBJZuttbCXX5J0NDPbruwBN6gG44tItnKv5mBm6V2zWKKl
         paq/JWoKNaq7/n525kX/rdVAkPNBx4naEwJGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a17YufEga9jnk+rgyH4vzLPfXMVuVPsDZ6W27y5AWxI=;
        b=AkiJOjKJtfMzUWl6zlX86IE+IoKH8LLWpvLuNK8Cl/ui1krDLNV2mWAoKnezMeSEnw
         IiWBXU2c3+g7cUUd57Gac+va6Br7H5iyxHSSYNNIrfvAjXtcigtxU+pkwXkE7aoCrcVi
         BWnvENUa3SPeq83KS4lDAo/N9zPj9j/pSylxih8V79BmeHkEzbYTsXllV8aF8jC+JSLW
         I1kHhi7t4SnehICJ2CJJ8HAy4HKGfV+IotBvCv2klcg/qdTG8SC9edywAoltR0taU8Gs
         emvkvglhAh4KSFfmoG8hDt5fBXMzgOHRJrcbAEWXGVDaTQzTOSNrlWn5JuXt3N5pycBj
         rC9g==
X-Gm-Message-State: AGi0PuZml64MX6HTiGKkMrg8v91H3bpMKhda8o6zZRcav4IP94GTs9nq
        KQF3nbiQFavmnp/czOyWjroym8KsKi0=
X-Google-Smtp-Source: APiQypLNxmI4jvuJ4PJ3PVm0dJraMyofQ+a+C+ecGXGIl9WeFlRXPkGEtmbCLuX8w5Sp4Fb9+veYQw==
X-Received: by 2002:a2e:3a16:: with SMTP id h22mr915321lja.81.1586464477078;
        Thu, 09 Apr 2020 13:34:37 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id e20sm16552960ljn.107.2020.04.09.13.34.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 13:34:35 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id q19so1111161ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 13:34:35 -0700 (PDT)
X-Received: by 2002:a2e:870f:: with SMTP id m15mr1007489lji.16.1586464475263;
 Thu, 09 Apr 2020 13:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200408014010.80428-1-peterx@redhat.com> <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <20200409114940.GT21484@bombadil.infradead.org> <CACT4Y+ZvQ9UvVAwTjjD8Zxo0X_nfxa3+6n6TqWk2g+hahBwdCw@mail.gmail.com>
 <20200409111604.c778ff091c00fab5db095e48@linux-foundation.org>
 <CAHk-=wiU77DeNxQsU4XrDCk59asyTs=Hn+mnTx6-SHB1_fA2NQ@mail.gmail.com>
 <20200409121250.d6bba6965b86c8dfcf325fbc@linux-foundation.org>
 <CAHk-=wgy3XRiyRP7vdfF6bHwWGaB1RwyWJmyphh+Q3qYk6w27w@mail.gmail.com>
 <20200409195633.GZ21484@bombadil.infradead.org> <CAHk-=wi50jKXOFpsRkxrqu4upNnEKm1oRZ_SG1yJB9QVh=VJZQ@mail.gmail.com>
 <20200409202751.GA7976@gmail.com>
In-Reply-To: <20200409202751.GA7976@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 13:34:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj64Uw1O9-f=XYCraLgbqBqqBHSdyO1JG80smvC-01Nug@mail.gmail.com>
Message-ID: <CAHk-=wj64Uw1O9-f=XYCraLgbqBqqBHSdyO1JG80smvC-01Nug@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 1:27 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Would it help if bugs blocking testing on linux-next were Cc'ed to
> linux-next@vger.kernel.org, so that Stephen could investigate?

Maybe. I'll let Stephen say.

But I think the big issue is the "blocking testing" part.

If it's "just" regular bugs, then:

> FWIW, the issue of "syzbot report sent and ignored for months/years" is actually
> a much broader one which applies to all bugs, not just build / test breakages.

I don't  know what to do about that, but it may be that people just
don't judge the bugs interesting or assume that they are old.

That's what made bugzilla so useless - being flooded with stale bugs
that might not be worth worrying about, and no way to really tell.

So old bugs generally should be aged out, and then if they still
happen, prioritized. With "this keeps us from even finding new bugs"
being a fairly high priority..

One de-motivational issue with syzbot reported bugs may be that they
sometimes get sent to the wrong set of people - but still wide enough
that everybody feels it's somebody elses issue. A kind of bystander
effect for bugs.

                Linus
