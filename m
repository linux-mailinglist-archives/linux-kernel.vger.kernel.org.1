Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEEA2819FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbgJBRot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBRot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:44:49 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7AFC0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 10:44:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u4so1857042ljd.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d98XeALx0jpZHa3k7E1jf9qNoDRB0A1nKFjz/K+o3Oc=;
        b=hl0PuFaoCAMYj8GG2Pfudjx+2xWIyYM9u8C0Qdhem4qPxdVN52uCOBMZr+AlpJ6RO/
         ipSBRwR2iybCGpME/uDGHDNjW1tSQeQNJ5s9JnnASrNUSYKfu65jvz9TAwA+F5Y5sLiI
         pNXkx5CP960QQ0z0dbv4LFfwNZkQIWPTE3pkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d98XeALx0jpZHa3k7E1jf9qNoDRB0A1nKFjz/K+o3Oc=;
        b=qpWvHHfzioqJYeL0Yp1m5JO6wOSpTy2ZzgAayPU7Ji3AJ4ilj3t0KDOhbYGNrZnj8G
         xP+EY2YK9Pl9Dm6huMC6DwXL37855TmkcgfL4xEGY8Y7kTNCiWZ7g52xO2/FfgzQHL6i
         TUSBdCaYxW7xEOTIh5r9yYdfRQ1A3mXvcOneGkRKa1kceJRSeeRJPzzYFFHVcsfItifx
         dxG16pdaIphew2MNMM+ixjL6O7UZ8tJLaAOBYasiSIP5K5yuE6+hzOOOMv13Uk8KoD+2
         WgUkuT3Gd1zelD4UjeH7yWxJGdcGSZF3Y9poxkQlWYC9+1iNdIkRgBV0CI20UPfoWipd
         43ug==
X-Gm-Message-State: AOAM5317jEprvS3iLmT+34uPu3JDCzslZSoTUuKDnkEE0xEEdppxQAai
        Bat2jnc3EgyWRxi6BEnGXgL/NkIAqeT5KQ==
X-Google-Smtp-Source: ABdhPJyQKBZbQuPYyM4JeaEDCDuwAJir7xveukZfRUeYypyC1CaCl4PVSgDAiaaSGE0Kj5geWuq0BQ==
X-Received: by 2002:a05:651c:554:: with SMTP id q20mr1115396ljp.348.1601660686894;
        Fri, 02 Oct 2020 10:44:46 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u2sm428766lff.255.2020.10.02.10.44.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 10:44:46 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id b12so2848505lfp.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:44:45 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr1368289lfg.344.1601660685616;
 Fri, 02 Oct 2020 10:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201002172025.GJ3421308@ZenIV.linux.org.uk>
In-Reply-To: <20201002172025.GJ3421308@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Oct 2020 10:44:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHFbAaqS0h_D-9d1=Yc-iq96wE-hrrqOfptGNUZx-GRg@mail.gmail.com>
Message-ID: <CAHk-=wiHFbAaqS0h_D-9d1=Yc-iq96wE-hrrqOfptGNUZx-GRg@mail.gmail.com>
Subject: Re: [git pull] epoll fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 10:20 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Several race fixes in epoll.

Fudge. I screwed up the commit message due to a cut-and-paste error
(don't ask - sometimes google chrome and gnome-terminal seem to stop
agreeing about the normal X paste buffer)

And I extra stupidly pushed the thing out after the build succeeded,
not having noticed how I screwed up the trivial commit message.

I've force-updated the public sites, and I really hope nobody pulled
in that (very short) time when my tree had a bogus commit message.

(In case anybody cares, the commit message said "SEQCNT_MUTEX_ZERO"
instead of "Several race fixes in epoll" because that's what I had
looked at in another terminal. So it was a very WTF message)

I think this was only the second time I had a forced push to fix some
stupidity of mine. So it's not exactly _common_, but it's
embarrassing.

                    Linus
