Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC1C2A78C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgKEIUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbgKEIUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:20:07 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B3421741;
        Thu,  5 Nov 2020 08:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604564405;
        bh=OxEccTE3bfAnA1ohOXHTDixCffF7U2d/NKMnHdBEUPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BwOIWldtDEfpH4mV9CENSMvFbWehPOwfMD8Q/VJQ16do57HhPmuxUkkJ+jsQYV0Vn
         AiUegYbpE57bVOJc0oDRB4tfz01CLQIk8AL7Y7FHutABjuITCVklzzc9v/FPuCf9/v
         f6rnhRRcOpTVfqkrFbcP5xwq6iSTCxl/SScDX6kw=
Date:   Thu, 5 Nov 2020 09:20:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bernard <bernard@vivo.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com
Subject: Re: Re: Re: [PATCH 0/2] drivers/tty: delete break after return or
 goto
Message-ID: <20201105082054.GA3426404@kroah.com>
References: <20201104115903.GA1694605@kroah.com>
 <AFMA0AACDZrecE*lgOxkLqot.3.1604561695441.Hmail.bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AFMA0AACDZrecE*lgOxkLqot.3.1604561695441.Hmail.bernard@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 03:34:55PM +0800, Bernard wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Date: 2020-11-04 19:59:03
> To:  Bernard <bernard@vivo.com>
> Cc:  Jiri Slaby <jirislaby@kernel.org>,Shawn Guo <shawnguo@kernel.org>,Sascha Hauer <s.hauer@pengutronix.de>,Pengutronix Kernel Team <kernel@pengutronix.de>,Fabio Estevam <festevam@gmail.com>,NXP Linux Team <linux-imx@nxp.com>,linux-kernel@vger.kernel.org,linux-serial@vger.kernel.org,linux-arm-kernel@lists.infradead.org,opensource.kernel@vivo.com
> Subject: Re: Re: [PATCH 0/2] drivers/tty: delete break after return or goto>On Wed, Nov 04, 2020 at 07:17:56PM +0800, Bernard wrote:
> >> 
> >> 
> >> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Date: 2020-11-04 19:02:53
> >> To:  Bernard Zhao <bernard@vivo.com>
> >> Cc:  Jiri Slaby <jirislaby@kernel.org>,Shawn Guo <shawnguo@kernel.org>,Sascha Hauer <s.hauer@pengutronix.de>,Pengutronix Kernel Team <kernel@pengutronix.de>,Fabio Estevam <festevam@gmail.com>,NXP Linux Team <linux-imx@nxp.com>,linux-kernel@vger.kernel.org,linux-serial@vger.kernel.org,linux-arm-kernel@lists.infradead.org,opensource.kernel@vivo.com
> >> Subject: Re: [PATCH 0/2] drivers/tty: delete break after return or goto>On Wed, Nov 04, 2020 at 02:53:29AM -0800, Bernard Zhao wrote:
> >> >> This patch sereies optimise code like:
> >> >> {
> >> >> case XXX:
> >> >> 	return XXX;
> >> >> 	break; //The break is meanless, so just delete it.
> >> >> case YYY:
> >> >> 	goto YYY;
> >> >> 	break; //The break is meanless, so just delete it.
> >> >> ......
> >> >> }
> >> >> 
> >> >> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> >> >> 
> >> >> ---
> >> >> Bernard Zhao (2):
> >> >>   drivers/tty/nozomi.c: delete no use break after goto
> >> >>   drivers/tty/serial/imx.c: delete no use break after return
> >> >
> >> >That is not the subject of the patches you sent out, what broke?
> >> 
> >> Hi:
> >> 
> >> I am sorry that I am a little confused:
> >> The patch series`s subject is "drivers/tty: delete break after return or goto"
> >> and the blurb is:
> >> This patch sereies optimise code like:
> >> {
> >> case XXX:
> >> 	return XXX;
> >> 	break; //The break is meanless, so just delete it.
> >> case YYY:
> >> 	goto YYY;
> >> 	break; //The break is meanless, so just delete it.
> >> ......
> >> }
> >> last, the modified files are:
> >> Bernard Zhao (2):
> >>   drivers/tty/nozomi.c: delete no use break after goto
> >>   drivers/tty/serial/imx.c: delete no use break after return
> >> 
> >> Is there something wrong that I didn`t catch?
> >
> >The above lines do not match up with the subject lines of the patches
> >you sent out, so something went wrong.
> 
> 
> Hi, Greg:
> 
> Sorry to bother you.
> I am a newcomer to the community, and this is my first time submitting a patch series.

You might want to start in the drivers/staging/ part of the kernel to
get your bearings and work out these types of things.  It's "easier"
there as the code there needs lots of work and it's set up to handle new
developers like yourself.

> I am sorry that I still don't understand："The above lines do not match up with the subject lines of the patches you sent out, so something went wrong."
> I compared my patch series with other people`s patch series, as shown in the picture below, they look the seem.
> The only difference is that I made a signature here, so is this the issue that you mean?

the output of the git command that caused those lines to be written was
taken from the subject lines of the patches in your tree.  Yet the
subject lines of the patches you emailed us did not match that at all,
so what you sent is not what you actually had here when you generated
that cover letter.  So something went wrong with your process.

Try deleting all patch files in the directory and generating them again,
and then emailing the series to yourself to verify that everything
matches up properly.

hope this helps,

greg k-h
