Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3AD28E6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbgJNTBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730160AbgJNTBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602702066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p+JrADlr5t+YAAhULA0pqV3ZIZBiEjPrGaYhwMVIKV4=;
        b=N4ycceOKEzHurJ8/X7qy86oRImwQFDPaONqSISxRHQvpQVL3kEezQs9ttrD02wfS3eb3Ly
        D+gcIgIefVtWcYNojeLDI9EDqbHKfYx2z6V/hJMYoCLZj04+V2/ArEgStOkHCI9EZw/8Bx
        FIU2nBpF0sAY7kxxlIkCSZ2bow5GyFU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-b3tvlVZlN_-ZrZPQ9_EAgg-1; Wed, 14 Oct 2020 15:01:04 -0400
X-MC-Unique: b3tvlVZlN_-ZrZPQ9_EAgg-1
Received: by mail-wr1-f71.google.com with SMTP id f11so76980wro.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+JrADlr5t+YAAhULA0pqV3ZIZBiEjPrGaYhwMVIKV4=;
        b=sFgDxXCf0+wmA6n/QiDjRrmL33XtfggatCBGKHkLLs+2fL+MYBadc+qAu4Jx4tMGNl
         kMzaKQ20qewGd19LJGNY8tKcxp+qoVLnUhiDNzUiZ/ek1pgo2MQJR9vjoH57kcJlmNKt
         NGx3rnPNc/qWE7yKCGoaPMcEXTcp/ul1sV0OPQbldmjTzWce+pehBH/ibINOyieymTn2
         GMvcb1u2xK4HwWsSiBQOXghiCzWUbQIzj/WUL3Rw+nlJ7bNhS9tat8OkehjkbMSi40jL
         pzw7WxfseLLfbQX07HpwpQEaHn0sln1lfLW+a2TyRXUwpEGdb1ASe4pR0bq0Wb1OwWAI
         jzVg==
X-Gm-Message-State: AOAM532O567sU/2gPkbUQEoB6pb++iKW0dDkkZUhq5yGyJFrSf5R/VCB
        1aMqkejkfdXEcGcchyYE6EwPcQIVDVztUAiXcTMBlAo8T2xbIfwOYhtEw3vVK0/gXFXWzudVqT2
        J2dOhNG/gBq54Z9TwGXtZpRPi6SIKagvtSHoxp/Yo
X-Received: by 2002:a5d:458c:: with SMTP id p12mr186314wrq.329.1602702063048;
        Wed, 14 Oct 2020 12:01:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh2JO2W6NeN0RV0lJkM57TwsR/X2vWR2a922i5/AIOwJDPP4K8W/FoMQAz+75TJkFLDN3hGuG8+rsCNlnVocI=
X-Received: by 2002:a5d:458c:: with SMTP id p12mr186290wrq.329.1602702062813;
 Wed, 14 Oct 2020 12:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201014163109.98739-1-anant.thazhemadam@gmail.com>
In-Reply-To: <20201014163109.98739-1-anant.thazhemadam@gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 14 Oct 2020 21:00:51 +0200
Message-ID: <CAHc6FU5s3xL745-gUueSW3JO+V78ySsk1ueZ6tT-jrc6w5FD5g@mail.gmail.com>
Subject: Re: [PATCH v2] fs: gfs2: add validation checks for size of superblock
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Andrew Price <anprice@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        syzbot+a5e2482a693e6b1e444b@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        cluster-devel <cluster-devel@redhat.com>,
        Fox Chen <foxhlchen@gmail.com>,
        syzbot+af90d47a37376844e731@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anant,

On Wed, Oct 14, 2020 at 6:31 PM Anant Thazhemadam
<anant.thazhemadam@gmail.com> wrote:
> In gfs2_check_sb(), no validation checks are performed with regards to
> the size of the superblock.
> syzkaller detected a slab-out-of-bounds bug that was primarily caused
> because the block size for a superblock was set to zero.
> A valid size for a superblock is a power of 2 between 512 and PAGE_SIZE.
> Performing validation checks and ensuring that the size of the superblock
> is valid fixes this bug.
>
> Reported-by: syzbot+af90d47a37376844e731@syzkaller.appspotmail.com
> Tested-by: syzbot+af90d47a37376844e731@syzkaller.appspotmail.com
> Suggested-by: Andrew Price <anprice@redhat.com>
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>
> Changes in v2:
>
>         * Completely dropped the changes proposed in v1. Instead,
>           validity checks for superblock size have been introduced.
>           (Suggested by Andrew Price<anprice@redhat.com>)
>
>         * Addded a "Suggested-by" tag accrediting the patch idea to
>           Andrew. If there's any issue with that, please let me know.
>
>         * Changed the commit header and commit message appropriately.
>
>         * Updated "Reported-by" and "Tested-by" tags to the same instance
>           of the bug that was detected earlier (non consequential change).
>
>
>  fs/gfs2/ops_fstype.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 6d18d2c91add..f0605fae2c4c 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -169,6 +169,13 @@ static int gfs2_check_sb(struct gfs2_sbd *sdp, int silent)
>                 return -EINVAL;
>         }
>
> +       /* Check if the size of the block is valid - a power of 2 between 512 and  PAGE_SIZE */
> +       if (sb->sb_bsize < 512 || sb->sb_bsize > PAGE_SIZE || (sb->sb_bsize & (sb->sb_bsize - 1))) {
> +               if (!silent)
> +                       pr_warn("Invalid superblock size\n");
> +               return -EINVAL;
> +       }
> +

I'll add that to for-next.

Thanks,
Andreas

