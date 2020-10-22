Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B112958EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508370AbgJVHRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508360AbgJVHRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:17:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CE84222E9;
        Thu, 22 Oct 2020 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603351037;
        bh=0uMgQw2LPxfnHIBnVz7lKSL+gAoez7EziK1x5BoBC2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIz+70xNJT0q0I78fc15yUpeXGHDyFknyRq3BoVSk4HgtkQDpUligIwGJi/tIHUXt
         ExX/ahCjYOym4iqjG5xqzJfluXxQWOpNHp0FHOkMFF3QhkIplGw0gNL90I39GVeEwu
         LXbhpbuBMgGxBXw2gK6aYQl8DbzViJ8hvUU7zJmY=
Date:   Thu, 22 Oct 2020 09:17:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <20201022071753.GA1470296@kroah.com>
References: <20201022061554.3418060-1-pmalani@chromium.org>
 <20201022065719.GA1440360@kroah.com>
 <CACeCKacvhtSfQ=hGYHi3AdrTT+XY2RpKmPHuYWoxNVmRWMeBBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKacvhtSfQ=hGYHi3AdrTT+XY2RpKmPHuYWoxNVmRWMeBBA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:13:54AM -0700, Prashant Malani wrote:
> Thanks for reviewing the patch, Greg.
> 
> On Wed, Oct 21, 2020 at 11:56 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Oct 21, 2020 at 11:15:54PM -0700, Prashant Malani wrote:
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> > > index b834671522d6..16440a236b66 100644
> > > --- a/Documentation/ABI/testing/sysfs-class-typec
> > > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > > @@ -170,6 +170,14 @@ Description:
> > >               will show 0 until Discover Identity command result becomes
> > >               available. The value can be polled.
> > >
> > > +What:                /sys/class/typec/<port>-partner/identity/product_type_vdo
> > > +Date:                October 2020
> > > +Contact:     Prashant Malani <pmalani@chromium.org>
> > > +Description:
> > > +             Product Type VDOs part of Discover Identity command result. 3 values
> > > +             are displayed (for the 3 possible Product Type VDOs), one per line.
> >
> > sysfs is "one value per file", not "one value per line".  This is not
> > ok.
> 
> I see. Would listing these out as three separate vdos (i.e vdo0, vdo1,
> vdo2) be better?

Given that your current implementation is not acceptable, something has
to change :)

thanks,

greg k-h
