Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC04283675
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJENYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbgJENX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601904238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTXYdIhHk5aDsmJRXzTWqZveS0sOxEzJruj8mLHJqCU=;
        b=KOncCOSY4j9dqsWNduDot79OgQZDMTDKeYnE8kjFYcw5JxslsJywvhtVhKJ4BJ4uhRfP2+
        itY8Iws2+r4rEtutywXVceGBCCuYzHZuRCGGjKljELzwjjypgnAgTAJ3eBAzursC8/Zqnn
        lVneYsUpY6krM2MM19XqZB1FqMDEY6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-eUFrkKDeMTelKyNiXLrKkg-1; Mon, 05 Oct 2020 09:23:54 -0400
X-MC-Unique: eUFrkKDeMTelKyNiXLrKkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBAD5191F55D;
        Mon,  5 Oct 2020 13:23:09 +0000 (UTC)
Received: from [10.33.36.138] (unknown [10.33.36.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 425D01002D46;
        Mon,  5 Oct 2020 13:23:04 +0000 (UTC)
Subject: Re: [Cluster-devel] [PATCH] gfs2: gfs2_read_sb: put gfs2_assert
 inside the loop
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20201003063143.13093-1-foxhlchen@gmail.com>
From:   Andrew Price <anprice@redhat.com>
Message-ID: <ca694fc8-5f1b-ebf0-b891-c9a20225704f@redhat.com>
Date:   Mon, 5 Oct 2020 14:23:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201003063143.13093-1-foxhlchen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2020 07:31, Fox Chen wrote:
> for (x = 2;; x++) {
>          ...
>          gfs2_assert(sdp, x <= GFS2_MAX_META_HEIGHT);  <--- after
>          ...
>          if (d != sdp->sd_heightsize[x - 1] || m)
>                  break;
>          sdp->sd_heightsize[x] = space;
> }
> 
> sdp->sd_max_height = x
> gfs2_assert(sdp, sdp->sd_max_height <= GFS2_MAX_META_HEIGHT) <--- before
> 
> Before this patch, gfs2_assert is put outside of the loop of
> sdp->sd_heightsize[x] calculation. When something goes wrong,

So this looks related to one of the recent syzbot reports, where the 
"something goes wrong" is the block size in the on-disk superblock was 
zeroed and that leads eventually to this out-of-bounds write. The 
correct fix in that case would be to add a validity check for the block 
size in gfs2_check_sb().

Andy

> x exceeds the size of GFS2_MAX_META_HEIGHT, it may already crash inside
> the loop when
> 
> sdp->sd_heightsize[x] = space
> 
> tries to reach the out-of-bound
> location, gfs2_assert won't help here.
> 
> This patch fixes this by moving gfs2_assert into the loop.
> We will check x value each time to see if it exceeds GFS2_MAX_META_HEIGHT.
> 
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>   fs/gfs2/ops_fstype.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 6d18d2c91add..6cc32e3010f2 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -333,6 +333,7 @@ static int gfs2_read_sb(struct gfs2_sbd *sdp, int silent)
>   		u64 space, d;
>   		u32 m;
>   
> +		gfs2_assert(sdp, x <= GFS2_MAX_META_HEIGHT);
>   		space = sdp->sd_heightsize[x - 1] * sdp->sd_inptrs;
>   		d = space;
>   		m = do_div(d, sdp->sd_inptrs);
> @@ -343,7 +344,6 @@ static int gfs2_read_sb(struct gfs2_sbd *sdp, int silent)
>   	}
>   	sdp->sd_max_height = x;
>   	sdp->sd_heightsize[x] = ~0;
> -	gfs2_assert(sdp, sdp->sd_max_height <= GFS2_MAX_META_HEIGHT);
>   
>   	sdp->sd_max_dents_per_leaf = (sdp->sd_sb.sb_bsize -
>   				      sizeof(struct gfs2_leaf)) /
> 

