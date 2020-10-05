Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7402835FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgJENAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJENAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601902799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x7QPPNUTCaSWIZPB/ju4HImGo/gOqjVPUMvGsrjSBRM=;
        b=cfNcbX1chkxu2m+ZXGja7C/hqZYqJ6Of98tjJvRc7+EGuzxA0R3J03Albjkv0L2DB8fGCu
        AM7Xpzcq/ZYwhKJWjd2+13cKXjGdp6oqRUZ+OKg0j0LxSDaOdcqi+fy6SUaEvkAStXpQVo
        PpBY08b1WOfI2x+etRjTgTIOtOIKJgM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-ld2Mgjp4MsG1mSYjxeU3AA-1; Mon, 05 Oct 2020 08:59:58 -0400
X-MC-Unique: ld2Mgjp4MsG1mSYjxeU3AA-1
Received: by mail-wm1-f71.google.com with SMTP id 73so1683775wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 05:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7QPPNUTCaSWIZPB/ju4HImGo/gOqjVPUMvGsrjSBRM=;
        b=M5iHMkQX8d/VEeQSg3eiaYiLOOkVSHwRFGL7ED9qp99QQ3/oVnm2f5ThYVHoGP3EVq
         VBCk2muL6+DfIlf7kMtS6ZyCXvAMCE0ZJioy0/e0E4/eNuhEzWjmZb8k51Vo+2QHQPC3
         aWSr1Ezn84T/Gqq++BgiR55M8Je3vokBgYJnuymTpk8e1l91CeMhNm9hetTWIy94bdoP
         Ky4VWbPkPeiH/y46oP4jZJvtwCWCj95ixtMW59Lb4I2eA0xnrjuKX23OJRRB0Pf3+UWQ
         XaRiYMvuLNwRA88D6y4ONfaWidFFccKM6BFz6AVsj2FPosQHa9csuIQlCNjBXznXyYsq
         GrGQ==
X-Gm-Message-State: AOAM532M/6jniu6pIWyK5X+7gRJMPQmZU3dKp4w4kQBl6TEgyQZGIND0
        coPv/JtkXa886rENGLwfJR0kIjc7OgGPEtUi4yfoJXSS5fhxba3W59FrDb/EA8iXZavqaMX/BGq
        Bo5JOIBrM4Une0vfd91N/WE2GYk47SwnS9xzGr/VX
X-Received: by 2002:a1c:b40b:: with SMTP id d11mr11275484wmf.152.1601902795887;
        Mon, 05 Oct 2020 05:59:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4hxQWHIG5sEkr7qJpu1eFp9BDYMA93jUhI2KXY8YUaEdNsvYM/MXWprVTBQPZx+qivjKOkAq6RZb3jjKD8QE=
X-Received: by 2002:a1c:b40b:: with SMTP id d11mr11275462wmf.152.1601902795672;
 Mon, 05 Oct 2020 05:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201003063143.13093-1-foxhlchen@gmail.com>
In-Reply-To: <20201003063143.13093-1-foxhlchen@gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 5 Oct 2020 14:59:44 +0200
Message-ID: <CAHc6FU4--0duukwCutZGct_0hgrkCr3Rcje6QRWVwM7rdDTsjQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: gfs2_read_sb: put gfs2_assert inside the loop
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fox Chen,

On Sat, Oct 3, 2020 at 8:33 AM Fox Chen <foxhlchen@gmail.com> wrote:
> Before this patch, gfs2_assert is put outside of the loop of
> sdp->sd_heightsize[x] calculation. When something goes wrong,
> x exceeds the size of GFS2_MAX_META_HEIGHT, it may already crash inside
> the loop when
>
> sdp->sd_heightsize[x] = space
>
> tries to reach the out-of-bound
> location, gfs2_assert won't help here.

that's true, but the smallest possible block size is 1024 bytes, and
with that, the height cannot grow bigger than 10. So the assert is
basically there only for documentation purposes.

Thanks,
Andreas

