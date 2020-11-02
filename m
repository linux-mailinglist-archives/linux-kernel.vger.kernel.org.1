Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980662A30D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgKBRGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgKBRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:06:43 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDBBC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:06:41 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u2so1182468pls.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ESh9xtdAgdP17+IlQOl8SchaQP1wByfvx2mtwCrql2Q=;
        b=X4DuJJO0/gEJdfLQm0/YE9Y2l9ZhKtY5Whhq2yImpVUTGKCiG2r0WVGyUFoVbJELm0
         LPmnoj1qViMSnbrVTZa3YlJxORw9Cxk4h/6jPyeDD7BV6b3PHq4EyLWx721+H44mT1+K
         ZBy4zvIIkSSMS0k9A5cRioGINRzvU1KBwGgS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ESh9xtdAgdP17+IlQOl8SchaQP1wByfvx2mtwCrql2Q=;
        b=rain0cnb+eg3dYGp2zDMSYWIvRAyhpBwqf2n4bL9D6KS4CyHAZgjoyTA9hj7C7T2oI
         +7Cjef09t9UPbazwELPsmrwp4YSGyWC6VjKYAcCD/l5oKtQzMYQsqpFkLpJdVjfU9mAn
         2LVkl0VV3356K4fXT5tQ3qvodqLrPvQRwt/HNV5SgQuIpknO6SjhkAq7BcM8K6AuL8n9
         rwPvjgcyKNPwwkbxPMA2E1RaqPCKY6XFWfGSTRQS9svkaTeWbWj14M/vS/0JvUUMh7g4
         iW0j4UlJqL1HmiiSxx2nQxkrR1IXQCgAvV0glOBJBZso0R/8P7ePdwB73UFUWI6XxQ97
         /Y/A==
X-Gm-Message-State: AOAM531M/x8l/fOEp4FxTGW9F7+sxHh+dq1uNpaKbKWbj6Q/80Ra3ZfH
        +PRraiQDHvqv8EItcsVfCNpOJA==
X-Google-Smtp-Source: ABdhPJxYfBE1SCamXj3nnapq9Wu8zWTv9R/9QOz630Xs5i8P2iZSQmvZci0pOSsNYwW2B9nmgp+aZA==
X-Received: by 2002:a17:902:8649:b029:d6:d1e7:e78b with SMTP id y9-20020a1709028649b02900d6d1e7e78bmr4135219plt.63.1604336801123;
        Mon, 02 Nov 2020 09:06:41 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 12sm5476052pfh.88.2020.11.02.09.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:06:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=VHvL4A3U==CECbgkfvRcy51v4cSBjodvRGA2463L+CZQ@mail.gmail.com>
References: <20201030011738.2028313-1-swboyd@chromium.org> <20201030011738.2028313-2-swboyd@chromium.org> <CAD=FV=VHvL4A3U==CECbgkfvRcy51v4cSBjodvRGA2463L+CZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/bridge: ti-sn65dsi86: Combine register accesses in ti_sn_aux_transfer()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Mon, 02 Nov 2020 09:06:38 -0800
Message-ID: <160433679882.884498.16765038474501300057@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-11-02 08:18:47)
> Hi,
>=20
> On Thu, Oct 29, 2020 at 6:17 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > These register reads and writes are sometimes directly next to each
> > other in the register address space. Let's use regmap bulk read/write
> > APIs to get the data with one transfer instead of multiple i2c
> > transfers. This helps cut down on the number of transfers in the case of
> > something like reading an EDID where we read in blocks of 16 bytes at a
> > time and the last for loop here is sending an i2c transfer for each of
> > those 16 bytes, one at a time. Ouch!
> >
> > Changes in v2:
> >  - Combined AUX_CMD register write
>=20
> The change from v1 to v2 makes me slightly nervous, though I guess
> it's fine.  Specifically, all the examples in the datasheet show
> programming the CMD before the ADDR and LEN.  This change will make it
> programmed after.  Since there's a separate START bit I guess it's OK,
> though.  Nothing in the datasheet explicitly says that the order in
> the examples is the only order that will work...

Hmmm now that you mention it the SEND bit is explicitly being cleared in
the programming sequence by being there at the start. If I want to
combine that with the adjacent register writes then I should make sure
that the SEND bit is cleared at the beginning. Otherwise the hardware
may be in the middle of a transaction if the previous transaction is
still running, i.e. a timeout where the SEND bit never cleared.

I think we should go back to the previous patch I had here. Combining
this register write is wrong. If anything, we should clear the SEND bit
on a timeout and make sure during probe that this bit is clear and then
drop the programming of this register from this function entirely. That
would reduce the sequence by one register, but is more complicated vs.
just making sure it has the clear bit here to begin with.

>=20
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks, but I'll send another round picking up acks and such and your
previous review tag on the v1 of this patch.
