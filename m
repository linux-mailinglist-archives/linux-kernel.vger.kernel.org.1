Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4A42CCCC6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgLCCpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 21:45:21 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42647 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbgLCCpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:45:20 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9246858024A;
        Wed,  2 Dec 2020 21:44:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 02 Dec 2020 21:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=w
        +W9iSoo52ek703UN86yNavgaMJrE/oRl/AMe/FXqTw=; b=ElTXHPc6LnBBeo9vD
        vipkY5202XP+551jbgD/kzr/xb9NwHy8uMg1h14c2xFF4tXofYN2Ui5dtei/ccbN
        NR9tNAW9zl1KKCd6LEbDXLuH1lgGnK8Y1L3p+2xAG8b+74iu/1jK2Fu04ZTCJa8g
        WSSBL3pn2MpkAoys/LfHTmGCfNNyDfa17GgDLMfJ0J/kmyCeIK01xe0TYXNKVQfe
        Lnq3+t0aZy0JI2OTfa1BVJEQQdX50UBa3y8lCrPEi31vmsT2W2V02l1R8Jl9ofHw
        +d3D5FYaiLuzQk9xzNmAzBscEFqUxoMEEn/LNFsnd++qk1DX54kbDXav5/kwWeMg
        /GUyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=w+W9iSoo52ek703UN86yNavgaMJrE/oRl/AMe/FXq
        Tw=; b=j+K/uufc6RI4uR/Lxp+vZNRKTAGGq1AuPjZRk+qKqP2baYclsEVKwsfuq
        haEZHICM73k6UpjdmSfjCB2U83dgoUK1lIyPw0v7JCuU9+ajyLRFZt9XUiY9/LJ+
        mTJ+/sR6MeLrLlFvCkYkC1fF0ly0Z7HPMIz4nhlxtDWP47T//PYH98MwFKGnnItn
        JWnSTJ5g3pkKj5EFdqloWhWxURk4laO6PK/YawszMipc5V3XMuciy09fQRBPHQDw
        WaMaScE8YQwAXTQ07unynIUFb6uRwK5Xp9M77ce77EzjXPpGOz2szsk/7do6NN+o
        N8HKQCnto926znql+64A7ZFkft9kw==
X-ME-Sender: <xms:D1HIX1uBIPPxt_0bK1o_qbF9fws-Wv77GSm9yQqSr2Iq1SZtj4Uw9A>
    <xme:D1HIX-fx6CrpNf4vbsQkLAEOWHk2Y4sjOsa9ncq-EZbju4SSGwnZJs-M-4HmZDDRx
    kTpQK_nrGxiH0EDlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeihedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepuddvleffkeejhfduieelheejteehleefieeikefgteeugefhtdev
    keefvefgheeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepjedtrddufe
    ehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:D1HIX4zh2NgtSlcRYk_RoURBg6aMso978BZFYezK1XwsRWxrlY-VfQ>
    <xmx:D1HIX8M878gsPmttLro9Uv9yzo4926KV-0nEmrpU-PURO71eVw7VfA>
    <xmx:D1HIX1_Ve9jjgYLQqiLyXEGqJ9bpN8lHJ2A7pCYMkV-eeP5cfOlmtQ>
    <xmx:ElHIX4Vu_vAC6yc-71_H2BmRtdaDD8WEMDspfUoW24BZAx5CI5_FUw>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D5EB6240059;
        Wed,  2 Dec 2020 21:44:30 -0500 (EST)
Subject: Re: [PATCH 4/8] clk: sunxi-ng: Add support for the Allwinner H616
 R-CCU
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Yangtao Li <frank@allwinnertech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <20201202135409.13683-5-andre.przywara@arm.com> <3151878.LmPXbFMbMm@kista>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <55df8346-0330-4e7d-03ef-334622851a98@sholland.org>
Date:   Wed, 2 Dec 2020 20:44:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3151878.LmPXbFMbMm@kista>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/20 12:20 PM, Jernej Škrabec wrote:
>> +};
>> +
>> +static struct clk_hw_onecell_data sun50i_h616_r_hw_clks = {
>> +	.hws	= {
>> +		[CLK_R_AHB]		= &r_ahb_clk.hw,
>> +		[CLK_R_APB1]		= &r_apb1_clk.common.hw,
>> +		[CLK_R_APB2]		= &r_apb2_clk.common.hw,
>> +		[CLK_R_APB1_TWD]	= &r_apb1_twd_clk.common.hw,
> 
> Do we know if TWD exists? I tested I2C and IR. What is your source for these 
> clocks?

Looking at https://github.com/orangepi-xunlong/linux-orangepi and comparing
drivers/clk/sunxi/clk-sun50iw[69].h, I see:

 /* PRCM Register List */
 #define CPUS_CFG            0x0000
 #define CPUS_APBS1_CFG      0x000C
 #define CPUS_APBS2_CFG      0x0010
-#define CPUS_TIMER_GATE     0x011C
 #define CPUS_TWDOG_GATE     0x012C
-#define CPUS_PWM_GATE       0x013C
-#define CPUS_UART_GATE      0x018C
 #define CPUS_TWI_GATE       0x019C
 #define CPUS_RSB_GATE       0x01BC
 #define CPUS_CIR_CFG        0x01C0
 #define CPUS_CIR_GATE       0x01CC
 #define CPUS_OWC_CFG        0x01E0
 #define CPUS_OWC_GATE       0x01EC
 #define CPUS_RTC_GATE       0x020C
 #define CPUS_CLK_MAX_REG    0x020C

which suggests that TWD is still there, along with OWC/W1 and an undocumented
RSB controller like the one in H6. Jernej, can you check RSB? It should be
PL0/PL1 function 2 and MMIO base 0x7083000.

Cheers,
Samuel
