Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A9B2B4B75
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbgKPQlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgKPQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:41:18 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD12BC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:41:16 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so19399831wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=Rtf3WPy2v5/PbwArc8zsVNsYHP4yZqiUV6FRg+0fDSA=;
        b=teNJyuybcUBRu8Y/N3gpPv/LkkNYwAueeD6QaOUW4C0LP+SGZAkWUTyyfuxdp71ABj
         mwJazhnQ3ObYIxtFblXSVQyRtxkhhCkWVEsdYJHKkEa45fxyFsy8NkGaxQ264EhAFrah
         KE68YvuSveMPDdbqLjECCajE7wFZNJI3NnPI2Du5TADkSQfiSL5QcijOsW4jjUZbdASw
         9aoSkR+JnlXDaGMV6tl8WBux4Bod70pl/GYVIAYgmoWVXGpsa2puo9GSkE631MpSr0ri
         gY3AByZqA8TLYUJhmV6X3+QWnhG25t2sgOaTkjhlEVkjS/BKkzt5W2+NTVUWZqofvv2U
         vSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=Rtf3WPy2v5/PbwArc8zsVNsYHP4yZqiUV6FRg+0fDSA=;
        b=pxYyAh2p0M0+Ej6sJXIJhyxeaM/mSP1But+jwYW8u4PG5S/GzKmvrN470yUBdTHXEi
         P/nYDaniE+Gaz82+IcoI2JtYmWwUfP9SRIyJCWm0/za1kbhHfEfZ2gUHh4uJrvrBxxrN
         Yta0fLJA3m2T5tkU8IjREHK210EfnEZHPmLHJvY65c3Q9N2zpJXgXyoQROxMZ2lnp1rk
         SxNIz0kU9puk0faYuwEeiCQl2LNTly2UdF6mE+/y5Al9ETWXqqwFG38Pd2S28D38SF5h
         QPmvyr1xDq6Y+LCtLX4EIxRVOQ/YlE7edtcZJ5c1xHxPDL7Nvw4MYCuJnknkl1D9iteY
         5i5Q==
X-Gm-Message-State: AOAM5318g2U4i03gapDJ9gKzRbMSXVVCw6AveWrxfZHJYuJxuCGI3M+D
        duPLOGyHE1wU7CwKVRudQymY/jV6G8gvCtUM
X-Google-Smtp-Source: ABdhPJzvBUGf8eI0OYt/qmbfQt+9LTf5uEZcDSPO6S6VGAe1+j7kmLoBgoNQyoNJtK+MHMe/ypdKGw==
X-Received: by 2002:adf:f4c7:: with SMTP id h7mr19643713wrp.234.1605544875289;
        Mon, 16 Nov 2020 08:41:15 -0800 (PST)
Received: from localhost (253.35.17.109.rev.sfr.net. [109.17.35.253])
        by smtp.gmail.com with ESMTPSA id k1sm20071604wrp.23.2020.11.16.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:41:14 -0800 (PST)
References: <20201112230043.28987-1-aouledameur@baylibre.com>
 <0f679c62aa48603ea43a8fa4819d688baa802d73.camel@pengutronix.de>
 <1jima91e92.fsf@starbuckisacylon.baylibre.com>
 <48332a44241f3c06966420277060b6048c1f77d0.camel@pengutronix.de>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2] reset: make shared pulsed reset controls re-triggerable
In-reply-to: <48332a44241f3c06966420277060b6048c1f77d0.camel@pengutronix.de>
Message-ID: <1j4klp1cgm.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 16 Nov 2020 17:41:13 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 16 Nov 2020 at 17:36, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> On Fri, 2020-11-13 at 16:13 +0100, Jerome Brunet wrote:
>> On Fri 13 Nov 2020 at 16:04, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>> 
>> > On Fri, 2020-11-13 at 00:00 +0100, Amjad Ouled-Ameur wrote:
>> > > The current reset framework API does not allow to release what is done by
>> > > reset_control_reset(), IOW decrement triggered_count. Add the new
>> > > reset_control_rearm() call to do so.
>> > > 
>> > > When reset_control_reset() has been called once, the counter
>> > > triggered_count, in the reset framework, is incremented i.e the resource
>> > > under the reset is in-use and the reset should not be done again.
>> > > reset_control_rearm() would be the way to state that the resource is
>> > > no longer used and, that from the caller's perspective, the reset can be
>> > > fired again if necessary.
>> > > 
>> > > Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> > > Reported-by: Jerome Brunet <jbrunet@baylibre.com>
>> > > ---
>> > > Change since v1: [0]
>> > > * Renamed the new call from reset_control_(array_)resettable to 
>> > > reset_control_(array_)rearm
>> > > * Open-coded reset_control_array_rearm to check for errors before
>> > > decrementing triggered_count because we cannot roll back in case an
>> > > error occurs while decrementing one of the rstc.
>> > > * Reworded the new call's description.
>> > 
>> > Thank you, applied to reset/next.
>> 
>> Hi Philipp,
>> 
>> Would it be possible to get an immutable branch/tag with this ?
>> It would allow to move forward on the USB side, without waiting for the
>> next rc1.
>
> Here you go,
>
> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
>
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
>
> are available in the Git repository at:
>
>   git://git.pengutronix.de/git/pza/linux.git reset/shared-retrigger
>
> for you to fetch changes up to 557acb3d2cd9c82de19f944f6cc967a347735385:
>
>   reset: make shared pulsed reset controls re-triggerable (2020-11-16 17:05:28 +0100)
>
> ----------------------------------------------------------------
> Amjad Ouled-Ameur (1):
>       reset: make shared pulsed reset controls re-triggerable
>
>  drivers/reset/core.c  | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/reset.h |  1 +
>  2 files changed, 74 insertions(+)
>

Thx Philipp !

> regards
> Philipp

