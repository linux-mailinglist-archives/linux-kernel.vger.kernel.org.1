Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8C28E165
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgJNNfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgJNNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:35:36 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD805C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:35:35 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0D78322EDE;
        Wed, 14 Oct 2020 15:35:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1602682531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gpsfNCqmhyhWIb/6pHpsGSqKCr3UlLlzM0y+pf6sqk=;
        b=WLosOpIzq7HB5k1Tkxd1KhsjTQq52HzejjPwWBDtLGguxTBZlRm6mdnxFk5Z2CWwBRh4Ad
        Xgnrhdh/C1pXGKr1Ky9m0C2s92W5W41FjjwIPbBGf6tyU6533SmjVsmx6Hpj+4djWvIDLK
        y3HLlMQqgV8DG9XKIUVjmIKItRCOVK4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Oct 2020 15:35:30 +0200
From:   Michael Walle <michael@walle.cc>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: MFD_SL28CPLD should depends on ARCH_LAYERSCAPE
In-Reply-To: <20201014131216.21891-1-geert+renesas@glider.be>
References: <20201014131216.21891-1-geert+renesas@glider.be>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <62c44b17a47001e570d275c3e32aa2c4@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-10-14 15:12, schrieb Geert Uytterhoeven:
> Currently the Kontron sl28cpld Board Management Controller is found 
> only
> on Kontron boards equipped with a Freescale Layerscape SoC.  Hence add 
> a
> dependency on ARCH_LAYERSCAPE, to prevent asking the user about a 
> driver
> for this controller when configuring a kernel without Layerscape 
> support.
> 
> Fixes: a538ad229bbee4f8 ("mfd: simple-mfd-i2c: Add sl28cpld support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Michael Walle <michael@walle.cc>
