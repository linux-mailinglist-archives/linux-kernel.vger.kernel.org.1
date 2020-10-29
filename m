Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5007829E6E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgJ2JHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ2JHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:07:37 -0400
Received: from coco.lan (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E64206D9;
        Thu, 29 Oct 2020 09:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603962456;
        bh=Gla487go1VrkmhiLWBVHX3FdQtKupPqvUz9Fe4VLBlw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E9tz59pEzlwn2SAmW0HovgPF33m/qtgLVhGRLFLo5Mkec9wlPtmF/oPqD7fNr9trZ
         GlCnF+ra0M41d7UBDnnj90bfNUUIY408OZk0K6CHeP41K3BYx4B2/9xnkQsEImpdE8
         S54iav4Sm1Sap+e+zNcQ16Aw7/AVCaIXGO0QnGx8=
Date:   Thu, 29 Oct 2020 10:07:21 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        Tony Luck <tony.luck@intel.com>, Wu Hao <hao.wu@intel.com>,
        Divya Bharathi <divya27392@gmail.com>,
        platform-driver-x86@vger.kernel.org,
        Divya Bharathi <divya.bharathi@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>
Subject: Re: [PATCH 00/33] ABI: add it to the documentation build system
Message-ID: <20201029100721.0fe83761@coco.lan>
In-Reply-To: <20201028144321.GA2302351@kroah.com>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
        <20201028144321.GA2302351@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 28 Oct 2020 15:43:21 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Wed, Oct 28, 2020 at 03:22:58PM +0100, Mauro Carvalho Chehab wrote:
> > Hi Greg,
> > 
> > As requested, this is a rebased version on the top of v5.10-rc1
> > adding support for having the Linux ABI documentted inside
> > the Linux admin manual.
> > 
> > When compared with the version I sent years ago, this
> > version has:
> > 
> > - a logic to detect duplicated ABI symbols;
> > - it auto-generate cross-reference markups for ABI symbols,
> >   ABI files and .rst files;
> > - Other files from 5.10-rc1 required adjustments in order
> >   to be accepted by the script in rst-source mode;
> > - Some bug fixes.
> > 
> > PS.: I didn't try to merge it against linux-next yet. So,
> > I won't doubt that applying it could cause some conflicts.
> > 
> > Feel free to review it.  
> 
> In general, I like it.
> 
> If there's no complaints, I'd like to take all of the Documentation/ABI/
> updates in for 5.10-rc2 at the least, to make it easier to build on top
> of and to keep these types of mistakes from living longer than they
> should be.  And make merging easier with other trees over time.

I rebased today on the top of linux-next. All patches applied as-is.

There's just a few new warnings due to a single patch, added via
platform-driver-x86:

	[PATCH v7] Introduce support for Systems Management Driver over WMI for Dell Systems

(plus, it generated a get_abi.pl warning, due to a description added there
without Description:)

The ReST warnings are:

	/devel/v4l/docs/Documentation/ABI/testing/sysfs-class-firmware-attributes:2: WARNING: Title underline too short.

	Dell specific class extensions
	--------------------------
	/devel/v4l/docs/Documentation/ABI/testing/sysfs-class-firmware-attributes:2: WARNING: Unexpected indentation.
	/devel/v4l/docs/Documentation/ABI/testing/sysfs-class-firmware-attributes:2: WARNING: Unexpected indentation.
	/devel/v4l/docs/Documentation/ABI/testing/sysfs-class-firmware-attributes:2: WARNING: Block quote ends without a blank line; unexpected unindent.
	/devel/v4l/docs/Documentation/ABI/testing/sysfs-class-firmware-attributes:173: WARNING: Unexpected indentation.
	/devel/v4l/docs/Documentation/ABI/testing/sysfs-class-firmware-attributes:173: WARNING: Unexpected indentation.
	/devel/v4l/docs/Documentation/ABI/testing/sysfs-class-firmware-attributes:173: WARNING: Block quote ends without a blank line; unexpected unindent.
	/devel/v4l/docs/Documentation/ABI/testing/sysfs-class-firmware-attributes:111: WARNING: Inline emphasis start-string without end-string.

Without looking at the file, from the warnings, I suspect
that adding a few blank before/after indented lines should be
enough to fix them.

I'll prepare a separate patch to the file author, fixing those,
to be merged via the platform-driver-x86 git tree.

Thanks,
Mauro
