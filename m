Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3662A271862
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 00:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgITWZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 18:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgITWZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 18:25:31 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4583AC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 15:25:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u4so9491005ljd.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVKjboQrT3oJ6ccGJ13Ynvvly8y25JK+SLQsgA3ssxI=;
        b=fRGthL0BPSiwRwvjS0tkxRE9LFQTexAi6uaerLKycgqPZrA/Iyv6NbJvNn1HvbgjtZ
         xJwNkCboa11XFK/6BtafMCZrxboBpnFbd2GRR2sATTuLKaYE4SGWgWWVo7ecxMjurIpy
         gkFd4X5yF1lh7KC96k6r6sHO1YWlYqFU4ETlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVKjboQrT3oJ6ccGJ13Ynvvly8y25JK+SLQsgA3ssxI=;
        b=qIwpz+Icx3Csa3p6YdaJmumsgEEk4AXNDBSPK2FnDPWXMO45FdNS1y+NFUM9vU0yQ2
         VA1bqbF23B2pkq4cHRta+G0r1tlkuqVhtmWFCk4uBc4rclGeNpr8QKRjgkX1OSRyYTwS
         +0O9hOlb4/pXpudFId1PIMVXNHHMAfNwUvLePtg1NMxK+yyAkRFEu20z2X59j6WMiFx6
         uIdiXKrWODSrvqVXoUXWACAWGlBAemVzLFi2pRbdnnVBIA7WJf5J8nieTxIlyMEYR7CS
         DJkHJbzD1aw0YiofouhWeUDfktS42ka3D4tcEMtwx+ahW6WnYSr6SAigws8nKPwMBQQF
         bD0g==
X-Gm-Message-State: AOAM531mD9hQxwj5orEfg8gqbxCtRkOyvKyWJdH67NODNjaR5XUURcfo
        QGluYiDyyYeaXf713X9HcvYR3NT403fd4w==
X-Google-Smtp-Source: ABdhPJylI7EV5XsLbDuxQAk3LkT84IVg1IdKcQYYbwQofW+IRcONir4gfDxr9LyKeLJSvDWSWmZD/Q==
X-Received: by 2002:a2e:6c03:: with SMTP id h3mr13883507ljc.212.1600640729308;
        Sun, 20 Sep 2020 15:25:29 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id z10sm2064741lfa.10.2020.09.20.15.25.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 15:25:28 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id u8so11939399lff.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 15:25:28 -0700 (PDT)
X-Received: by 2002:a19:8907:: with SMTP id l7mr13822198lfd.105.1600640727853;
 Sun, 20 Sep 2020 15:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200920193312.GD13044@zn.tnic>
In-Reply-To: <20200920193312.GD13044@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Sep 2020 15:25:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=witaxLCP4ZoxywTkJrcd3n+yBBJ46j3obsSFrcWK2Yjpg@mail.gmail.com>
Message-ID: <CAHk-=witaxLCP4ZoxywTkJrcd3n+yBBJ46j3obsSFrcWK2Yjpg@mail.gmail.com>
Subject: Re: [GIT PULL] efi/urgent for v5.9-rc6
To:     Borislav Petkov <bp@suse.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 12:33 PM Borislav Petkov <bp@suse.de> wrote:
>
> I'm simply forwarding Ard's tag, I hope that's ok.

That's ok, although it shows perhaps a weakness in our model.

Git actually would have allowed you to create a signed tag pointing to
Ard's tag, and we'd have had the signature chain that way. Although
I'm not even sure the commit signature code has then ever been tested
with that kind of odd situation.

But that might have technically been the best way of doing things
(kind of like sign-offs on commits when forwarding them in email), but
I don't think it really matters.

I just mentioned this odd tag forwarding in the merge commit instead.
It all looks fine, it's just a bit unusual.

           Linus
