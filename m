Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3772C23B0E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 01:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgHCX3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 19:29:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42781 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727091AbgHCX3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596497383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRm3NJEvomEDfGeZbbN2TL8ZG4riiX42sSsKVhTtCDg=;
        b=Fr+M+UIixqInbx9UFT+Jl0PMuqZuYm2VlEQ66k7p0FOWCLV8sGPRdHRVWb7m99HhKZSdUs
        Fxkvnrj/mDbXml3/izLH6VaDQrNAJ0+SGGECsLWjRPEp9e/WO1vs5V16d3oR23aCIplaYJ
        ConoecJqaG5k+XlgDSPG0af/nGVapOg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-4IIAOs0wNEqmeePJInIJUg-1; Mon, 03 Aug 2020 19:29:42 -0400
X-MC-Unique: 4IIAOs0wNEqmeePJInIJUg-1
Received: by mail-ed1-f70.google.com with SMTP id j14so2736240edk.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRm3NJEvomEDfGeZbbN2TL8ZG4riiX42sSsKVhTtCDg=;
        b=OXYm3QvSE9cm5r8OkwO434ahfrCKzzSE+HhUN2+/DCbdZ+MJIdQp0kO5tWBs337Oxr
         Yq73O9PdKuAh2BSlKGBbeEfk5X0czxviLUm8l19DSfGP/Mqq5SeRqDs5K02ds6FU7q6Z
         k51TfldjHk1TkLYdrXrA5bQfbf8+rOBxeOKGHxjQnU+0tx3NNca3sbB9IiRdW6vzyEV3
         Y7w9EU9rujtaxYx9ZZcd+9KvIZWJhWns+Cy61ixJq0ON37l/8JYSMDP/bx9+mYxseGdN
         d5fb6RDH0dcNGse7MLsnWcO+Awl7HFtb+bGbvYuR4tp13FJX9vFb2CfwITgfiC/MxXUg
         mxqw==
X-Gm-Message-State: AOAM530M38a+wkOHKy6zAj+VxTd3flB3V5HK8yDQiew9EaZW/7djXK1v
        p+2d4Dr7WU63YhF218CffgjxeXfXROJs2+2//t28gLoqkJOjK6VvSEW1uKp2EOH6DADhpLK3+03
        qyLRsflb4GF6YEmtN+4IM/UgkKnKboU6kZX4ClBPN
X-Received: by 2002:a17:906:1104:: with SMTP id h4mr18840732eja.456.1596497381273;
        Mon, 03 Aug 2020 16:29:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp34p+Z8Mc6zwI3NcJv7oAfXkQvVK17vRb9paXv+mYpGH4EsJxZEwwVOS602UUu476FtjmqlNZsTpKWJyyYFw=
X-Received: by 2002:a17:906:1104:: with SMTP id h4mr18840718eja.456.1596497381059;
 Mon, 03 Aug 2020 16:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200730192110.1466e63e@canb.auug.org.au> <20200730120303.GQ19097@mellanox.com>
 <cf7af4c9-592a-2143-831a-cb0f44bc768e@nvidia.com> <20200803231923.GR19097@mellanox.com>
In-Reply-To: <20200803231923.GR19097@mellanox.com>
From:   Ben Skeggs <bskeggs@redhat.com>
Date:   Tue, 4 Aug 2020 09:29:30 +1000
Message-ID: <CABDvA=mvks3Nrs=8wo1jomPxGjWFxwz4EWrppmmHTzsOuQO6Kg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the hmm tree with the drm tree
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 9:19 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Jul 30, 2020 at 10:31:45AM -0700, Ralph Campbell wrote:
> >
> > On 7/30/20 5:03 AM, Jason Gunthorpe wrote:
> > > On Thu, Jul 30, 2020 at 07:21:10PM +1000, Stephen Rothwell wrote:
> > > > Hi all,
> > > >
> > > > Today's linux-next merge of the hmm tree got a conflict in:
> > > >
> > > >    drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
> > > >
> > > > between commit:
> > > >
> > > >    7763d24f3ba0 ("drm/nouveau/vmm/gp100-: fix mapping 2MB sysmem pages")
> > > >
> > > > from the drm tree and commits:
> > > >
> > > >    4725c6b82a48 ("nouveau: fix mapping 2MB sysmem pages")
> > > >    1a77decd0cae ("nouveau: fix storing invalid ptes")
> > > >
> > > > from the hmm tree.
> > > >
> > > > 7763d24f3ba0 and 4725c6b82a48 are exactly the same patch.
> > >
> > > Oh? Ralph? What happened here?
> >
> > Ben did email me saying he was planning to take this patch into
> > his nouveau tree and I did reply to him saying you had also taken it
> > into your tree and that I had more nouveau/SVM patches for you on the way.
> > So, I'm not sure what happened.
>
> Well no answer from Ben and it looks like it is in the main DRM tree,
> so I will drop the 4725c6b82a48 patch from hmm.
My apologies, both for this slipping past me, and for the trouble.  I
did mean to drop that patch from my tree before sending it on to Dave.

Ben.

>
> Jason
>

