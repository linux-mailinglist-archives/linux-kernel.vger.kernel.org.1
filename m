Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925702AFA14
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgKKUz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKUz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:55:27 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC19C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:55:26 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id 128so1980156vso.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6wXQms3X2jDTGkCw8WsYRVzU1kvWpMHgYkx09XvOSo=;
        b=t+grscLb20Tx0eHT7Z0/3k9KRGG3yAc0IuHJ5S/pi0ek59meKkGY0CtxIplTBbl11j
         oTSxcbEMlEMkj8W7RMJlTS1d4xPkr1a9fJ0aFfgLvj6eONeTK+BAqezy+ExOkbkaSFzz
         25gAAZ2u1RLDBe9B4QZXGhEYkSSCOeUc7BJkODARM3xlgpQ9PPXQCewu0QQltVG2UlA3
         hiXI4alqL1PNC3XL+Mdn1mA6QhEf2vUaKUaZKqM29U31JUVzowAbMa0xAARMQGraosCI
         4BfQtavFo6mDftIYj2i2ouxw3RpRrZIH2N0LuBt/ad/yK0c6L409r2KUGMroCHWjHZ1X
         YA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6wXQms3X2jDTGkCw8WsYRVzU1kvWpMHgYkx09XvOSo=;
        b=Mi/ND6+FXn1yG3786N3YcKCPBhaQPOfZ5xAgXwdhkGunyAyivRmML0kGsjy7RKzKiE
         jOw+HIv9LjIVzdTmBLp3LGCLeVKWTB166jBSgmXbWNdd39JaXadlDeVCAor+LDnfYEzO
         NL1sv8M6Vyyqx2Co0MSvBl7rMivM+jTesy+Qky4Iau8S1zCYpokCsU/jgiHxjqV8p7K0
         UAcUQYU2cPCMU5TwFdax8CXnNwQVT1rlA29p4j1XLB4h4z1PUfA/FpYxsSjl31nNAEiq
         D1K9h4h50CbVOlNwEmLxbYDEwhmf2UMSH3I9ssZZcUUloobZVwax0BFct+jRMB/2krWW
         3dUg==
X-Gm-Message-State: AOAM533+9BeksLUGeY5ayCFUyX1z2yfh/UNPvyEw1vgsIYZap/ppXUBe
        vEnk6mcLpeEKTQRmOSqOGmpUi0YcpHg=
X-Google-Smtp-Source: ABdhPJxJoTMVfOBF5yolF7BhGfblnJyIWUmQsf+Lb0Y3YqxtyMkX6eYTpuwl8ev5YRGdsQwj3EQ7RQ==
X-Received: by 2002:a05:6102:a17:: with SMTP id t23mr9679209vsa.25.1605128125345;
        Wed, 11 Nov 2020 12:55:25 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 59sm293490uag.13.2020.11.11.12.55.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 12:55:24 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id m16so1969075vsl.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:55:24 -0800 (PST)
X-Received: by 2002:a67:ce0e:: with SMTP id s14mr16942916vsl.13.1605128123561;
 Wed, 11 Nov 2020 12:55:23 -0800 (PST)
MIME-Version: 1.0
References: <sc7E1N6fUafwmUSYAu3TKgH39kfjNK5WuUi0wng54@cp4-web-030.plabs.ch>
In-Reply-To: <sc7E1N6fUafwmUSYAu3TKgH39kfjNK5WuUi0wng54@cp4-web-030.plabs.ch>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 11 Nov 2020 15:54:45 -0500
X-Gmail-Original-Message-ID: <CA+FuTSc3Xk9U51f1PCLVAmu-+Wfs8i2+gb8K2igcV5fUq_b40A@mail.gmail.com>
Message-ID: <CA+FuTSc3Xk9U51f1PCLVAmu-+Wfs8i2+gb8K2igcV5fUq_b40A@mail.gmail.com>
Subject: Re: [PATCH v5 net 2/2] net: udp: fix IP header access and skb lookup
 on Fast/frag0 UDP GRO
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Eric Dumazet <edumazet@google.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 3:45 PM Alexander Lobakin <alobakin@pm.me> wrote:
>
> udp{4,6}_lib_lookup_skb() use ip{,v6}_hdr() to get IP header of the
> packet. While it's probably OK for non-frag0 paths, this helpers
> will also point to junk on Fast/frag0 GRO when all headers are
> located in frags. As a result, sk/skb lookup may fail or give wrong
> results. To support both GRO modes, skb_gro_network_header() might
> be used. To not modify original functions, add private versions of
> udp{4,6}_lib_lookup_skb() only to perform correct sk lookups on GRO.
>
> Present since the introduction of "application-level" UDP GRO
> in 4.7-rc1.
>
> Misc: replace totally unneeded ternaries with plain ifs.
>
> Fixes: a6024562ffd7 ("udp: Add GRO functions to UDP socket")
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Acked-by: Willem de Bruijn <willemb@google.com>
