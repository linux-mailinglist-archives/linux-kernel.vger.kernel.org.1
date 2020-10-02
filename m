Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A448281CB3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgJBUNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgJBUNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601669583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JEA567/T1YVaTHkPnZGy8nWmG2WU769exGNrto6IMdE=;
        b=fjIBp7Got3zcBQATMdbvE1e39EkEOL4c1AE4olubUlPSqZOHRZtL5NDpy+rqf3aRHDa9Bw
        taM40KB3W3lCLqzYzU2AFvon2iDJaP3cCNTlJ0VEjEC3RZBhUW49KIW1W/YM+E/GGqfey/
        km2mnmuGvgL6JWrDLPhuWjRsQmq+54U=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-OnnhNY3TPC2eF__nQQy4uQ-1; Fri, 02 Oct 2020 16:13:01 -0400
X-MC-Unique: OnnhNY3TPC2eF__nQQy4uQ-1
Received: by mail-oo1-f71.google.com with SMTP id a11so427139oot.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 13:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEA567/T1YVaTHkPnZGy8nWmG2WU769exGNrto6IMdE=;
        b=G8bvjhoUGnuhLFS/avAWhA6GVsH/B956ol2KpSGfy7nVRoRkMF2O1ouaUW1ff001dh
         srZmvEkr3SbKAoP/C6dRU2v7w03VkexbS8RjyiWY+eKcbsYUuGYLv7e1ycdS4qXjovri
         MJw6pWeRCBqx9Mj87njq3a870Jgv4NHMpKJBLLhU/2DRcyhoeU4rRfpNPQSCrdaCqqbG
         i5II6VMXBSNAKRBXVP0U6nN89Z9vDcCDDBbRaahZBq4PaoTDr6U1Yde9nQBrZHITBKSF
         HBXQJVvvFIiY+X6iGjFTSTIvM70VFQwUg9NYzugHMl7YyP8+K2AMSK6t8d0ZbBW7b3B+
         6qaA==
X-Gm-Message-State: AOAM531sl7lzYdcgp7M1kZodl9JWyT4ljybaqgaLSVFnWqIajdy3ABPS
        tiyJqf8IGXt8prm4HFdbHJILk7+wx6sSNftaknMYs+xwZt9Swh0k9jZrvlp+i3CftfEtAPI+5TJ
        SK4EgnJreM6/JDTApJDacOwZ9luY4a8jfRjUqtuVK
X-Received: by 2002:a9d:6c4f:: with SMTP id g15mr2968716otq.277.1601669580658;
        Fri, 02 Oct 2020 13:13:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjj9nlQwmwXjZdO4Ufa9bzBeHpRccUJkfdIO6OXpxZOtLIcbkvyRpVwmUw6l80CbxhDYAWys7PpBFv2FQ9LQo=
X-Received: by 2002:a9d:6c4f:: with SMTP id g15mr2968701otq.277.1601669580438;
 Fri, 02 Oct 2020 13:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201002174001.3012643-1-jarod@redhat.com> <20201002174001.3012643-6-jarod@redhat.com>
 <20201002121051.5ca41c1a@hermes.local>
In-Reply-To: <20201002121051.5ca41c1a@hermes.local>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Fri, 2 Oct 2020 16:12:49 -0400
Message-ID: <CAKfmpSecU63B1eJ5KEyPcCAkXxeqZQdghvUMdn_yGn3+iQWwcQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] bonding: update Documentation for
 port/bond terminology
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 3:11 PM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Fri,  2 Oct 2020 13:40:00 -0400
> Jarod Wilson <jarod@redhat.com> wrote:
>
> > @@ -265,7 +265,7 @@ ad_user_port_key
> >       This parameter has effect only in 802.3ad mode and is available through
> >       SysFs interface.
> >
> > -all_slaves_active
> > +all_ports_active
>
> You can change internal variable names, comments, and documentation all you want, thats great.
>
> But you can't change user API, that includes:
>    * definitions in uapi header
>    * module parameters
>    * sysfs file names or outputs

All of those are retained by default here in this set. There are 0
changes to the if_bonding.h uapi header, module parameters with 'port'
in them have duplicates with the old terminology included, and all
sysfs file names are duplicated (or aliased) as well. The
documentation was updated to point to the new names, but the old ones
still exist across the board, there should be no userspace breakage
here. (My lnst bonding tests actually fall flat currently if the old
names are gone).

-- 
Jarod Wilson
jarod@redhat.com

