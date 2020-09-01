Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DFF2588AE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 09:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIAHEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 03:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgIAHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:03:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4C6C0612AC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 00:03:59 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so204492pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=yt2/uuzJefKJes8DuYxR0BUPgeMCP8QxYbisa2vpogM=;
        b=GcLmuGSJUeWmTAXBiL86j+aUB1GdEuPM+DXtZrMF567L9Ld8A1nbpQLTCshAzMzzqi
         apZO6aIlaInhmpaAIHCKBTuu2lt9KXzHl3eoOMybotovWlNG169L3M4C/2yFtBPAHxDm
         uOku83ScHQ7nSaeAuff8b8oVvo1Fu2ciMH8SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=yt2/uuzJefKJes8DuYxR0BUPgeMCP8QxYbisa2vpogM=;
        b=oAuEovr+Qg8ilTinEdM3yTLj5HTLROH+Jt+Qb1NnT0BLaUx4sakMbiTOz7OFgNCvRU
         bXd6DBbuq/JS3lNh2idQ5slXLV//C2gO97Y477GM90nSQKrgj9mIvim7YKUOuJqpceRA
         62fBLsOxUbhkUErI48/8Wv2yH1+mL5c4alXCzUFxWyeLiPl+Fl4oSqDTNhaO09ZOEtIX
         IxQ/nNxjZ8wkyuYqC9fIf07+/YV1aNaeISfxsF0WjMwiofiNr4NNWyW6hsrzPJaAlpq1
         oY9cBIMnd2mtR7BeZx9nr1fG+qHJ+cS0CzyAa7MRxz7Z2JCHuQpPncYh6rPNaP+4t/4b
         8OmQ==
X-Gm-Message-State: AOAM531mqVmqhkeDrxDy6U4Q3bPAn4PAwob3Uqjet48xcYycLMmaMkXY
        7oWYMDpfucvDqMwyQuif7aAu+A==
X-Google-Smtp-Source: ABdhPJw2vSZ55ft3u0C6inxDIBpYawyYF+bsrmkuFF946I/Pa+kkKz3JD1d88pKLbb743Flov3K+SQ==
X-Received: by 2002:a63:4a1d:: with SMTP id x29mr319979pga.317.1598943837907;
        Tue, 01 Sep 2020 00:03:57 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id hg16sm378729pjb.37.2020.09.01.00.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 00:03:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=VWrXwDwoxBK9y2ZeFEoG-edO4WktdSW0MFZLfbcS2hLQ@mail.gmail.com>
References: <20200828170052.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid> <20200829161230.398e0051@archlinux> <CAD=FV=W3=kRFH0TzEAX0DWS7jb113LuWUJqVS686EyRzexvoRA@mail.gmail.com> <20200829181754.52d3cc3b@archlinux> <CAD=FV=VWrXwDwoxBK9y2ZeFEoG-edO4WktdSW0MFZLfbcS2hLQ@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Prefer async probe
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>
To:     Doug Anderson <dianders@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Tue, 01 Sep 2020 00:03:55 -0700
Message-ID: <159894383586.334488.2938301456606601581@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-08-31 11:59:37)
> On Sat, Aug 29, 2020 at 10:18 AM Jonathan Cameron <jic23@kernel.org> wrot=
e:
> > Agreed. However, I'd like a comment next to the place we turn it on
> > saying what delays we are trying to mitigate by enabling it in this
> > driver.
>=20
> OK, I used function graph to get a trace.  Some of the time is simply
> i2c transfers, which we do A LOT of during initialization (and i2c
> transfers aren't known for being instant).  However, that's not the
> big problem.  Check out the regmap_read_poll_timeout() in
> sx9310_init_compensation().  20 ms per sleep with a 2 second timeout.
> This seems to eat over around 220 ms of the time on my system.
>=20
> So how do you want to do this?  Do you want me to re-post the patch
> and mention the regmap_read_poll_timeout() in the commit message?  Do
> you want to just add that to the commit message yourself?
>=20

I think the suggestion is to put a comment next to the
PROBE_PREFER_ASYNCHRONOUS flag indicating that
sx9310_init_compensation() can take a while. Should the compensation be
delayed even further though to some time when userspace opens the device
node?
