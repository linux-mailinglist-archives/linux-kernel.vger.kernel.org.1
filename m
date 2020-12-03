Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC7C2CCD11
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 04:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgLCDK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 22:10:59 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:53835 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727392AbgLCDK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:10:59 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 495265802C9;
        Wed,  2 Dec 2020 22:10:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 02 Dec 2020 22:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=F
        SgQvZoglQetGYEJFgiWoedLNRJXBHY71to2V3053SQ=; b=kf+AoImueCgPccNgI
        qDb4cXuy61xaretU5H7dqYyi6wioypibLjvQX/Smwr97NS2B/EaKJvhAGZsgCoY8
        OF+QCFZlKT1A/ZUIL++gZVjnACpDzmJ2XIUd5pUz+z7KbRoyxmZuDlkqkiVPnxZd
        DXlvP5s3bwQZFAw/hCeNp/oq6c98IisPU2CdC2kBfSpUzZnTGcw6jvi8l8b9eyQY
        JhlmP+aZKSVks1qMsLAPKn6BwOdqTSaJMlrcgNAPpYJWDOUQ/YgK3MmYdJGdpjlV
        urE+J+VV1IRIcgXmldU/uU6ypvW/P+vjTpKv9mFZhR1RW/JOnR9Hj8TJyGVETK0E
        A70YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=FSgQvZoglQetGYEJFgiWoedLNRJXBHY71to2V3053
        SQ=; b=E2GoCYwyl1Ud6jZr+OdCpnxAPy773Z3xcN7UFL/bkHPkmmjatl4Yg//l0
        +w49uf2tw4NVD9OTfvgYUmVpz6jFeIXIvrszPV4tPZRjGWFlH9q8GLvDaRJRxFn/
        vvGnxBqhAraH1yZtrZqBr7amCu/OmV2fOnN0KSsJDEpBYp4TrgnvR+gTsA65zk1G
        VDuzVLbesZ7Pi1g/lHCHs2k3iV0fDT7T0DNA4U+LYbriNtp0JAADncZlF5So8Bn8
        vWCcjfY6DTsLARluCO36INm6Lrv/2MXzIZ+PGiisZQPYftFhihy/25PmxJW9Hfct
        bbVvIVTvhGRjXMI/0S5CacVezIwRA==
X-ME-Sender: <xms:ElfIX80H5W111qkFImCXUtwgGLlwcNZ0K_uzUETQAeisF30MceuOrQ>
    <xme:ElfIX65UN87bvj7KnEbGoprCThFeYHjGmugK9xv_KHlBqGc0-PxxOLcuMvRUSO7IS
    8m3K5bFmYQmmXP8Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeihedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:ElfIX9_BWMq_O6jlD3kJrM06Fy6l5p78kuhHLUGtrtxUvjV-gRoDbA>
    <xmx:ElfIX5VBZ3WXlcD_ch5wAHV_7Flj4sr-mOJeMKdzm9gUwlm5bHae1A>
    <xmx:ElfIX4rFp_skJavwk9OxGjaH9Ttt14gY5Tv7CJKAdpJVfO5LSCGsQw>
    <xmx:FVfIX8-IFRg8R42sUCLJpLJ9fFK3Q6Jztu2loupC139uOjvE_kzz8A>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 33343240066;
        Wed,  2 Dec 2020 22:10:10 -0500 (EST)
Subject: Re: [PATCH 7/8] arm64: dts: allwinner: Add Allwinner H616 .dtsi file
To:     Maxime Ripard <maxime@cerno.tech>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-arm-kernel@lists.infradead.org
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <20201202135409.13683-8-andre.przywara@arm.com>
 <20201202160504.klxbpqgagra4uxeh@gilmour>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <07e8d86e-0e1b-03d3-f43e-78e5bcbb53cc@sholland.org>
Date:   Wed, 2 Dec 2020 21:10:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201202160504.klxbpqgagra4uxeh@gilmour>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/20 10:05 AM, Maxime Ripard wrote:
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		arm,no-tick-in-suspend;
> 
> This was tested with crust I assume?

No, there is no AR100 and supposedly no SRAM A2, so there is no place for crust
to run. I assume it was copied from the H6 .dtsi.

However, regardless of where the PSCI implementation runs, even if it's on CPUX,
it will likely disable OSC24M to save power. So the counter will stop, and the
property is appropriate to add.

Cheers,
Samuel
