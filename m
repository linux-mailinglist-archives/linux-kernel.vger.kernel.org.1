Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5ED2A2C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKBOWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:22:24 -0500
Received: from mail2.sp2max.com.br ([138.185.4.9]:45338 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgKBOVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:21:21 -0500
Received: from [172.17.0.6] (37-247-245-190.fibertel.com.ar [190.245.247.37])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPSA id 30E1F7B04AC;
        Mon,  2 Nov 2020 11:21:16 -0300 (-03)
Subject: Re: [PATCH] ARM: dts: sun7i: bananapi: Enable RGMII RX/TX delay on
 Ethernet PHY
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1604190857-3078-1-git-send-email-pgreco@centosproject.org>
 <20201102140715.r72yz7jx3usuhqi7@gilmour.lan>
From:   =?UTF-8?Q?Pablo_Sebasti=c3=a1n_Greco?= <pgreco@centosproject.org>
Message-ID: <52413556-ec13-e428-7139-01d323697ebc@centosproject.org>
Date:   Mon, 2 Nov 2020 11:21:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201102140715.r72yz7jx3usuhqi7@gilmour.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: 30E1F7B04AC.A2654
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-2.901, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90, NICE_REPLY_A -0.00)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/11/20 11:07, Maxime Ripard wrote:
> Hi,
>
> On Sat, Oct 31, 2020 at 09:34:15PM -0300, Pablo Greco wrote:
>> The Ethernet PHY on the Bananapi M1 has the RX and TX delays enabled on
>> the PHY, using pull-ups on the RXDLY and TXDLY pins.
>>
>> Fix the phy-mode description to correct reflect this so that the
>> implementation doesn't reconfigure the delays incorrectly. This
>> happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
>> rx/tx delay config").
>>
>> Fixes: 8a5b272fbf44 ("ARM: dts: sun7i: Add Banana Pi board")
>> Signed-off-by: Pablo Greco <pgreco@centosproject.org>
> Thanks for sending those patches.
>
> However, I'm not entirely sure how you sent it but the odd threading you
> used (each other patches being in reply to this one without 0/N in the
> name) seem to confuse the tools we use to apply the patches.
>
> Can you resend it properly?
> Thanks!
> Maxime
I prepared them individually but sent them together in a single 
git-send-email, that must have been the problem.
I"ll send them again one by one.

Pablo.
