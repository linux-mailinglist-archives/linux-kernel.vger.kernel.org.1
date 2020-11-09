Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061542AC142
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgKIQsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:48:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730558AbgKIQsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604940492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fqIq5NUwLO5XS6VOJO9c8F79ciX9FemcAwNmtAIcwRI=;
        b=CkMV2P1js/W4GNDaJvi2ISSBI+CCIDL2N56ZES5Hqa4IwVqL0XkAGaf8oaM3Y/V2zZIaJG
        OL7khUlH/t69828qvo6Hgw4uasvCy7Si6U3iFAMt36Htwpb2v0EvI9uhR2eWIL3WjXFcIp
        QsP6ldG4J/3s5kxCAEUhZixVhb9qmxg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-4uAA5Hu9NBW9Tko3dR-OYQ-1; Mon, 09 Nov 2020 11:48:10 -0500
X-MC-Unique: 4uAA5Hu9NBW9Tko3dR-OYQ-1
Received: by mail-oo1-f69.google.com with SMTP id m13so1804704ooq.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:48:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqIq5NUwLO5XS6VOJO9c8F79ciX9FemcAwNmtAIcwRI=;
        b=b9Q+3Fbg5neBAdKfNzJR26JN0wWSTBfNehU16j+jncYVS8FEQxqCkX/psDGNoik045
         0qBcvpnVLG1oO665dPstabrg6Q83fZooQCrSfxxUFEY6kT/yfuzFUTHfzyyAhdUFM9bM
         S+/PjbUy2EsXjCcofyMJrfDf+BmR2wTTTt3W8atlf5oFvROzK50a7VTbJcqc0lhAl7Ox
         Igd6hEwo7XchD8a3+5Wthk2kn17xPoBMM74x8fk9fK1JO2Novo94Tf6k2iucST5J+q3c
         1y/ZXFwHH7FUwXcdvGbzloDo3Aq25QLfsC0C2+XOwgzhGdVb8kEeP7Cq7R4DAwyez/AG
         +hgA==
X-Gm-Message-State: AOAM532UPAt6VpYSFNck8KnmUlIuEplQY4ZygDo5TY/+KUp9WsStnCpj
        uSAnewwU860EoKe0g4wgzzZtk+Cf5c6rI8QylNidd/tD34jhKv/IZDSywlDrYkBVgjG8JnFK9Im
        1Z654KqIkblQrweeeklDxGxNW8CGJNSZNGAr9EP33
X-Received: by 2002:aca:4f53:: with SMTP id d80mr29988oib.120.1604940488746;
        Mon, 09 Nov 2020 08:48:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHFiGAk0galmy0bk5raHPkH/pu4uljJlFq+eNb+KPxOugkwKoJBdOHvGL6Z37sQJd6iaPMBOkPmw04bQVv+dE=
X-Received: by 2002:aca:4f53:: with SMTP id d80mr29973oib.120.1604940488554;
 Mon, 09 Nov 2020 08:48:08 -0800 (PST)
MIME-Version: 1.0
References: <20201106200436.943795-1-jarod@redhat.com> <20201106184432.07a6ab18@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201106184432.07a6ab18@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Mon, 9 Nov 2020 11:47:58 -0500
Message-ID: <CAKfmpSfkmo1GVVThadDDtXma1m1yrNwPoPz87sMy5664uJbevg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/5] bonding: rename bond components
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 9:44 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri,  6 Nov 2020 15:04:31 -0500 Jarod Wilson wrote:
> > The bonding driver's use of master and slave, while largely understood
> > in technical circles, poses a barrier for inclusion to some potential
> > members of the development and user community, due to the historical
> > context of masters and slaves, particularly in the United States. This
> > is a first full pass at replacing those phrases with more socially
> > inclusive ones, opting for bond to replace master and port to
> > replace slave, which is congruent with the bridge and team drivers.
>
> If we decide to go ahead with this, we should probably also use it as
> an opportunity to clean up the more egregious checkpatch warnings, WDYT?
>
> Plan minimum - don't add new ones ;)

Hm. I hadn't actually looked at checkpatch output until now. It's...
noisy here. But I'm pretty sure the vast majority of that is from
existing issues, simply reported now due to all the renaming. I can
certainly take a crack at cleanups, but I'd be worried about missing
another merge window trying to sort all of these, when they're not
directly related.

-- 
Jarod Wilson
jarod@redhat.com

