Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A83A282671
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 21:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJCTou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 15:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbgJCTos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 15:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601754287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ajQYGYojq4f9aQLq4fZ43qbXeKvwhmhvTmq4l0hgCs=;
        b=iolzYA72rwRTeMOgkMRLXENozUKvU2bVeoYVmk/6WGo0eH7LvDFjBmzmnfw2OuBc/N2gxi
        K/reKmb6sq0GNPvDlURzLfogH0mlY9W5OU1ATKCPGISKnalVqQTRdibSyzsg1HbgmQUelX
        e00OZBOry8yRo10Z2dXnPTggIi/WqYE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-_3E15oi-OOKm3vouTgujhQ-1; Sat, 03 Oct 2020 15:44:45 -0400
X-MC-Unique: _3E15oi-OOKm3vouTgujhQ-1
Received: by mail-ot1-f72.google.com with SMTP id g2so2295468otr.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 12:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ajQYGYojq4f9aQLq4fZ43qbXeKvwhmhvTmq4l0hgCs=;
        b=UFy4wewna1ZVMSE+MXZR+a5jGSYpAEVKt/+xPbDF5lUEaQwzHLxIDAAoL9+QgfnkY1
         VMu+ce9ESo+7IKVthAPyj6Gkw7VVg3fkLiuzGXN0cvUH7s55s/DoEnQsxLYRjRucVXGu
         jjta+DZukDU9Ej48vjstQaWVj3AwesFn8kMBKSSviauK2Mxj9FagVrzh69/gB1MVw8lH
         uBG3EWQsakT5R2+ZeXv8dbhFCRVA1X2PCb4ENOoqTduekcaaWBbpBoungaX2p9WElNtd
         FwmKSUy/oB/jCgL3EFvf+73z1FvRhRWTtlWPjoepmvF3EBBV3LBYlDLf89c+KHpfaNE8
         JGvA==
X-Gm-Message-State: AOAM5320GkDDS74UzMDVLa25kyjQjhx4JpvOVqBjRcVsSwDvsEzaPNFQ
        1V7E/evgZZVyxSAYGfDTK6nAQxuHWtDdjA7POPPoVRB9yDsC/v4lkjemKg9tpwB9DRQjnlEDzor
        LKIYejRl4TLjfNe5DQTgoo8ppykrKB8PLRzpwbhti
X-Received: by 2002:aca:4e06:: with SMTP id c6mr2746463oib.120.1601754284256;
        Sat, 03 Oct 2020 12:44:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+1W2OcJQdBH5Es26AH2enJprMfA6Y6Ta0TykOVjsUsp+EeIZZaj3b8yn+Q4U1qjm0n74jCFvjcTLQRMWgMzI=
X-Received: by 2002:aca:4e06:: with SMTP id c6mr2746461oib.120.1601754284042;
 Sat, 03 Oct 2020 12:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201002174001.3012643-6-jarod@redhat.com> <20201002121051.5ca41c1a@hermes.local>
 <CAKfmpSecU63B1eJ5KEyPcCAkXxeqZQdghvUMdn_yGn3+iQWwcQ@mail.gmail.com> <20201002.155535.2066858020292000189.davem@davemloft.net>
In-Reply-To: <20201002.155535.2066858020292000189.davem@davemloft.net>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Sat, 3 Oct 2020 15:44:33 -0400
Message-ID: <CAKfmpSd=mSUEThgD_z58wHkyLtHZcZHcK87t+EzXHU2QSxf2Dg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] bonding: update Documentation for
 port/bond terminology
To:     David Miller <davem@davemloft.net>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 6:55 PM David Miller <davem@davemloft.net> wrote:
>
> From: Jarod Wilson <jarod@redhat.com>
> Date: Fri, 2 Oct 2020 16:12:49 -0400
>
> > The documentation was updated to point to the new names, but the old
> > ones still exist across the board, there should be no userspace
> > breakage here. (My lnst bonding tests actually fall flat currently
> > if the old names are gone).
>
> The documentation is the reference point for people reading code in
> userspace that manipulates bonding devices.
>
> So people will come across the deprecated names in userland code and
> therefore will try to learn what they do and what they mean.
>
> Which means that the documentation must reference the old names.
>
> You can mark them "(DEPRECATED)" or similar, but you must not remove
> them.

Okay, so it sounds like just a blurb near the top of the file
referencing the changes that have been made in the code might be the
way to go here. Tagging every occurrence of master or slave in the doc
inline as deprecated would get ... noisy.

-- 
Jarod Wilson
jarod@redhat.com

