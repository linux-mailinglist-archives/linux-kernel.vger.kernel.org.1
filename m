Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF36D2CFEA2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 21:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgLEUA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 15:00:26 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:55968 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEUAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 15:00:25 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 560CA804C8;
        Sat,  5 Dec 2020 20:59:36 +0100 (CET)
Date:   Sat, 5 Dec 2020 20:59:35 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Chrisanthus, Anitha" <anitha.chrisanthus@intel.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "Dea, Edmund J" <edmund.j.dea@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        lkp <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/kmb: fix array bounds warning
Message-ID: <20201205195935.GJ332836@ravnborg.org>
References: <20201129200927.1854104-1-arnd@kernel.org>
 <BY5PR11MB4182B94E480EFACBF817DFFF8CF50@BY5PR11MB4182.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB4182B94E480EFACBF817DFFF8CF50@BY5PR11MB4182.namprd11.prod.outlook.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=7gkXJVJtAAAA:8
        a=e5mUnYsNAAAA:8 a=XabvsrOi_kiJB9eJBZMA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anitha,
On Mon, Nov 30, 2020 at 10:19:13PM +0000, Chrisanthus, Anitha wrote:
> Hi Arnd,
> Thanks for your patch.
> 
> > -----Original Message-----
> > From: Arnd Bergmann <arnd@kernel.org>
> > Sent: Sunday, November 29, 2020 12:09 PM
> > To: Chrisanthus, Anitha <anitha.chrisanthus@intel.com>; Dea, Edmund J
> > <edmund.j.dea@intel.com>; David Airlie <airlied@linux.ie>; Daniel Vetter
> > <daniel@ffwll.ch>; Sam Ravnborg <sam@ravnborg.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>; lkp <lkp@intel.com>; dri-
> > devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] drm/kmb: fix array bounds warning
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > gcc warns about an out-of-bounds access when the using nonzero
> > values for 'plane_id' on kmb->plane_status:
...

> Looks good.
> 
> Reviewed-by: Anitha Chrisanthus <anitha.chrisanthus@intel.com>

You wanted a little time to get comforable with dim, so I picked up this
patch and pushed it to drm-misc-next.

	Sam
