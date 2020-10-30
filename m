Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BA92A0797
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgJ3OOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgJ3OOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:14:42 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1845C0613CF;
        Fri, 30 Oct 2020 07:14:42 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 30DE02E7;
        Fri, 30 Oct 2020 14:14:42 +0000 (UTC)
Date:   Fri, 30 Oct 2020 08:14:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        "=?UTF-8?B?TsOtY29s?= =?UTF-8?B?YXM=?= F. R. A. Prado" 
        <nfraprado@protonmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Subject: Re: Python 2.7 support and automarkup.py - Was: Re: [PATCH v2 1/5]
 docs: automarkup.py: Use new C roles in Sphinx 3
Message-ID: <20201030081440.47a74dad@lwn.net>
In-Reply-To: <20201030151026.3afd7997@coco.lan>
References: <20201013231218.2750109-1-nfraprado@protonmail.com>
        <20201013231218.2750109-2-nfraprado@protonmail.com>
        <5053e824-625b-5a76-d862-2c855c79c427@collabora.com>
        <20201030151026.3afd7997@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 15:10:26 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> I see a few alternatives:
> 
> 1) fix automarkup.py for it to work again with python 2.7;
> 
> 2) conf.py could gain some logic to disable automarkup with
>    Python < 3;
> 
> 3) scripts/sphinx-pre-install already detects Python version. 
>    It should likely be easy to ask the user to use python 3.x,
>    if an older version is detected.
> 
> Doing (1) or (2) will require an additional step when we raise
> the bar for Python version.

We haven't dropped support for Python 2 yet, so this constitutes a
regression.  My own approach would be something like this at the top of
automarkup.py:

	if python2:
	    ascii = 0
	else:
	    ascii = re.ASCII

...then s/re.ASCII/ascii/ throughout.  I can probably put together
something later this morning.

jon
