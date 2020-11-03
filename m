Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AAB2A49F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgKCPdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgKCPdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:33:15 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498D820735;
        Tue,  3 Nov 2020 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604417594;
        bh=W571NPcDIE5ZXTV/zMmJykXxM0qZYlkoHanLbG2nw84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y5L54ijl1bqs8JZb6DcGz/lO1YgExP6G6NybEcPB+sixrb+cWycBsL9TswlWNukSi
         tLqeNWfqpLtPZG9m/Cuj96MhweqpAseCwLrhU4KtrmVFRKCHyu+RuoeY2gzCSeoJ6s
         /TKSJFxHuRliMLwfp9anZkiBE8ztwtSE/kizOM9Y=
Date:   Tue, 3 Nov 2020 16:34:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] drm/amdgpu: do not initialise global variables to 0 or
 NULL
Message-ID: <20201103153407.GB3267686@kroah.com>
References: <20201102184147.GA42288@localhost>
 <CADnq5_OnA3T_p4pTEOpoqQ=NZyso2VFoDiOHu=+h7dKOeKHq-A@mail.gmail.com>
 <c916ae88-5933-ab06-ad32-d87f00cac21f@gmail.com>
 <20201103065324.GD75930@kroah.com>
 <MN2PR12MB4488F91151FA17018306F92AF7110@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR12MB4488F91151FA17018306F92AF7110@MN2PR12MB4488.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 02:50:40PM +0000, Deucher, Alexander wrote:
> [AMD Public Use]
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, November 3, 2020 1:53 AM
> > To: Koenig, Christian <Christian.Koenig@amd.com>
> > Cc: Alex Deucher <alexdeucher@gmail.com>; Deepak R Varma
> > <mh12gx2825@gmail.com>; David Airlie <airlied@linux.ie>; LKML <linux-
> > kernel@vger.kernel.org>; Maling list - DRI developers <dri-
> > devel@lists.freedesktop.org>; Melissa Wen <melissa.srw@gmail.com>;
> > amd-gfx list <amd-gfx@lists.freedesktop.org>; Daniel Vetter
> > <daniel@ffwll.ch>; Daniel Vetter <daniel.vetter@ffwll.ch>; Deucher,
> > Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: do not initialise global variables to 0 or
> > NULL
> > 
> > On Mon, Nov 02, 2020 at 09:06:21PM +0100, Christian König wrote:
> > > Am 02.11.20 um 20:43 schrieb Alex Deucher:
> > > > On Mon, Nov 2, 2020 at 1:42 PM Deepak R Varma
> > <mh12gx2825@gmail.com> wrote:
> > > > > Initializing global variable to 0 or NULL is not necessary and
> > > > > should be avoided. Issue reported by checkpatch script as:
> > > > > ERROR: do not initialise globals to 0 (or NULL).
> > > > I agree that this is technically correct, but a lot of people don't
> > > > seem to know that so we get a lot of comments about this code for
> > > > the variables that are not explicitly set.  Seems less confusing to
> > > > initialize them even if it not necessary.  I don't have a
> > > > particularly strong opinion on it however.
> > >
> > > Agree with Alex.
> > >
> > > Especially for the module parameters we should have a explicit init
> > > value for documentation purposes, even when it is 0.
> > 
> > Why is this one tiny driver somehow special compared to the entire rest of
> > the kernel?  (hint, it isn't...)
> > 
> > Please follow the normal coding style rules, there's no reason to ignore them
> > unless you like to constantly reject patches like this that get sent to you.
> > 
> 
> I'll apply the patch, but as a data point, this is the first time I've
> gotten a patch to make this change.  I get several bug reports or
> patches every year to explicitly set values to global variables
> because users assume they are not initialized.  So it will always be a
> trade off as to which patches you want to NACK.

Are you all not running your patches through checkpatch.pl to tell you
simple things like this?  If no, I suggest you start doing that :)

thanks,

greg k-h
