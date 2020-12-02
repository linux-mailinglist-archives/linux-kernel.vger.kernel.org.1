Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F6B2CBB83
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgLBLXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30828 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbgLBLXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606908095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tWFGgSupy/SUledxw6vTNMTFDlvVB4tfXcEiiE/bKy4=;
        b=HPywrElrs6AEfnNKCHcRjRe/KPiw66lCvYoPhzRN36Po7EhKqQXYnCmTURwPBcF0TuSaiF
        GPPX9Niy8eyOSkoPoTK+zMtgUrEsnMhnC+erP08nPDZ7H08lQmZzRs0KTdYYOYqiPgJA9q
        qk4hz6JMUZ/2gkcq7i6+pbv2IAmLbgU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-pjer-GE-NOasdK58ZJZ4vA-1; Wed, 02 Dec 2020 06:21:34 -0500
X-MC-Unique: pjer-GE-NOasdK58ZJZ4vA-1
Received: by mail-wr1-f70.google.com with SMTP id b12so3411521wru.15
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 03:21:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tWFGgSupy/SUledxw6vTNMTFDlvVB4tfXcEiiE/bKy4=;
        b=IxEbe4CQSdmYBa+PHa0yXqL3qzm/Qs5glsD/B8gO147nPJ10U5uR4r3bHgjJpvjfKK
         /AX5e9xzNwDQUyRsnq2vCaPBOV73MpGmgJw7iBdMjFue0iAuGkQ4UVaCYS6fG5ftFJ7D
         7+gNRwn/lWLbxvRjpF94lsKLy49EaiFhoSd0i6HMYoxO3Gl8XFjF5DcKd3zuyblCBgQb
         TP0XP8J31KfmB9cf13XxF/GURinNv+rSFrvweN4Mlprjbyq+ibv08y10cWMNzQZRO+IP
         2O2Sv4NlTmmqZy5KnlVYLi9NVf1N1UgzpAJpDE78EeV6/gkVXpZX18doomI2nzw46qP4
         fE4Q==
X-Gm-Message-State: AOAM531xxUvY3FUo1wpWPYDotAd5ueFdWDoWrM9WBMQhdcjoHjQD4fSk
        +s4SMA9AJHVo6byVOrZWk+XfLbX1Hut0uE/JfGBlBm4nxpkbQ/HnE2toDjSBiLTui1wSW+mcO0s
        tXgZptOMWtA+pY4M/AcpxNcQr
X-Received: by 2002:a5d:634b:: with SMTP id b11mr2911846wrw.97.1606908092963;
        Wed, 02 Dec 2020 03:21:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1fsWF2Z7gQLSZxuX2FtoXMrXiM5VaYGLyrMtNuIcm5lD7L7yq4NnqVWesShsXHBORlb/pRA==
X-Received: by 2002:a5d:634b:: with SMTP id b11mr2911827wrw.97.1606908092807;
        Wed, 02 Dec 2020 03:21:32 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id v1sm1623707wrr.48.2020.12.02.03.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:21:32 -0800 (PST)
Date:   Wed, 2 Dec 2020 06:21:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 2/2] uapi: virtio_ids: add missing device type IDs from
 OASIS spec
Message-ID: <20201202062046-mutt-send-email-mst@kernel.org>
References: <20201202111931.31953-1-info@metux.net>
 <20201202111931.31953-2-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202111931.31953-2-info@metux.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 12:19:31PM +0100, Enrico Weigelt, metux IT consult wrote:
> The OASIS virtio spec (1.1) defines several IDs that aren't reflected
> in the header yet. Fixing this by adding the missing IDs, even though
> they're not yet used by the kernel yet.


double yet ;)

> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  include/uapi/linux/virtio_ids.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 3cb55e5277a1..bc1c0621f5ed 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -34,15 +34,21 @@
>  #define VIRTIO_ID_CONSOLE		3 /* virtio console */
>  #define VIRTIO_ID_RNG			4 /* virtio rng */
>  #define VIRTIO_ID_BALLOON		5 /* virtio balloon */
> +#define VIRTIO_ID_IOMEM			6 /* virtio ioMemory */
>  #define VIRTIO_ID_RPMSG			7 /* virtio remote processor messaging */
>  #define VIRTIO_ID_SCSI			8 /* virtio scsi */
>  #define VIRTIO_ID_9P			9 /* 9p virtio console */
> +#define VIRTIO_ID_MAC80211_WLAN		10 /* virtio WLAN MAC */
>  #define VIRTIO_ID_RPROC_SERIAL		11 /* virtio remoteproc serial link */
>  #define VIRTIO_ID_CAIF			12 /* Virtio caif */
> +#define VIRTIO_ID_MEMORY_BALLOON	13 /* virtio memory balloon */
>  #define VIRTIO_ID_GPU			16 /* virtio GPU */
> +#define VIRTIO_ID_CLOCK			17 /* virtio clock/timer */
>  #define VIRTIO_ID_INPUT			18 /* virtio input */
>  #define VIRTIO_ID_VSOCK			19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO		20 /* virtio crypto */
> +#define VIRTIO_ID_SIGNAL_DIST		21 /* virtio signal distribution device */
> +#define VIRTIO_ID_PSTORE		22 /* virtio pstore device */
>  #define VIRTIO_ID_IOMMU			23 /* virtio IOMMU */
>  #define VIRTIO_ID_MEM			24 /* virtio mem */
>  #define VIRTIO_ID_FS			26 /* virtio filesystem */
> -- 
> 2.11.0

