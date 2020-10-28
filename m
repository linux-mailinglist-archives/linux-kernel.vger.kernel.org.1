Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A914E29DF4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404023AbgJ2BAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731513AbgJ1WR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C328724797;
        Wed, 28 Oct 2020 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603896149;
        bh=q2VuirjQipFeCk6vMKPTQkByS8+2pDUDdvPQJahP3Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfoE8Wrgvgb9afpHW35evgTSo5OBKyoiDKUKEHe2SDglZt5Myn08zcSnY2BPOp0YP
         oJlittf1FKBQR/s1pNC91tTLItG+n/4O/t7KGpxKiyrfBr8LATj+QfOPV7Hb4AYFHk
         gDUoBpWmoch2u3j9znZhTWf20WjgMYgUuO8q5J0A=
Date:   Wed, 28 Oct 2020 15:43:21 +0100
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
Message-ID: <20201028144321.GA2302351@kroah.com>
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

In general, I like it.

If there's no complaints, I'd like to take all of the Documentation/ABI/
updates in for 5.10-rc2 at the least, to make it easier to build on top
of and to keep these types of mistakes from living longer than they
should be.  And make merging easier with other trees over time.

thanks,

greg k-h
