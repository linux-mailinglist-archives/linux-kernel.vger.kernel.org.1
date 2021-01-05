Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66AB2EAB4B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbhAEM4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:56:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54430 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729527AbhAEM4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609851281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkaRfLQqH0U8BvET7tQ/CKyv+rk+rxXC9tFuL3Sdp/s=;
        b=RQNvLZ3v6igmOewiB+DRqACDKliDR1aPFrCit9Oxt71uZGHYpXejRGN47YCqd65GBVAxKv
        ykriYMGwuKX6qRYe9wzWfLpLMyivQRQfh55J/TxJF6PnUhKmwjg31R3QhFiRaZbPqacSrD
        Mws+JpkHnSvi2e3+rC0vcFuUeXCMNfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-pdn8YQ71NjKJuXVrEcLByg-1; Tue, 05 Jan 2021 07:54:39 -0500
X-MC-Unique: pdn8YQ71NjKJuXVrEcLByg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A00D800683;
        Tue,  5 Jan 2021 12:54:38 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52B6618A2F;
        Tue,  5 Jan 2021 12:54:37 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 1DC4718095C7;
        Tue,  5 Jan 2021 12:54:37 +0000 (UTC)
Date:   Tue, 5 Jan 2021 07:54:34 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Message-ID: <1535117686.42500348.1609851274846.JavaMail.zimbra@redhat.com>
In-Reply-To: <1609807642-31552-1-git-send-email-huangzhaoyang@gmail.com>
References: <1609807642-31552-1-git-send-email-huangzhaoyang@gmail.com>
Subject: Re: [PATCH v2] fs: amend SLAB_RECLAIM_ACCOUNT on gfs2 related slab
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.28, 10.4.195.12]
Thread-Topic: amend SLAB_RECLAIM_ACCOUNT on gfs2 related slab cache
Thread-Index: ebnfMPn3ZtGLtG6ofpW+am73oZGEhw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> As gfs2_quotad_cachep and gfs2_glock_cachep have registered
> the shrinker, amending SLAB_RECLAIM_ACCOUNT when creating
> them, which make the slab acount to be presiced.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: add gfs2_glock_cachep for same operation
> ---
Hi,

Thanks. Your patch is now pushed to the linux-gfs2/for-next branch.
I cleaned up the description a bit. For example, I changed "fs:" to
"gfs2:" to conform to other gfs2 patches.

Regards,

Bob Peterson

