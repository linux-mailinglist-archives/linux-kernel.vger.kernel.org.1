Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391C82CFB89
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 15:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgLEOTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 09:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgLEM6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 07:58:53 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28DC09424E;
        Sat,  5 Dec 2020 04:47:11 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id z5so8649901iob.11;
        Sat, 05 Dec 2020 04:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/XpRQ3Q0ad+Q2MHPv+UdGhls3f1Aa2YKOEanYedPdIk=;
        b=egBmuZj9si4XcjX7hbuUrl90XqzQXy6ONSDPwnubdJFkNY/KxL8tQlLFtE6yQh+Q1z
         kiRIqpGw27Inc3+YPNWvfKxzE95d/O4RJ5dP/9jwZS4NLBZRXKZW82aAM2LjuwIoWzl+
         uojW88o+rW24I544Gc6FgQXpFYf+XUSkWQKoXJRkFqefa5wN8J5CbNP9UItPiRXRCKtd
         LSiQ2OQN+T8V048oM7Y+eirAixi7/mXhQSCuUcb73tPmdhD8ll+vEokBfvVdgbDtf3hv
         2Afswj2FDWL+iavY7+76Rj5Q5FcwRbt5fsXkw98m6vnmfWQ/vem9MofoRcIyJpM5NFX5
         Vr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/XpRQ3Q0ad+Q2MHPv+UdGhls3f1Aa2YKOEanYedPdIk=;
        b=uTIEiPgoTduBd4KvVi3A96LNRe05CftafIZsepJMKsWbL+BhJ2aJKqphYIbf/0vFu8
         yi3W3KOb5eNaeaW0ZQzdFOhA5tN0785IMYFTV45m0L0lEfctOg5lz/71OZEnxIYSBo9r
         4e+6Z8TmTSdU1Bba97gDR3zw8eKtp/nlDehuDwHq5RRpIAtn3Q2CWOGGRwGdPV/88PL0
         QoLX476WVaptp9qgLGq8AqpuJxcVyukfrZA1QxXSjvlrpGmMksiF7rYeLKT84gpM4SLg
         a9O39rqgqLxjvN1GxmMVkMoaLD6X9B7OBSHKOEodNXJN2jtO17EJcZBFzxw0tXHgUQoZ
         b33g==
X-Gm-Message-State: AOAM531p5UOdtS+hHejavH6zaN22NH202LPN115vsgpKnd30SS/jiQE/
        67pWFEb11THwp7JMcbowf1LgdLkirDMZsL72MAk=
X-Google-Smtp-Source: ABdhPJybJZKeM2jBJZXvPwqinwg7SiIw9A482TPoAQbPUhShWdncpaKiViV/Yh0v1/8UU1YtvF3IUVI8LrUW6/uPJL0=
X-Received: by 2002:a5d:8e06:: with SMTP id e6mr10819023iod.27.1607172431223;
 Sat, 05 Dec 2020 04:47:11 -0800 (PST)
MIME-Version: 1.0
References: <1607063090-3426-1-git-send-email-minhquangbui99@gmail.com> <20201204161249.GA1141609@rowland.harvard.edu>
In-Reply-To: <20201204161249.GA1141609@rowland.harvard.edu>
From:   =?UTF-8?Q?Minh_B=C3=B9i_Quang?= <minhquangbui99@gmail.com>
Date:   Sat, 5 Dec 2020 19:47:01 +0700
Message-ID: <CACtPs=Gg3C0KxdFnETHujAyis4hhKnCdV4_ZWqprHkXCXahFvw@mail.gmail.com>
Subject: Re: [PATCH] USB: dummy-hcd: Fix uninitialized array use in init()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V=C3=A0o Th 6, 4 thg 12, 2020 va=CC=80o lu=CC=81c 23:12 Alan Stern
<stern@rowland.harvard.edu> =C4=91=C3=A3 vi=E1=BA=BFt:
> Does this initialization end up using less memory than an explicit
> memset() call?

You mean speed? In my opinion, there is no difference in speed between 2 wa=
ys.
When I compile this array initialization using gcc 5.4.0,  this
initialization becomes
mov instructions when MAX_NUM_UDC=3D2 and becomes rep stos when
MAX_NUM_UDC=3D32. I think it makes no difference when comparing with memset=
()

Thanks,
Quang Minh
