Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE026151E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 18:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbgIHQoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 12:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731771AbgIHQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599582670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UXzNpJhj5sowidUDfDEXaS6phGxQ0LavcBR8ek7/U9c=;
        b=iK7u8gqpTdfoXtYU7OEq1JMZEKUJ/jsz2+CmjRLgK0vnEdBMfK+xTHflvuSIQPLCQXQfKI
        USZG0O04bXNJOlvoGMTFRjaBw7T40JaXY42xiTQfpf4AohMPEtBxaRPxNgnOL7Zhri5m+g
        MiUFwMRms28BSiokT5MqTL9KorYiJ3Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-NTz7vs9qOBO87HqdsTWTiw-1; Tue, 08 Sep 2020 10:15:58 -0400
X-MC-Unique: NTz7vs9qOBO87HqdsTWTiw-1
Received: by mail-wr1-f70.google.com with SMTP id n15so6987947wrv.23
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 07:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UXzNpJhj5sowidUDfDEXaS6phGxQ0LavcBR8ek7/U9c=;
        b=Au6uLxctztv6jf5BDxOLkYBGxoMPEYRgWfmOG8QaGXaWAwg4lxn1uovcAfD1FmvhfM
         qnPI6rz8alZU7HSJwHPpB0JiAKVSRVfdtdmulrNHNDvC9IaXGgoNBbfgbu//+SbAumo9
         WCf1DVTrM1zyM5YDwp1ROSGe9vRV+o9JHiJHMts6M8LeHnNLsb4CZ+zxeHvBpiNYWz/z
         F3oltTX9ezT53NWilRQ32DmUdBDieKQ8UO1MSJdp+XWY+WnDfmz1eKVlTiRJ+Frl8sKM
         BhNnNhVFMwOADzqn5xkIYEjjd5ghkLeHo1Gi7sKErB9jL1vyvKqE0X3nOTZyWYZNPJaw
         ctRg==
X-Gm-Message-State: AOAM5303nggodCpw46pZ29hIGD/quAVk5vE2Ml7IO0Elze+UmcarbKRv
        NWWsEpZsZzUdITanQHW3l1CVORTVjFDqxYwvbaWrirdKBYaayrzxqkbS6Sc3ZS1ENm9uHVZwk4D
        O3B8F6EGgqxHk0WRADXAtPy50
X-Received: by 2002:adf:ba10:: with SMTP id o16mr26932376wrg.100.1599574557186;
        Tue, 08 Sep 2020 07:15:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqEKlAdEL5xW+LjUpamB0FNN2eHC7z5gQAJUS0ZT9mISMnhGZ2hx0LZial5U4dn8IDd/bz+A==
X-Received: by 2002:adf:ba10:: with SMTP id o16mr26932354wrg.100.1599574557014;
        Tue, 08 Sep 2020 07:15:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-218-236.inter.net.il. [80.230.218.236])
        by smtp.gmail.com with ESMTPSA id a20sm30604272wmm.40.2020.09.08.07.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 07:15:55 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:15:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matej Genci <matej.genci@nutanix.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH] Rescan the entire target on transport reset when LUN is 0
Message-ID: <20200908101531-mutt-send-email-mst@kernel.org>
References: <CY4PR02MB33354370E0A81E75DD9DFE74FB520@CY4PR02MB3335.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR02MB33354370E0A81E75DD9DFE74FB520@CY4PR02MB3335.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 12:21:35PM +0000, Matej Genci wrote:
> VirtIO 1.0 spec says
>     The removed and rescan events ... when sent for LUN 0, they MAY
>     apply to the entire target so the driver can ask the initiator
>     to rescan the target to detect this.
> 
> This change introduces the behaviour described above by scanning the
> entire scsi target when LUN is set to 0. This is both a functional and a
> performance fix. It aligns the driver with the spec and allows control
> planes to hotplug targets with large numbers of LUNs without having to
> request a RESCAN for each one of them.
> 
> Signed-off-by: Matej Genci <matej@nutanix.com>
> Suggested-by: Felipe Franciosi <felipe@nutanix.com>

Stefan, Paolo, could you review this pls?

> ---
>  drivers/scsi/virtio_scsi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index bfec84aacd90..a4b9bc7b4b4a 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -284,7 +284,12 @@ static void virtscsi_handle_transport_reset(struct virtio_scsi *vscsi,
>  
>  	switch (virtio32_to_cpu(vscsi->vdev, event->reason)) {
>  	case VIRTIO_SCSI_EVT_RESET_RESCAN:
> -		scsi_add_device(shost, 0, target, lun);
> +		if (lun == 0) {
> +			scsi_scan_target(&shost->shost_gendev, 0, target,
> +					 SCAN_WILD_CARD, SCSI_SCAN_INITIAL);
> +		} else {
> +			scsi_add_device(shost, 0, target, lun);
> +		}
>  		break;
>  	case VIRTIO_SCSI_EVT_RESET_REMOVED:
>  		sdev = scsi_device_lookup(shost, 0, target, lun);
> -- 
> 2.20.1

