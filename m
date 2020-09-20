Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5208F271734
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgITSp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:45:29 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42017 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbgITSp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:45:29 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 14:45:28 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 12AC9580195;
        Sun, 20 Sep 2020 14:45:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 20 Sep 2020 14:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=U
        ktx1VRTJlKt926xOC0fJTdMwvcW/tqqviFWzSCgYTM=; b=rAQrhhB5BY0ozfCkJ
        ULTtKfgOS3lObtqJesEa7hjgZauSluJH9jNbISNOMO3zbDec68JUb5gZBeBOpok5
        m+9OAWwbJ+jfiMXM8DdSxxpFbnDtZX7H5mBhFPCWOg3SPbUBGuLMVgXbLLWUqlSi
        4oUigGIyYSul7rZXoxrx2t1mmg50ixyI+VX5MBEnDo5++2Ew/1y65jFYb/sMkjGx
        4Re53tg45uWn7be/XhNg6csizZBb+cvXfZ330fbWNX+PfUjqALaJif1tcU3/C9Gs
        V8r7cadIatj9uJRQ6XUdmhXYJtUUj5QeYQbi8zwlkKUuLfMqpZ556n+0COra6Mz7
        /7tsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Uktx1VRTJlKt926xOC0fJTdMwvcW/tqqviFWzSCgY
        TM=; b=AbCyfx6U/EbMMaPCWW1L77lTvD7DlIDa0Az2WEgvymv2ZaG96RfPHawTu
        WS4z/r/r19hSvIlclTboFKRiY6hy8R/0hUM9Z/T994jKm/GF5bAdfkQ4RVA+glbp
        vcsFZtxbEem/BAdBusZEoSGnQ7LMUllTlAYs9jLiCb1GtB/U3z8jgRVgkzExp7Hj
        uur7YrQhy0pnbBe1AyOBtC0HnfFauPD4WOC4kH5yJqNft38GQwX3rILolLrkdiij
        ON154Jscjw4AakZWff6WsEpBqomqgpy8QZnpj/QC/G7bf16t33PMokahpcZ/VI8Y
        3ydIJLbCGGub5YfsTxUmQ1yqp4nUQ==
X-ME-Sender: <xms:RqNnXwSI0Wrg8dfDYN4_sS3QU-0_62cUy31SVgAMDBEJwXLz2dZ5Zg>
    <xme:RqNnX9ydEN93faF_-710xV6VuUdqP6V1fJiAA4_uxVacTfwmox-_apY7Ef8Z3Kpfg
    7xtLWGKoBzc1FHO_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfelkeduveejtdejhfeiledvhfeggeeiieeklefhfeefffffffeg
    udetteelieejnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:R6NnX902Fy5EhF0jiUx3_Pl0HOoeA9_3WEGJyerJ-_8NP2iFAF6tfA>
    <xmx:R6NnX0BWzPk2KOx8Oh9NsQCn8idrKwokWSLrylMqMrQTCSRKu4jDOQ>
    <xmx:R6NnX5j9wTAF8rmwFN0dXZm0MetMKinuMIZyFkp0Z48pEnTnSMtfzQ>
    <xmx:SKNnXyZCTMzcRgmjMOOqgzJNPEPVkdOzn-SsTtg1jQcKIkNyZPwHpQ>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 63E06328005A;
        Sun, 20 Sep 2020 14:45:26 -0400 (EDT)
Subject: Re: [PATCH v3 05/19] ASoc: sun4i-i2s: Add 20 and 24 bit support
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200920180758.592217-1-peron.clem@gmail.com>
 <20200920180758.592217-6-peron.clem@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <2d2799c5-62e8-8e64-c739-3d85b89c1178@sholland.org>
Date:   Sun, 20 Sep 2020 13:45:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200920180758.592217-6-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/20 1:07 PM, Clément Péron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Extend the functionality of the driver to include support of 20 and
> 24 bits per sample.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
As I have mentioned before, if you want to support a 32-bit slot width on sun4i
variants (which patch 2 does via TDM and this patch does via PCM format), you
need to fix sun4i_i2s_get_wss() to return "3", not "4", for a 32-bit input.

Cheers,
Samuel
