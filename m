Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938062B1D90
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKMOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:36:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53134 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgKMOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:36:09 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605278168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/7H7cJ5j1JFx9OGMmbYXMDayFBipc1Odzd7yUdm50eQ=;
        b=PvtncT+DBe+snL/saZY+J1T9Q3NG/FTcri0yCZCHiRMzeRegVVIAuy5lwbugFDgCy3H1xs
        DN/R4SFpSCrlCdXtjWAPkGyLh4bDQ2hh5NdUs21MIGoe2Svy0ZPG/piECCNYM1Dc3MW9Si
        Ozzgg4cuzMedVodJa1AUg0OBqHEtUWBUByTscdSKS7+vuSUlFQ/u/yWWDRzYHI2+Jf98kb
        Tm20U4B32eyJfS2h13hFL7FCKrtYOitnUhXIwLS9jnY85WPUuhc4BDKjcVPwmxz51BClJ+
        CMCzWuPiu0reZsavJEJQGX/FJ+IFU+VwhQK66Rm4FPzo9GgDqThUSJaJB493lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605278168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/7H7cJ5j1JFx9OGMmbYXMDayFBipc1Odzd7yUdm50eQ=;
        b=WrTh6JnTuXCGlQiWJQu2QtVRhUeab7lUfU1+4W28/LT8gg2CX5O1n/e8USHAOcqpo04T3U
        2Lz6Dj2wlYCb0HBw==
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list\:TENSILICA XTENSA PORT \(xtensa\)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] highmem: fix highmem for xtensa
In-Reply-To: <CAMo8BfKEr-89awEnV072uWR=4fniDRJ0drWmZrtnyvj-mANk0A@mail.gmail.com>
References: <20201113122328.22942-1-jcmvbkbc@gmail.com> <87zh3ll6hw.fsf@nanos.tec.linutronix.de> <CAMo8BfKEr-89awEnV072uWR=4fniDRJ0drWmZrtnyvj-mANk0A@mail.gmail.com>
Date:   Fri, 13 Nov 2020 15:36:07 +0100
Message-ID: <87sg9dl3xk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max,

On Fri, Nov 13 2020 at 05:50, Max Filippov wrote:
> On Fri, Nov 13, 2020 at 5:40 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Fri, Nov 13 2020 at 04:23, Max Filippov wrote:
>> > Fixmap on xtensa grows upwards, i.e. bigger fixmap entry index
>> > corresponds to a higher virtual address. This was lost in highmem
>> > generalization resulting in the following runtime warnings:
>>
>> Sorry for not noticing.
>>
>> > Fix it by adding __ARCH_HAS_POSITIVE_FIXMAP macro and implementing
>> > vaddr_in_fixmap and fixmap_pte primitives differently depending on
>> > whether it is defined or not.
>>
>> What's wrong with just doing the obvious and making the fixmap defines
>> the other way round?
>
> It becomes really awkward when we get to support high memory with
> aliasing data cache: we must think about the actual virtual addresses
> assigned to pages and it feels much simpler when it's done this way.

Feeling are not really a technical argument. Is there any functional
difference which matters?

Thanks,

        tglx
