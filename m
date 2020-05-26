Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699681E26C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgEZQVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 12:21:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23367 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728332AbgEZQVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590510091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++oMQ8DAzk3stWgAeDWQyIugeO5lrOVIAn/CXGwtVkI=;
        b=PI5VSddaRYnHCwbpxyWs/ZqYOXNx41JWPFZLEquW4LcaZt3szA8bs4UtDGNUkF/kNIX6FS
        q/QxYgnnOrTHCHeCC9xEGWhGRQF+V33Qcqogf1smtyuztE2a187JColM4BI/wZ6GN5nm7K
        sHwD2lnl2ZXm8ulXdQc5Tv3QGGZvLu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-ZIZ60EleMaySfh3xy6gibg-1; Tue, 26 May 2020 12:21:29 -0400
X-MC-Unique: ZIZ60EleMaySfh3xy6gibg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 766868014D7;
        Tue, 26 May 2020 16:21:28 +0000 (UTC)
Received: from x1.home (ovpn-114-203.phx2.redhat.com [10.3.114.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 289BD6E50D;
        Tue, 26 May 2020 16:21:28 +0000 (UTC)
Date:   Tue, 26 May 2020 10:21:27 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     cohuck@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] vfio/pci: fix a null-ptr-deref in
 vfio_config_free()
Message-ID: <20200526102127.5afc9035@x1.home>
In-Reply-To: <20200522011829.17301-1-cai@lca.pw>
References: <20200522011829.17301-1-cai@lca.pw>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 21:18:29 -0400
Qian Cai <cai@lca.pw> wrote:

> It is possible vfio_config_init() does not call vfio_cap_len(), and then
> vdev->msi_perm == NULL. Later, in vfio_config_free(), it could trigger a
> null-ptr-deref.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  RIP: 0010:vfio_config_free+0x7a/0xe0 [vfio_pci]
>  vfio_config_free+0x7a/0xe0:
>  free_perm_bits at drivers/vfio/pci/vfio_pci_config.c:340
>  (inlined by) vfio_config_free at drivers/vfio/pci/vfio_pci_config.c:1760
>  Call Trace:
>   vfio_pci_release+0x3a4/0x9e0 [vfio_pci]
>   vfio_device_fops_release+0x50/0x80 [vfio]
>   __fput+0x200/0x460
>   ____fput+0xe/0x10
>   task_work_run+0x127/0x1b0
>   do_exit+0x782/0x10d0
>   do_group_exit+0xc7/0x1c0
>   __x64_sys_exit_group+0x2c/0x30
>   do_syscall_64+0x64/0x350
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fixes: bea890bdb161 ("vfio/pci: fix memory leaks in alloc_perm_bits()")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

I may get yelled at for it, but I need to break my next branch to fix
the lockdep issue you noted in my series, so I'm going to go ahead and
roll this into your previous patch.  Thanks,

Alex
 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index d127a0c50940..8746c943247a 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1757,9 +1757,11 @@ void vfio_config_free(struct vfio_pci_device *vdev)
>  	vdev->vconfig = NULL;
>  	kfree(vdev->pci_config_map);
>  	vdev->pci_config_map = NULL;
> -	free_perm_bits(vdev->msi_perm);
> -	kfree(vdev->msi_perm);
> -	vdev->msi_perm = NULL;
> +	if (vdev->msi_perm) {
> +		free_perm_bits(vdev->msi_perm);
> +		kfree(vdev->msi_perm);
> +		vdev->msi_perm = NULL;
> +	}
>  }
>  
>  /*

