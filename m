Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E272DB6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgLOWt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:49:29 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34961 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730015AbgLOWtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:49:06 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F9265C0043;
        Tue, 15 Dec 2020 17:47:58 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Tue, 15 Dec 2020 17:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=QWzDvy6drK5slTeHs2rtc/DTIJ65yki
        vR5Tsxc+1DFI=; b=MXcvFzCLfwAyH3Lw6LehPx4X5BX7ctYKM8XVoHx8tHMaZTj
        FP1vr39w8LtlM2HIkpYmXlsGaZ0XpU3wbuutdM6FNaJc5aC+uoNldplUat685jeM
        DOHj3CW+nykIXuSnccUGfNWLOs4SUUoZEXtpFJINmcrgNQnBEHQcKUl5hh1/yNOp
        FSEanvh57wmqBhlWrO8+bDCAVqcPdMzJdW8Sa6zjhVE0jum/+tMLi5jJVh12TOxj
        DSCjdpOmhr50C5KYMlZTztX+6TY8DAQbRcpnNQ7mt5h9UosYJ2JKJ2JdRW71GITX
        e2Rz8EHjYw3ax/y49FvLvr+MVh+3hPqKK5IknCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=QWzDvy
        6drK5slTeHs2rtc/DTIJ65ykivR5Tsxc+1DFI=; b=b2m8f3Vjtzqu8X/XEbzq+0
        HmMV87aFW6WeQFE9tbZXMhxd8NG6NcMqvaE7dztb0w7vSPCHQ0Z4QhRSqPMplIUc
        maicbeHqdFxA49VEEnhdkSYlBJhEgx+jU9vZiJSJ7DxdMvq8YQ8OW8Y5QwQjfgAw
        wb4hkv0jcvmlCfPtLLPtedAG3aXxHUbq7t2wb+nuoTafMLdqcP4bnRFNofr+1yVe
        P0imvSsCeQ4BAp8YXN5nSssqaQrqRdGThACikQNbBX2ql7GXCuDAD5GDTBIP2RHl
        TE2S0/ZktXihYxo6cP7SADF1H+F9o4sGncczaGgmUJeDU/rU8AvLhSqlXUfwoA/Q
        ==
X-ME-Sender: <xms:HT3ZX7aNro-4wU3wDkCkJFE76CkjCxEwLz62YTO0p52slosxMUSkfQ>
    <xme:HT3ZX6b2YcD6NWfbvx79P2VKs-EnRrO_UpYj39x4lzdOy2gv3WOHf0SZ4o_Vqso9y
    gFvwZs6rYfuG95dSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeluddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:HT3ZX9-Atzm4CVQb1f6jHivdEBhJRZB9WWPruxvYH_lfajRtaIaNvw>
    <xmx:HT3ZXxqlYeVRsnLpVk5vG_QNnJtdPUkfoWtG5ICz7yE1asOirJ-mVg>
    <xmx:HT3ZX2psJGGzlbneb3VW5U-9LTqbqhIC5KpHUaksjdT10Q0mksMa_w>
    <xmx:Hj3ZX_lJn_UKAy5nC6MlUiDepiktkmzMyTmbuIqPb90ATNd7UqcHOw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9D6A9E0504; Tue, 15 Dec 2020 17:47:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.1-61-gb52c239-fm-20201210.001-gb52c2396
Mime-Version: 1.0
Message-Id: <0a513b26-a4e4-4808-a02a-eb6ffc84f5ba@www.fastmail.com>
In-Reply-To: <20201215192323.24359-2-hongweiz@ami.com>
References: <20201215192323.24359-1-hongweiz@ami.com>
 <20201215192323.24359-2-hongweiz@ami.com>
Date:   Wed, 16 Dec 2020 09:17:36 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Hongwei Zhang" <hongweiz@ami.com>, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        "Jakub Kicinski" <kuba@kernel.org>,
        "David Miller" <davem@davemloft.net>
Cc:     "Joel Stanley" <joel@jms.id.au>
Subject: =?UTF-8?Q?Re:_[Aspeed,ncsi-rx,_v1_1/1]_net:_ftgmac100:_Fix_AST2600_EVB_N?=
 =?UTF-8?Q?CSI_RX_issue?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Dec 2020, at 05:53, Hongwei Zhang wrote:
> Fix AST2600 EVB NCSI RX timeout issue by removing FTGMAC100_RXDES0_RX_ERR bit
> from macro RXDES0_ANY_ERROR.

But why? What is wrong with the EVB that this change resolves? Which revision 
of the EVB?

The change affects all designs using the MAC, not just the AST2600 EVB. Why is 
this patch an appropriate course of action? Can we not add a quirk targeting the
specific board (e.g. a devicetree property)?

Andrew
