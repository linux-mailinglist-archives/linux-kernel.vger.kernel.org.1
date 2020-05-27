Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3774C1E50D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 00:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgE0WA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 18:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE0WA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:00:58 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA1C05BD1E;
        Wed, 27 May 2020 15:00:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o15so8499157ejm.12;
        Wed, 27 May 2020 15:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJ7qs4KFV6ljkhIIkNMDHu8kqAaBL+nGojh30Ee94Vw=;
        b=olPcckYxJ+9VtkFPIRUwt6nqVH8yrrNm1Tao0uxDTsRCjUISFwdvp8AUEdnZXs0yak
         dRZHLc1NHWBikx/6E+144Zz2kA6sg0CyDmsLoN/k1b8zOrA7N5Kut8mOj1xF1Ca5kYrP
         XgjoEjJ9B2EUlRk5mFYZkLVQtFZ+RKmX0V/CXt2U/znHeeTpfzgomsYL1ztichiIUMNr
         LQbLNr5Oy5DoRkniO05pIAPXt+dODBuYcTmAdxUQCDsleVt1dP5+dZxqLcRsd35UVvzk
         gr+4FvFXobMMf93thp4PRpKs1GcObo+IzEIrotIL3OSFj9BruqS6fv513FBm/rJ/YGDf
         iRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJ7qs4KFV6ljkhIIkNMDHu8kqAaBL+nGojh30Ee94Vw=;
        b=Sp4od9a3iVZPIrincrOajkd4be0RS92kWjKK/QHduR6LmnN0y9ynCTc5yB/swJFCU8
         9xgybt8/xwqIeoHXefbGtBEBHwmsuJPm5lF4+TgCAiJGmP35SBdiq5bxP8wDDPyqeSLb
         NH5Z8jVFw/jl15bGnNDZ6679eBB9I0HjAeD6dA7pXTj/qXpBlytEcjJxcbwCzwCpfWM+
         v8aylmlXFXxtZswySyzJKrNemvbBPKl8dZVm2oS5G69q5jmhjOaWDRtyIpqmii2aBv+0
         pYUSuDUiG7iBTLb5c6JTippDjB2Sr6pYAlwjqiiShWIx6pAGXXgvz0zocP5ISmAf5D4d
         zBjA==
X-Gm-Message-State: AOAM532PHV+OFh4PY/6cJUfCSvwgqZl19/zrSDqlDLVN3yupmJMsMuto
        SpNrj73tIVhFcNMkj2/eleS+dGsgzCYtWhlTBcc=
X-Google-Smtp-Source: ABdhPJxRAbwQZuWTsdBY69MZE/9FcI+e/DuHf3f64iq0rKqMJer5SoNND33jq+KASIMYTS0EiH7on7s/iVEZwG3084Y=
X-Received: by 2002:a17:906:f108:: with SMTP id gv8mr343542ejb.91.1590616856463;
 Wed, 27 May 2020 15:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200527195532.28077-1-wu000273@umn.edu>
In-Reply-To: <20200527195532.28077-1-wu000273@umn.edu>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 28 May 2020 07:00:44 +0900
Message-ID: <CAKFNMomc1ek72NdROKZ9F-E9Dz=gW2kSrQtkQdL9Msn=+pJdpg@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: Fix reference count leak in nilfs_sysfs_create_snapshot_group.
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        Vyacheslav Dubeyko <Vyacheslav.Dubeyko@hgst.com>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Apply this, please.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

On Thu, May 28, 2020 at 4:55 AM <wu000273@umn.edu> wrote:
>
> From: Qiushi Wu <wu000273@umn.edu>
>
> kobject_init_and_add() takes reference even when it fails.
> If this function returns an error, kobject_put() must be called to
> properly clean up the memory associated with the object. Previous
> commit "b8eb718348b8" fixed a similar problem.
>
> Fixes: a5a7332a291b ("nilfs2: add /sys/fs/nilfs2/<device>/mounted_snapshots/<snapshot>group")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  fs/nilfs2/sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
> index e60be7bb55b0..b2517c5e773a 100644
> --- a/fs/nilfs2/sysfs.c
> +++ b/fs/nilfs2/sysfs.c
> @@ -209,8 +209,10 @@ int nilfs_sysfs_create_snapshot_group(struct nilfs_root *root)
>                                             "%llu", root->cno);
>         }
>
> -       if (err)
> +       if (err) {
> +               kobject_put(&root->snapshot_kobj);
>                 return err;
> +       }
>
>         return 0;
>  }
> --
> 2.17.1
>
