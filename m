Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD9623D576
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 04:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgHFC2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 22:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgHFC2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:28:39 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ABCC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 19:28:39 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b18so2860151edv.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 19:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEm+dlp1WdNi0+PXsBNsNlqTbpmLlIffHnRCEZ/ShIw=;
        b=LHytj7wEOoUKbN8Af702TsxP7iQcm0vGOWJ/kzlC+zRXabbRwX3UYnXrz9ca1HNhnv
         9ZTJXYUEW6rx66iYOaoLglszTSuPCjuoxh/nAe0Jo3edR8OQBgNihGxWExdft0TGUK2j
         DLyu54D/KcPwUXxzvRzfKyi3D0nsh2mpXtCzZQ6Jqvso1KEZ/IUJZ4wayMXdlCKlelyJ
         4f0QSW1B2n5TcCkkWn6dQqPiVr+hnjlazZ0QqL3D3rcMOXDe2U36dtkrSL1XhWRNcz9Y
         0nQOtAcln4FY+D99l+IdYOCIDpZ7Z984QRyx6ey6ieD6dvKYJeEDgyhjJqEMTmF+zx8d
         ZEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEm+dlp1WdNi0+PXsBNsNlqTbpmLlIffHnRCEZ/ShIw=;
        b=Y4NfiZUkO+Vco6vpzDMSgG115anr9BM5u/GgCAm+unJucn5sJYpyn+miQk9Ibc4uPC
         sxs5C+myDJFlXUo/ikq46loZEscgP4NIC/9j4unTyMUad6+wbyL8wvywe/vtpzi8ZzX1
         Xf+JB0kpsBQwvzBxfEZS/ms+9muuqmZ2oi6lR0cK+BDCmmXxl/PITkuyKUDz/7YmHi9g
         ptBgTGUTTtEeNdjqDLW6Fr8ZGBdJsEF/KqR8oC1BZB4nYNaEmRmeoamx/dg7V8ICeebC
         5ypMgQaWNUYkE/1DWlaj3RKltAUlfgDqLg3jZ/QBz1OHIx9izyLolhBqywAlKF6g+IfC
         XuZA==
X-Gm-Message-State: AOAM533bU3zy2sAqRGCWHnoqCebO6m+tW/bf6Dah2+GGeE5GE5HbhcOF
        Z9KkXbqE1KoBuSeH0R/JS1LVJy+cHVTb8uxMuIKZDUnP
X-Google-Smtp-Source: ABdhPJzZOFtmp8gmQerAwygw4JMNDMYMMF73frKCBmWS8ROr79j8FTkhETlIodmilbZKIOf3K+uwiPnXvyJHimIJDbk=
X-Received: by 2002:aa7:c983:: with SMTP id c3mr1977991edt.383.1596680917928;
 Wed, 05 Aug 2020 19:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9ty8hOY0m2+RJdRiRADY5Li-hs3ZaDEK-DTf6rgFewar7g@mail.gmail.com>
In-Reply-To: <CAPM=9ty8hOY0m2+RJdRiRADY5Li-hs3ZaDEK-DTf6rgFewar7g@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 6 Aug 2020 12:28:25 +1000
Message-ID: <CAPM=9tx5bMLofaA75ZrBwdjAF-ZpQ3xU+pf5QGKJakLUQYNKNg@mail.gmail.com>
Subject: Re: [git pull] drm next for 5.9-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 at 11:07, Dave Airlie <airlied@gmail.com> wrote:
>
> Hi Linus,
>
> This the main drm pull request for 5.9-rc1.
>
> New xilinx displayport driver, AMD support for two new GPUs (more
> header files), i915 initial support for RocketLake and some work on
> their DG1 (discrete chip).
>
> The core also grew some lockdep annotations to try and constrain what
> drivers do with dma-fences, and added some documentation on why the
> idea of indefinite fences doesn't work.
>
> The long list is below.
>
> I did a test merge into your tree and only had two minor conflicts, so
> I think you should be able to take care of it fine.

I should say I did a test merge yesterday, but you likely pulled more trees,

https://lore.kernel.org/dri-devel/20200806115140.6aa46042@canb.auug.org.au/T/#t

So there was an unfortunate miscommunication and one patch went two
ways, in future Jason and Ben will coordinate better.

Dave.
