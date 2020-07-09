Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0421A69E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgGISJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgGISJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:09:02 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E01BC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:09:02 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u25so1713544lfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLUY2+cROQWDH9LIMjuUg8XLSdiwCev/lP1hc9DwpHE=;
        b=Xw17pp3QVH4SLTeelEhTcbB9WI56tYv4leZAltXzvEIWNs50TewZI2tfSpQ7QZMxH6
         5F3rhBO6EWtqhrcf2t3KoUtkNyWFvvLaN2SzNstCrzohcqjTqUHBNcOnAIhq1Jin6fEG
         t49EF28LHN/k7FfZi6olVrtLnJMu540l0OAEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLUY2+cROQWDH9LIMjuUg8XLSdiwCev/lP1hc9DwpHE=;
        b=qJeKrP32B6oUngjG9BzbJrcVEBf2ozOhq0FjXEeV0VFkqnGnNNGLGOuCnnlzUtvt41
         5IRr+htczIBiO8ddONaHJ24uNoN24JFc+TyXQvQp2w2QHKA0mIie0feWWIAzfnaQzTBo
         rGjue4uIGHWVpENRd3CgSwm9MmZX7u1o9axT8jCP3Ryx3qUd6hISETJhqUmYHr2fCjB3
         t2XIHfRu7HsVUc/a4G8ZCiTq6SMIRN1hRkIRyFAWdU6T+BAb91rcrXDTYo6rSz/vJbVD
         usjoGtrDFZ8wTkme0ClgR42jplPKC5f4tBeNsieu2d1UuuC76R20qvjYfDPzY0bhrexc
         jOSQ==
X-Gm-Message-State: AOAM532wZrDo3Wp++fRi5M+Z9B8lYcM++zAis8NKopLQM7jcDxL1P8tZ
        95FAiIUYvdQzKqYp1HfC/mC5EFPm5MA=
X-Google-Smtp-Source: ABdhPJzEOmBJmf8RgK6zibC9ElzVLx0ZZ5G6pbLKaD/PDNAOeEK1zP21J6gv9w5W5XwoVB+T7PbIUA==
X-Received: by 2002:ac2:57c6:: with SMTP id k6mr40780193lfo.179.1594318140304;
        Thu, 09 Jul 2020 11:09:00 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id q3sm730896ljm.22.2020.07.09.11.08.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:08:59 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id z24so3439053ljn.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:08:59 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr36562158ljj.102.1594318138800;
 Thu, 09 Jul 2020 11:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200709151814.110422-1-hch@lst.de>
In-Reply-To: <20200709151814.110422-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jul 2020 11:08:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibathZJc6oSfgBdw7qhW75eF1ukg9y3bMXFfmp5t_uig@mail.gmail.com>
Message-ID: <CAHk-=wibathZJc6oSfgBdw7qhW75eF1ukg9y3bMXFfmp5t_uig@mail.gmail.com>
Subject: Re: decruft the early init / initrd / initramfs code v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 8:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no really good tree for this, so if there are no objections
> I'd like to set up a new one for linux-next.

All looks good to me. I had a wish-list change for one of the patches
that I sent a reply out for, but even without that it's clearly an
improvement.

Of course, I just looked at the patches for sanity, rather than
testing anything. Maybe there's something stupid in there. But it all
looked straightforward. So Ack from me, with the hope that you'd do
that "vfs_chown/chmod()" thing.

                Linus
