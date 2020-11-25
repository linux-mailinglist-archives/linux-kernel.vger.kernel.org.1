Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EEF2C453B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbgKYQaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730619AbgKYQaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:30:19 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454CDC061A51
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 08:30:18 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id i7so615023oot.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2ymb6kphenbYa9NqBfUSs5w3DhdYrXoLEdK5gIrDe4=;
        b=pCjIkr08b2JNL/em/FgTdQ6lsR/OmEC306joPof9QfgAPqdwSgF9s6u7INeZaoJQv2
         hloN19U0M+R04BAIpi6uzXJKEHAD8xH7peMPFUOFAl4Nc9ni1KTfTze7hsdbGcairdlY
         wUj4N7pMoWMm9oCHP/YtBz7FOGRIjyFqKko9J8Mrv0mgKdgsNUNmunGubxSPGZgFKyiZ
         8GetxyC8WtIPq5T8K/WoB5uKeHAs93S2bRI8z9Pbi87k466zhCV4RmREbkydyWkSnxr/
         10/XzMTReGwC8CDy/Apnr1w0U4s4yiVzErpeo59puaM/4jmLxMbFzY82k0kCaYVmstft
         ZwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2ymb6kphenbYa9NqBfUSs5w3DhdYrXoLEdK5gIrDe4=;
        b=MexiFg9tVwe9XHrctpDK1QotfiO3SAep8FfS9PYd0Vs5pgkSNQxRlcurMI2bQcIMwj
         q/TGpJ2fqrSKYBU7amxXEPz6Fw6MMOb5qW1Yok44ajunvPCZhwEKecCjWCx1PqXAAE+k
         JFmTvVcJEZ9Wgh0NXAyYopOFowPK2spszVWiqwSOaze9+jgro3vOAcxPbC7ngBikbsLN
         /JAQpXaxrSeBEZ+bbye7JD9bkitaHMRCd+JcGbgXtvHyxqUkOPA1mmCpltiLIlK99H66
         XVXrZODJcghfiyJ9B4acF/H/rTa6BeMz3EKyiun3PPOUSpA91m2fSXFAN4n3YJCJOZAT
         ao1w==
X-Gm-Message-State: AOAM531GVnB/lnsKrBeEMPuwLYAph4xuBbDdhDxK/A187z902dqlPPeP
        aMLIp6JLo+FLaGZWrlDj9nIerdjpCOLVQnoPqyVrjg==
X-Google-Smtp-Source: ABdhPJyvUAUS2PQ3HfaYjg7qyRIj/80oKoHdVzEk1YjEWjiFajYFbOrcbDV631NIDei82VfRcJvgUrOuwYtwM+VoN6o=
X-Received: by 2002:a4a:b28b:: with SMTP id k11mr3299006ooo.54.1606321815976;
 Wed, 25 Nov 2020 08:30:15 -0800 (PST)
MIME-Version: 1.0
References: <20201029173620.2121359-1-aleksandrnogikh@gmail.com>
 <20201029173620.2121359-3-aleksandrnogikh@gmail.com> <20201121160941.GA485907@shredder.lan>
 <20201121165227.GT15137@breakpoint.cc> <20201121100636.26aaaf8a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <bcfb0fe1b207d2f4bb52f0d1ef51207f9b5587de.camel@sipsolutions.net>
 <20201121103529.4b4acbff@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <106fc65f0459bc316e89beaf6bd71e823c4c01b7.camel@sipsolutions.net>
 <20201121125508.4d526dd0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <86c6369a937c760e374c78f5252ffc67cf67b1e1.camel@sipsolutions.net> <20201121130227.5136221c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201121130227.5136221c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 25 Nov 2020 17:30:04 +0100
Message-ID: <CANpmjNM-CiP9HBgUZARe=4A0WF53Q1fmpETBHgdG9ZZ_F2qvAA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] net: add kcov handle to skb extensions
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Florian Westphal <fw@strlen.de>,
        Ido Schimmel <idosch@idosch.org>,
        Aleksandr Nogikh <aleksandrnogikh@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org,
        willemdebruijn.kernel@gmail.com,
        Aleksandr Nogikh <nogikh@google.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Nov 2020 at 22:02, Jakub Kicinski <kuba@kernel.org> wrote:
> On Sat, 21 Nov 2020 21:58:37 +0100 Johannes Berg wrote:
> > On Sat, 2020-11-21 at 12:55 -0800, Jakub Kicinski wrote:
> > > It is more complicated. We can go back to an skb field if this work is
> > > expected to yield results for mac80211. Would you mind sending a patch?
> >
> > I can do that, but I'm not going to be able to do it now/tonight (GMT+1
> > here), so probably only Monday/Tuesday or so, sorry.
>
> Oh yea, no worries, took someone a month to notice this is broken,
> as long as it's fixed before the merge window it's fine ;)

I took the liberty of taking patch 2/3 from v2 which was still storing
kcov_handle in sk_buff, and resending with the updates to patch 3/3:
  https://lkml.kernel.org/r/20201125162455.1690502-1-elver@google.com

Thanks,
-- Marco
