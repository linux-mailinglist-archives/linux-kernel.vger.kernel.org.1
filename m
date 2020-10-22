Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9629574B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394460AbgJVEau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgJVEat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:30:49 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DBCC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:30:49 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 184so510540lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WccrU7y9GtXvSS4lHjkn9vtmXExwGt9W1J4camOQdZw=;
        b=So3a2V6gq3lJWJhOM+LAuRfLWCpK6nhciW4kGooc7P6f9limLQxWvk5X8r0mDoGEFp
         +9y2jIx3fMrVMTayBLUZscbEVP4uUJqDWEkK7qAeDeSLtUSplo5aTSnleSLeuAwkMM2c
         BDQgTRnLR/jW0POXmKgiidJHDvpeYylWUlDnUdYtdXN8SVYRI6wNNMlYGOUpqzUa1uxs
         /KnawegpAYi4KgrK19P6at5Bz3WJ8kvExt27vsb6UbLs2w4WOLJ2/LlfKijTavBAe6mu
         AeYXf3w0jCijzsVHGcdoY5GXsqaWhoA6wZishO4DOiAWX4vIGxKgEONjuIdliOO49/FD
         c3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WccrU7y9GtXvSS4lHjkn9vtmXExwGt9W1J4camOQdZw=;
        b=s8WYEFuGMlc39PPVbaO40aBJedFsPjk381dVofMyoYS7POv+t3xLcMmcgDd/gwXFLY
         5quJ+Gsw4N5iJxhGLtRmUi5E3rEncdD6MQ8yYIAgvWdJLnj4bX3FcydsHMdp2Ddcixr0
         IvVOvolHrjm/5nh3jW0raaUyZgGyul6gqXLSYyZVW2270nAd0w6yFsjqGxfUjEFNY8d4
         NaJoOY5IrTeGGx/7iBM/NmRoTlbak8fPxiWIAzq2wIbJlEZ8J/a80vzxb1gdRtyaUkp7
         xQnJxqfM9bEf8/sH5HHmaOKM37gGwnSpcUvqmGGXnFHNaepI6rJH4Pp5n0efrk1SB7e/
         E7AQ==
X-Gm-Message-State: AOAM533O0Z18aKxdZd3gmzcEkoLrbFstBHmW2uWqiMoU9fx3tnfO+23C
        7lx9aYo5SWN/7UTAeDuknivC71Y9mHXVr1r3T3U=
X-Google-Smtp-Source: ABdhPJzWoE1r/k/Mo5NARBTN141/Zm8LV2karpbwBQM8VCimIVy7qXrt0UR551kH15zk86yawR1h6CeDg+EZGfgrqYk=
X-Received: by 2002:a05:6512:34cc:: with SMTP id w12mr183250lfr.326.1603341047728;
 Wed, 21 Oct 2020 21:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201022035848.976286-1-daeho43@gmail.com> <20201022042257.GA857@sol.localdomain>
In-Reply-To: <20201022042257.GA857@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 22 Oct 2020 13:30:36 +0900
Message-ID: <CACOAw_zVO8FugS_UAXCYyg99-6GWCm4aGi4xEtrhxeBofa2=cA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, it sounds more clear~

2020=EB=85=84 10=EC=9B=94 22=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 1:22, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Oct 22, 2020 at 12:58:47PM +0900, Daeho Jeong wrote:
> > +     if (!f2fs_compressed_file(inode)) {
> > +             inode_unlock(inode);
> > +             return -EINVAL;
> > +     }
>
> How about using ENODATA here?  EINVAL tends to be used for lots of differ=
ent
> reasons, and it's not always clear what it means.
>
> Note that FS_IOC_GET_ENCRYPTION_POLICY fails with ENODATA when called on =
an
> unencrypted file, which is a similar case.
>
> - Eric
