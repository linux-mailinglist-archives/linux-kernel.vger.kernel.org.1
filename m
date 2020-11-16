Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFE92B4CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbgKPR2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbgKPR2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:28:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86523C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:28:40 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1keiIx-0003MA-2L; Mon, 16 Nov 2020 18:28:39 +0100
Subject: Re: [PATCH v3 0/2] nvmem: skip nodes with compatibles other than
 "nvmem-cell"
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, ceggers@arri.de,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20200428111829.2215-1-a.fatoum@pengutronix.de>
 <20200512141834.GA3023@bogus>
 <f03ecee7-c4b6-7a59-7ab8-42c5dfcaffc4@pengutronix.de>
 <3f050e96-8bd3-a77e-b1cf-1739a1be0c2d@pengutronix.de>
 <adb40d7d-c5e9-19b7-a561-10c33a6cf8ab@pengutronix.de>
 <58738d86-7822-cd9f-6f05-6333d9251bf9@linaro.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <74673dd2-a49f-9b23-8470-dcec56b42efe@pengutronix.de>
Date:   Mon, 16 Nov 2020 18:28:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <58738d86-7822-cd9f-6f05-6333d9251bf9@linaro.org>
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

Hello Srini,

On 16.11.20 18:21, Srinivas Kandagatla wrote:
> 
> 
> On 16/11/2020 17:04, Ahmad Fatoum wrote:
>>>> To allow for co-existence of NVMEM cells and other subnodes, would following patch be
>>>> acceptable to you and Srini?
>>> Gentle ping. Would the patch below be acceptable?
>> Did you have time to look at this?
>>
> 
> I did reply back to this thread way back in June saying that
> 
> "Thanks for the patch, this looks good to me, lets wait for Rob to ack the bindings! "

Rob replied a day later saying that he would prefer it done otherwise.
What Rob suggested doesn't solve my actual issue, so I suggested another
solution a month ago. I have not yet received feedback on it, so that's
why I pinged:

https://lore.kernel.org/lkml/f03ecee7-c4b6-7a59-7ab8-42c5dfcaffc4@pengutronix.de/

> 
> 
> --srini
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
