Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E685B281CCB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgJBURu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgJBURt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601669867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEUOwZ0tWV1logok69UsC+MxMC9OHL/Bwty2qonClRw=;
        b=NkCWONlzobPHP6gYsx4eom4HRv+Z3F8uV8WtGh6lopLgvYDI2xZY80CTwW5b8McDU+Wu1R
        DaRO1e4m3z2RCR9E0S8fHqhXXG4TF86VMBT4gzmcj8YkMfd1ZTnDEhqUugFaotgkqEfR4x
        xNx23/qf4ndwflHpNuxs4sAonTBHFME=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-bqaIpjM0MXmkUFb9KKKDuQ-1; Fri, 02 Oct 2020 16:17:45 -0400
X-MC-Unique: bqaIpjM0MXmkUFb9KKKDuQ-1
Received: by mail-oo1-f71.google.com with SMTP id k18so1246660oou.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 13:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEUOwZ0tWV1logok69UsC+MxMC9OHL/Bwty2qonClRw=;
        b=q7qsMxS7i8SVb0UZUSqRwh/v0boZfUoAmmdxbkOsF9k88wBiaUcMpCNKY+3aJfbvsG
         FhbVJP+x6YQzfydAS1pI991Yr2XelEncAOYxqJs6K22rQUUc3+pUVjDPEi6jzOk0i81f
         ZIZaJRjosnBwipRkG61nb0XP8r8LBb7sKiuI+76CMVdRojc2yinG/IQQ2BSKbkVP1aRU
         wrYG1pwouBn6/vgEmhYH2+9JBDcOwCJwoeZPN4DwQy4gQKiIzFTJ/buIup42wwfVvgFg
         2gr2G4iqLHbOl129JDlnzrzqrNb9eanYSWjIpGRSaiRzvREYv2yc4HyrKkN1DTQqovGb
         byGQ==
X-Gm-Message-State: AOAM5312hRkCcSAJL5u/ZSaJxCMR7eT45SbgRI6uHkUTQgsh1aNOOvxU
        yGMjNezWcVIIq1mcxgdXaqit46m8IWlryEvnxbSucJ/YfZXz17eQlmDnjiVprKylmJU0QvXAkkw
        PxBpSnLP0KFTvQUsmKII2eS9vM9aVeACV4iKTOHrS
X-Received: by 2002:aca:4e06:: with SMTP id c6mr489540oib.120.1601669865242;
        Fri, 02 Oct 2020 13:17:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvdS35Ea37ROGo1fYbebLRZH1ABdflntD5YaM5bNZwtZgSOpxbSaOedhxZbd0qqjj2olyqKx8Kqwb0YkeFG3s=
X-Received: by 2002:aca:4e06:: with SMTP id c6mr489527oib.120.1601669865016;
 Fri, 02 Oct 2020 13:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201002174001.3012643-1-jarod@redhat.com> <20201002174001.3012643-6-jarod@redhat.com>
 <20201002180906.GG3996795@lunn.ch>
In-Reply-To: <20201002180906.GG3996795@lunn.ch>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Fri, 2 Oct 2020 16:17:34 -0400
Message-ID: <CAKfmpSd00=ryeznA3ubfMCmeiFAeo-jQhvT3fAgwJqbDEL7w_w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] bonding: update Documentation for
 port/bond terminology
To:     Andrew Lunn <andrew@lunn.ch>
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

On Fri, Oct 2, 2020 at 2:09 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Oct 02, 2020 at 01:40:00PM -0400, Jarod Wilson wrote:
> > Point users to the new interface names instead of the old ones, where
> > appropriate. Userspace bits referenced still include use of master/slave,
> > but those can't be altered until userspace changes too, ideally after
> > these changes propagate to the community at large.
> >
> > Cc: Jay Vosburgh <j.vosburgh@gmail.com>
> > Cc: Veaceslav Falico <vfalico@gmail.com>
> > Cc: Andy Gospodarek <andy@greyhouse.net>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Thomas Davis <tadavis@lbl.gov>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Jarod Wilson <jarod@redhat.com>
> > ---
> >  Documentation/networking/bonding.rst | 440 +++++++++++++--------------
> >  1 file changed, 220 insertions(+), 220 deletions(-)
> >
> > diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> > index adc314639085..f4c4f0fae83b 100644
> > --- a/Documentation/networking/bonding.rst
> > +++ b/Documentation/networking/bonding.rst
> > @@ -167,22 +167,22 @@ or, for backwards compatibility, the option value.  E.g.,
> >
> >  The parameters are as follows:
> >
> > -active_slave
> > +active_port
>
> Hi Jarod
>
> It is going to take quite a while before all distributions user space
> gets updated. So todays API is going to live on for a few
> years. People are going to be search the documentation using the terms
> their user space uses, which are going to be todays terms, not the new
> ones you are introducing here. For that to work, i think you are going
> to have to introduce a table listing todays names and the new names
> you are adding, so search engines have some chance of finding this
> document, and readers have some clue as to how to translate from what
> their user space is using to the terms used in the document.

Hm. Would a simple blurb describing the when the changes were made and
why at the top of bonding.rst be sufficient? And then would the rest
of the doc remain as-is (old master/slave language), or with
terminology conversions?

-- 
Jarod Wilson
jarod@redhat.com

