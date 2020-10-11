Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA9128A60B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 08:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgJKGqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 02:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbgJKGqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 02:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602398759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJ3BlgkCnk7q4i6A6rDWI4Y07VULo0UVj4WHUXEfZVc=;
        b=A52kVWBnFxYjfLMe8GnfzT1mY4Xi3g7OBInt98GDU/lvpkSYN41de64uxpeZzCNDUnCsem
        XhyHzjBtsoVINwHY2GOy8LTerxHhECs8YSVrj3k+jCg/F2j4iUTXNuujWV9Z/Y8gUVH0AR
        wL+hbsZCW1FPY99AiSO3SIjFPUrxliY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-1J0zyNsYMkOqzpG7DiFILw-1; Sun, 11 Oct 2020 02:45:57 -0400
X-MC-Unique: 1J0zyNsYMkOqzpG7DiFILw-1
Received: by mail-wr1-f71.google.com with SMTP id t3so937767wrq.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 23:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dJ3BlgkCnk7q4i6A6rDWI4Y07VULo0UVj4WHUXEfZVc=;
        b=nEB/yZnbMIRRqB0FqIzxWgifyeoV5qhdKDXrrVUDiNM/ANGSXbV9XMivIWvfs3XqN3
         7wKORnPkUa4upRbyFp1Es9nPiX/CwiEDhXmj5rb/lAL+v9Uq4SKC6F3BUVHJyYUuEYzJ
         Qflj0fE+7kF6gRDsCOMBjM3Lwd5mvrSaz+LjfbaqHQqPp8ljKWU4yvuhAX5uVYaoYOxD
         xFbqMB9MQwCEeJLxyhIBN2/cH+Y4z54bdSAGo2URXPAy8tqf2qhX83kNFbDVCwDqx4CQ
         mCwGmYUYZMhWjjjbd9NyZKxEOiKeGhxOUVf0S6Rvkcpeaqe0egDNnbkh9G3LQsk8RRbF
         humQ==
X-Gm-Message-State: AOAM531Eq7QFymOGEhGGmBMoX8WcOwmC0tTmqgdqB6fVnBNwgyPNaO1H
        JltJYPrif+ChKLVy7FVI2a8/34jv4VeBfhOAsmxcVV2MdsLQuzVvDCiFnSNBk7zjE2UX72yWZkp
        6IsfJdAg3pqWoOv9Kk5472NPf
X-Received: by 2002:a7b:c183:: with SMTP id y3mr5518156wmi.84.1602398755966;
        Sat, 10 Oct 2020 23:45:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymVd3zPBGJk+gsm5hB6NEr0sdsOHn19hXK54y5exKXDFRh+F/ZOFStkaryviOkX38fGRPEVg==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr5518140wmi.84.1602398755755;
        Sat, 10 Oct 2020 23:45:55 -0700 (PDT)
Received: from redhat.com (bzq-79-179-76-41.red.bezeqint.net. [79.179.76.41])
        by smtp.gmail.com with ESMTPSA id y66sm1509945wmd.14.2020.10.10.23.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 23:45:55 -0700 (PDT)
Date:   Sun, 11 Oct 2020 02:45:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>, lingshan.zhu@intel.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] vhost-vdpa: fix vhost_vdpa_map() on error
 condition
Message-ID: <20201011024533-mutt-send-email-mst@kernel.org>
References: <1601701330-16837-1-git-send-email-si-wei.liu@oracle.com>
 <1601701330-16837-2-git-send-email-si-wei.liu@oracle.com>
 <a780b2e2-d8ce-4c27-df6b-47523c356d02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a780b2e2-d8ce-4c27-df6b-47523c356d02@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 09:48:42AM +0800, Jason Wang wrote:
> 
> On 2020/10/3 下午1:02, Si-Wei Liu wrote:
> > vhost_vdpa_map() should remove the iotlb entry just added
> > if the corresponding mapping fails to set up properly.
> > 
> > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > ---
> >   drivers/vhost/vdpa.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 796fe97..0f27919 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -565,6 +565,9 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
> >   			      perm_to_iommu_flags(perm));
> >   	}
> > +	if (r)
> > +		vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
> > +
> >   	return r;
> >   }
> 
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

Linus already merged this, I can't add your ack, sorry!

-- 
MST

