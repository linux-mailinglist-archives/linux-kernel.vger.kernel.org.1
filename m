Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE12E9EDB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 21:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbhADU3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 15:29:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbhADU3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 15:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609792076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZyoiIpH6kZDHPl7NK/RSNTGczl9VjVr3GWY2olZ3kOk=;
        b=dhW+hnJT28dPbn646/0TWsFLRonF44sPUCiu6RXF9muG4HQDzVGN62mmAl0ughTg/M9GmW
        4RirvGq42M5fE47tR1V/uKRKkdekhRUkYx/FGCn9vHRD6HnuxH6IuqcZ6tpBfEQOYwPeNt
        pmoLEcPETA5dYip6NtUlPxK1yaaci5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-BigQOZF4NlqZ0XWu9Z0Xnw-1; Mon, 04 Jan 2021 15:27:55 -0500
X-MC-Unique: BigQOZF4NlqZ0XWu9Z0Xnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AC6B10054FF;
        Mon,  4 Jan 2021 20:27:54 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A86B517250;
        Mon,  4 Jan 2021 20:27:50 +0000 (UTC)
Date:   Mon, 4 Jan 2021 15:27:50 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Defang Bo <bodefang@126.com>
Cc:     agk@redhat.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: dm snap : add sanity checks to snapshot_ctr
Message-ID: <20210104202749.GA3721@redhat.com>
References: <1608878926-2283057-1-git-send-email-bodefang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608878926-2283057-1-git-send-email-bodefang@126.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25 2020 at  1:48am -0500,
Defang Bo <bodefang@126.com> wrote:

> Similar to commit<70de2cbd>,there should be a check for argc and argv to prevent Null pointer dereferencing
> when the dm_get_device invoked twice on the same device path with differnt mode.
> 
> Signed-off-by: Defang Bo <bodefang@126.com>
> ---
>  drivers/md/dm-snap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
> index 4668b2c..dccce8b 100644
> --- a/drivers/md/dm-snap.c
> +++ b/drivers/md/dm-snap.c
> @@ -1258,6 +1258,13 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  
>  	as.argc = argc;
>  	as.argv = argv;
> +
> +	if (!strcmp(argv[0], argv[1])) {
> +		ti->error = "Error setting metadata or data device";
> +		r = -EINVAL;
> +		goto bad;
> +	}
> +
>  	dm_consume_args(&as, 4);
>  	r = parse_snapshot_features(&as, s, ti);
>  	if (r)
> -- 
> 2.7.4
> 

We already have this later in snapshot_ctr:

        if (cow_dev && cow_dev == origin_dev) {
                ti->error = "COW device cannot be the same as origin device";
                r = -EINVAL;
                goto bad_cow;
        }

Which happens before the 2nd dm_get_device() for the cow device.  So
I'm not seeing how you could experience the NULL pointer you say is
possible.

Mike

