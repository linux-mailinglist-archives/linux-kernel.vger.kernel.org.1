Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D29F2F42F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbhAMEPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726413AbhAMEPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610511233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfDrAPvjsoYVMqNEVx94XHjGqbWNvX3wApkmUTM+rnQ=;
        b=Ui9U/WeoHyKUNL4RMn6j9AzeRCVwVIw6LovmI0z1tSXsZT12oSwV03P4QZyGFNurMQGRVS
        +VzUXJ0UVzOFfVrvFmAuxjRELyDdjfqpOXJuXlIl5CpH1DtY/LeF4hT+B8jfdm+lVUV0Fq
        WqVkgJ4Jm7CQeW1gZCOYAoQFzjFn78w=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-nQmkmhR-NG-XpdH6dtXdTw-1; Tue, 12 Jan 2021 23:13:51 -0500
X-MC-Unique: nQmkmhR-NG-XpdH6dtXdTw-1
Received: by mail-pf1-f199.google.com with SMTP id r15so547145pfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 20:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfDrAPvjsoYVMqNEVx94XHjGqbWNvX3wApkmUTM+rnQ=;
        b=qleRf09VXxDj8FVTurQlncvONoPic1VFpE5NfxIsW4f+xDVSkfXxFUmdftGodMxbCt
         y09JLZGCDeNoj2eAmFh1t4m6mipFLE0fhupIJBW0G2RfW9TG5f3GhT8HMcp21CfQiO78
         NazsSukLV8+ttbT2TwKR41VYTXj955lI8Ads+fH78edAaBKopKNKbEplvBRBJzlPbctv
         UGZM+5yInTXwlrNK4tjMiojpLr9gcviueLY0Vd0YsOtykcTRv4IXssYBubk7haXTH2cZ
         x/0XJFo0xSfdOCLwaC6Qv6GzGGm1UVAXkZFaR9BdhBysHusihYNlBDrgWO1DtmfWKONu
         lHsg==
X-Gm-Message-State: AOAM532X1m/a7Rt89irO31AAR1lew+/vSqIWTassqSr+dXKBpoMMEMyP
        aamwdyI424Yjb+dnJ+D7E+a7VLreyR27Cv73wveDPcK2t03800OWqRsn6THQFSsMrTZ/GHShvvQ
        eLOej5cxrArFaXK1eHNsdAATdn2rliL06tTmROH1D
X-Received: by 2002:aa7:97bc:0:b029:19e:18c7:76b with SMTP id d28-20020aa797bc0000b029019e18c7076bmr270873pfq.23.1610511230809;
        Tue, 12 Jan 2021 20:13:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwL2OenbuBUblwlUNcw3x1ULR/Z+jRldpO3boKIQ/Xb8tMIvpRP21VUS+e1MBM0V79w64PV65ol/7dXaBACQ0E=
X-Received: by 2002:aa7:97bc:0:b029:19e:18c7:76b with SMTP id
 d28-20020aa797bc0000b029019e18c7076bmr270848pfq.23.1610511230515; Tue, 12 Jan
 2021 20:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20210112053629.9853-1-lulu@redhat.com> <X/1Up+fcTcYq2osi@kroah.com>
In-Reply-To: <X/1Up+fcTcYq2osi@kroah.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Wed, 13 Jan 2021 12:13:14 +0800
Message-ID: <CACLfguUbB08xCZ5hk3+8jHGZtBy_YC4twuxpEf-MvKAJHq46Xg@mail.gmail.com>
Subject: Re: [PATCH v3] vhost_vdpa: fix the problem in vhost_vdpa_set_config_call
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        "Zhu, Lingshan" <lingshan.zhu@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 3:53 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 12, 2021 at 01:36:29PM +0800, Cindy Lu wrote:
> > In vhost_vdpa_set_config_call, the cb.private should be vhost_vdpa.
> > this cb.private will finally use in vhost_vdpa_config_cb as
> > vhost_vdpa. Fix this issue.
> >
> > Fixes: 776f395004d82 ("vhost_vdpa: Support config interrupt in vdpa")
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vdpa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>
>
Thanks Greg, I will fix this and send a new version

