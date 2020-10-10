Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A93289D27
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 03:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgJJBlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 21:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbgJJBJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 21:09:33 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4870C0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 17:43:47 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id x11so2333333uav.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 17:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+T6J3hzgOr+sfqzPyYNT2JLTYVihzKsAyiTnBxS+wo=;
        b=R2GUDGgapHD/0U0DkOG4nn6rwNC0rWOcgW0DWpSp+kfYtfXrEO+lBSUC2XO24MLBcQ
         h6QunDzPLf9N0FDr2Z1Evvxf+YRmMXR1jqsFp0wXkwb28jQ0bbegI6RGycYwLF04tHN2
         B3L9GNPVAtJoMSui7Y5sX+GKrz8QjFLOCyMvgjPrDZmrvvm1oZcMLM1f0hBKiSz6CBPb
         cUIe5gEVkBuBs3f8Gn9ZUMMcFFFLAaGyA5hDhvEGw9nQuBzyNADxEyAi+AEo3HAkk48T
         JlG27xcih5pDUo+Mh6xTLhO+4yeyN/zxUhKuZ3zJ9NePRdZyjysvhuFX+38vAd/F5zud
         sR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+T6J3hzgOr+sfqzPyYNT2JLTYVihzKsAyiTnBxS+wo=;
        b=jhrL//ILMLVkCb4DS/eMAmg1ZkaKRigPjY1kW6WWD08ZWluBv7EjfT2mWZrK3SQMdw
         vnEG7VR+3LYo5VTnCp+ULO17KRBXgsZeelo/xSkzSenFpoRPKSUTol59vbvnN0mK9G6Q
         T2YJPcycQtVMWFAfDNErRJwd43V0aXgpq3EfiHMyUF3Nv/lq3p0w2sGm5ETHvIW73tkm
         iftxBuEzT2BF2k01W+HJlHBbY2jdrP0z2GDcCbQocfFMuEjcl+WePtv8AqmowfOXHGfH
         0zta381A2G4Jo/s6aIK4mkoLxAWYqxOnw0JU/kmcBMTRwkGUMg4XztUrJLVFI16ujDdR
         OdEw==
X-Gm-Message-State: AOAM5327Z6SqFPqnq2YyWhtm2C2bJztJGBzhrntkxOu6A44htGjs9Uno
        RsIMeCbDT/yydr2RiP01PweSO5+6xfQlNHPeqSy0/w==
X-Google-Smtp-Source: ABdhPJz2EWv35VtaXdfAgtI6hsZ4m4ljsGsezwO7sf3Ku0Y1O+bdmkQebYdRgdDsc7bTa7joJ+rKyisXmitexkLjmoc=
X-Received: by 2002:ab0:2a43:: with SMTP id p3mr9502803uar.122.1602290626762;
 Fri, 09 Oct 2020 17:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201009103121.1004-1-ceggers@arri.de> <CABeXuvpg4EkuWyOUEU-4F5Hd_iF7pjGX=K8KmMVZGWTt0P_EkQ@mail.gmail.com>
In-Reply-To: <CABeXuvpg4EkuWyOUEU-4F5Hd_iF7pjGX=K8KmMVZGWTt0P_EkQ@mail.gmail.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Fri, 9 Oct 2020 20:43:09 -0400
Message-ID: <CA+FuTScqLoAQTVwEJ+OcyTpQ-bbns6G5xq+p-Swc4hR7Hf5RLQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] socket: fix option SO_TIMESTAMPING_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Christian Eggers <ceggers@arri.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 8:30 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Fri, Oct 9, 2020 at 3:32 AM Christian Eggers <ceggers@arri.de> wrote:
> >
> > The comparison of optname with SO_TIMESTAMPING_NEW is wrong way around,
> > so SOCK_TSTAMP_NEW will first be set and than reset again. Additionally
> > move it out of the test for SOF_TIMESTAMPING_RX_SOFTWARE as this seems
> > unrelated.
>
> The SOCK_TSTAMP_NEW is reset only in the case when
> SOF_TIMESTAMPING_RX_SOFTWARE is not set.
> Note that we only call sock_enable_timestamp() at that time.
>
> Why would SOCK_TSTAMP_NEW be relevant otherwise?

Other timestamps can be configured, such as hardware timestamps.

As the follow-on patch shows, there is also the issue of overlap
between SO_TIMESTAMP(NS) and SO_TIMESTAMPING.

Don't select OLD on timestamp disable, which may only disable
some of the ongoing timestamping.

Setting based on the syscall is simpler, too. __sock_set_timestamps
already uses for SO_TIMESTAMP(NS) the valbool approach I
suggest for SO_TIMESTAMPING.

The fallthrough can also be removed. My rough patch missed that.
