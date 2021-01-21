Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24D82FECCA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbhAUOTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729755AbhAUOTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:19:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1BF3239EE;
        Thu, 21 Jan 2021 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611238704;
        bh=iHZmCfgCE5DMYwibpiRYlS9ExKJIU87VXIrkTuIKNkY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DORrOr8SB5+NAdAAUknQyiGXTPuLvDgJsjLcVG+tJD1WA/uMjImtRsVsbcydhI8iH
         U2o/+CLu2oczpm+rFQ3XptV0vzx2dq7XAYk60JD379rVHoyZv8qFJGJ00YHrsAeRxo
         sNng+WglD184bTAgathgK0ZMdbAA4p2dx02XKt9NiX0NKReUioZ7nPKiOMTxgTRHE5
         NVcJoCZ6sNf4jS+bfs7wWKpQJ6LtCGON0+jRADldux9uofHKGDlF7mDsOc0QdMH/CX
         qIJF44ovTgdIeoxt3PQF2Fde5YlWNqfRJHtT72Vs3zS/UOMpxwH8lQeIFYHndP7v2N
         BUiyVHemgvdkw==
Received: by mail-ej1-f46.google.com with SMTP id r12so2798899ejb.9;
        Thu, 21 Jan 2021 06:18:23 -0800 (PST)
X-Gm-Message-State: AOAM5310sbLuKihiYRXCQGweahpSgTc1Tta7cQp05I5lbOeJdTD6/2qg
        OfuWdd43RTh5HaCpm+oe0O1VCwRO/FM/aYiJtw==
X-Google-Smtp-Source: ABdhPJx4TK68KC3wwDUFgodvSUbxRGBlIwqIAoHuahg0TDvWYSAJ6OQpB3WAFwhKjs60p6epbftliklSpSFimjV6wiE=
X-Received: by 2002:a17:906:ce49:: with SMTP id se9mr9519806ejb.341.1611238702312;
 Thu, 21 Jan 2021 06:18:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611124778.git.viresh.kumar@linaro.org> <f63b3fd7fadf8912e8e7e8653df45b5b78f5d005.1611124778.git.viresh.kumar@linaro.org>
 <20210121004457.GD5174@yekko.fritz.box> <20210121041757.cskxlai5e7a2pfgb@vireshk-i7>
 <20210121062622.GI5174@yekko.fritz.box>
In-Reply-To: <20210121062622.GI5174@yekko.fritz.box>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 21 Jan 2021 08:18:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKy7xJ6MSUdE4dy=7WLz=V_NL=1x=5B4sxfeHDRPKy5Ag@mail.gmail.com>
Message-ID: <CAL_JsqKy7xJ6MSUdE4dy=7WLz=V_NL=1x=5B4sxfeHDRPKy5Ag@mail.gmail.com>
Subject: Re: [PATCH V5 3/5] scripts: dtc: Remove the unused fdtdump.c file
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bill Mills <bill.mills@linaro.org>,
        Anmar Oueja <anmar.oueja@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 12:43 AM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> On Thu, Jan 21, 2021 at 09:47:57AM +0530, Viresh Kumar wrote:
> > On 21-01-21, 11:44, David Gibson wrote:
> > > On Wed, Jan 20, 2021 at 12:36:45PM +0530, Viresh Kumar wrote:
> > > > This was copied from external DTC repository long back and isn't used
> > > > anymore. Over that the dtc tool can be used to generate the dts source
> > > > back from the dtb. Remove the unused fdtdump.c file.
> > > >
> > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >
> > > Doesn't this make updating the kernel dtc from upstream needlessly
> > > more difficult?
> >
> > Hmm, I am not sure I understand the concern well. The kernel keeps a
> > list of files[1] it needs to automatically copy (using a script) from
> > the upstream dtc repo and fdtdump.c was never part of that. Keeping it
> > there isn't going to make any difficulty I believe.
>
> Hm, ok.  Seems a bit clunky compared to embedding the whole directory,
> but whatever.

Either way, it's a list of what to keep or what to omit as we don't
want build files nor tests. If we were to take the whole thing, then
we should do a submodule, but so far no one wants submodules in the
kernel tree. There is a git subtree feature now that could do the same
thing as the script. But the script is good enough only needing small
tweaks occasionally, and anything else is work.

Rob
