Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36D1212F78
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 00:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGBWYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 18:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgGBWYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 18:24:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D694C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 15:24:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q7so21019140ljm.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rmRp1ZZXJd6eN5hNQwPnS8csHi2t2UcvvKpaxxW8OSo=;
        b=dg7C3tlrqxSyRBVh8XrZt1yUXgkta1ByzkZ3tEGx48lZx2vqiLJJ0X8MQO93IB5GAQ
         Afndo7zFedxvT5SxiIQiNfEnN2/vLTqdvDaY5UO/gaf+QPNh3aahvZem6AJDkhfqDzs3
         0m3eDL9N5MmJgDJCsgtKgN4of3aNVBFTy72w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rmRp1ZZXJd6eN5hNQwPnS8csHi2t2UcvvKpaxxW8OSo=;
        b=lPzQ6HcgUV+VCepIZISTs8Cw77E5R4fzAl+d7+Gm3zE0koRFM5guhDnUEJu1V0u2qr
         gA44Qp9v9yv54OyhinKlPiX3U1GzfXvLYPOUTvktMEJ2SPy2YTWyxBmQQAwmPhAmgXKx
         c8/TJtjPH90SGlfyOBEgYUgFKJ0Bvhr/GeUlxjRtnzm3XhGBypziNs3tQj+fuS0aH+zY
         5Zknd9D3MlpVx4UsM6wokQtPQc84l8HwldjvuwS0xnhZ4DbEx6JfxhBYITiU4YllkOws
         unoJ9ny7+wDWlZ5QkJW+1Jm+vKZEiRgUBdR/0Oconu8uGYrMl1VVGdJW9jkrNQNc8pJj
         o1hQ==
X-Gm-Message-State: AOAM531HcZN1/IKHPr2y64CWnZSBV4uT3aRShPucLIINPRDmtJ8SXvLd
        HQSmNZh/KQqa+Hp4K/srrCm+MQpi/QY=
X-Google-Smtp-Source: ABdhPJylLqGBFmVF3zQpe/7GHJYxkAKpMn6z7mscajgWUR1zbqQAeOexfcAweDNoaHGZhAcXSStL4w==
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr2592366ljn.38.1593728687079;
        Thu, 02 Jul 2020 15:24:47 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id r25sm3809822ljg.9.2020.07.02.15.24.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 15:24:45 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id k17so4396996lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 15:24:45 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr19715939lfd.31.1593728685003;
 Thu, 02 Jul 2020 15:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200629153502.2494656-1-sashal@kernel.org> <20200629153502.2494656-115-sashal@kernel.org>
 <20200702211717.GC5787@amd>
In-Reply-To: <20200702211717.GC5787@amd>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 15:24:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1VVZoNvtVYL9wCPVjBHwxhCXd4TfKbY0-OsG4nGyf2w@mail.gmail.com>
Message-ID: <CAHk-=wj1VVZoNvtVYL9wCPVjBHwxhCXd4TfKbY0-OsG4nGyf2w@mail.gmail.com>
Subject: Re: [PATCH 4.19 114/131] ocfs2: avoid inode removal while nfsd is
 accessing it
To:     Pavel Machek <pavel@denx.de>
Cc:     Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Joel Becker <jlbec@evilplan.org>,
        Jun Piao <piaojun@huawei.com>, Mark Fasheh <mark@fasheh.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 2:17 PM Pavel Machek <pavel@denx.de> wrote:
>
>
> > commit 4cd9973f9ff69e37dd0ba2bd6e6423f8179c329a upstream.
> >
> > Patch series "ocfs2: fix nfsd over ocfs2 issues", v2.
>
> This causes locking imbalance:

This sems to be true upstream too.

> When ocfs2_nfs_sync_lock() returns error, caller can not know if the
> lock was taken or not.

Right you are.

And your patch looks sane:

> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index c141b06811a6..8149fb6f1f0d 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -2867,9 +2867,15 @@ int ocfs2_nfs_sync_lock(struct ocfs2_super *osb, int ex)
>
>         status = ocfs2_cluster_lock(osb, lockres, ex ? LKM_EXMODE : LKM_PRMODE,
>                                     0, 0);
> -       if (status < 0)
> +       if (status < 0) {
>                 mlog(ML_ERROR, "lock on nfs sync lock failed %d\n", status);
>
> +               if (ex)
> +                       up_write(&osb->nfs_sync_rwlock);
> +               else
> +                       up_read(&osb->nfs_sync_rwlock);
> +       }
> +
>         return status;
>  }

although the whole thing looks messy.

If the issue is a lifetime thing (like that commit says), the proper
model isn't a lock, but a refcount.

Oh well. Junxiao?

               Linus
