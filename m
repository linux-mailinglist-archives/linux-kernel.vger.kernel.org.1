Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBEC2AFC90
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgKLBjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgKLAlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:41:16 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E91FC0613D6;
        Wed, 11 Nov 2020 16:41:16 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c66so2901145pfa.4;
        Wed, 11 Nov 2020 16:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hy+K1YgnwFdKlAc0ui0j41XCZFbpulfNL4llqoUSukQ=;
        b=pSJiiSCQJBX1wSPW5tIs3qbjlpf4FlNsL99G/EMu5rAuxi1mu/4KZoFRgkbDtNrHsI
         QRwgpVnwEIhf82OJS8mi2eFIB6LuQ77aRGCI2E1DUr8t4xnh2/FilkFtn/+R5hTuP+Ub
         myio/ANiOAuhvAF+DLrIpVsljjnoXyF10s853krs1IJl2/JjcsQu+SZtOGdCjYjq/z/2
         vxIJV/iEzTC8bFjTKJmO9qc3FmGSzK72P2x/vF2gjV3ap49pMnkmEmp6hyix4EwzLJGI
         kom1bRANzZuIqo3Zlpr8fW3XUFg0j21iR+ON+3aAv87A68Vei645AHoeW1Pqk9ve/Wuc
         yYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hy+K1YgnwFdKlAc0ui0j41XCZFbpulfNL4llqoUSukQ=;
        b=XI5iWXuARQE3b+nzCl+NzgPTYhJHQdKRec3NBu+t78Z6sBPMVKzJ+vKNjpBVvzLGIt
         zvp+hAX70OLa1MdtXE97WVNMnFOX5y1QyRqz/mAdOb5P2Oje0kMPVjeK9UpCcZZAvt6V
         g5Lm36ED9HcY/MwTNjcL5/UGbIxVCOZH979XUBwez9/fhzEMlO5Jv+Pj0WmgY5zAWbMJ
         40IWD8eJFBdWZ46OHmAWin1li7gpGhZNi4FV62ytZQEH929oD7F6Fin7YNhPhTQNL+fx
         dGD5f8Y1JWFXbDvMXPcDBsMjSNBmZvI9zwlVOQHDacaFzBROOpJgXVF23jlrw9YQlu0D
         h8zw==
X-Gm-Message-State: AOAM53231zpFcpVelcPznQAB1nkejF6u6cVXZJMx8nHnCWjZbz/7GbaX
        g3XGQuGMzpiHImQqdLhVeoc=
X-Google-Smtp-Source: ABdhPJyYGAhwK1wvgbPRZygnqvGf9L9Av/xAFmTIIyPPx6DmFzEUVef1MpHBcTjgdqXAIi1iLGjVgQ==
X-Received: by 2002:aa7:908d:0:b029:15f:d774:584 with SMTP id i13-20020aa7908d0000b029015fd7740584mr167784pfa.6.1605141675790;
        Wed, 11 Nov 2020 16:41:15 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id b4sm3854232pfi.208.2020.11.11.16.41.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Nov 2020 16:41:15 -0800 (PST)
Date:   Wed, 11 Nov 2020 16:41:08 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: Add Facebook Galaxy100 BMC
Message-ID: <20201112004107.GA31289@taoren-ubuntu-R90MNF91>
References: <20201111232330.30843-1-rentao.bupt@gmail.com>
 <CACPK8XdC8FRKOLQ9e583gVuDrL5829MOfx5L=O68dou6mjW_6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XdC8FRKOLQ9e583gVuDrL5829MOfx5L=O68dou6mjW_6g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:34:10PM +0000, Joel Stanley wrote:
> On Wed, 11 Nov 2020 at 23:23, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > The patch series adds the initial version of device tree for Facebook
> > Galaxy100 (AST2400) BMC.
> >
> > Patch #1 adds common dtsi to minimize duplicated device entries across
> > Facebook Network AST2400 BMC device trees.
> >
> > Patch #2 simplfies Wedge40 device tree by using the common dtsi.
> >
> > Patch #3 simplfies Wedge100 device tree by using the common dtsi.
> >
> > Patch #4 adds the initial version of device tree for Facebook Galaxy100
> > BMC.
> 
> Nice. They look good to me.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks a lot for the quick review, Joel.

> Is there another person familiar with the design you would like to
> review before I merge?

Patrick Williams sometimes helps reviewing my patches although he doesn't
work on Network BMCs. Let me see if he has bandwidth this time :)


Cheers,

Tao
