Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C617E2AD56D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbgKJLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbgKJLin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:38:43 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CB4520659;
        Tue, 10 Nov 2020 11:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605008323;
        bh=qG//VPoZy9c9brd/95xrCB78I00JrSjZNxCU8gagNVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYescbww2rIt69r/e9MdSaA4naI0vpV2iBwa2YCcOlnxF+AUVJjZfh0wAlEGhyC/c
         J5ZoC77bNkH2RDODmY9nW4lxS6I3azAtRk2CACLEaT5PDyk/hFPXxz2czPXDRDnpOb
         EbT5+aXk4p8CdxJDOTXqlIZw4gcc0Wej2BeX+tMg=
Date:   Tue, 10 Nov 2020 12:39:38 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>, Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: Re: [PATCH v2 03/10] usb: cdns3: Moves reusable code to separate
 module
Message-ID: <X6p7+nXa/H4uqj0+@kroah.com>
References: <20201106114300.1245-1-pawell@cadence.com>
 <20201106114300.1245-4-pawell@cadence.com>
 <20201110090854.GB22481@b29397-desktop>
 <DM6PR07MB55294E87F6D76BA3C04E510ADDE90@DM6PR07MB5529.namprd07.prod.outlook.com>
 <20201110112054.GC22481@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110112054.GC22481@b29397-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:21:22AM +0000, Peter Chen wrote:
> On 20-11-10 09:20:54, Pawel Laszczak wrote:
> > Hi,
> > 
> > >>
> > >>  int cdns3_hw_role_switch(struct cdns3 *cdns);
> > >> -int cdns3_init(struct cdns3 *cdns);
> > >> -int cdns3_remove(struct cdns3 *cdns);
> > >> +extern int cdns3_init(struct cdns3 *cdns);
> > >> +extern int cdns3_remove(struct cdns3 *cdns);
> > >
> > >Why add "extern" here and below?
> > >
> > 
> > These functions are the API between cdnsp and cdns3 modules.
> > It's looks like a common approach in kernel.
> > Many or even most of API function in kernel has "extern". 
> > 
> 
> Even you have not written "extern" keyword, the "extern" is
> added implicitly by compiler. Usually, we use "extern" for variable
> or the function is defined at assembly. You could see some
> "extern" keyword use cases at include/linux/device.h.

We are moving away from using this keyword for functions now, if at all
possible please.  Only use it for variables, I think checkpatch now
catches it as well.

thanks,

greg k-h
