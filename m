Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454DF2C7B1D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 21:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgK2UNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 15:13:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgK2UNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 15:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606680709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zaOiU6gv3Cl3SmrnFPxyyv/QzuHHKMlBz/t6xjcea8E=;
        b=ZRFLJDIY1w/ZKe7U3iJi3ZcRs58UqEx0OoRO0+UZfllk0nGBD4EDj7QsqWaA3hbbj4Qt/W
        XcN14RFa+2SrEIfwl5hl5eAYlDNGLL2k14ldFloZOOFbLabaj8FyvuF4MDYPar6Hk9YHX9
        ca/dcWccZ6sh5s0l8U/mSQ8/0/j6kQ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-mSH9WsZYPMGv4pRgb-RZGw-1; Sun, 29 Nov 2020 15:11:47 -0500
X-MC-Unique: mSH9WsZYPMGv4pRgb-RZGw-1
Received: by mail-wr1-f70.google.com with SMTP id z13so7108271wrm.19
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 12:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zaOiU6gv3Cl3SmrnFPxyyv/QzuHHKMlBz/t6xjcea8E=;
        b=IMMpQXhN6Um6Ovllu4M/K3mHKIj7vdqCHIrvf/flVQQ0H0DczaXGDV5tKnv/j14tBB
         o+KR2lu/lStYp4jKRLnVKXeeMBZ3sDiJy9gw3Pe905iPI4hAMZMzKtFL6S/a+W1K93gf
         VQoK1Pen0tl0YyQj0VedCC3+hAc1ysife3XnmQPnw6D0w93n9poaAmiAUDyRXLnl7cPx
         yvhzHF2flCn2QN5mBxayfovS0r/OvZuhQX+Y5rcCVknBZuvSCBTH5uoj1dHJTcmkk8Yi
         Mixjm5QNfF++72pqof5CN6qU8Ffpc4JC68rqlZi4ESxZroPSPlsn2Fh73vHitlBXd/El
         Wkhg==
X-Gm-Message-State: AOAM531F1jjY8fJpDjgKQvdEOMYT1dQpKeTTo9ZjRvrPHynB6VUqAD39
        RNb7ardb+l7pFmULgWJqhE9GzlQuqiF0Jw9UY5vfzVJFPEgYde+pI8S2a7P9h4Ag8wxTHD8nhNt
        gF4swJ5hQr4zplGuDWe7JBvqC
X-Received: by 2002:a05:6000:105:: with SMTP id o5mr18151676wrx.164.1606680706163;
        Sun, 29 Nov 2020 12:11:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPka2aHaDPPX0PTgwDnAG/w5i0WrMz+FyjrUMAbM+Qjqz54JODofUJr+22IVyBqFlX4tuyzw==
X-Received: by 2002:a05:6000:105:: with SMTP id o5mr18151664wrx.164.1606680706012;
        Sun, 29 Nov 2020 12:11:46 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id 34sm24071900wrh.78.2020.11.29.12.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 12:11:45 -0800 (PST)
Date:   Sun, 29 Nov 2020 15:11:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, jasowang@redhat.com,
        linux-gpio@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20201129151113-mutt-send-email-mst@kernel.org>
References: <20201127183003.2849-1-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127183003.2849-1-info@metux.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 07:30:03PM +0100, Enrico Weigelt, metux IT consult wrote:
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index b052355ac7a3..85772c0bcb4b 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -48,5 +48,6 @@
>  #define VIRTIO_ID_FS           26 /* virtio filesystem */
>  #define VIRTIO_ID_PMEM         27 /* virtio pmem */
>  #define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
> +#define VIRTIO_ID_GPIO           30 /* virtio GPIO */


Pls remember to reserve the ID with the virtio TC
before using it in the driver. Thanks!

>  #endif /* _LINUX_VIRTIO_IDS_H */
> -- 
> 2.11.0

