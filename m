Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71641BE450
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgD2Qt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 12:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2Qt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:49:26 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A01DC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 09:49:26 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j14so2256134lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9Uuz2eH1rEC3Rsd9pWrnSIaGFJoBuGHkEpyj9FO1RU=;
        b=fNkYlfC7XyU0na36V1nAsEErxJD6SCdd001tONSj5QzCTF5pfnhtkJHTnLvT4RbjHZ
         Esmpn/Ja4kfMTNbK4V/ULBUaFnl8J/DehN+PSbsUTUNm9u5a0/1rtLVU7yIw59uOmHc1
         Oz8J1e1DSH0V3mg6CW+Ys3Xe1HiKJDyaEj9z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9Uuz2eH1rEC3Rsd9pWrnSIaGFJoBuGHkEpyj9FO1RU=;
        b=IJDQ3g1oykEoOkoqC4DwVBz7oTiqfl8GHX5xp7a8FcOHrVW41Egw6nL4ySktL5BmUs
         umdVJ/3xkwWG+OzG+BEQBOyi93E7ETJGGS70mvNYPAdbCavMcpZGMkNmElrRT7GrdE5g
         uXmADH4VXsTWKv4CocPb4l/apHyMwbFQADZPBuhg3LQyVftDNu56bhiScxTvzL2Th+wO
         Qe4YMGQCr6kFUb+5af1DcsvpaY6vT4DjXfCJL/l2wmOIVIfWDoSvayVmWTW7ab3pgfWD
         ohm1tOwg1BkDDyDIytcTCxqP8FsZvebCLIDR6YpTRvPGdJWFP3dSDJCJS0Z2YebYFKJy
         cyfQ==
X-Gm-Message-State: AGi0PuacQFyN9yFvO0y/8Zg3//ibF7ay+/JJcgVaxCwHZJPtYh4lFRzc
        9pZiqilM4n3IuP/KTrGJE5WvE3g6zEQ=
X-Google-Smtp-Source: APiQypJIwsW62bIBM2PrWmRf+QEnBc4jPGqD+ocYUwBsHtV2evu3K9NisWFrn4Cs5MXVlxhR1f5sbw==
X-Received: by 2002:a19:7507:: with SMTP id y7mr23501746lfe.121.1588178964259;
        Wed, 29 Apr 2020 09:49:24 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id i14sm2977100lfl.21.2020.04.29.09.49.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 09:49:22 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id h6so2287566lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 09:49:22 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr23676248lfl.125.1588178962247;
 Wed, 29 Apr 2020 09:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <158810566883.1168184.8679527126430822408.stgit@warthog.procyon.org.uk>
 <20200429060556.zeci7z7jwazly4ga@work>
In-Reply-To: <20200429060556.zeci7z7jwazly4ga@work>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Apr 2020 09:49:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHoa0onB0KTthLXeHNNBupcPOdf38OEoFFy3ok3nOeJA@mail.gmail.com>
Message-ID: <CAHk-=wiHoa0onB0KTthLXeHNNBupcPOdf38OEoFFy3ok3nOeJA@mail.gmail.com>
Subject: Re: [PATCH] Fix use after free in get_tree_bdev()
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:06 PM Lukas Czerner <lczerner@redhat.com> wrote:
>
> This fixes the problem I was seeing. Thanks David.
>
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Well, it got applied as obvious before this, so the commit log won't
show your testing.

Commit dd7bc8158b41 ("Fix use after free in get_tree_bdev()") in case
anybody cares. Didn't make -rc3, but will be in -rc4.

          Linus
