Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62D62D4E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 23:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389056AbgLIWjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 17:39:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389044AbgLIWjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607553503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pLh08CODrTtOHr1xQAUm+7JhxhEsEXmLpw4HRIcM1tc=;
        b=eIdevc2h+X38oXj8nZiNyVvrKd+20hGcX3WsT3sR6Cajf7ezWTHl7xFA8rx4tCc2TELZgQ
        cojXGjCvW55cRXfblHoloFUyLOdSEZr+QnUzZM35+0iNBaEJ05vmE/86lF9RQZieDbiNTh
        8r4u+qY66t1l2fztnNvpkAuhR9vvKpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-NybBHuTDMeSb_WVQBgiOJA-1; Wed, 09 Dec 2020 17:38:22 -0500
X-MC-Unique: NybBHuTDMeSb_WVQBgiOJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E56866D53C;
        Wed,  9 Dec 2020 22:38:14 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA4216F990;
        Wed,  9 Dec 2020 22:38:02 +0000 (UTC)
Date:   Wed, 9 Dec 2020 17:38:02 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Song Liu <songliubraving@fb.com>, axboe@kernel.dk
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com,
        Matthew Ruffell <matthew.ruffell@canonical.com>,
        Xiao Ni <xni@redhat.com>
Subject: Re: Revert "dm raid: remove unnecessary discard limits for raid10"
Message-ID: <20201209223801.GB2752@redhat.com>
References: <20201209215814.2623617-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209215814.2623617-1-songliubraving@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09 2020 at  4:58pm -0500,
Song Liu <songliubraving@fb.com> wrote:

> This reverts commit f0e90b6c663a7e3b4736cb318c6c7c589f152c28.
> 
> Matthew Ruffell reported data corruption in raid10 due to the changes
> in discard handling [1]. Revert these changes before we find a proper fix.
> 
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1907262/
> Cc: Matthew Ruffell <matthew.ruffell@canonical.com>
> Cc: Xiao Ni <xni@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  drivers/md/dm-raid.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index 9c1f7c4de65b3..dc8568ab96f24 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -3728,6 +3728,17 @@ static void raid_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  
>  	blk_limits_io_min(limits, chunk_size_bytes);
>  	blk_limits_io_opt(limits, chunk_size_bytes * mddev_data_stripes(rs));
> +
> +	/*
> +	 * RAID10 personality requires bio splitting,
> +	 * RAID0/1/4/5/6 don't and process large discard bios properly.
> +	 */
> +	if (rs_is_raid10(rs)) {
> +		limits->discard_granularity = max(chunk_size_bytes,
> +						  limits->discard_granularity);
> +		limits->max_discard_sectors = min_not_zero(rs->md.chunk_sectors,
> +							   limits->max_discard_sectors);
> +	}
>  }
>  
>  static void raid_postsuspend(struct dm_target *ti)
> -- 
> 2.24.1
> 

Short of you sending a v2 pull request to Jens...

Jens please pick this up once you pull Song's MD pull that reverts all
the MD raid10 discard changes.

Thanks!

Acked-by: Mike Snitzer <snitzer@redhat.com>

