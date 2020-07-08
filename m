Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C242219076
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 21:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgGHT3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHT3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:29:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D526C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 12:29:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so55588663ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3MvdpjEnNZW9BbNR1qpkm/LIeqAjdP1q1FXS5ya3cc=;
        b=ZdmqSHw+ojnrdPsvv1UtjXgW9fyDes5zTLr6Htwfa4QWwEsIMFWuh2fkJSL6YM5Zj3
         droYP0zu8FMPsbEcGrT7veMxZZ/J7Cs7MpgbA+iIQ+nkRO5el5hYWKXMIFwYrydJ9Miu
         JPVftQVB9whnsuzJoOVw/bJT49by7hQfJfckU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3MvdpjEnNZW9BbNR1qpkm/LIeqAjdP1q1FXS5ya3cc=;
        b=rvZp0v+GgK/uK2DzU8QaUIFn2e6P+gy9b+wgUOw0ZgONHgb0vtLiQ0iRJqmHUjZeTJ
         olv/Zds+xn5+F7PQ/PoSEmamI9N25CYdtRJ88b6ZFgkwho+xGwxf3tfsW9xVEpilOPJG
         5QF6b8W07L54baE+HBLyzbYzJ/ZIhUQ5ih2KapriZxpqRkIwXrt8czVEbAJVBvBvDnYn
         O8zxAHA4shDIAl/KnMIa2Rup3Gad1eh9hc7hcfoNqYn95kRXPBV5iRxnviIVgeQYqOpO
         untPCCwQqhPvD9HBqWs3+GbdPIKyvV+sC1m/muHfbeStNSW78/htQad/vWti5JF8ThTj
         GXuQ==
X-Gm-Message-State: AOAM5304pTeWhqIuU69TYYn38jiFEvTcngDol3pmMXUoqj1RdWTuunyg
        huvJ1u3cjkG89h2CesVIjid+cr2/MIY=
X-Google-Smtp-Source: ABdhPJymA1qMgF+OiUzUvKkmnpWiBm4DYl0jvgY9ji150hcFUyHM8akE8xxfU9ehxPaKLemYpiH9CQ==
X-Received: by 2002:a2e:8ec8:: with SMTP id e8mr24077832ljl.51.1594236570754;
        Wed, 08 Jul 2020 12:29:30 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r13sm163605ljg.101.2020.07.08.12.29.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 12:29:29 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q4so19856637lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:29:28 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr20526501ljj.312.1594236568492;
 Wed, 08 Jul 2020 12:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <a98e9c26-5405-3894-6197-3f5e388a5698@infradead.org>
 <CAHk-=whkuOeHvA_ws=usQt=rYq_M2vh448mDxY7kYhUmp_Lomw@mail.gmail.com>
 <1ac6b3ba-ad54-a227-94d3-06cdf4fa4c91@infradead.org> <CAHk-=wg1W=g_oUUfN6aqbWhsicuFLikHZ4B8UkT1RfEa351J_A@mail.gmail.com>
 <20200708131048.30a494d1@lwn.net>
In-Reply-To: <20200708131048.30a494d1@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Jul 2020 12:29:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5DSEZMsJXLtKZaJBoGKR_TgkqvZYCn3g4T6BNqELAUg@mail.gmail.com>
Message-ID: <CAHk-=wj5DSEZMsJXLtKZaJBoGKR_TgkqvZYCn3g4T6BNqELAUg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: update for gcc 4.9 requirement
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 12:10 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Either is fine with me; I can add the Fixes: tag.  If you want it in
> 5.8-rc, it's maybe best if you just take it directly; I don't have another
> 5.8 pull in the works at the moment.

I took that as an ack, and applied it.

                 Linus
