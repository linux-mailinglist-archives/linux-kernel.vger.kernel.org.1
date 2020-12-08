Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33DC2D2DBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgLHPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:01:19 -0500
Received: from ms.lwn.net ([45.79.88.28]:60808 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbgLHPBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:01:18 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 176322AE;
        Tue,  8 Dec 2020 15:00:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 176322AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1607439638; bh=yCuzldZelk8kIjP+52qwYerratgcfI2Ank1fcr7J+Cw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MMPfIWQ72kZ4xHBSm6tILj5cZWVJQiCpiH23V28gjKsJM1YHV9iE0dDGQAtwdxKaQ
         0Tz7xMyOKBuvpnBkDHVxcLXck5YlCdgVUX/0fZQiWi7A1mKVYsAMUJPX/1dUY8bmE8
         CLlI0UdeiFfqyDjlCL6PSpaq6UtoUoY95cDwXd6iajw8bXUs4TJGptqV3pbKpMbDpF
         u2KrNuX13sFT27HK5oOggjb55sc9+LDQ4wrFGmSHubO9hvbUPcWB/8aiARNtAo7wv4
         pyqcoVtiQlI0Ll9V3vPxa6AJ6bYGAj3RL3WgSzn+1qZ9aJNl6udGmcERiqhQDMXrok
         k5upW2/iMN3BQ==
Date:   Tue, 8 Dec 2020 08:00:37 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ran Wang <gxndwr@outlook.com>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/zh_CN: Improve Cinese transolation quality.
Message-ID: <20201208080037.40543cdb@lwn.net>
In-Reply-To: <AT5PR8401MB096492D31BB7E602E1F45DC9CCCD0@AT5PR8401MB0964.NAMPRD84.PROD.OUTLOOK.COM>
References: <AT5PR8401MB096492D31BB7E602E1F45DC9CCCD0@AT5PR8401MB0964.NAMPRD84.PROD.OUTLOOK.COM>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Dec 2020 21:16:04 +0800
Ran Wang <gxndwr@outlook.com> wrote:

> Signed-off-by: Ran Wang <gxndwr@outlook.com>
> ---
> Change in v2:
>   - For 'cn_development_coding' part, change back to '是关于编码过程的'
> 
>  .../translations/zh_CN/process/1.Intro.rst    | 61 ++++++++++---------
>  1 file changed, 32 insertions(+), 29 deletions(-)

Thank you for working to improve the documentation!  Please, though,
include a changelog with your patch; what does "improve translation
quality" mean here?

Thanks,

jon
