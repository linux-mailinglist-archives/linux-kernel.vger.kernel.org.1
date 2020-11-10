Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5749C2AD3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbgKJK01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbgKJK01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:26:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82ACC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:26:26 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kcQr3-00005S-9h; Tue, 10 Nov 2020 11:26:25 +0100
Subject: Re: [PATCH v1] dt-bindings: arm: stm32: lxa,stm32mp157c-mc1: add
 extra SiP compatible
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201104113932.30702-1-a.fatoum@pengutronix.de>
 <20201109163733.GA1404197@bogus>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <decb0b4e-e6bf-98c5-df77-6b5f2405ae7f@pengutronix.de>
Date:   Tue, 10 Nov 2020 11:26:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201109163733.GA1404197@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 11/9/20 5:37 PM, Rob Herring wrote:
> On Wed, Nov 04, 2020 at 12:39:31PM +0100, Ahmad Fatoum wrote:
>> I know that bindings and device tree patches should be separate. Does
>> this apply here as well? Should I split the dts change into a follow-up
>> commit? 
> 
> Yes.
> 
>> Is it ok that dtbs_check will report an intermittent breakage?
> 
> If the binding comes first, it won't break.
> 
> But generally, 'dtbs_check' being warning free is not yet a requirement. 
> That will probably first have to be per platform.

here the old binding is deleted, so between the patches, there will be
a dtbs_check warning, which is why I asked. I've now split it up with
binding first.

>> +          - const: oct,stm32mp15xx-osd32
> 
> 'oct' is not docuemnted in vendor-prefixes.yaml.

Huh, I only checked whether it's in use, not if it's documented.
I just sent out a v2 with your points addressed.

Thanks for review,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
