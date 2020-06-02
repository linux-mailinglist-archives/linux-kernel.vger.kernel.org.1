Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC531EB4F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 07:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgFBFPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 01:15:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42441 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725841AbgFBFPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591074920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Omt9gJipjlxk0xAiBkDipMLYpK/jCtWILzTzD1eFi2g=;
        b=IMukX3sOMlM8mgpuDBgEJx7qRf7dV6flhp4QzdZOJqHVfHbzK6nzzOZWIZwPmaA1ERyUMZ
        xZkdHXhr8FDX1cxfedAp1VGBp1VNI4cSze6y8E4cG3yLSZujyi2z07heo3SgCLfy8qxxG4
        4y5VuwtYiW15TQRz1ND4sbDy7VDFUto=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-WN6aMau5OVWM74m0XJzd1w-1; Tue, 02 Jun 2020 01:09:38 -0400
X-MC-Unique: WN6aMau5OVWM74m0XJzd1w-1
Received: by mail-wr1-f70.google.com with SMTP id m14so881215wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 22:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Omt9gJipjlxk0xAiBkDipMLYpK/jCtWILzTzD1eFi2g=;
        b=fKWyfxtqjPQcoZ1vE5FSO4vAQ7HmJTYlfmk2jE0lZ+mI7lEp87LBSyllluS0Nt3R0P
         FmrpsJHdv7c4EfGZpHdCmvsQ7yI/yEB8w9CehPo9GFcKjE9GeBFw1IMB5qna4wQH2yly
         t/c26Y8DTAZirpNM08kJaJgnGMxvNopM76Visfho7sNcRnKLDlt5iopwjRLsLixbhqpF
         koeE1Ms2xzSvqGirGN5rA3X7Xhi2dDk6VXdbs15+DGr+h/A82kv1t4o1vfOXLGEjywoB
         aedgbl1I7X5vreLQspQGD4CUp2/cuMhfkZcnUkv9Nu7cY6BegutW9FY9LniC038XGIwB
         oKxg==
X-Gm-Message-State: AOAM530R6OjIwiucbT5BA4DDZQInjTkRWYfJo7HhJv1z8ByI9zNr0wR5
        0mGe7NIWTDF/QszjNexHJqg0eP45nWWyHnkokVAc92juLc/TRb3saW7YQjDh7vomXRQtHVjn2Ll
        4jwVKZItTGhP7IT1DFHaD3zao
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr23481643wrx.141.1591074577588;
        Mon, 01 Jun 2020 22:09:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzC4LVeDOhERR8qf9AS4nc4Mi6WpaPRsevGBTu/GWRHQywd6PHu2y8E93bGd9V5IBqDeftUgQ==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr23481639wrx.141.1591074577444;
        Mon, 01 Jun 2020 22:09:37 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id a3sm1785369wmb.7.2020.06.01.22.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 22:09:36 -0700 (PDT)
Date:   Tue, 2 Jun 2020 01:09:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH 5/6] vdpa: introduce virtio pci driver
Message-ID: <20200602010809-mutt-send-email-mst@kernel.org>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-6-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529080303.15449-6-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 04:03:02PM +0800, Jason Wang wrote:
> Note that since virtio specification does not support get/restore
> virtqueue state. So we can not use this driver for VM. This can be
> addressed by extending the virtio specification.

Looks like exactly the kind of hardware limitation VDPA is supposed to
paper over within guest. So I suggest we use this as
a litmus test, and find ways for VDPA to handle this without
spec changes.

-- 
MST

