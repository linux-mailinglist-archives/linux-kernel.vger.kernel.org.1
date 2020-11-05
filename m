Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655382A7795
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 07:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgKEGwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 01:52:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725298AbgKEGwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 01:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604559162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K5R6JGiYe4/u2K6/yJ14UH2NO+ZUGFzIOqRPQLmETsU=;
        b=BZ9kYKJCYBqa3kerMr/hC7IXA5AkjQUBoYh1742a3PFVRDGCpJIk0g8bmkPmCqlb0qCQG+
        6qsCraPDw/vCpdJ1QQvZMltzfTh/PVe9Ratr3D35/E2XjForMsVys5Hs87b/qL2L8j/Xuc
        Dq7ih6MkAqZqPXjXXzUmM364cUuwAzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-s43WvTDkOEyEdii-a-OWkw-1; Thu, 05 Nov 2020 01:52:38 -0500
X-MC-Unique: s43WvTDkOEyEdii-a-OWkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4254E8015AD;
        Thu,  5 Nov 2020 06:52:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com [10.36.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB1095D9D5;
        Thu,  5 Nov 2020 06:52:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DC06D16E18; Thu,  5 Nov 2020 07:52:33 +0100 (CET)
Date:   Thu, 5 Nov 2020 07:52:33 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Suleiman Souhlal <suleiman@google.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: use kvmalloc for large allocations
Message-ID: <20201105065233.3td3zuyfmbypjtvq@sirius.home.kraxel.org>
References: <20201105014744.1662226-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105014744.1662226-1-senozhatsky@chromium.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> -	*ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
> -			      GFP_KERNEL);
> +	*ents = kvmalloc_array(*nents,
> +			       sizeof(struct virtio_gpu_mem_entry),
> +			       GFP_KERNEL);

Shouldn't that be balanced with a kvfree() elsewhere?

take care,
  Gerd

