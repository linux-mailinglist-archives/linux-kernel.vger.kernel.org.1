Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D252A079D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgJ3OQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgJ3OQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:16:03 -0400
Received: from coco.lan (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FDAF2076E;
        Fri, 30 Oct 2020 14:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604067363;
        bh=0brlscylgaQTxX0ekfO/xD5tY9Q8B9NUREgRnvRyJMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=np6IRWXPmN0gw/SGabp4bPAVfHdc+yyvXMxAphzV8HwenCqrpQk4jpe4zcAhy4Ate
         ZOxkatGkxXKVrI0cIl44o9uhCeukJQdGbJzAS4EXXSRAFV+YrAfbqLy8XNNMlY6gO9
         Am7XdF4/gd/GwqYbhQacUxlGK2hOLiWfVzlG0Mf8=
Date:   Fri, 30 Oct 2020 15:15:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        "=?UTF-8?B?TsOtY29s?= =?UTF-8?B?YXM=?= F. R. A. Prado" 
        <nfraprado@protonmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Subject: Re: Python 2.7 support and automarkup.py - Was: Re: [PATCH v2 1/5]
 docs: automarkup.py: Use new C roles in Sphinx 3
Message-ID: <20201030151558.65330bff@coco.lan>
In-Reply-To: <20201030081440.47a74dad@lwn.net>
References: <20201013231218.2750109-1-nfraprado@protonmail.com>
        <20201013231218.2750109-2-nfraprado@protonmail.com>
        <5053e824-625b-5a76-d862-2c855c79c427@collabora.com>
        <20201030151026.3afd7997@coco.lan>
        <20201030081440.47a74dad@lwn.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 30 Oct 2020 08:14:40 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Fri, 30 Oct 2020 15:10:26 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > I see a few alternatives:
> > 
> > 1) fix automarkup.py for it to work again with python 2.7;
> > 
> > 2) conf.py could gain some logic to disable automarkup with
> >    Python < 3;
> > 
> > 3) scripts/sphinx-pre-install already detects Python version. 
> >    It should likely be easy to ask the user to use python 3.x,
> >    if an older version is detected.
> > 
> > Doing (1) or (2) will require an additional step when we raise
> > the bar for Python version.  
> 
> We haven't dropped support for Python 2 yet, so this constitutes a
> regression.  My own approach would be something like this at the top of
> automarkup.py:
> 
> 	if python2:
> 	    ascii = 0
> 	else:
> 	    ascii = re.ASCII
> 
> ...then s/re.ASCII/ascii/ throughout.  I can probably put together
> something later this morning.

Makes sense.

> 
> jon



Thanks,
Mauro
