Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E7C1BD06F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 01:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgD1XKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 19:10:04 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:41199 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgD1XKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:10:03 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 078fe6c1;
        Tue, 28 Apr 2020 22:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=+pPISQMqFxTrP0qCf0FuggC3lus=; b=qlxGJY
        WGjse5gcNmibU1zg7WYgXb0/RjibCS2lWFDFwOItuz2ICRpA6pP0XgSMX4oSK2zI
        lPDjZtg1823vzUmS/wNxKGv/1AW1mgsNsKRHlvMhIStABHh00tHR2SVgwtN80vGU
        nTeqnfescZsyFbCOg+ghbdROG++vJYRIR0fX2SC4pgsMdb0GiHkbMLiDjuNTqwIy
        bjKMFdkfiPCSAt2Wfek/OUSww8nGcOyXtJHZUIHP0zXxYF3WOMjoU0EHmCPBoCV+
        1W3q4C6nw8oRFR+jMXRPySL+F1bAhZdoZQYkLhsZgUUZjBxaYYIFcdSf0mx29lqb
        a1FRnbEGywcJKFbQ==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 55194e36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 28 Apr 2020 22:58:16 +0000 (UTC)
Received: by mail-il1-f178.google.com with SMTP id q10so662516ile.0;
        Tue, 28 Apr 2020 16:09:57 -0700 (PDT)
X-Gm-Message-State: AGi0Pua390tvs2fRci/PorK/38awMqBJvIVnTHB8PX0V5j6ORUhcPMMT
        O/1dWJH64BVmphlZIUgnfllkg++9dMaP8xVEaHA=
X-Google-Smtp-Source: APiQypLFBTEqzIsMWL5IIDmD+RjrMKuT2Kwxq90aLIbknJdICxwCpdyDqftd7SMlsayBnczg1Do3aTutqcTKnU4j77Y=
X-Received: by 2002:a92:d98c:: with SMTP id r12mr29411687iln.224.1588115397226;
 Tue, 28 Apr 2020 16:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200422200344.239462-1-Jason@zx2c4.com> <20200422231854.675965-1-Jason@zx2c4.com>
 <CAMj1kXHV=ryaFmj0jhQVGBd31nfHs7q5RtSyu7dY6GdEJJsr7A@mail.gmail.com>
 <20200423184219.GA80650@kroah.com> <CAMj1kXF9uLUE3=rX1i_yYoigB7j-nLMZpGc35ve2KV+NxjRhVQ@mail.gmail.com>
 <20200423202348.GA2796@gmail.com> <CAMj1kXGAUQ3DT-9roymODC20+GPFv4R280r1BrN=juHtYhnq7g@mail.gmail.com>
In-Reply-To: <CAMj1kXGAUQ3DT-9roymODC20+GPFv4R280r1BrN=juHtYhnq7g@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 28 Apr 2020 17:09:46 -0600
X-Gmail-Original-Message-ID: <CAHmME9oS5L0GXAUvBAuz7a2WtRT=nBQk6H7-iHKnspao4ckgjA@mail.gmail.com>
Message-ID: <CAHmME9oS5L0GXAUvBAuz7a2WtRT=nBQk6H7-iHKnspao4ckgjA@mail.gmail.com>
Subject: Re: [PATCH crypto-stable v3 1/2] crypto: arch/lib - limit simd usage
 to 4k chunks
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

This v3 patchset has a Reviewed-by from Ard for 1/2 and from Eric for
2/2, from last week. Could you submit this to Linus for rc4?

Thanks,
Jason
