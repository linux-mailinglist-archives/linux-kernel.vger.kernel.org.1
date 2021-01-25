Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C3730366A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbhAZGU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbhAYN0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:26:14 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C4CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:25:15 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m22so17707783lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L3XVlCmEvFUUK4TdCen7gzk/JsV1RDgOScAX/Jsq6gk=;
        b=e0cuny2GH9PczbzQrVAAAO+Kh29HZcyZgcXm9RWzWkv95XwAo52+AbntS4df72RPJP
         pALBAog13AD111F7T2EJOwd+op45bIwZI86NiaST93l6bAeZ+Lg4VUxk2I+iSQod65lA
         cz3CIkFyWk3z9qlyE07YrqlZH1iWCuTLiVwlHUnM1/AVxN8mbgVZtWAJO6lA5/2RhMUx
         7/KaPv7FPAeXb3gOKiqDYtHH6ANc92I2lbWNKzFhyVSoSfjy8ERmBaRn/ODs/DOuUcT5
         MkPzMmgTvZ1DN6Uv0zRZjBjKrJ6bg62w9UoEcDKpBWMLVEz/jkP9guyYlBI5BOQ+e2Ox
         DR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3XVlCmEvFUUK4TdCen7gzk/JsV1RDgOScAX/Jsq6gk=;
        b=GNT2T+NxokG6LdlCUsE9ydmy5n0DuOFoSrD8+MX1M4zaN7tPFYSVS9yPWQVmUjyZu4
         CdMF1yzGPqgb2pGTrcQqs/sgN7XKg4ijB/O0rwkBN9McPy4QkWP9pulKx3+SCa4FryZQ
         yzA/Ou4N6hEB8UyuNgd8caaERwRUGUCHfFm0QWY0T+41+uGZQNaqmGF4qD5dqLKCfS/F
         PFbIUiBhEKEuqthnqHl5tdJ/P2qZdmJDlY9uI+eqNHXkRfL7A2zTCq+DMdIREk187b5k
         OOPltmIi59D034aYm4MHaHvyj/+IJpUOpDvUMgakHB6BBlYOo9HPNivMf4wLfBa4ujai
         uWKQ==
X-Gm-Message-State: AOAM532ABKPvlJl6+RWln3NkdLm5de3bB8DDPKsNBPuolmnxa8GmurAG
        BH0XYMAg+zNGqAX/ZrEZpm/4Tvp4torJKzw/j3XKMw==
X-Google-Smtp-Source: ABdhPJy/mNjzVis7rlMla5hcgPSEs42xQlQ3FK6FdC6cUAFeXj6cNtnnXjl6Xwyjw+ik5CHkTfXDCNxeVfiNmcI3EzU=
X-Received: by 2002:a19:495d:: with SMTP id l29mr252466lfj.465.1611581114148;
 Mon, 25 Jan 2021 05:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20210120063019.1989081-1-paweldembicki@gmail.com>
 <20210121224505.nwfipzncw2h5d3rw@skbuf> <CACRpkdb4n5g6vtZ7sHyPXGJXDYAm=kPPrc9TE6+zjCPB+aQsgw@mail.gmail.com>
 <20210124234509.c4wkoauiqchv4aan@skbuf>
In-Reply-To: <20210124234509.c4wkoauiqchv4aan@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Jan 2021 14:25:02 +0100
Message-ID: <CACRpkdYi9dZjj8A9=sUJPDCvm9ajDVVAZzW5+hmH8Oux-dpixQ@mail.gmail.com>
Subject: Re: [PATCH] dsa: vsc73xx: add support for vlan filtering
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:45 AM Vladimir Oltean <olteanv@gmail.com> wrote:

> Anyhow, you did not approve or disprove the tag_8021q idea.

I just don't understand it well enough so I didn't know what to
say about that...

> With VLAN trunking on the CPU port, how would per-port traffic be
> managed? Would it be compatible with hardware-accelerated bridging
> (which this driver still does not support)?

I think in vendor code it is done like it is done on the RTL8366RB:
one VLAN per port, so the filtering inside the switch isolate the ports
by assigning them one VLAN each and the PTAG of the packets
make sure they can only reach the desired port.

(+/- my half-assed knowledge of how VLAN actually works,  one
day I think I understand it, next day I don't understand it anymore)

Yours,
Linus Walleij
