Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9D51E5695
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 07:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgE1FhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 01:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgE1FhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 01:37:06 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D635C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 22:37:05 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n24so30679967ejd.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 22:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gy40l8ytYFD4On3jgRuXuVgXsORjyYNKkP1fvl5BPX0=;
        b=vWo864aurC3+M/TSNk+TthFtkQQX7o1qOe+6xoraeNLnBopLzJ+cKiNE9ze2TczG4A
         apWyilBlgzHifms1ZTkgrkWquMTTFnicFuQj8WvbFCPUTiFFCnCrt+2MQpOY9TEQ/GtE
         tWwMFlYSdq20cIKnO45SgFSiS316pCt0NZhT1LVoUsOrD7dNSc/QTpaQLXc5ZqXl81OI
         dEd76mirnI/VA4NAvDYULb0mSfQ48A74hJ9dv1t3bQZisfpvfIFExUEaOwcHCnfGzcqF
         /8eUgfVNyWcDB1FXKHS8vjYUgjmNPKqFHWHnkdEMsNFq0Z1ao1txQmdO/utYhgaUEYu/
         9UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gy40l8ytYFD4On3jgRuXuVgXsORjyYNKkP1fvl5BPX0=;
        b=A00NrEHZufyZErKvSsIDIFX6xPgwcXD6Ttj2N+ktS4QMKtmAh5NMNWnNOMkukmVou5
         UiBTIeCV7/a9KdX8J0vWWnf+b+3vSHJKJR2YoYKHSYSAFapgt22e0Otxn2oviZP0xNJM
         znTw7zLRMnAvm60u0YBXgfsFEtVysUFxzN/uJYAU6jA5AiZUkFmSErccZJc01UOfRdIy
         OB7B80OkYNUmGcCQikF2qCmYvJN4+wHXyYi7CP7AByAeE89j59Awmg9IxGgmPtaIRa01
         iG/MXOv9juXG3K7mqqPMe0lUd2SUvqvR3nL9TpwzSk0mtOD/n/UxYNQ4VOnLvrYrcJuc
         1uhw==
X-Gm-Message-State: AOAM531GHJDvEVfzpq3X0RYFDxnwn0EUXM9Bkwf7xUwcUXeCqM4tIV0d
        HGUQRX7BRmpicOqsotw4faPuHjxdRxNeanMVbRyQOQ==
X-Google-Smtp-Source: ABdhPJyX6LHyIsUbfRxySNpFhUlOfjIe8odA5lY+ulB8QAePBB1iqSkzOITEmqNMBTGJ6Z5OnJTvXRT1ZsFQGxUMdWI=
X-Received: by 2002:a17:906:57c5:: with SMTP id u5mr1409803ejr.419.1590644223757;
 Wed, 27 May 2020 22:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200527134254.854672-1-arnd@arndb.de> <CAKb7Uvhh2JKck524D9S14uNSLykFj+U48AgR+sd2uwchsH_wEQ@mail.gmail.com>
 <CAK8P3a3kRP6Sg-An5szsN=4Pv1OsG+-YQYa1wgxJCi1c+uedPw@mail.gmail.com>
In-Reply-To: <CAK8P3a3kRP6Sg-An5szsN=4Pv1OsG+-YQYa1wgxJCi1c+uedPw@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 28 May 2020 15:36:52 +1000
Message-ID: <CAPM=9tw_D0edbF38iFSrecDM8gnK4wNCDGiL2JV86tSUAmSk6g@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] nouveau: add fbdev dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ilia Mirkin <imirkin@alum.mit.edu>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 at 00:36, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, May 27, 2020 at 4:05 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> >
> > Isn't this already fixed by
> >
> > https://cgit.freedesktop.org/drm/drm/commit/?id=7dbbdd37f2ae7dd4175ba3f86f4335c463b18403
>
> Ok, I see that fixes the link error, but I when I created my fix, that did
> not seem like the correct solution because it reverts part of the original
> patch without reverting the rest of it. Unfortunately there was no
> changelog text in the first patch to explain why this is safe.

No it doesn't, I think you missed the pci in API name.

The initial behaviour doesn't use the pci version of the API, the
replacement did, and the fix used the drm wrapper around the pci one.

So this patch isn't necessary now that I've fixed it the other way,

Thanks,
Dave.
