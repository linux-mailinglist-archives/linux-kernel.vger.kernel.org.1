Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998F82E9C22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 18:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbhADRhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 12:37:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbhADRhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609781786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1LnAemTbBNBbqP419KX05Pp5Uzm2RZAoo+8GOCACn4=;
        b=DDy1R+jPH+vtn3ARkkQeBd4nSPerhd4IxH/MsPwkNc8aRA8VsvAFJX+fX2SktAXqxv+1Vm
        L9a16bs6/7XbRjU5PbpMWXpkuupmbRY1a0ZNnc0UR7vnsuvnpJhOURmPKveyeK2B32marH
        +C2Ugwy/DAinzBZCHzg0ZtCcof2yZDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-2rDerYD2M0yXms6uUtP6TA-1; Mon, 04 Jan 2021 12:36:25 -0500
X-MC-Unique: 2rDerYD2M0yXms6uUtP6TA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC753800D53;
        Mon,  4 Jan 2021 17:36:22 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3A161001281;
        Mon,  4 Jan 2021 17:36:22 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A09AE4BB40;
        Mon,  4 Jan 2021 17:36:22 +0000 (UTC)
Date:   Mon, 4 Jan 2021 12:36:17 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Message-ID: <1782315626.42423902.1609781777002.JavaMail.zimbra@redhat.com>
In-Reply-To: <1609126800-19953-1-git-send-email-huangzhaoyang@gmail.com>
References: <1609126800-19953-1-git-send-email-huangzhaoyang@gmail.com>
Subject: Re: [PATCH] fs: amend SLAB_RECLAIM_ACCOUNT on gfs2_quotad_cachep
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.52, 10.4.195.21]
Thread-Topic: amend SLAB_RECLAIM_ACCOUNT on gfs2_quotad_cachep
Thread-Index: K9p1ljaFLQ5Tr93kZqn0v2ncKqiWDA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> As gfs2_quotad_cachep has registered the shrinker, amending
> SLAB_RECLAIM_ACCOUNT when create gfs2_quotad_cachep, which
> make the slab acount to be presiced.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  fs/gfs2/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
> index 136484e..db39de9 100644
> --- a/fs/gfs2/main.c
> +++ b/fs/gfs2/main.c
> @@ -136,7 +136,7 @@ static int __init init_gfs2_fs(void)
>  
>  	gfs2_quotad_cachep = kmem_cache_create("gfs2_quotad",
>  					       sizeof(struct gfs2_quota_data),
> -					       0, 0, NULL);
> +					       0, SLAB_RECLAIM_ACCOUNT, NULL);
>  	if (!gfs2_quotad_cachep)
>  		goto fail_cachep6;
>  
> --
> 1.9.1
> 
> 
Hi,

Thanks for the patch.
We should also do this for gfs2_glock_cachep. Can you add that to your patch?

Regards,

Bob Peterson

