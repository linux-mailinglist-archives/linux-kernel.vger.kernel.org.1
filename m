Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A005F29DE8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390950AbgJ2AzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731643AbgJ1WRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:40 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 087402479D;
        Wed, 28 Oct 2020 14:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895925;
        bh=4Sd9H0iyDibm66VtOY/tpVPi01ikmzIRBw+3lZNBRkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KGaDEITLa8T0x4V05EzNRarwdt3hxDWgQN16RmuXdjF4BTMRJajQ15BfJiUQuWvRX
         bfgLI66sIN0EZ4e5bsVenI23KFXFIXacm5HLwS0ZkZEcZUkFJa32//fy0c8DRq6Uee
         gxnN2jsoqzmFbwr0eRv5CHpXSJPolbpj1y6kw8z0=
Date:   Wed, 28 Oct 2020 15:39:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Anton Vorontsov <anton@enomsg.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Benson Leung <bleung@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Colin Cross <ccross@android.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Richard Cochran <richardcochran@gmail.com>,
        Richard Gong <richard.gong@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Tony Luck <tony.luck@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH 00/33] ABI: add it to the documentation build system
Message-ID: <20201028143937.GA2302095@kroah.com>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603893146.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 03:22:58PM +0100, Mauro Carvalho Chehab wrote:
> Hi Greg,
> 
> As requested, this is a rebased version on the top of v5.10-rc1
> adding support for having the Linux ABI documentted inside
> the Linux admin manual.
> 
> When compared with the version I sent years ago, this
> version has:
> 
> - a logic to detect duplicated ABI symbols;
> - it auto-generate cross-reference markups for ABI symbols,
>   ABI files and .rst files;
> - Other files from 5.10-rc1 required adjustments in order
>   to be accepted by the script in rst-source mode;
> - Some bug fixes.
> 
> PS.: I didn't try to merge it against linux-next yet. So,
> I won't doubt that applying it could cause some conflicts.
> 
> Feel free to review it.

After applying the first 10 patches, and running it, I see a bunch of
these types of warnings:

Use of uninitialized value $kernelversion in substitution (s///) at ./scripts/get_abi.pl line 444.
Use of uninitialized value $users in substitution (s///) at ./scripts/get_abi.pl line 446.
Use of uninitialized value $users in substitution (s///) at ./scripts/get_abi.pl line 447.

When doing something like:
$ ./scripts/get_abi.pl search usb --dir Documentation/ABI/stable/

Is that expected?

thanks,

greg k-h
