Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFE72F8144
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbhAOQx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:53:29 -0500
Received: from ms.lwn.net ([45.79.88.28]:36120 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbhAOQx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:53:28 -0500
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 280B8614D;
        Fri, 15 Jan 2021 16:52:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 280B8614D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610729568; bh=7VkGsCvR1km/mioSiHbHP45lykLsrwe8rUibzc6hfCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m/9gfY72TImnlsZPWNX6vggnVMXdpZ66zWenN3Xd/mzj5UaeGtC53kVwdwL9fL7X8
         OoJ48FIGRgpDMvKtnaax1lkArYPRAcSTkMh0nQrYoTutm9UFt8P05a94a5Y8nAzEAR
         JZJXpIcZlH526EPYYjSBFGzNsIHSid0d8BP6Kl8WJa0FApM74VPvknwsBSWOS+LeuX
         IReS+X6tIlNM/de8SjrGqnDY1JZsprKXpwTHjwfrBdjAIC7suKFMXT0HDkN8ULBFry
         utrGy+XPI2hiCrZYqmXrk/VwX6urPfnlsmY3P/nyn17zYoqi+v4iEKDucZVTMfblrn
         IfcvlBO6FyrcQ==
Date:   Fri, 15 Jan 2021 09:52:46 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
Subject: Re: Related work to MAINTAINERS truth and fiction
Message-ID: <20210115095246.653748af@lwn.net>
In-Reply-To: <CAKXUXMzj=LYJK74Le+rYnAaY3ji6AxugppwHwneAEL_xTTAyGw@mail.gmail.com>
References: <CAKXUXMzj=LYJK74Le+rYnAaY3ji6AxugppwHwneAEL_xTTAyGw@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 07:57:51 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Pia Eichinger has done some related analysis and work in this area as
> part of her bachelor's thesis on Maintainers Expectations vs.
> Maintainers Reality: An Analysis of Organisational and Maintenance
> Structure of the Linux Kernel. Simply quoting her conclusion:
> 
> "We showed that around 20% of all patches were theoretically wrongly
> integrated when strictly analysing MAINTAINERS. The reality of
> integration and maintenance structure is more complicated than that,
> which we also explored. Furthermore, we identified 12 major subsystems
> of the Linux kernel. This is very helpful for an overview of the
> organisational structure, realistic grouping of subsystems and further
> Linux kernel topology discussions."
> 
> Announcement and thesis here:
> https://lists.elisa.tech/g/devel/message/1269
> https://drive.google.com/file/d/12ta2YxgEzEfrIcmWid8kwIyVEywbUjbA/view?usp=sharing

Interesting, I was completely unaware of this work.  I blame Wolfgang, who
should have pointed it out to me :)

Thanks,

jon
