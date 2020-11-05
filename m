Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7F62A799A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgKEIrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKEIrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:47:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588A8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 00:47:41 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kaavf-00083b-70; Thu, 05 Nov 2020 09:47:35 +0100
Subject: Re: [Linux-stm32] [BUG] Error applying setting, reverse things back
 on lot of devices
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     lgirdwood@gmail.com, mripard@kernel.org,
        linux-kernel@vger.kernel.org, wens@csie.org, broonie@kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel@lists.infradead.org
References: <20201021183149.GA8436@Red> <20201023134201.GA533@Red>
 <20201023203943.GA21435@Red> <20201024115307.GA2745@qmqm.qmqm.pl>
 <8a580d12-fa4a-6cd8-4d82-3e3b784e348b@pengutronix.de>
 <20201102202727.GA20042@qmqm.qmqm.pl>
 <124b90a8-72c7-c6cb-790f-7a22ef7510eb@pengutronix.de>
 <81490c3c-b27f-2280-3e4e-4319224fccea@st.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <373f9c99-caee-b18c-c5d9-4375a412ee5b@pengutronix.de>
Date:   Thu, 5 Nov 2020 09:47:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <81490c3c-b27f-2280-3e4e-4319224fccea@st.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alex,

On 11/4/20 11:50 AM, Alexandre Torgue wrote:
>> Boot up with v5.10-rc2 + your cf1ad559a2 + &pmic { regulators { vref_ddr-supply = <&reg_5v2>; }
> 
> Just to know, Did you test v5.10-rc2 + vref_ddr-supply = <&reg_5v2>; ? (which seems to correspond to the patch I sent for DK/EV STM32 boards)

I did yes, it masks the issue and allows the system to boot.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
