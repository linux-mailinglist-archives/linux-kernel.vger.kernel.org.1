Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD622D9D45
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408190AbgLNRJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:09:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502174AbgLNRIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607965649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Azb2htRas8xw7ALEsczO2gUqGRQgmT58BISrepmg2Mo=;
        b=gpdf8RRP5zzt25TeiD+g1VwuLen6MSYO0r1hJ7LaRRQIlJEDMwk2HKK1Z3lY6vgGK8QI9+
        KjLwmF8J4FAEgJgmlyy+otqF534KHMmzpsKhRIGQmVytWZ8FtnlidDQn5pxwGA3pzP899E
        Ecqh3OJBMRNH/cIIUtCWsBZcdyWpGIQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-34PIeuvkNd2Fj1lCH-6HNg-1; Mon, 14 Dec 2020 12:07:28 -0500
X-MC-Unique: 34PIeuvkNd2Fj1lCH-6HNg-1
Received: by mail-wr1-f72.google.com with SMTP id b5so6841507wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Azb2htRas8xw7ALEsczO2gUqGRQgmT58BISrepmg2Mo=;
        b=bA0+Ikp3n6hIslW/rp/pfNyqVjwoN9H4ukUnGcDFnWcfFBKdfNWS38xjd8vQ6pnwID
         fX+cVdRqWzE9PgSOGrMEgyalXMDp3UbMCiG+iF0s+T7pYNPo3VxNtes1OTkDoulsRTfy
         AqIZP8Yu+9XCKxknMZmJCSDDv9kzBAn/Omnl0n11HFswOtTy7ksNdP3pKqnyiPkvPC4d
         dhVQCx4pOLwHWfFxKPHrC5IqezbKhWByD2f4oHd27cJCCaAvm/kxOtynBIK24itcXqFF
         5OUJQXPkB4D4Lv9WB3rAYl9OT6Mb6vNmeXxRS9VSJtUjgJFpFMTILAI8hjV9QORnX7Mu
         L/IQ==
X-Gm-Message-State: AOAM533xyn9UZz0AeWEP9YYjVYmR9OLmPh4+yEx5gZu1EnR1mrqPPcPq
        2d/3/qBF7zggs0UGFTjilEzfuELQAr+u+dq9yBRB1qD1/l9VTVtQ7nC8CHaUupkAyzABHk7vb5A
        SUk1JIuy4OE6TG1PZ+psYKs4P
X-Received: by 2002:a1c:7c19:: with SMTP id x25mr29307634wmc.94.1607965646719;
        Mon, 14 Dec 2020 09:07:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7I/rvdEHeRXqeMaWfQBBGfoNDRbexdnUYpm5DZwVRI2+hpzR31gY+6uQIurK6i2JelGwaVw==
X-Received: by 2002:a1c:7c19:: with SMTP id x25mr29307609wmc.94.1607965646430;
        Mon, 14 Dec 2020 09:07:26 -0800 (PST)
Received: from steredhat (host-79-13-204-15.retail.telecomitalia.it. [79.13.204.15])
        by smtp.gmail.com with ESMTPSA id m11sm16704991wmi.16.2020.12.14.09.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 09:07:25 -0800 (PST)
Date:   Mon, 14 Dec 2020 18:07:22 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Andra Paraschiv <andraprs@amazon.com>
Cc:     netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        David Duncan <davdunc@amazon.com>,
        Dexuan Cui <decui@microsoft.com>,
        Alexander Graf <graf@amazon.de>,
        Jorgen Hansen <jhansen@vmware.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH net-next v4 3/5] vsock_addr: Check for supported flag
 values
Message-ID: <20201214170722.hzv3lc3iqk2p6rsv@steredhat>
References: <20201214161122.37717-1-andraprs@amazon.com>
 <20201214161122.37717-4-andraprs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201214161122.37717-4-andraprs@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 06:11:20PM +0200, Andra Paraschiv wrote:
>Check if the provided flags value from the vsock address data structure
>includes the supported flags in the corresponding kernel version.
>
>The first byte of the "svm_zero" field is used as "svm_flags", so add
>the flags check instead.
>
>Changelog
>
>v3 -> v4
>
>* New patch in v4.
>
>Signed-off-by: Andra Paraschiv <andraprs@amazon.com>
>---
> net/vmw_vsock/vsock_addr.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vsock_addr.c b/net/vmw_vsock/vsock_addr.c
>index 909de26cb0e70..223b9660a759f 100644
>--- a/net/vmw_vsock/vsock_addr.c
>+++ b/net/vmw_vsock/vsock_addr.c
>@@ -22,13 +22,15 @@ EXPORT_SYMBOL_GPL(vsock_addr_init);
>
> int vsock_addr_validate(const struct sockaddr_vm *addr)
> {
>+	__u8 svm_valid_flags = VMADDR_FLAG_TO_HOST;
>+
> 	if (!addr)
> 		return -EFAULT;
>
> 	if (addr->svm_family != AF_VSOCK)
> 		return -EAFNOSUPPORT;
>
>-	if (addr->svm_zero[0] != 0)
>+	if (addr->svm_flags & ~svm_valid_flags)
> 		return -EINVAL;
>
> 	return 0;
>-- 
>2.20.1 (Apple Git-117)
>
>
>
>
>Amazon Development Center (Romania) S.R.L. registered office: 27A Sf. Lazar Street, UBC5, floor 2, Iasi, Iasi County, 700045, Romania. Registered in Romania. Registration number J22/2621/2005.
>

