Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D83230388
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 09:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgG1HLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 03:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgG1HLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:11:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ACEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 00:11:10 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q4so20006570lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 00:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRjmm9UeBZr7w+ollM4mmi9tSJezjZAc4TEhn0vLBdU=;
        b=KI0fDHv19vGSEykHx1Xxf2uYI1XOVLyGfQIU2/9514vqCxwHHTuFLpmtTzjcMIpBqX
         Q4N6atO6Hv6xE+kmibPoISKeJ0N8BEwd7vDhnnrta5dig7mD+QKpIMhi2LR5In0odMxD
         v/nw+xjY3Qv9PFJ5+ftNOCgEYwYFO7UBhG2UaoeCiyFYdShW2l65MLefZvXX/TuFKjTd
         fpKWungKDmOiDVtcfDpM1ne/HrIMnuanUoAnejRD22L1Nh254yuh+FQ8NFKakM4PXwQo
         WXZL7qsvYv7QZfeTgazav5diHpXeDKzma6PRjlvDlgFL5fVjpDm/UP17EucCmH9R4gtQ
         i8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRjmm9UeBZr7w+ollM4mmi9tSJezjZAc4TEhn0vLBdU=;
        b=IfxayrQY4Er6s3EhV2WtoEHtGJxeVyDJHqoGZzd+tv8liX/FtIUVMFXerG2FPWqwHb
         WK3S/hTKL7MnhA9+U2kktMXADlJMIkpXd6+QBk+6uKglrFYuMGqcjNrL+kkODKs8lVkZ
         dudJXpHo1mSewiA428T80TMVM+aAhlbTSILD4IhZ+aoI64KctQr9w/sgUybstlCkYbCG
         0VfRSkPz3Mado3OudR//FQ1XX+MHNuw88Hddh/DEZNN6ktbW1HmeQYQuyCkzrRXtdnHU
         xqj8aeEuLR26qiYfNaLJtZvfPHedhz4nwBdzUcjV/9G03NR/g3L3mOvaGvumoU5WDbDD
         f5kg==
X-Gm-Message-State: AOAM5329v0K+XvNvsOI1IgQXoLuYph9aaKm85va3Ya5yHlXDzOF0IaQ2
        6WRtFKzTJKkKgu0QT7kl4imI0ZEHTqcpZicFUXw=
X-Google-Smtp-Source: ABdhPJyjhWJvOexjJ9Q7VOnPBUZjH1m1y72aPQWml/W5gmrJ56dELIFOcCms21hPKK+BstFoDGJXHhFoL5JEnD4D+Xc=
X-Received: by 2002:a2e:920e:: with SMTP id k14mr12349908ljg.430.1595920268329;
 Tue, 28 Jul 2020 00:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 28 Jul 2020 12:40:57 +0530
Message-ID: <CAFqt6za8U04U2TQhe6DUCv7B4h9L-iqPtyE1DuALXUWOD=1M3A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Few bug fixes and Convert to pin_user_pages*()
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Sun, Jul 12, 2020 at 9:01 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> This series contains few clean up, minor bug fixes and
> Convert get_user_pages() to pin_user_pages().
>
> I'm compile tested this, but unable to run-time test,
> so any testing help is much appriciated.
>
> v2:
>         Addressed few review comments and compile issue.
>         Patch[1/2] from v1 split into 2 in v2.
> v3:
>         Address review comment. Add review tag.
>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Paul Durrant <xadimgnik@gmail.com>
>
> Souptick Joarder (3):
>   xen/privcmd: Corrected error handling path
>   xen/privcmd: Mark pages as dirty
>   xen/privcmd: Convert get_user_pages*() to pin_user_pages*()

Does this series looks good to go for 5.9 ?

>
>  drivers/xen/privcmd.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
>
> --
> 1.9.1
>
