Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782032A34ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgKBUKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgKBUJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:09:47 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D39120870;
        Mon,  2 Nov 2020 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604347786;
        bh=URXjsVEknTXcprxYlN0AN65VL/Q3nRcgZdYVADBLdzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V44X/eBh88ZcoQr0DgPwJTJa/lBENDAbD5oS9b0exdEEWilQIWEgQhwo5FTyLMMX2
         +3WXD0T6quL9vrn5IytNAeZ5GZoD1tuoXn+U1QA9xjXlHPo9XR5/Zm7je3nmxxB4f6
         MhwPXtf7y5xT4Pk/Zwh5sbZ28GuIxGEfNLe3S8G8=
Date:   Mon, 2 Nov 2020 21:10:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Deepak R Varma <mh12gx2825@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] drm/amdgpu: do not initialise global variables to 0 or
 NULL
Message-ID: <20201102201040.GA2433494@kroah.com>
References: <20201102184147.GA42288@localhost>
 <CADnq5_OnA3T_p4pTEOpoqQ=NZyso2VFoDiOHu=+h7dKOeKHq-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_OnA3T_p4pTEOpoqQ=NZyso2VFoDiOHu=+h7dKOeKHq-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 02:43:45PM -0500, Alex Deucher wrote:
> On Mon, Nov 2, 2020 at 1:42 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
> >
> > Initializing global variable to 0 or NULL is not necessary and should
> > be avoided. Issue reported by checkpatch script as:
> > ERROR: do not initialise globals to 0 (or NULL).
> 
> I agree that this is technically correct, but a lot of people don't
> seem to know that so we get a lot of comments about this code for the
> variables that are not explicitly set.  Seems less confusing to
> initialize them even if it not necessary.  I don't have a particularly
> strong opinion on it however.

The kernel coding style is to do it this way.  You even save space and
time by doing it as well :)

thanks,

greg k-h
