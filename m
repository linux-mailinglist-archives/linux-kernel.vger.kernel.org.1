Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA22244A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 15:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgHNNfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 09:35:50 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:37176 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHNNfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1597412147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vhg2qIv0Jz5uNB1to7SsFv5hNsQzCGoy7ntsgX816ME=;
  b=U1CiDBcZk1odElv4SojTnBSGXwXPhBkaRZVZk/CoBW0ullto4znGBiGG
   uHsf5+yOe5TM4xt5+ykkaT0K0rYGhjo3bcvLQEVoSoqYxXBQbhyMw67JN
   3OBQzvUv8Tw+ohvEHxpm16tWiFRt7DnCHf2UeY5y3FeugHwP8L1o9Z+VU
   Y=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: 3kOFJD7N60ERtsB74qGJI3XB6PL0hrH37iAm0pbM5PNV/FQ6T6jmbeXASasblAXIeXQLqwqf0n
 B/Da4GKHV9G6vOYMwD44IXUGCJ3cYZz2PgjkPj0Fu8FehPYFdfIA/yqX5Wl/Wi5AdwnNtqOBNq
 40Ye7b7xVui+0ZvJub15TmF7cyPT3T+Bh7pUD91DG/xaiMgJ/3oxy9ZFN8COrkdaJsAjZEg4WX
 mmGqnJVZd3jJ/pY7wNa7/8pzAw/ZVX0QKpqU1zHC70psBGvrmWKbneBDww7mnmZg+X4dW6syS7
 mIA=
X-SBRS: 2.7
X-MesageID: 24880445
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,312,1592884800"; 
   d="scan'208";a="24880445"
Date:   Fri, 14 Aug 2020 15:35:36 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, Wei Liu <wl@xen.org>,
        "Yan Yankovskyi" <yyankovskyi@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <xen-devel@lists.xenproject.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 2/2] xen: add helpers to allocate unpopulated memory
Message-ID: <20200814133536.GL975@Air-de-Roger>
References: <20200811094447.31208-1-roger.pau@citrix.com>
 <20200811094447.31208-3-roger.pau@citrix.com>
 <20200813073337.GA16160@infradead.org>
 <20200813075420.GC975@Air-de-Roger>
 <20200814072920.GA6126@infradead.org>
 <20200814095629.GJ975@Air-de-Roger>
 <a907ff4a-c887-7d02-1d45-140d7749afa4@suse.com>
 <20200814124724.GK975@Air-de-Roger>
 <fc10d3a5-fe79-335e-353a-1bf480af7c7c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc10d3a5-fe79-335e-353a-1bf480af7c7c@suse.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 02:54:38PM +0200, Jürgen Groß wrote:
> On 14.08.20 14:47, Roger Pau Monné wrote:
> > On Fri, Aug 14, 2020 at 12:27:32PM +0200, Jürgen Groß wrote:
> > > On 14.08.20 11:56, Roger Pau Monné wrote:
> > > > On Fri, Aug 14, 2020 at 08:29:20AM +0100, Christoph Hellwig wrote:
> > > > > On Thu, Aug 13, 2020 at 09:54:20AM +0200, Roger Pau Monn?? wrote:
> > > > > > On Thu, Aug 13, 2020 at 08:33:37AM +0100, Christoph Hellwig wrote:
> > > > > > > On Tue, Aug 11, 2020 at 11:44:47AM +0200, Roger Pau Monne wrote:
> > > > > > > > If enabled (because ZONE_DEVICE is supported) the usage of the new
> > > > > > > > functionality untangles Xen balloon and RAM hotplug from the usage of
> > > > > > > > unpopulated physical memory ranges to map foreign pages, which is the
> > > > > > > > correct thing to do in order to avoid mappings of foreign pages depend
> > > > > > > > on memory hotplug.
> > > > > > > 
> > > > > > > So please just select ZONE_DEVICE if this is so much better rather
> > > > > > > than maintaining two variants.
> > > > > > 
> > > > > > We still need to other variant for Arm at least, so both need to be
> > > > > > maintained anyway, even if we force ZONE_DEVICE on x86.
> > > > > 
> > > > > Well, it still really helps reproducability if you stick to one
> > > > > implementation of x86.
> > > > > 
> > > > > The alternative would be an explicit config option to opt into it,
> > > > > but just getting a different implementation based on a random
> > > > > kernel option is strange.
> > > > 
> > > > Would adding something like the chunk below to the patch be OK?
> > > > 
> > > > ---8<---
> > > > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > > > index 018020b91baa..5f321a1319e6 100644
> > > > --- a/drivers/xen/Kconfig
> > > > +++ b/drivers/xen/Kconfig
> > > > @@ -328,7 +328,14 @@ config XEN_FRONT_PGDIR_SHBUF
> > > >    	tristate
> > > >    config XEN_UNPOPULATED_ALLOC
> > > > -	bool
> > > > -	default y if ZONE_DEVICE && !ARM && !ARM64
> > > > +	bool "Use unpopulated memory ranges for guest mappings"
> > > > +	depends on X86
> > > > +	select ZONE_DEVICE
> > > > +	default y
> > > 
> > > I'd rather use "default XEN_BACKEND" here, as mappings of other guest's
> > > memory is rarely used for non-backend guests.
> > 
> > There's also the privcmd and gnt devices which make heavy use of this,
> > so I'm not sure only selecting by default on XEN_BACKEND is the best
> > option.
> 
> I just want to avoid that kernels built for running as Xen guest, but
> not as dom0, will be forced to select ZONE_DEVICE.
> 
> As privcmd is dom0-only, this is no problem.

Oh, didn't know that, I somehow assumed privcmd would be available to
all Xen guests regardless of whether dom0 support was selected.

> In case you are worrying about gnt devices, I'd be fine to switch to
> 
> default XEN_BACKEND || XEN_GNTDEV

Sure. maybe even:

default XEN_BACKEND || XEN_GNTDEV || XEN_DOM0

Do you want me to resend with this changed or are you happy to fixup
if there are no further comments?

Thanks, Roger.
