Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC02D97DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438924AbgLNMHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:07:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbgLNMHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:07:51 -0500
Date:   Mon, 14 Dec 2020 13:08:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607947631;
        bh=SKeb8tUaCWmRkOkTs12ibMLd3qXoZtx157nLp1CXucg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zuar/vFW/027QMD+99KDUp5pH91011XJRlGtMHZEKlAkL3Opi5pIqzTDgc6WaZ59l
         m/qdQMXaDQAlWGE/BSc3CRmvV3k8LUJIlR+7qaUuYTkurW9yU2cLQdBnkgBXEzV3dD
         2mzebyt7E+lEg7SqhsbyXBiawNB0vHv3gLWss1qw=
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Pawel Laszczak' <pawell@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: Re: [PATCH] usb: cdns3: Fixes for sparse warnings
Message-ID: <X9dVsI5CDbXEyU/w@kroah.com>
References: <20201214110433.19461-1-pawell@cadence.com>
 <d232a54761a7473692976188aba0a5f6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d232a54761a7473692976188aba0a5f6@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 11:26:22AM +0000, David Laight wrote:
> From: Pawel Laszczak
> > Sent: 14 December 2020 11:05
> > 
> > Patch fixes the following warnings:
> ...
> > cdns3-ep0.c:367: sparse: warning: restricted __le16 degrades to integer
> ...
> > diff --git a/drivers/usb/cdns3/cdns3-ep0.c b/drivers/usb/cdns3/cdns3-ep0.c
> > index b0390fe9a396..9a17802275d5 100644
> > --- a/drivers/usb/cdns3/cdns3-ep0.c
> > +++ b/drivers/usb/cdns3/cdns3-ep0.c
> > @@ -364,7 +364,7 @@ static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
> >  	if (le16_to_cpu(ctrl->wValue) != USB_ENDPOINT_HALT)
> >  		return -EINVAL;
> > 
> > -	if (!(ctrl->wIndex & ~USB_DIR_IN))
> > +	if (!(le16_to_cpu(ctrl->wIndex) & ~USB_DIR_IN))
> >  		return 0;
> 
> It's generally best to byteswap the constant.

Why?  This is fine, it's better to operate on the value that needs to be
operated on.

greg k-h
