Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95002CC695
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389773AbgLBTYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730977AbgLBTYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606936995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lr+GzTGv/tYwwixUOA9RKf5AXaWL7MAsFRfhEe+PT2M=;
        b=W8cV//8o9LAtf4GcpEIPbVTaOr7OXSc/aeov1TbgDwCsihvVMlQr86HTofqti4kvBUACsy
        IJe/laEn171ICqD1JCzjHLO8cABFbPH0AgTwl8Tuo3IT+JjYvUQRfYtVObhHgBZUdiYo3N
        FSqHBZgxebk3ML9lvgYFOeTgm4pcThc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-OCehH7DjMZGhIc0Vf_EX5g-1; Wed, 02 Dec 2020 14:23:12 -0500
X-MC-Unique: OCehH7DjMZGhIc0Vf_EX5g-1
Received: by mail-oo1-f70.google.com with SMTP id r10so1303548ooc.20
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lr+GzTGv/tYwwixUOA9RKf5AXaWL7MAsFRfhEe+PT2M=;
        b=U3YxXEliqY1goBpUHrmd8d6WAYN5zum9+Tji38wltQ96DjpNv0sqEYUUHcYA+1elMK
         eJv/P4ZbUQ4EDAs0xHEiKyJIjy98St/W7uglSemnN0rJN5pzoQ+zemgdKPCY4hTCDb5e
         LylW6XoY+cKJERWHjJRWoDdfewG1+qN/nECYp0Ns8HY2TxNe/OHhdBi7DEB1hn5gtcjv
         nfbVxhNKX7aZ3jZbm2eaO9/JF12OTDRQyL5TjpLMRjo4Yf2OlPc5Zbng4CTbkB8CrkDm
         aLqi4orFxifkedTWjXKTzoUiS4N+upqWJIgh0x3LWxopZPQP/Us+4OxJalXlNF6dCcEm
         hSOQ==
X-Gm-Message-State: AOAM533EyXaVrzunoQ2tjoQp1711nVZJmE6AhwU6prPUxc0ot3Q0N6TJ
        tf/AwPZbFOYTrXMuGpXg1Y0DSWeQAVvgZU0q2m/UKZ1hNjqAYYrFx6yMZUAAt+T+LolzfbqlCdU
        mKEiHPsMCi8h/nqSRZedm6pDrpuzqZUhkfRMMRUUA
X-Received: by 2002:a05:6830:1308:: with SMTP id p8mr2903150otq.330.1606936991547;
        Wed, 02 Dec 2020 11:23:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxX2YnxD6Ozd+sX5JV1YOnJISXeMr1Gv1Ja+oYM3RceGc4WJzg+JFojVnQMVUZ7dlP40OhfK+p+2PnTD3KJUOk=
X-Received: by 2002:a05:6830:1308:: with SMTP id p8mr2903138otq.330.1606936991353;
 Wed, 02 Dec 2020 11:23:11 -0800 (PST)
MIME-Version: 1.0
References: <20201123031716.6179-1-jarod@redhat.com> <20201202173053.13800-1-jarod@redhat.com>
 <14711.1606931728@famine>
In-Reply-To: <14711.1606931728@famine>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Wed, 2 Dec 2020 14:23:00 -0500
Message-ID: <CAKfmpSez1UYLG5nGYbMsRALGpEyXnwJcoFJV_7vALgpG3Xotcw@mail.gmail.com>
Subject: Re: [PATCH net v2] bonding: fix feature flag setting at init time
To:     Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ivan Vecera <ivecera@redhat.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 12:55 PM Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>
> Jarod Wilson <jarod@redhat.com> wrote:
>
> >Don't try to adjust XFRM support flags if the bond device isn't yet
> >registered. Bad things can currently happen when netdev_change_features()
> >is called without having wanted_features fully filled in yet. Basically,
> >this code was racing against register_netdevice() filling in
> >wanted_features, and when it got there first, the empty wanted_features
> >led to features also getting emptied out, which was definitely not the
> >intended behavior, so prevent that from happening.
>
>         Is this an actual race?  Reading Ivan's prior message, it sounds
> like it's an ordering problem (in that bond_newlink calls
> register_netdevice after bond_changelink).

Sorry, yeah, this is not actually a race condition, just an ordering
issue, bond_check_params() gets called at init time, which leads to
bond_option_mode_set() being called, and does so prior to
bond_create() running, which is where we actually call
register_netdevice().

>         The change to bond_option_mode_set tests against reg_state, so
> presumably it wants to skip the first(?) time through, before the
> register_netdevice call; is that right?

Correct. Later on, when the bonding driver is already loaded, and
parameter changes are made, bond_option_mode_set() gets called and if
the mode changes to or from active-backup, we do need/want this code
to run to update wanted and features flags properly.


-- 
Jarod Wilson
jarod@redhat.com

