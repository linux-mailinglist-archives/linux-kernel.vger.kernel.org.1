Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F742BBC67
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 03:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgKUCvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 21:51:53 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:46931 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbgKUCvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 21:51:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 27AD810F3;
        Fri, 20 Nov 2020 21:51:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 20 Nov 2020 21:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=O
        u73bD4f45P9uvVKv0KtV27VfJnt6NKTFMndwelV6do=; b=MSULuAWfZNB+8eVnW
        c0xx2MQ5RRLIdgBFOuvrufrIxtG9MUmcyOsIwdHCxm5Rsnr+HeZI+nnuhYZq66+L
        Yg9hBUCXqRkCtvJqra9ntwKHI495kwMjpEWghgOkgpfi9rBursCrS/JP2IwITRnw
        5H8xg5Q0907S0hjxKpTczfX9XkI0Nm7qI8nMn+Ye0kLH3gqg/aGVwo2T+Kh+2OZP
        J7WC4+psb87PQGp1e7bBhhOlfEGaSvFkPeRm+AnDRNsF8rGMmtBVHl/CV5pNYbgd
        Y1Na3fabPWm15fZh2w6kZCi4rCdn4qd5n1gNg42ifFIZyVKQNyUddw77EQoW+mb8
        Aff5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Ou73bD4f45P9uvVKv0KtV27VfJnt6NKTFMndwelV6
        do=; b=sAVWfcR6RH9QwlyY1gQ81V2/VwA+G7J2mcB/ULi4dbRmqoFlPOwQ1j9nR
        CF6GsNpB8UnSyODJWtiNz4t76XrKG4nOnaDPCTyAOcBJ6QmgQvqTNU9IfcGQSO8B
        oOdpf/M3m1paqvxrUMiHSoQtsI70v2bv5Zron+nrk16KBha+rGc2C/jvUFa5m+lN
        lJ5aSRRyIY8kgyQRQWsFzUZMRsR/vnSvAKa3w2wZcH6Crwqw7M2imcMKPYIW20Zk
        eprdHf4lddcM343KvmzXbKlhYjPXJEkIClw3BJIkDdHYVFac4eDV139Ycf38mj8p
        /D6a9VjPC/uVc4XpWWcU7JKHGG8rA==
X-ME-Sender: <xms:xYC4X5rsOvCu_nflTYDQW0zoiU68-igeIG-7ayXxcZkcpB1NcT_xGg>
    <xme:xYC4X7o1lyuw3n2JnhlXUFOqOJLuMAHvlZKbyia2YRxtral9cO05p8dAch3PuZ5gq
    FZgMI9bt9qGv-eN2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeguddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdejieduudfgffevteekffegffeguddtgfefkeduvedukeff
    hedtfeevuedvnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:xYC4X2NUfzQZdkmirWQbP0UC-hnpYBTiIjdEdD5nrPNO6bLyGubxGQ>
    <xmx:xYC4X05ML6oA_h0V2XtWDiw__ocU8Rldcr4QWRf-1uKrbPnnxtK7TQ>
    <xmx:xYC4X45V3Szfn5SgkwN-5gv_UvTGOigFPoBxCVEX7_TJ61qrZbOLxw>
    <xmx:xoC4X1usBBY-OkFEQilIefiZqTX_-FDQ26WJl9xKtMradODZ_SpK9Q>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 723433280060;
        Fri, 20 Nov 2020 21:51:49 -0500 (EST)
To:     Icenowy Zheng <icenowy@aosc.io>, Maxime Ripard <maxime@cerno.tech>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20201107124958.2222253-1-icenowy@aosc.io>
 <20201107125332.2223197-1-icenowy@aosc.io>
 <20201110103925.rbej5ueo2fefbmlp@gilmour.lan>
 <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io>
 <20201116155508.364dg6ycklwylswe@gilmour.lan>
 <8FFC1A6C-9CA4-4F94-91C4-F111A7519979@aosc.io>
 <20201120155939.3ajmbny2pka2vsnf@gilmour>
 <A8E91BA0-22FD-47F4-A5B2-A80A38FE9A0E@aosc.io>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT
 for PineTab developer sample
Message-ID: <38ee5feb-e35d-801f-99a1-65e23618e73b@sholland.org>
Date:   Fri, 20 Nov 2020 20:51:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <A8E91BA0-22FD-47F4-A5B2-A80A38FE9A0E@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime,

On 11/20/20 5:30 PM, Icenowy Zheng wrote:
>>>>>>> +/ {
>>>>>>> +	model = "PineTab Developer Sample";
>>>>>>> +	compatible = "pine64,pinetab-dev", "allwinner,sun50i-a64";
>>>>>>> +};
>>>>>>
>>>>>> Changing the DT and the compatible half-way through it isn't ok. Please
>>>>>> add a new DT with the newer revision like we did for the pinephone
>>>>>
>>>>> We did this on Pine H64.
>>>>
>>>> What are you referring to? I couldn't find a commit where we did what
>>>> you suggested in that patch to the pine H64.
>>>
>>> Oh the situation is complex. On Pine H64, we didn't specify anything at
>>> start (which is the same here), the DT is originally version-neutral
>>> but then transitioned to model B, then reverted to model A. Here the DT is always
>>> for the sample.
>>>
>>> However, for Pine H64 there's model A/B names, but for PineTab there's no
>>> any samples that are sold, thus except who got the samples, all PineTab
>>> owners simply owns a "PineTab", not a "PineTab xxx version".
>>
>> It's fairly simple really, we can't really predict the future, so any DT
>> submitted is for the current version of whatever board there is. This is

I don't think that was the intention at all. The DT was submitted for a
future product, whatever that future product ends up being at the time
of its release. Since there are necessarily no users until the product
ships, there is no chance of breaking users by modifying the DT.

>> what we (somewhat messily) did for the PineH64, for the pinephone, or
>> really any other board that has several revisions

Surely a non-public prototype doesn't count as a separate revision! This
sort of policy strongly discourages ever shipping a board with
out-of-the-box mainline Linux support. Because if there any hardware
bugs fixed between initial upstreaming and production, the manufacture
must come up with a new DT name.

This is hostile to the users as well, because the "canonical" DT name no
longer matches the "canonical" (read: the only one ever available)
version of the hardware.

Do you want manufacturers to submit their initial board DT as
"$BOARD-prototype.dts", just in case they have to make a change before
production? And only after the board is shipped (with out-of-tree
patches, of course, to use $BOARD.dts, since the shipped board is *not*
the prototype) submit a "$BOARD.dts" to mainline?

Maxime, can you clarify specifically what the line is where a device
tree is "locked down" and further changes to the hardware require a new
name? First sample leaves the factory? $NUMBER units produced? First
sold to the public for money?

Without some guidance, or a change in policy, this problem is going to
keep coming up again and again.

You'll note that so far it has mostly affected Pine devices, and I don't
think that's because they make more board revisions than other
manufacturers. It's because they're actively involved in getting their
boards supported upstream. For other manufacturers, it's some user
sending in a device tree months after the hardware ships to the public
-- of course the hardware is more stable at that point. I think Pine's
behavior is something we want to encourage, not penalize.

> Okay. But I'm not satisfied with a non-public sample occupies
> the pinetab name. Is rename it to pinetab-dev and add a
> pinetab-retail okay?
To me, naming the production version anything but "pinetab" isn't
satisfying either.

Samuel
