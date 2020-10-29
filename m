Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBFE29F264
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgJ2Q6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgJ2Q6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:58:48 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDF3C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:58:46 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id f4so1904449vsk.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDtbXhTlBa748s0h1Ogx7XDQgfv7TLeyu6NvN3vLWQk=;
        b=JW39bg0p3pFD6AuX17A3EEqsbHd0ilwYe+VdOG97eUwMsV15P/meUrTLamSm1kTXRj
         bHzeyPULvQZqQU48nfD85WNvvghI+YxKz8LFaurQx5w2xYHkPNlVCMxlvHpD004uptnf
         ulQc57Vc9bAj+Ish/kDabJxnrhwYhuKj6GKLfyXxCviMnNUSDWtXZAtFPQbPpYeoueVJ
         DGkXppSZiL/RmP4UIvtAUtQqH4RBQrE/QUYqKmxSL38A1w5a8LFpQHr2n0m4ur48C8+T
         h6GGW7U6bro8CSEJVbYcn0bUI8SvBhFk3ZSRYKImT531boAy5HgGDNq+6bJdFXxZgp+h
         G+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDtbXhTlBa748s0h1Ogx7XDQgfv7TLeyu6NvN3vLWQk=;
        b=rFS7NJNz/Q4oqmVIMm+Cn0Ae1fnKnDozxdHTmkNlicGUdoO10rkZWGiZPX+C+OCW1/
         +T6Jx9P3EUUPhhFIwjGDEM89zUOuHiIjCny1a/stPxRzoLlIFDtdPXspIuJcgqVXfWlb
         eg61Nh5gFTeHI+KUDZudQQJpS8fQKXx5Dd5ybztm+EHzkdkx9ckujz5teZ7naDiGVVA0
         cwPBaz6Em+Ub4N0kSiaPnqyv58wglJoXzh0ayugpxlU7H3GY1mOXQ4fPiZg0IVJFpWcN
         5+luncx5XaE8oOWG8YjcnZX3qux8FiXmBY3oGBkAXrclka4vYTLINEhywS5qbO3KNwgo
         h8ww==
X-Gm-Message-State: AOAM530cLFN072JWlAFFjnk1PRTaZxGMiLv7d+2ia9lz48TpTtuc9186
        +GWUnLxdJ6QMWSI2ArbXTcoWpze5BOM=
X-Google-Smtp-Source: ABdhPJweYwGZPZ2tn1RQ5EDiTuc+fKrwHkP2WL49OoigTnh9Pae63FP7YptmISWwn123btxC/zgpdQ==
X-Received: by 2002:a67:7283:: with SMTP id n125mr4342118vsc.20.1603990725049;
        Thu, 29 Oct 2020 09:58:45 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id n16sm441690vsk.17.2020.10.29.09.58.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 09:58:44 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id b34so896333uab.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:58:43 -0700 (PDT)
X-Received: by 2002:ab0:35d7:: with SMTP id x23mr3511937uat.92.1603990723236;
 Thu, 29 Oct 2020 09:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201028184310.7017-1-xie.he.0141@gmail.com> <20201028184310.7017-3-xie.he.0141@gmail.com>
In-Reply-To: <20201028184310.7017-3-xie.he.0141@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 29 Oct 2020 12:58:05 -0400
X-Gmail-Original-Message-ID: <CA+FuTSf_Veb8Pexix5_Nx3Ujm3P+d=0VNx6hhzPsyoBBdwQ=BQ@mail.gmail.com>
Message-ID: <CA+FuTSf_Veb8Pexix5_Nx3Ujm3P+d=0VNx6hhzPsyoBBdwQ=BQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/4] net: hdlc_fr: Change the use of "dev" in
 fr_rx to make the code cleaner
To:     Xie He <xie.he.0141@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Krzysztof Halasa <khc@pm.waw.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:12 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> The eth_type_trans function is called when we receive frames carrying
> Ethernet frames. This function expects a non-NULL pointer as an argument,
> and assigns it directly to skb->dev.
>
> However, the code handling other types of frames first assigns a pointer
> to "dev", and then at the end checks whether the value is NULL, and if it
> is not NULL, assigns it to skb->dev.
>
> The two flows are different. Mixing them in this function makes the code
> messy. It's better that we convert the second flow to align with how
> eth_type_trans does things.
>
> So this patch changes the code to: first make sure the pointer is not
> NULL, then assign it directly to skb->dev. "dev" is no longer needed until
> the end where we use it to update stats.

No need for dev at all then?
