Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1112DDF4C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 08:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgLRH6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 02:58:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbgLRH6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 02:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608278225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3uqE9M30CbyZz7Al0ttuF7vbymURHAmKiPU9njynek=;
        b=XGjnKEsBRTw7FYgpvoM1ERZZB2XEKRnLotOZ/S1dAH6bHHtHxGqtY2XLVbY6R01zhy8ZtM
        rfK+kSAwfTTxCq1f7ScqWyQqJJoomi8HINNXguSyzoEe1vQJUjrdW0i8KjYWKCBcNzWFaH
        DyLhOapSYtbQXIA6RhG4aI0S0L97X4w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-3MgflpRtPvyHtDb4QI5Ogg-1; Fri, 18 Dec 2020 02:57:03 -0500
X-MC-Unique: 3MgflpRtPvyHtDb4QI5Ogg-1
Received: by mail-wr1-f70.google.com with SMTP id v1so792247wri.16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 23:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e3uqE9M30CbyZz7Al0ttuF7vbymURHAmKiPU9njynek=;
        b=PBtcZqICYifHvNKnkQ+gFtLIUR9zaHDDiLNPKw0H8RYVJF+xsSlVMAHV2Ni8ioGeIo
         IURX9C46CkGPmbt7esUPNWtmAHuddxYwOClUlIGfp17QodDMZ/L1dFz9uQEPix5JbBij
         fTX0ER5iQ9k1ggoJR9PwAYJUWKXA74eGBCTJXS6qWgIaf0RcYjRxLDGB9QYaaycy4hM/
         Je87roZz4lV/kxunLxxr0eQ7OUKnNf9kuneA8iVReiXtlQwmdbAVroAizxhTM1OpwG4I
         /kDbHyadyeFtBifyO9aIIIeGef5JtyAUhH3xg5xQT1Mt6Zx9P2n+zDW9jrd/HqM5rSF0
         D9cw==
X-Gm-Message-State: AOAM533M22fuEZD2ySP+sGBOeUCnVmhSB/BvUfhMOAZP1Pw6sUxLQ/tt
        UdTK8mAB6G92p1Xi6cdtCcjqmMzH/mlTP48hECdMAmwimmYcCcsEwFirQdMKOpJCaj50Imvu5cQ
        te2k16P60rB9ygIcUvtSYwkBg
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr2979122wml.155.1608278222393;
        Thu, 17 Dec 2020 23:57:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyz7342iA1Eqkl5G56cSsoK9yPrUy+f4KaNGvgeqTyJrNoyAJ8oxkVW15SUsDhqyoYqS0l4Cg==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr2979112wml.155.1608278222237;
        Thu, 17 Dec 2020 23:57:02 -0800 (PST)
Received: from steredhat (host-79-13-204-15.retail.telecomitalia.it. [79.13.204.15])
        by smtp.gmail.com with ESMTPSA id r20sm13239858wrg.66.2020.12.17.23.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 23:57:01 -0800 (PST)
Date:   Fri, 18 Dec 2020 08:56:59 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     mst@redhat.com, jasowang@redhat.com, mgurtovoy@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] vdpa: Mark macaddr_buf with static keyword
Message-ID: <20201218075659.zjts2fiwp2jkh2ei@steredhat>
References: <1608256295-69649-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1608256295-69649-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 09:51:35AM +0800, Zou Wei wrote:
>Fix the following sparse warning:
>
>drivers/vdpa/vdpa_sim/vdpa_sim_net.c:36:4: warning: symbol 'macaddr_buf' was not declared. Should it be static?
>
>Reported-by: Hulk Robot <hulkci@huawei.com>
>Signed-off-by: Zou Wei <zou_wei@huawei.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

I built with W=1 but I didn't have this warning.

Thanks for fixing,
Stefano

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>index c10b698..f048242 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -33,7 +33,7 @@ static char *macaddr;
> module_param(macaddr, charp, 0);
> MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
>
>-u8 macaddr_buf[ETH_ALEN];
>+static u8 macaddr_buf[ETH_ALEN];
>
> static struct vdpasim *vdpasim_net_dev;
>
>-- 
>2.6.2
>

