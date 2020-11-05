Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340DB2A784D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgKEHvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:51:04 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:53821 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEHvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:51:03 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8CFC322EE3;
        Thu,  5 Nov 2020 08:51:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604562661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y9nYMNipFWE8sSkn1Vl8PkFScRN6z5TpxXpkMWetXpU=;
        b=EcKDtfv4J8/6mEv4+l/JnAIjw2EfFpGZbPhRTvUJxHMf/xSCy0jvF90Prq51i4SLhoWCBx
        o527QJDxBJ6k3M7cpXMX3bGoOFnSesN38eVWUdreIdKfvnWX8Yd1S6XTkKbhmIG8GJcADN
        HwxhyugtauPxeyIRfrrC8bngWYlKxog=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Nov 2020 08:50:59 +0100
From:   Michael Walle <michael@walle.cc>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] clk: fsl-sai: fix memory leak
In-Reply-To: <160453619129.3965362.7473462251338349415@swboyd.mtv.corp.google.com>
References: <20201101184818.2754-1-michael@walle.cc>
 <160453619129.3965362.7473462251338349415@swboyd.mtv.corp.google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <93b003ea4b80e0b6ec3eb63288e028eb@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-11-05 01:29, schrieb Stephen Boyd:
> Quoting Michael Walle (2020-11-01 10:48:18)
>> diff --git a/drivers/clk/clk-fsl-sai.c b/drivers/clk/clk-fsl-sai.c
>> index 0221180a4dd7..1e81c8d8a6fd 100644
>> --- a/drivers/clk/clk-fsl-sai.c
>> +++ b/drivers/clk/clk-fsl-sai.c
>> @@ -68,9 +68,20 @@ static int fsl_sai_clk_probe(struct platform_device 
>> *pdev)
>>         if (IS_ERR(hw))
>>                 return PTR_ERR(hw);
>> 
>> +       platform_set_drvdata(pdev, hw);
>> +
>>         return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, 
>> hw);
>>  }
>> 
>> +static int fsl_sai_clk_remove(struct platform_device *pdev)
>> +{
>> +       struct clk_hw *hw = platform_get_drvdata(pdev);
>> +
>> +       clk_hw_unregister_composite(hw);
> 
> Should we add a devm_clk_hw_register_composite() API and use it here?
> That way we don't need a remove function and devm can be used
> throughout.

Can do. But does adding a devm_ function qualify for the -stable branch?
Or should I expect to have exactly this patch as a backport there then?

-michael
