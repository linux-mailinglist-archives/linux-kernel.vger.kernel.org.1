Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6D91AD073
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 21:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbgDPTi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 15:38:27 -0400
Received: from baldur.buserror.net ([165.227.176.147]:38538 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgDPTi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 15:38:27 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1jPAJ1-00077a-HA; Thu, 16 Apr 2020 14:36:11 -0500
Message-ID: <85bb4c9563377d2f76938ff1419ba34a5c825c0c.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Wang Wenhu <wenhu.wang@vivo.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@vivo.com,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Thu, 16 Apr 2020 14:36:09 -0500
In-Reply-To: <20200416063034.GB299193@kroah.com>
References: <20200415124929.GA3265842@kroah.com>
         <20200415152442.122873-1-wenhu.wang@vivo.com>
         <20200415152442.122873-6-wenhu.wang@vivo.com>
         <37b6b890-e537-7424-6b26-04565681f40a@c-s.fr>
         <f2a1f91f92c0fe4bce46c28222dea355d96e2090.camel@buserror.net>
         <20200416063034.GB299193@kroah.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, christophe.leroy@c-s.fr, wenhu.wang@vivo.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kernel@vivo.com, mpe@ellerman.id.au
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on baldur.localdomain
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  -15 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -1.5 GREYLIST_ISWHITE The incoming server has been whitelisted for
        *      this recipient and sender
Subject: Re: [PATCH v2,5/5] drivers: uio: new driver for fsl_85xx_cache_sram
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-16 at 08:30 +0200, Greg KH wrote:
> On Wed, Apr 15, 2020 at 02:27:51PM -0500, Scott Wood wrote:
> > > > +		dev_err(&pdev->dev, "error no valid uio-map
> > > > configured\n");
> > > > +		ret = -EINVAL;
> > > > +		goto err_info_free_internel;
> > > > +	}
> > > > +
> > > > +	info->version = "0.1.0";
> > > 
> > > Could you define some DRIVER_VERSION in the top of the file next to 
> > > DRIVER_NAME instead of hard coding in the middle on a function ?
> > 
> > That's what v1 had, and Greg KH said to remove it.  I'm guessing that he
> > thought it was the common-but-pointless practice of having the driver
> > print a
> > version number that never gets updated, rather than something the UIO API
> > (unfortunately, compared to a feature query interface) expects.  That
> > said,
> > I'm not sure what the value is of making it a macro since it should only
> > be
> > used once, that use is self documenting, it isn't tunable, etc.  Though if
> > this isn't a macro, UIO_NAME also shouldn't be (and if it is made a macro
> > again, it should be UIO_VERSION, not DRIVER_VERSION).
> > 
> > Does this really need a three-part version scheme?  What's wrong with a
> > version of "1", to be changed to "2" in the hopefully-unlikely event that
> > the
> > userspace API changes?  Assuming UIO is used for this at all, which
> > doesn't
> > seem like a great fit to me.
> 
> No driver version numbers at all please, they do not make any sense when
> the driver is included in the kernel tree.

Again, reporting a version string is part of the UIO API.  It might not be a
good API, but if it's left as NULL the registration will fail.

-Scott


