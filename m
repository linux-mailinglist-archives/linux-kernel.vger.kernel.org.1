Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E7A1F9DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 18:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbgFOQ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 12:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgFOQ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:57:19 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184E3C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:57:19 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so9991027lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIkal8pUfONI4oNrGMEW7FJGnsyPgxFx6nFiYlCav8Q=;
        b=BOdfnS1nQ1loTAy3XfZG4v2ypfE6UrK/J+Zd6u9ARxAU0HozZqAjdnCtxoLxulSvq0
         7PoDNtEz3pdUYnk9jHe+VKu0KTcBji19fekNHUB4EqiWzTIqAhfzI/qVn548WkWINsOo
         G2cfvtd1eBk/jMWvfGGb0/G2cdASiBLrgA7w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIkal8pUfONI4oNrGMEW7FJGnsyPgxFx6nFiYlCav8Q=;
        b=RE0HNpa6nZ3V3kPM2UIR9IjDl/ohVC5omfDujUNjUMCMBKcqDdpKfykfs1vgISPjR4
         8toW1tZP9uUh5EEYaf798NdboOc7Csght2o+jh3FGQDC5FjiN/xWY8TuReIh8sENOawl
         RaNOcTP4hAo969Oe6zCaMn37yZixIWHBUeTPGumybb3hQ3u3+ZkYsKKoemi1DGbsUgQp
         xth1JyDwEu+JxROavCXmzQh9Vt1+RSLJm44oApXGgkuDqG6SstlGD4Jpmp+foLkBKaYt
         8zi6I9ZVQRn/aDOyU8PzxbUkjVni/0k7WHBydbUwukADmGGfHtGClVJC5NcP1g5LSlfV
         u9Yg==
X-Gm-Message-State: AOAM5317IqZ6uIFeyDlH1rEnIDNvITXWg7IsV0yTZXPxqd9Hnoa9fKEz
        Yj7srlPfuEzqxM/JqndyUmYTaPHpgoY=
X-Google-Smtp-Source: ABdhPJylb5VcstnMRUP1PcbbgmrtFh2WMHdSw4D3BHWujgrpcqSTG+i6ak9I6yQlhOiL6bYRn2CQvg==
X-Received: by 2002:ac2:521a:: with SMTP id a26mr1104095lfl.192.1592240237158;
        Mon, 15 Jun 2020 09:57:17 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id o201sm222992lff.8.2020.06.15.09.57.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:57:16 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 9so20095346ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:57:16 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr12503482ljn.70.1592240235665;
 Mon, 15 Jun 2020 09:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200615121257.798894-1-hch@lst.de> <20200615121257.798894-11-hch@lst.de>
 <CAHk-=wiBJjjV4NuKr_z2Q3vWEXSoGtAmkH=jZ0SkBJ=wZh4=hw@mail.gmail.com>
In-Reply-To: <CAHk-=wiBJjjV4NuKr_z2Q3vWEXSoGtAmkH=jZ0SkBJ=wZh4=hw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 09:56:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVjH4C+PzyHfsR0+GzFUf_2XX5H_tQoHGqp+pMGuec7Q@mail.gmail.com>
Message-ID: <CAHk-=wiVjH4C+PzyHfsR0+GzFUf_2XX5H_tQoHGqp+pMGuec7Q@mail.gmail.com>
Subject: Re: [PATCH 10/13] integrity/ima: switch to using __kernel_read
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 9:46 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It worries me that you're making these kinds of transformations where
> the comments imply it's a no-op, but the actual code doesn't agree.

Note that it's not that I think the FMODE_READ check is necessarily
_needed_. It's more the discrepancy between the commit message and the
code change that I don't like.

The commit message implies that __kernel_read() has _more_ checks than
the checks done by integrity_kernel_read(). But it looks like they
aren't so much "more" as they are just "different".

                Linus
