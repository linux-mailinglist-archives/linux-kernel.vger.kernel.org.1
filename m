Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2CE2C448E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgKYP5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:57:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730254AbgKYP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606319837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6UsChBqvJlhq7/VCtB24VhPBOq4VAuCpHpvRtmkDfHo=;
        b=TeMmV/4JInvg6xGTZI71Pov+sRJMMreW4g/G3+Mn7tn39eKJ6EazeqoplBNygf/lFYhMEb
        Y1yV9Nm2s8CoH8Ldi7fLK2SZkQoxjBMlGGN0Xyn79nchZIz45jh3rJA5LnP1/0heQEycKj
        Vj7mbbQYFL92Y2DKvPUS0JDUti1EnNw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-OtmzrRf_P7quDOm848VKug-1; Wed, 25 Nov 2020 10:57:14 -0500
X-MC-Unique: OtmzrRf_P7quDOm848VKug-1
Received: by mail-qk1-f198.google.com with SMTP id w189so2876656qkd.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6UsChBqvJlhq7/VCtB24VhPBOq4VAuCpHpvRtmkDfHo=;
        b=LMpew5E8ihj48B7eUaSKhiBafaK+kJ9Jf5IKuKNBoR1hlhBxWHbhEmzPQULU7t3iSN
         yvXy+cv00hZdkzNVfmZO+bbv8e3dGcWYz+ZCTizOwI/fpwgQCnf8P44SrjWHBYhEz/RY
         wfNIYef6prIfknDrIvEBL0CnTp9u6i74rYYAqgNbPRaGjfKc0kHKfQYQNX+CkgFWJO1f
         gf6PTM+s/pGBmd8YHuVHfmO3MYl7Juwp50yuRjwy2sHkHmF5k+LEOw5Ixsx3Tq32RB+r
         3S4TpXoNVPNoHspGvvXqiy73GWUb+VgfOv5ltqVsIN89TADjgB/7cXiKnOmKIAGF0cis
         Qzkw==
X-Gm-Message-State: AOAM5314Eme3Wp5ouxpXxKMSozHr1EUJAOC2v2Gl+NllGycUlgCqSkew
        mXAjMQ+OQxqrVFZzSWzCD6JR8u5BDVF6VsAiw6hNyxyTU70eg0JdbSv5Q2lnHyqZfc2oeOcTmTH
        g42Zq3nXoj9sflyDH3J2ovOT4
X-Received: by 2002:ac8:3a22:: with SMTP id w31mr3607605qte.361.1606319834457;
        Wed, 25 Nov 2020 07:57:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqXP9dfk5vg012xJp3zY6wCkaEZcvXplSVZ/8UjBZyLOw518QOEPgewUcisXjRkEI7Hyt7UA==
X-Received: by 2002:ac8:3a22:: with SMTP id w31mr3607591qte.361.1606319834220;
        Wed, 25 Nov 2020 07:57:14 -0800 (PST)
Received: from xz-x1 ([142.126.81.247])
        by smtp.gmail.com with ESMTPSA id d19sm2387953qtd.32.2020.11.25.07.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 07:57:13 -0800 (PST)
Date:   Wed, 25 Nov 2020 10:57:11 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Justin He <Justin.He@arm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] vfio iommu type1: Bypass the vma permission check in
 vfio_pin_pages_remote()
Message-ID: <20201125155711.GA6489@xz-x1>
References: <20201119142737.17574-1-justin.he@arm.com>
 <20201124181228.GA276043@xz-x1>
 <AM6PR08MB32245E7F990955395B44CE6BF7FA0@AM6PR08MB3224.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR08MB32245E7F990955395B44CE6BF7FA0@AM6PR08MB3224.eurprd08.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 01:05:25AM +0000, Justin He wrote:
> > I'd appreciate if you could explain why vfio needs to dma map some
> > PROT_NONE
> 
> Virtiofs will map a PROT_NONE cache window region firstly, then remap the sub
> region of that cache window with read or write permission. I guess this might
> be an security concern. Just CC virtiofs expert Stefan to answer it more accurately.

Yep.  Since my previous sentence was cut off, I'll rephrase: I was thinking
whether qemu can do vfio maps only until it remaps the PROT_NONE regions into
PROT_READ|PROT_WRITE ones, rather than trying to map dma pages upon PROT_NONE.

Thanks,

-- 
Peter Xu

