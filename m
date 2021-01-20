Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37F92FE31F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAUGoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbhATXla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:41:30 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40E5C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:40:49 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id i17so481660ljn.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0EKRpra5vnzlsqH1m61RjZinafDpDBSUNcZj2tUSZQ=;
        b=F9fdoDC9z6i3C7NWkauOjoq/M4vmZThwArdnXgPvBySNEv8Jst9vRqTbwdOQOEnAjc
         eZBSBZ4ouTsYIWAIdUidT+baAn/6s62LyePwXZmdBFmPKANnX1bMJ7sDUQMs0B6q0S4w
         LYEZVKl1qiT/ODWqFXNDHv7I5oaz/1MGUUAhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0EKRpra5vnzlsqH1m61RjZinafDpDBSUNcZj2tUSZQ=;
        b=UlUV2UguhyX4xWxTmaHADKscaczHhbKhq8OmTQtJSfGJJoHBemvbFthAbIfwHh1x1p
         UimIO+32JeZ95/JBgUtaLAHH7wSj12PEQOhyh2O/WRZKOcEvg99gbAEgcvt4cz/xcgzG
         rsxGW+0Or4SFI8OHcO6qya7i8DZN7Sg9+vRPeIXBO75thZNTfIhfd3hzblubCuMESKhQ
         R3u7likDZh5t35nU/hn6vS5acsGYUO5zuh3Kcw024LTDXVxGE1NRHdQwDer66x2gSxCa
         Ys0JWdGp29G49FEiDpcVr5fLy/g/r1x+R6uFNzbLbWyD8WX+ObRdoHQv2sRSmKtJ+ZdY
         0p/Q==
X-Gm-Message-State: AOAM530XgAuZyCEyfy6Eg9JGrO1lQGi3Ku0mSgfKePxqpl0xxsEOXJZi
        RGMBfJuhPlQe/9hBS8/hcBiPMAQHb1vtJg==
X-Google-Smtp-Source: ABdhPJyqt0fE3VMufA7MX/8AnipNgp5FNnI9Q/Xy3IIxE20GPguLbOjfFw00imVnDeACq7YcxAWY8Q==
X-Received: by 2002:a2e:8714:: with SMTP id m20mr5193292lji.320.1611186048005;
        Wed, 20 Jan 2021 15:40:48 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d24sm326527lfc.225.2021.01.20.15.40.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 15:40:47 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id p13so475378ljg.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:40:46 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr5862326ljj.220.1611186046375;
 Wed, 20 Jan 2021 15:40:46 -0800 (PST)
MIME-Version: 1.0
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de> <20210118193457.GA736435@zeniv-ca>
 <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
 <20210118195400.GC736435@zeniv-ca> <20210120162608.GB740243@zeniv-ca>
 <20210120191116.GC740243@zeniv-ca> <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
 <20210120231439.GE740243@zeniv-ca>
In-Reply-To: <20210120231439.GE740243@zeniv-ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jan 2021 15:40:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=widQ+oLHbm=wSrewpLgXJg_FWCZV3BERmaEAx+ZCMfmZg@mail.gmail.com>
Message-ID: <CAHk-=widQ+oLHbm=wSrewpLgXJg_FWCZV3BERmaEAx+ZCMfmZg@mail.gmail.com>
Subject: Re: Splicing to/from a tty
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 3:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  Why do we clear FMODE_PWRITE there [seq_open - ed], anyway?

I think it's pointless and historical, and comes from "several /proc
files supported the simple single-write model, nothing ever supported
moving around and writing".

The seq_file stuff was always about reading, and then the writing part
was generally random special-case hacks on the side.

So I think that "clear PWRITE" thing is to make sure we get sane error
cases if somebody tries something funny, knowing that none of the
hacky stuff support it.

And then the very special kernfs thing adds it back in, because it
does in fact allow seeking writes.

             Linus
