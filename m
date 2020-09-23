Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F5B276294
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIWUyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:54:36 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45959 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgIWUyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:54:35 -0400
Received: by mail-il1-f195.google.com with SMTP id h2so921200ilo.12;
        Wed, 23 Sep 2020 13:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d+sz3hgQEAMMDOvG0RAlSgcLLpJYw3j9zk3rcGcy++0=;
        b=cBYtCVl3rM9hLYsPAP1vvHrPFqq0IMMjEtefLSqa9RR/vXAQGz23cVeHtvqZxGfaj0
         UgVXjXL2ephRIKVc28emvbVO9/YGo+NbdkWgHZybuGyQYFoxBRcds0SWdKnnTOheOHqP
         G/XWBfocCyeG6caDML2yk+diFEussh+vThXn+S+10k+U8ZHM+BlFpzevBsj7+YqzC5CQ
         4tfwnBZlmmCYNZgjRgbCMVHdMFTDibzTaWb+Gx0NT5L3Asru1XaKBz3WWfUCrf4NwotR
         0YGTBWj51AQX5Mv6peg4BS6vkeUWew88A59IwA3ljvb3gZdidyNKU3MnFkB88Lzbvv0M
         1Wjw==
X-Gm-Message-State: AOAM5323OGdOAjdbEuO8cXtkA81wbWvMD2mpqa8XIsO0AbiUw7O3IsdC
        ZreUT3//49JFSxZhu2kkIA==
X-Google-Smtp-Source: ABdhPJwhB3U+7nGpX1fOCxLfZQPy0Ana+7kdT7ZxdZzgBNG61Fg1tLqg9BV4if/p+1kRC6H1Is5gRQ==
X-Received: by 2002:a05:6e02:f48:: with SMTP id y8mr1415364ilj.103.1600894474882;
        Wed, 23 Sep 2020 13:54:34 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x1sm386462ilo.50.2020.09.23.13.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:54:34 -0700 (PDT)
Received: (nullmailer pid 1290212 invoked by uid 1000);
        Wed, 23 Sep 2020 20:54:33 -0000
Date:   Wed, 23 Sep 2020 14:54:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, souvik.chakravarty@arm.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        igor.skalkin@opensynergy.com, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 6/7] dt-bindings: arm: Add virtio transport for SCMI
Message-ID: <20200923205433.GB1285024@bogus>
References: <20200918162311.254564-1-peter.hilber@opensynergy.com>
 <20200918165558.257086-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918165558.257086-1-peter.hilber@opensynergy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 06:55:58PM +0200, Peter Hilber wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> Document the properties for arm,scmi-virtio compatible nodes. The
> backing virtio SCMI device is described in patch [1].
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.html
> 
> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> ---
>  .../devicetree/bindings/arm/arm,scmi.txt      | 38 ++++++++++++++++++-
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index 55deb68230eb..844ff3c40a49 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -13,6 +13,9 @@ the device tree.
>  Required properties:
>  
>  The scmi node with the following properties shall be under the /firmware/ node.
> +Some properties are specific to a transport type.
> +
> +shmem-based transports (mailbox, smc/hvc):
>  
>  - compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
>  - mboxes: List of phandle and mailbox channel specifiers. It should contain
> @@ -21,6 +24,17 @@ The scmi node with the following properties shall be under the /firmware/ node.
>  	  supported.
>  - shmem : List of phandle pointing to the shared memory(SHM) area as per
>  	  generic mailbox client binding.
> +
> +Virtio transport:
> +
> +- compatible : shall be "arm,scmi-virtio".
> +- virtio_transport : phandle of the virtio device. This device must support one
> +                     virtqueue for transmitting commands ("tx", cmdq), and,
> +		     optionally, one more virtqueue for receiving notifications
> +		     and delayed responses ("rx", eventq).

Isn't what the virtio device provides discoverable? We don't have virtio 
protocols in DT for anything else. Why is SCMI special?

Rob
