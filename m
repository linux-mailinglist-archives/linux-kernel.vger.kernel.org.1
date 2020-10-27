Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8893029A1E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439346AbgJ0Ar7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:47:59 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36098 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409032AbgJ0Ar6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:47:58 -0400
Received: by mail-ej1-f68.google.com with SMTP id w27so16873662ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 17:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zgg4GYSOzhMNXob/AD+3MIiJxld51yGU7eO4edUELsQ=;
        b=R7fS/qNaV6yzi3Q9vQ8DVduWldZq98cV+AhQG/wOF4XKWEW0SV1PdBOy1MuNP0C4Tg
         QR1qTfTYGVf5eX5rWeAbbsCvmUiSSnU2kdygnYVvBN5dRa0HG7xkuPVZVSdoXhopWJSF
         8i4ACot62SbDkbluj4zpE1URkpBY+F+bk0f9clNCUnoynUNQDOU48EI3iIarLS58JlBA
         CBvydk5/DpaeZgRVLdv1+niGE1D/fpCIOinntB5iY+F9vGIhuOgH7nzvlhd0t8IokHp9
         9/TskunsCNWV4er1QKwq9Lwsnzbf8CnD2k4KfV4a6I9COfXkaL3n/0IsBPKbdTicwchH
         Esbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgg4GYSOzhMNXob/AD+3MIiJxld51yGU7eO4edUELsQ=;
        b=tyrovIul035MWGM8ceyR0ZQSuP4IlSOLXSLZCAk1x7/dNwzP8XWx+kZDbPsNhPBd5U
         rFU/3HdtpksGAHOH5e13PjB95c/hUKKm6ahmnngarNXFvWoSqcBNfFOTVTAWqcTi+e2r
         gmPKLqPnJhWjZxhWd6sJjTwyA4ItG2U3sKniItVzx9SMgmyz+lAj7M4tFgrZIyM0Owg4
         96ajvmXTdqtv13I7H+g0kx6DrAif+INRgF5gWdcJoO3LeyTLFlTadJdNyYP0Fx3CoEI9
         8YA7gpemH/J+gFuxnn0iR25GVAQjrhCjjM28sQ55jcJdxuwlmd541h5Bz7WGfxvSTCVe
         dYQA==
X-Gm-Message-State: AOAM531EwFSoCNRtcEadfsjLBHNP3qHJuMYE1QpJeo0dNqIJMR82vNrp
        E8BHf0hcH2r6ci/EOeklN04AzUtiUqMhQeep4u2IBcgvMIVblT2+
X-Google-Smtp-Source: ABdhPJw/66IJucPzoIrbdkwK5W1umFxutPVL/ZBiK8X/L6H5LbmgzJFOTCTeF0+xM3CVwrmcrpmdESt0sorQCpOIdLc=
X-Received: by 2002:a17:906:715a:: with SMTP id z26mr18360560ejj.300.1603759677021;
 Mon, 26 Oct 2020 17:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <f69575e0-5170-2d51-8d74-8b3453723aa3@kernel.dk>
In-Reply-To: <f69575e0-5170-2d51-8d74-8b3453723aa3@kernel.dk>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 26 Oct 2020 17:47:45 -0700
Message-ID: <CAP045Ao+uJAj6CEqaJ3Qxi1ma2frio7UEURJ63ua2yTruvv+pA@mail.gmail.com>
Subject: Re: [PATCH] Fix compat regression in process_vm_rw()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 5:03 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> The removal of compat_process_vm_{readv,writev} didn't change
> process_vm_rw(), which always assumes it's not doing a compat syscall.
> Instead of passing in 'false' unconditionally for 'compat', make it
> conditional on in_compat_syscall().
>
> Fixes: c3973b401ef2 ("mm: remove compat_process_vm_{readv,writev}")
> Reported-by: Kyle Huey <me@kylehuey.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> ---
>
> diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
> index fd12da80b6f2..05676722d9cd 100644
> --- a/mm/process_vm_access.c
> +++ b/mm/process_vm_access.c
> @@ -273,7 +273,8 @@ static ssize_t process_vm_rw(pid_t pid,
>                 return rc;
>         if (!iov_iter_count(&iter))
>                 goto free_iov_l;
> -       iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r, false);
> +       iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r,
> +                               in_compat_syscall());
>         if (IS_ERR(iov_r)) {
>                 rc = PTR_ERR(iov_r);
>                 goto free_iov_l;
>
> --
> Jens Axboe
>

I tested this patch and it does fix the original testcase I reported.

- Kyle
