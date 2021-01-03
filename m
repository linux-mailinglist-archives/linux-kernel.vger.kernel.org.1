Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934A92E8C28
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 13:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbhACMoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 07:44:19 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:51113 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbhACMoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 07:44:18 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9ED1F580422;
        Sun,  3 Jan 2021 07:43:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 07:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=E
        QudM2IkgCNnrANuZ5EqosYh8eVwyuFNr39cKDL8pQI=; b=YbcPVeaR6FIG1ljHU
        ziUoqI+Y6pV6GNKSFNBVOYDertVRmgAdDeT0xOgvZP8hUssCSrWTvG0+lvYU36a+
        vhBqv2ozeG+JoRuwyo+aZYMXTXmBa5Pk/SVfx/4splQ/jZ1pgvxzDYWF4iEzeYHc
        N8WntfuLBOH8U08G+8nbNKsN8pFTXewtvjU6fG7q3M4M91E6lFMwoLBcewcIwbQM
        K5mJUNcJzS9wtAe4EhhJUhjUSLrbVqmZHRc9k28xu6VuH1bjinllsE50Adq4kNfh
        8s1t2nIe4rV2QJWMQjCk9cUdUExcJ+1DT9Lgg/XwyP+Eol2it3TJdKwNpeKc8D9G
        S0/UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=EQudM2IkgCNnrANuZ5EqosYh8eVwyuFNr39cKDL8p
        QI=; b=CwzpY95tW8/SM1wgieUitIwNOv3rfPQqkTkl5Y8T7IwXrywMX4V9Doabn
        lxXALtVax5EoIoDr628+oyVzx9mL3NQOQjdJfZVqsDLI2f2DH2+ITCzmUUi8/cns
        S4ynlbjT2x/D0UBZfxdBNlxv71tSHaCSK9fE15UP0T13rocbrUrrp7gYJIz3f3iO
        +kEhCxH8OBHIEef2N4f0aFTNgFh01IY1KCblXuXM7UJsTQceUfh+QftxVg3NoQTc
        sePwOuII3FcGXNcQf85Ua3g+euN+iTSxzjH0bUWi0ZdS4SjvrK5YmdIShA1DQf0s
        Nmb1epjYD5cRJ9I0lttkSgNoqZzww==
X-ME-Sender: <xms:87vxX2vDP2i_1i0ghcSB--vpQi59oh6CGH0TCtYezsAOTv3ZU0ssxA>
    <xme:87vxX7dyUuX0-tilg8SwHdN_olQ6WVDdT6JFcxtx9srIus8mCKVIUM13n4Uwg7cp6
    r1bihGtG8aa5JEpZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:87vxXxyaPyF6_WAjP7o-mHChN9tYNJ1xmBuLgGIn1mb3OQ7h12aL3Q>
    <xmx:87vxXxMyPeshUq0BEazhOm6PgKib3507ZjcvON6e2NhwmZ8ZCtrAaA>
    <xmx:87vxX28o0wMbapswVJqn4bXD1XQ7C_t2SAIhGtT82GFGIGxzav0jXg>
    <xmx:9LvxX320oCFQGxsqieVDBsXVfuHVYOCdMMHALClA-vMleWLH8nivbA>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9220A108005B;
        Sun,  3 Jan 2021 07:43:30 -0500 (EST)
Subject: Re: [PATCH v3 00/10] sunxi: Support IRQ wakeup from deep sleep
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210103103101.33603-1-samuel@sholland.org>
 <874kjykyg0.wl-maz@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <7d867708-c8c2-c248-46c9-eedfdf955408@sholland.org>
Date:   Sun, 3 Jan 2021 06:43:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <874kjykyg0.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/21 6:16 AM, Marc Zyngier wrote:
> [dropped linux-sunxi@googlegroups.com, which seems to be a closed ML]
> 
> On Sun, 03 Jan 2021 10:30:51 +0000,
> Samuel Holland <samuel@sholland.org> wrote:
>>
>> Allwinner sun6i/sun8i/sun50i SoCs (A31 and newer) have two interrupt
>> controllers: GIC and R_INTC. GIC does not support wakeup. R_INTC handles
>> the external NMI pin, and provides 32+ IRQs to the ARISC. The first 16
>> of these correspond 1:1 to a block of GIC IRQs starting with the NMI.
>> The last 13-16 multiplex the first (up to) 128 GIC SPIs.
>>
>> This series replaces the existing chained irqchip driver that could only
>> control the NMI, with a stacked irqchip driver that also provides wakeup
>> capability for those multiplexed SPI IRQs. The idea is to preconfigure
>> the ARISC's IRQ controller, and then the ARISC firmware knows to wake up
>> as soon as it receives an IRQ. It can also decide how deep it can
>> suspend based on the selected wakeup IRQs.
> 
> Out of curiosity, how do you plan to communicate dynamic configuration
> of IRQs to the ARISC? We recently went through this with some TI
> stuff, and the result a bit awkward (the arm64 side configures
> interrupts that are not visible to the kernel, but only to the
> co-processors).

Assuming by "dynamic" you mean while Linux is running, I don't plan to
communicate anything. As far as I'm concerned, the driver is feature-complete
after this patch series. The ARISC firmware does not use the interrupt
controller (or any other shared peripherals) while Linux is running. It sits in
a tight loop polling its side of the mailbox, waiting for a
hotplug/suspend/poweroff/reboot command.

> I wondered whether you had other ideas...

Sorry, I guess not. We tried to avoid using the ARISC for long enough that
anything that can have a native Linux driver has one. So the ARISC firmware has
nothing to do while Linux is running. (This is in comparison to the vendor BSP,
where some peripherals are only accessed through their firmware.)

Samuel

> Thanks,
> 
> 	M.
> 

