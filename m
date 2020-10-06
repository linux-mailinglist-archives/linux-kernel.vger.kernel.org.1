Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE14C284EA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgJFPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 11:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgJFPNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:13:38 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74266C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 08:13:38 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 7so6270585vsp.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24vAgql5Dqcn8/iHEJwevkJshhxRgPh777MgK3JWTsY=;
        b=pnmDEAYzNx9gWXPcfR0aRKzsSXPzwRgvhgbj7H/Vizqzd6iuFianxXf/KSWglOHbLR
         ojrNXPnrz8dC9sefKr5f+COQ6ufaaPG6Rp9APm733BpQWqwNwYk5bAp9qrtxyP0FVlqW
         Ui48aZxx4smn/FiFt4W5ohVuZFbIK5g76f0U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24vAgql5Dqcn8/iHEJwevkJshhxRgPh777MgK3JWTsY=;
        b=Z5ymz6LZTxtfvV8oaoslqw8mCOFyS7fYnEiPkBwsHDcLe7X+uAL9IRPuKykDc6MjvL
         l2ITLHELV0l1yUDkN7OnHMeWaqupPgVIPFlGmvdXqU0I0iHvFffCtNb4ll/dkroFSm+e
         lhlvAVp5y/eV/DZx5oi1eOQqMoaj4TiuOt6nHRXaCMB1oLGZBfdSohC40S53GYanky76
         08y7EwAAEYQrTOPNOMgjgwp1hE/yIKnOSKNf5itrQ09chCuYjBJ9d6k/r9QsDA9zILXr
         MT56Ck7pdYN77O+y9aLdn5nwH6NYELCPB1pp8EQX/UDGUP98qe/sueW3IkF37h5iI1Is
         cATg==
X-Gm-Message-State: AOAM533BSf6QfCVEgXk/rO7RnOXAmcpwTOKmOwwzP5q581qH5LWiFss6
        rKPFSCDiuUTZ3sXbi+ble/f2eeXnMHZjqqJwAsLJUA==
X-Google-Smtp-Source: ABdhPJwne6XwG4rCqz7el40G36q5VtevxEWc60abwElUWGgAA5HzmqXYaOA70Ubk9BY4LaFmDcaFwZe4Kz2wK8eLBrQ=
X-Received: by 2002:a67:a603:: with SMTP id p3mr3833722vse.4.1601997217529;
 Tue, 06 Oct 2020 08:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200925083507.13603-1-ptikhomirov@virtuozzo.com> <20200925083507.13603-3-ptikhomirov@virtuozzo.com>
In-Reply-To: <20200925083507.13603-3-ptikhomirov@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Oct 2020 17:13:25 +0200
Message-ID: <CAJfpegvgmnWrmsACuWe_hYCfVm2r0Ltv0C+sN+3T1DBMzrGE9w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ovl: introduce new "uuid=off" option for inodes
 index feature
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 10:35 AM Pavel Tikhomirov
<ptikhomirov@virtuozzo.com> wrote:

> Note: In our (Virtuozzo) use case users inside a container can create
> "regular" overlayfs mounts without any "index=" option, but we still
> want to migrate this containers with CRIU so we set "index=on" as kernel
> default so that all the container overlayfs mounts get support of file
> handles automatically. With "uuid=off" we want the same thing (to be
> able to "copy" container with uuid change) - we would set kernel default
> so that all the container overlayfs mounts get "uuid=off" automatically.

I'm not sure I buy that argument for a kernel option.   It should
rather be a "container" option in that case, but AFAIK the kernel
doesn't have a concept of a container.  I think this needs to be
discussed on the relevant mailing lists.

As of now mainline kernel doesn't support unprivileged overlay mounts,
so I guess this is not an issue.  Let's just merge this without the
kernel and the module options.

Thanks,
Miklos
