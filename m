Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8902A1A4B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 20:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgJaTsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 15:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgJaTsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 15:48:07 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3816C0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 12:48:07 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id b3so5303041vsc.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TvEQ3YQDe4ioMttFW9AwFbw6LSuGpfeloBKzl/hwf0=;
        b=IDj6i1+cuJSQyq+kkNXHcWcEd1hvOYWnrSvXv0s0ROaG9b3QYTWDTlm+nwqycPyeD1
         2FxRIdHd50riM0xnGHM8PAxowUPjGpJiAaw2ica70WjYifM0hptMG2Rq+e4tOPxx6BZk
         Mv6e3hOUefJZ52j8zrirWOA1+wSsufpnVZn4SCwd7+1t0krTJpFZJOOrk7BnJ3tdr+ii
         IpCWQbYpUD/cYlAPD28X9M63MRlDYXUw6INMISzVxqDEaZw7hcDt+Pdwl/qNyFEqpobo
         lIgXyWlny9UHlK9zvRVmzi7DCeXLNF8R9NdGAxeCJv0oWFWvweV4uTpG0D65T47BVfGu
         b0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TvEQ3YQDe4ioMttFW9AwFbw6LSuGpfeloBKzl/hwf0=;
        b=JNKtT81C5f4k3sdmdMg+Si4vHirSM8D3UqwoXb74Qnb+oL+gXI2DJ7M5FSov5mx5IP
         fkMKaTjlaIuK4Lr0GibLlbYthcJmXxmVC8GcPcZymNSvutnPDnpLxG7OAWXGngQkVRAa
         YRiRwEv6/I3GsVftBy0OOsCenlbIeRZ18KQ5BgUz0Ikd0m6GP5+3W+3U2oT/iZ8p3Lxn
         WiqBd+rklWBKXwuHp8ZCmLGln46x6pIwxbS66xb1Ygz9EO/g0+j934sLUcidHORijR2B
         v10A3yTxcii3edOG4UPtb7LlPGZMIJAFMH3eiWGyQVCzZMNVYzBSO4foEOCGKTze7RDR
         zMEw==
X-Gm-Message-State: AOAM530dUgR13NHJuOdUHfY0QYPVC5L3Wgv9+lvAiy7aRwp4WBajHsOK
        0s34TzvHfVdOoW6GdL97zoGZljSfzzs=
X-Google-Smtp-Source: ABdhPJzlZDWMr+acwAWY1uT/ZSJqGU8pHOI9HnHkbkS/klw5Grcx1itFnK2FsoWbTW4CcuqIARZAMA==
X-Received: by 2002:a67:eb92:: with SMTP id e18mr10625587vso.41.1604173686528;
        Sat, 31 Oct 2020 12:48:06 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id m14sm1246626vkk.17.2020.10.31.12.48.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 12:48:05 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id x11so2690292vsx.12
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 12:48:05 -0700 (PDT)
X-Received: by 2002:a67:7704:: with SMTP id s4mr10588523vsc.51.1604173684822;
 Sat, 31 Oct 2020 12:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201031004918.463475-1-xie.he.0141@gmail.com>
 <20201031004918.463475-2-xie.he.0141@gmail.com> <CA+FuTSfKzKZ02st-enPfsgaQwTunPrmyK2x2jobZrWGb16KN0w@mail.gmail.com>
 <CAJht_EOhnrBG3R8vJS559nugtB0rHVNBdM_ypJWiAN_kywevrg@mail.gmail.com> <CAJht_EMgt4RF_Y1fV7_6VdzbMu0Fn8o+yW8C2RfnSsLjqsm_cg@mail.gmail.com>
In-Reply-To: <CAJht_EMgt4RF_Y1fV7_6VdzbMu0Fn8o+yW8C2RfnSsLjqsm_cg@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 31 Oct 2020 15:47:28 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfkMBow-2xvY1SKuiQQVicbxYSD0agCdGwr_h8ceXA8Fw@mail.gmail.com>
Message-ID: <CA+FuTSfkMBow-2xvY1SKuiQQVicbxYSD0agCdGwr_h8ceXA8Fw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/5] net: hdlc_fr: Simpify fr_rx by using
 "goto rx_drop" to drop frames
To:     Xie He <xie.he.0141@gmail.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Krzysztof Halasa <khc@pm.waw.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 12:02 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> On Sat, Oct 31, 2020 at 8:18 AM Xie He <xie.he.0141@gmail.com> wrote:
> >
> > > Especially without that, I'm not sure this and the follow-on patch add
> > > much value. Minor code cleanups complicate backports of fixes.
> >
> > To me this is necessary, because I feel hard to do any development on
> > un-cleaned-up code. I really don't know how to add my code without
> > these clean-ups, and even if I managed to do that, I would not be
> > happy with my code.

That is the reality of working in this space, I think. I have
frequently restructured code, fixed a bug and then worked backwards to
create a *minimal* bugfix that applies to the current code as well as
older stable branches.

Obviously this is more of a concern for stable fixes than for new
code. But we have to keep in mind that every code churn will make
future bug fixes harder to roll out to users. That is not to say that
churn should be avoided, just that we need to balance a change's
benefit against this cost.

> And always keeping the user interface and even the code unchanged
> contradicts my motivation of contributing to the Linux kernel. All my
> contributions are motivated by the hope to clean things up. I'm not an
> actual user of any of the code I contribute. If we adhere to the
> philosophy of not doing any clean-ups, my contributions would be
> meaningless.

There are cleanups and cleanups. Dead code removal and deduplication
of open coded logic, for instance, are very valuable. As is, for
instance, your work in making sense of hard_header_len.

Returning code in branches vs an error jump label seems more of a
personal preference, and to me does not pass the benefit/cost threshold.

FWIW, there is lots of code that I would jump at the opportunity to
restructure. Starting with skb_segment, probably.

Obviously, all this is just one opinion on the topic.
