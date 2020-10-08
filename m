Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B4E287534
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbgJHNXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJHNXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:23:25 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C9AC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 06:23:23 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t7so4410198ilf.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 06:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5p9In3c0U7T6cVuoZBmWzXApSWOi+BckNf5ncuvNs8I=;
        b=PwyldEAvIJgXJSsl5CHzKf5lUZLC079HI2xVpd53hlK7EOH0HlVGE+yk8MyWaWw4f9
         +PKdgtgeX3mySa1ihAZLprRrUdKSVn8xw5+G/IT/8LePaE0XqXyCce5USvAmFGSxHW7d
         hMZ1279le+2NGukSQtrUksNET99cLc/BAl23ALfXWdeHL1nxyg2TxqaVuekOzOwdq2ee
         dYfUtBNnfoCSVVME7Irmquv20CwvWboAZ5jDrdQkJD7jj8MLcHRd7+y5Fs1PWvoghuSK
         ff0D3OFYB1c7LmxfjnVa2d1mfDl2ZWgJghJAy27E9NjdcT208zSHJbWhkBWGXc7L0pib
         aPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5p9In3c0U7T6cVuoZBmWzXApSWOi+BckNf5ncuvNs8I=;
        b=R/aUmiyaAjV+B0i++trJ5yyP+ABQSOWygIc7etLnigHby4KG1O3uN9yzNnpvMj+IKu
         Sz8xtDBQSJ859uAI6oRq2Ox8d99uw7EwOtTC1dV6DquOlu6GSYRvtc3dw5t5K/3rFlYr
         aTNTyyKGbOxwU22wTS4I+gkKZUmyNlsyRTGpnEfX8F6MmhzFX0AtXNqrsikq/4BDplvc
         ZWuIjjlmhIct+V7Xa3/BCpsOYnIxXUhc8BZmMXB0A0YB6U7nddGTItvCBmN85i1tB3wU
         o0PiU3c7PxT3jjtUr5+bnRtJ2Fls339RbOkCr8DcextAXx9ekcPystO4kc8rcHTEGh3e
         Ee8w==
X-Gm-Message-State: AOAM5332kUDgb3tyn8B1reZbxjw5rMLBX8N0OOrXXy7guKB77GLhQMPR
        Hyeu6CXC94nIGPj1ZHed08CQFO7BHWIjdzFMXtJr/fRN9RE=
X-Google-Smtp-Source: ABdhPJyBReT8TYP778m2wzzvAexq5aDCjIVSwwsS2AoRcS8u7BvEdURFzqwqNIShLoctFgA4VvqIqKZz2HIosFKFcVU=
X-Received: by 2002:a05:6e02:f10:: with SMTP id x16mr6401998ilj.220.1602163402746;
 Thu, 08 Oct 2020 06:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200924124526.17365-1-brgl@bgdev.pl> <20200924124526.17365-3-brgl@bgdev.pl>
 <20201007134323.GA764@lst.de>
In-Reply-To: <20201007134323.GA764@lst.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 8 Oct 2020 15:23:11 +0200
Message-ID: <CAMRc=Mf8BDyoy+V-S_JQjAZ9+Lt=+5pEYH2ugSL0pbQ5E5Dfrw@mail.gmail.com>
Subject: Re: [PATCH 02/12] samples: configfs: order includes alphabetically
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 3:43 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Sep 24, 2020 at 02:45:16PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The preferred coding style is to order all includes alphabetically for
> > improved readability. There's no need for the configfs header to come
> > last.
>
> Is it?  People seem to have all kinds of weird opinions, but I don't
> think any ordering really makes sense.  What does make sense it dropping
> the pointless empty line, so I've folded that into the next patch.

This is not just a baseless opinion, keeping headers sorted clearly
has an advantage: you more easily avoid duplicating includes, you see
right away if a header is already included or not. Many maintainers
will require ordering in new patches.

It's your call but it's better code with not much effort.

Bartosz
