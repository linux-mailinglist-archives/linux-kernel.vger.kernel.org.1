Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358B51E5118
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 00:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgE0WVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 18:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0WVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:21:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD52C05BD1E;
        Wed, 27 May 2020 15:21:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d7so29917706eja.7;
        Wed, 27 May 2020 15:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzzLRzAW0nQP8h/XDQSb0USxXb11km0BANKGPPnjAFo=;
        b=QgVfy4DuSqx4yjM69aMxy3euvPCdQ5TZLa/0/nEH7Yb5x3POW/isiHy/znghOdKZFK
         KYGPALjH2n+7Fc9t09/FkP95+ZRV99w+N7jSsGzEOHURa2Jq4+yohVb6U57qOFUsrNyM
         McICiIIxPIK+b2pHFRoc0AN81YRjxkJ/ooPSWVyF1ZG5veySbhuQogCwY9C4Y4rCw7ZC
         6jcH+QqjlgPrmHwaFX2iFS3sJspoyW2y/8JVXXbTWCg7aeC+tqOmR+GK6oJfbFilxBQ+
         DAbZw9HMi0P0V4ycF4P+FTHw+UjTIj8mx5jejg3Q5wyNW7knx0xVqpiPDnJ6Qn/hUGit
         IHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzzLRzAW0nQP8h/XDQSb0USxXb11km0BANKGPPnjAFo=;
        b=lqbfWDeEyY9lBCyxroX0JUlbP+aIlGWISuJgXlquMaO2BwCkqIuhzt90ipU+pYBQe+
         JfBye+heis0KM7BHrDVcgBz/AZqwzvE18ZE0yI5OoJ5urNnk4UZGOO/Vqa2TZ+NpDplP
         OgwJYBCZrrxqV1J+CNgRMDFfHaCVEXOlKaa+45yZsNwAdJ9GZn5tBzsWQh1Zec3aqIcQ
         5CaXmosmQRNXibYi6iKyn3WThubm+pdPPY3uAbkCtZBRP3IJwC9/dnc9iVGI5iG6CBvy
         lTS5sTsFJPGHK8OCpYo4c8g/9ztNwJi7QOpVRclw9Wr0yeCuemB02w4f5ui6qeIC0gDF
         GJGg==
X-Gm-Message-State: AOAM533EuvzSga+j56o3OFG8VgtvJVcStoIBNsR2ZFd32eLXJbAGBsSh
        5NN/kym6YHUMYqEJpCozSBZAFEf8x/87Uh05JOZFVXCccRQ=
X-Google-Smtp-Source: ABdhPJw+2VusqG50YhBTr71oeD5u16guwGS2UPTzSkv1v/6wxGhpbu1d3T+vN0ol/0hzUEsZ8IZUjwgJroX5dfj1F7g=
X-Received: by 2002:a17:906:c7cc:: with SMTP id dc12mr419619ejb.263.1590618093350;
 Wed, 27 May 2020 15:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200527200933.31135-1-wu000273@umn.edu>
In-Reply-To: <20200527200933.31135-1-wu000273@umn.edu>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 28 May 2020 07:21:21 +0900
Message-ID: <CAKFNMom3X-M-4x5X+TaxvZw9AzdFKOhSZu6BcKK1CU9fCasjng@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: Fix reference count leak in nilfs_sysfs_create_device_group
To:     wu000273@umn.edu
Cc:     kjlu@umn.edu, Vyacheslav Dubeyko <Vyacheslav.Dubeyko@hgst.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qiushi Wu,

Can we call kobject_del() instead of kobject_put() when
kobject_init_and_add() failed ?
If it's unclear, I think we should fix this by
    calling kobject_put() when kobject_init_and_add() fails, and
    goto free_dev_subgroups.

Regards,

On Thu, May 28, 2020 at 5:10 AM <wu000273@umn.edu> wrote:
>
> From: Qiushi Wu <wu000273@umn.edu>
>
> kobject_init_and_add() takes reference even when it fails.
> In nilfs_sysfs_create_device_group(), the memory allocated by
> kobject_init_and_add() is not freed when kobject_init_and_add()
> fails. Thus replace the jump target "free_dev_subgroups" by
> "cleanup_dev_kobject".
>
> Fixes: da7141fb78db ("nilfs2: add /sys/fs/nilfs2/<device> group")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  fs/nilfs2/sysfs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
> index e60be7bb55b0..4a74756d52fe 100644
> --- a/fs/nilfs2/sysfs.c
> +++ b/fs/nilfs2/sysfs.c
> @@ -1000,7 +1000,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
>         err = kobject_init_and_add(&nilfs->ns_dev_kobj, &nilfs_dev_ktype, NULL,
>                                     "%s", sb->s_id);
>         if (err)
> -               goto free_dev_subgroups;
> +               goto cleanup_dev_kobject;
>
>         err = nilfs_sysfs_create_mounted_snapshots_group(nilfs);
>         if (err)
> @@ -1038,8 +1038,6 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
>
>  cleanup_dev_kobject:
>         kobject_del(&nilfs->ns_dev_kobj);
> -
> -free_dev_subgroups:
>         kfree(nilfs->ns_dev_subgroups);
>
>  failed_create_device_group:
> --
> 2.17.1
>
