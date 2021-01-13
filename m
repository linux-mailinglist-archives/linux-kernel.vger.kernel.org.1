Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4482F4FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbhAMQVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:21:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbhAMQVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:21:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2AC42313C;
        Wed, 13 Jan 2021 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610554867;
        bh=6EdT+m3Wn2ychuGl919Mrdw++5SqBUU5ccd9n3RGfR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCG1qMd875U2d1SRx7d/smt0dA3i4Cp80FeYHJVmLiVdiN+kbvFVm8kiV2b+wxkpq
         eWy7zBNsQ6raWiuk3SQhrAnGYfHEQtjYi/9b13VkARlPDpizYx6tAZsWMg7IqRhmq5
         4+jdsP5a0z8oh0WXjn6ji14Rv4sWWyAU2z7oX50Y=
Date:   Wed, 13 Jan 2021 17:22:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/1] docs: submitting-patches: Emphasise the requirement
 to Cc: stable when using Fixes: tag
Message-ID: <X/8eNVSQo5SY2mQn@kroah.com>
References: <20210113142347.1263024-1-lee.jones@linaro.org>
 <X/8XUMW709ThubH1@kroah.com>
 <20210113160859.GE3975472@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113160859.GE3975472@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 04:08:59PM +0000, Lee Jones wrote:
> On Wed, 13 Jan 2021, Greg Kroah-Hartman wrote:
> 
> > On Wed, Jan 13, 2021 at 02:23:47PM +0000, Lee Jones wrote:
> > > Clear-up any confusion surrounding the Fixes: tag with regards to the
> > > need to Cc: the stable mailing list when submitting stable patch
> > > candidates.
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: linux-doc@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  Documentation/process/submitting-patches.rst | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> > > index 7c97ad580e7d0..636ef067c1565 100644
> > > --- a/Documentation/process/submitting-patches.rst
> > > +++ b/Documentation/process/submitting-patches.rst
> > > @@ -554,7 +554,8 @@ is used to make it easy to determine where a bug originated, which can help
> > >  review a bug fix. This tag also assists the stable kernel team in determining
> > >  which stable kernel versions should receive your fix. This is the preferred
> > >  method for indicating a bug fixed by the patch. See :ref:`describe_changes`
> > > -for more details.
> > > +for more details. Attaching a Fixes: tag does not replace the requirement to
> > > +Cc: stable@vger.kernel.org on all stable patch candidates.
> > 
> > Want to just link to the "stable kernel rules" document here to show
> > the proper way to do this is documented there?
> 
> I think this needs to be clearly stated here.
> 
> What if we linked to the rules document *as well*?

Sure, that works for me.

thanks,

greg k-h
