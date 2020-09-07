Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F56E25FB7E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 15:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgIGNdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 09:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729503AbgIGNTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:19:36 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE268207C3;
        Mon,  7 Sep 2020 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599484717;
        bh=BKBAEsfKZS4E5QjfPye1MWvCwF5n9qQJ1ssxeiA8wKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wdUQiNLvADjY9FuVRehVsImJ44DgtFXxrELd+iJo0A+WUE9LY3OSKo9PUyuzgYe5l
         iyf3Yf3AnwILWJZ3I7pfv1zo8jcJ8qmJjbvrYAPkjG6IPrUrqviiTlNA6+yTw8nCR8
         j6/v7RGyYnuG1X7uws+rAW9GQnn2zaeeArc2Lvxs=
Date:   Mon, 7 Sep 2020 15:18:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH v2 1/2] LICENSE: add GFDL deprecated licenses
Message-ID: <20200907131851.GA2608040@kroah.com>
References: <cover.1598449136.git.mchehab+huawei@kernel.org>
 <a729c45bda6499e07112fc420015838ddd02557a.1598449136.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a729c45bda6499e07112fc420015838ddd02557a.1598449136.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 03:46:51PM +0200, Mauro Carvalho Chehab wrote:
> There are some files under Documentation which uses
> deprecated versions of GNU Free Documentation License, on
> both versions 1.1 and 1.2.
> 
> On all cases, the license is with no Invariant Sections,
> Front-Cover Texts or Back-Cover Texts.
> 
> Add the text file for them, as we'll start using SPDX
> for those.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  LICENSES/deprecated/GFDL-1.1 | 355 +++++++++++++++++++++++++++++++
>  LICENSES/deprecated/GFDL-1.2 | 397 +++++++++++++++++++++++++++++++++++
>  2 files changed, 752 insertions(+)
>  create mode 100644 LICENSES/deprecated/GFDL-1.1
>  create mode 100644 LICENSES/deprecated/GFDL-1.2
> 
> diff --git a/LICENSES/deprecated/GFDL-1.1 b/LICENSES/deprecated/GFDL-1.1
> new file mode 100644
> index 000000000000..a03f60403947
> --- /dev/null
> +++ b/LICENSES/deprecated/GFDL-1.1
> @@ -0,0 +1,355 @@
> +                GNU Free Documentation License
> +                   Version 1.1, March 2000

<snip>

Please follow the format of other licenses in the tree and add the
correct headers to them that include things like:
	Valid-License-Identifier
	SPDX_URL
	Usage-Guide

and other things like that so we can properly track these things.

thanks,

greg k-h
