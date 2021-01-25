Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB103028F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbhAYRcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731024AbhAYRcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:32:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07B0022ADF;
        Mon, 25 Jan 2021 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611595882;
        bh=tSl2j3Xo3oOZAF0XrbcXkB/VqG7UiW1dnFIFToLJEj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ffo+o3AS5PKnvgXeTFf9HOjinHsxjyuD1GCTIisNJYXNtmdDF6+t2JkMuwGTaUZi5
         uM+bQVCLy3tEQhx6QfIsQEjW6takV4e5kcgh5f3Rx9cC6etJd+3uM5odLMtasHrFDy
         dVlJ+Ret+dD9u6LLUT9BCeX5FAo0RFmAlS4WXZWDyUO1YXR5a77Fo3USn7ZK7Q4eI+
         zq42/1WcXheHa+Rur4IGR+AtvWUp4d/OhKS0PJCiRF/t5bT7ZLpSaNMYDQRBUIECOu
         GE7MjEHYbMi52/TlZjOgbqHUW2gKiXcU1x3bw/8luHeP+dO7Byj7tMFZ7ohmRV8fjR
         lYzKYhzv8Evtw==
Date:   Mon, 25 Jan 2021 19:31:19 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     corbet@lwn.net,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@protonmail.com>, Ben Widawsky <ben.widawsky@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: Make the description of return value readable
Message-ID: <YA8AZ/pOhts/DneP@kernel.org>
References: <20210125081905.145569-1-jarkko@kernel.org>
 <20210125105353.5c695d42@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125105353.5c695d42@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 10:53:53AM +0100, Mauro Carvalho Chehab wrote:
> Em Mon, 25 Jan 2021 10:19:04 +0200
> Jarkko Sakkinen <jarkko@kernel.org> escreveu:
> 
> > The description on how to describe return values is over-complicated, and
> > hard to follow. For alien reason, the body of the section is a note, and
> > the first paragraph speaks about 'Return', albeit the section name is
> > actually 'Return:'.
> > 
> > To give a better help when both implementing and reviewing patches, provide
> > a straight-forward guideline, how to decribe return values, instead of
> > providing a note that starts by "blacklisting" one of the infinite possible
> > options of doing it wrong.
> > 
> > This decreases the cumulative amount of time, which is probably
> > substantial, on this otherwise somewhat trivial topic.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  Documentation/doc-guide/kernel-doc.rst | 34 +++++++-------------------
> >  1 file changed, 9 insertions(+), 25 deletions(-)
> > 
> > diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
> > index 79aaa55d6bcf..dc5e1722c150 100644
> > --- a/Documentation/doc-guide/kernel-doc.rst
> > +++ b/Documentation/doc-guide/kernel-doc.rst
> > @@ -136,34 +136,18 @@ Examples::
> >  Return values
> >  ~~~~~~~~~~~~~
> >  
> > -The return value, if any, should be described in a dedicated section
> > -named ``Return``.
> > +The return value, if any, should be described in a dedicated section named
> > +``Return:``.
> >  
> > -.. note::
> > -
> > -  #) The multi-line descriptive text you provide does *not* recognize
> > -     line breaks, so if you try to format some text nicely, as in::
> > -
> > -	* Return:
> > -	* 0 - OK
> > -	* -EINVAL - invalid argument
> > -	* -ENOMEM - out of memory
> > -
> > -     this will all run together and produce::
> > -
> > -	Return: 0 - OK -EINVAL - invalid argument -ENOMEM - out of memory
> > -
> > -     So, in order to produce the desired line breaks, you need to use a
> > -     ReST list, e. g.::
> > +In order to describe multiple return values, a ReST list should be used. That
> > +way Sphinx knows how to line-up them properly::
> >  
> > -      * Return:
> > -      * * 0		- OK to runtime suspend the device
> > -      * * -EBUSY	- Device should not be runtime suspended
> > +  * Return:
> > +  * - 0:	The run-time is allowed to suspend the device.
> > +  * - -EBUSY:	Device should not be suspended.
> >  
> > -  #) If the descriptive text you provide has lines that begin with
> > -     some phrase followed by a colon, each of those phrases will be taken
> > -     as a new section heading, which probably won't produce the desired
> > -     effect.
> > +Using a dash rather than asterisk an is probably a better idea, because it does
> > +not meddle as much with the C-comments.
> 
> Well, there are different opinions with that regards... Some devs think that
> using:
> 
> 	- -EBUSY
> 
> is confusing. I ended agreeing with that. That's why the recommendation is
> to use an asterisk.

Maybe then whitelisting two options would be the way to move forward?

> Thanks,
> Mauro

/Jarkko
