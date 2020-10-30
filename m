Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B642A0736
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgJ3N5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgJ3N5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:57:25 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D938AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 06:57:24 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e3so3442000vsr.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzBRWn/WcIelGIhQxbbQi07HyUQWnQ50iS13cdl8p6o=;
        b=Sd1km1AHNanOm6XD9wPybbde8CgiaA47T/SqDN31LL5XfZbSRO6qJ5OEEKDhgNPRaK
         0ykKJxOReVRPMczdl3b4T4cv5zURyQ4/tuoc4bK5Ce6IMgoKnu2w3gqPeIpu9Asgfeb/
         YPhitPR6p6eI44guadpEP07wd/n07QO5rT3SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzBRWn/WcIelGIhQxbbQi07HyUQWnQ50iS13cdl8p6o=;
        b=aES/IziNpKDR6tfmJhjtgyTrllvshTzYhA04NJfy7DT7mdfZP9DdfoNEB98T6L2hdx
         0IxkmCXPpJuNZP/g1Fgd7yAV9U5NgXsFf2uihHjS5Njxb9OGgXwnVVEn9uUiVhEUnrDr
         TfmeL+5bCJCPLnrZad/FTxiLQERshndoiYoQ38WpVrZpXhomxIv47AMPK6KqqY0bZqmh
         BCiMkPHg9MFMIFy+DuIk0Ra44wmMUyNORrGcYuycbJ5eViLU3uIghMWRZyPI7OFsBiPN
         A6KOmXaDbeuGrdmn9G032weRvJCPbykbuotxIBlZGRz9xpfEP38mm87hULEiM2zWNlrt
         ND3g==
X-Gm-Message-State: AOAM531Gd7/StoUwIu0gChu1bWovqJxcZX1ORour0ed2oOnhhobK7UPC
        kSfQ268lO2DVekTQDBrfOjX6dqKvljRKSplmAK5zMg==
X-Google-Smtp-Source: ABdhPJznp3wb2QmYYIZpS+0t2yNhmEYecMl9nRbvn/9Y9Dtzh/rsq5OSSsUNRIwZMYWqpu/KYbP2g+cgCjW70zcycFE=
X-Received: by 2002:a67:2b47:: with SMTP id r68mr5475707vsr.7.1604066244180;
 Fri, 30 Oct 2020 06:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201013145954.4274-1-ptikhomirov@virtuozzo.com>
In-Reply-To: <20201013145954.4274-1-ptikhomirov@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Oct 2020 14:57:13 +0100
Message-ID: <CAJfpegvvaN0O1PGnq6rLSA-XnseuPcaSGZDeA7uG6WA7ftCfYQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] ovl introduce "uuid=off"
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 5:00 PM Pavel Tikhomirov
<ptikhomirov@virtuozzo.com> wrote:
>
> This is a v5 of:
> ovl: introduce new "index=nouuid" option for inodes index feature
>
> Changes in v3: rebase to overlayfs-next, replace uuid with null in file
> handles, propagate ovl_fs to needed functions in a separate patch, add
> separate bool "uuid=on/off" option, fix numfs check fallback, add a note
> to docs.
>
> Changes in v4: get rid of double negatives, remove nouuid leftower
> comment, fix missprint in kernel config name.
>
> Changes in v5: fix typos; remove config option and module param.
>
> Amir, as second patch had changed quiet a bit, I don't add you
> reviewed-by to it.
>
> CC: Amir Goldstein <amir73il@gmail.com>
> CC: Vivek Goyal <vgoyal@redhat.com>
> CC: Miklos Szeredi <miklos@szeredi.hu>
> CC: linux-unionfs@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Thanks, applied.

Miklos
