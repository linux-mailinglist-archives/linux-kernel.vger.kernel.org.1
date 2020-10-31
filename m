Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CC62A172D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 13:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgJaMBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 08:01:11 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:40999 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726935AbgJaMBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 08:01:11 -0400
X-IronPort-AV: E=Sophos;i="5.77,437,1596492000"; 
   d="scan'208";a="475164141"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2020 13:01:08 +0100
Date:   Sat, 31 Oct 2020 13:01:08 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Alex Deucher <alexander.deucher@amd.com>,
        =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: Re: [Outreachy kernel] [PATCH] drm/amdgpu: use DEFINE_DEBUGFS_ATTRIBUTE
 with debugfs_create_file_unsafe()
In-Reply-To: <0b818156537f354904938f437cbb9dd02e765653.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2010311300530.2733@hadrien>
References: <20201030032245.GA274478@my--box>  <20201030071120.GA1493629@kroah.com> <20201030075716.GA6976@my--box>  <20201030080316.GA1612206@kroah.com> <0b818156537f354904938f437cbb9dd02e765653.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 31 Oct 2020, Joe Perches wrote:

> On Fri, 2020-10-30 at 09:03 +0100, Greg KH wrote:
> > On Fri, Oct 30, 2020 at 01:27:16PM +0530, Deepak R Varma wrote:
> > > On Fri, Oct 30, 2020 at 08:11:20AM +0100, Greg KH wrote:
> > > > On Fri, Oct 30, 2020 at 08:52:45AM +0530, Deepak R Varma wrote:
> > > > > Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
> > > > > function in place of the debugfs_create_file() function will make the
> > > > > file operation struct "reset" aware of the file's lifetime. Additional
> > > > > details here: https://lists.archive.carbon60.com/linux/kernel/2369498
> > > > >
> > > > > Issue reported by Coccinelle script:
> > > > > scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> []
> > There is a reason we didn't just do a global search/replace for this in
> > the kernel when the new functions were added, so I don't know why
> > checkpatch is now saying it must be done.
>
> I think it's not a checkpatch warning here.

That is correct, it's a coccinelle script.

julia

>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/0b818156537f354904938f437cbb9dd02e765653.camel%40perches.com.
>
