Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB89029777A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753865AbgJWTFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753814AbgJWTFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:05:33 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E8DC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:05:32 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d24so3334850lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlX2QDr5JXTLV/+pFMeSHpaHIWIoMTpMZ3CHCWOoKfI=;
        b=IH9eUi1QJZocyOQ1cwxM2kztO+Z75OStTajGFwBB6CZKjBA+D5hdkycLXHmN0yjRfZ
         4SI5s0Dp0wg3jsFtMFs489W9VRXaiLdbTvdJ2x8eH+v3amoUYzHTWlVghgsF8jtfpzis
         JALnBVmvLXSsnUT1WcbbjqaHLPVvB0vMqCnXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlX2QDr5JXTLV/+pFMeSHpaHIWIoMTpMZ3CHCWOoKfI=;
        b=JtomDrlfDFbDWNGKkaopNrG9BlnD/+pVH1O2Vy3o2Y+R6IN1Qvi7ldQjasWp26BGR9
         YEuVEz2rs22WR1J+xPdnhDeRCrR0s5K1fnfC0ypPTYhTrbY0dytXDFdIltG94hQu89QL
         DRb/kp9NjkoVXdc6VIdLel8GcY/+NFL4V473+24TInIGXsEwcpnDLL9tCTDKbXF5cpFq
         KQcqFSh8WHsY054nouptIgQW9gp2l+UKEnQNvQQVV8IwftTJGvcgOXo2mdsNiLhkVFbw
         TME78OVTjbNwLrw90C6TBcYCFM5H6cwa7e1GM+xD4EubHk/snUPsvdTTNZw1dKmZL6Mu
         JiQw==
X-Gm-Message-State: AOAM533F+FU8W70sE+jz3oOOp04F8CWPyxEw80D6e7EGbwH6oTiAqenB
        FinhIZ0jI3LCYJ7GJoNDcWSCj9fck0e7Jg==
X-Google-Smtp-Source: ABdhPJzodx4cJFWCZrXY1CSToLhIVfc9YGVOb51qtxQTeh+keudyw2nvyWV5vKOWCgeByM5fiTpSIw==
X-Received: by 2002:a19:2291:: with SMTP id i139mr1194099lfi.387.1603479931053;
        Fri, 23 Oct 2020 12:05:31 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id s3sm255629lji.81.2020.10.23.12.05.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 12:05:29 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id l28so3326612lfp.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:05:28 -0700 (PDT)
X-Received: by 2002:a19:4b03:: with SMTP id y3mr1127466lfa.534.1603479927999;
 Fri, 23 Oct 2020 12:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201022144826.45665c12@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201022144826.45665c12@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Oct 2020 12:05:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxBeNJTac5PDkzbdtvO3bZn+f9DzSHk-A6gzUAxFHVQw@mail.gmail.com>
Message-ID: <CAHk-=wgxBeNJTac5PDkzbdtvO3bZn+f9DzSHk-A6gzUAxFHVQw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 2:48 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Latest fixes from the networking tree. Experimenting with the format
> of the description further, I'll find out if you liked it based on how
> it ends up looking in the tree :)

Looks fine to me. Honestly, the format isn't a huge deal, as long as
it's understandable. But I do like the grouping, since that increases
legibility.

A lot of my editing of these things end up being about trying to make
the merge messages from different people look somewhat uniform (a
couple of common patterns, and generally a somewhat common indentation
policy etc). And yours have already been closer to the norm than
David's numbering is, for example.

But I don't get _too_ hung up about it, the most important thing by
far is that I get a feeling for the overview of the changes, and that
I feel the commit message is useful and sensible for others that are
interested in what's going on (ie I will generally try to edit out
things like "This pull request does XYZ", because that kind of
language makes no sense once it's a merge commit in the history).

             Linus
