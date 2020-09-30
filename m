Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CBC27F3DC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgI3VDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3VDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:03:40 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A66C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:03:38 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id x20so2329878ybs.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUkGb/zQmshcq7ZJh1yZhPj0UxQQipG2VPSR+vnHzZc=;
        b=JndInnWpkr8t80BkW9gUPR9Jj89HXBjgg6DcE1sZPj7XOSNJ5s5tff7Ry/sjmYmMJb
         umOTX6VEtwF2OvQffs6BnbSEc97uYOmFLJ5RHYviQW8b8mJaV0rpsQ1dTlVpAc82DoiP
         3zHdSydTIDs/78LZbdlxdannnUbNgYE8Y7YwAV+myQ9Bxq8u6YHuqN0OMiObGbHmFB71
         Hy57ohCEPGgL/K9FwoPoY2Y6cZvOh8B8yKTCdeXkF2vidYxOJkE4+eQ8gRfbrCFe2wHa
         I/H2m0cQjtf5ta8LMWyplZhVu4AO6RjZT5nxR9DlcNUK9kH1uOmacDXGbFZO6PrTYMQM
         jr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUkGb/zQmshcq7ZJh1yZhPj0UxQQipG2VPSR+vnHzZc=;
        b=KBEHzoZR3WqUjBXCZYdDkcUjXHHLb0hR+Oy76nrGDj/WxvjpDg2QnF6vbg55mDQmCN
         vM0FRzwwf75YsQcUFpRS1/PHFCTeJBlxxLqhe7fl6yNu/OisxA/VDJbeucuPlPaUjRyC
         lADo/GzPxSxjRx0EXnrGda8twGgxRxfVfavMvJQBl1MPvspAr3byXUtYzYMDyNlWjGAk
         n1OFG56At9l82Zp4hKQxDL/tj6/OK5OJB680xYLABWXyneH4GRwEu8fLPZBOxUrG4eXG
         n/hv0QYQDpaRjtT518J5s7H1ZoQBo4lIJJCL5SZiOJ4N4I/Z3OLSNRKLP3k9ZUCXZyUl
         mF4w==
X-Gm-Message-State: AOAM533XbYZhSChGjZXUFfLFktxrNn+p8lsMeOqVphXPlTznJOYmvTgr
        ZYl0+vr6bU7dy9GM/HXik/8dq0ubiy6jCtm2wMZVAA==
X-Google-Smtp-Source: ABdhPJz0yWYBj9ZwI5k3Sl23q2cg00dXG/tN18YAf3DLVxIjbeBmZvdeQGM085E16Y3uD3JrFBkUx6Q4iupSR/bb3c4=
X-Received: by 2002:a25:dbd3:: with SMTP id g202mr5479143ybf.310.1601499817454;
 Wed, 30 Sep 2020 14:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601467849.git.mchehab+huawei@kernel.org> <432ab85d294936e5e9f39524efc7a3a55cd3df2e.1601467849.git.mchehab+huawei@kernel.org>
In-Reply-To: <432ab85d294936e5e9f39524efc7a3a55cd3df2e.1601467849.git.mchehab+huawei@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 30 Sep 2020 14:03:01 -0700
Message-ID: <CAGETcx9mcv3pN6FEt75Jswfyz5EZMNJvBpWmDunejcPFNut1AA@mail.gmail.com>
Subject: Re: [PATCH v4 31/52] docs: device_link.rst: remove duplicated
 kernel-doc include
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 6:25 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The infrastructure.rst file already includes the external
> symbols from drivers/base/core.c.
>
> Duplicating 3 functions there causes namespace collisions:
>
>         Documentation/driver-api/device_link.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/infrastructure'.
>         Declaration is 'device_link_state'.
>         Documentation/driver-api/device_link.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/infrastructure'.
>         Declaration is 'device_link_add'.
>         Documentation/driver-api/device_link.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/infrastructure'.
>         Declaration is 'device_link_del'.
>         Documentation/driver-api/device_link.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/infrastructure'.
>         Declaration is 'device_link_remove'.
>
> So, drop the reference, adding just a mention to the functions
> associated with device_link.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/driver-api/device_link.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
> index 76950d061632..ee913ae16371 100644
> --- a/Documentation/driver-api/device_link.rst
> +++ b/Documentation/driver-api/device_link.rst
> @@ -317,5 +317,4 @@ State machine
>  API
>  ===
>
> -.. kernel-doc:: drivers/base/core.c
> -   :functions: device_link_add device_link_del device_link_remove
> +See device_link_add(), device_link_del() and device_link_remove().

I just "copy paste" rst formatting because I've never bothered to
understand it. If these changes fix warnings, I'm okay with them. They
seem pretty harmless.

-Saravana
