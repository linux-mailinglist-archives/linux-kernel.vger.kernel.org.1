Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7FD27B793
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgI1XN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:13:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:43207 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgI1XN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:13:28 -0400
IronPort-SDR: oOcRo+Z6RighYYP/VKtkCLsBqZNFJf5YUz6pvL2+BDKdYnOMi60eh6ylqfx2pR1VYg1+TurTli
 kurwS+PPh0dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="161305096"
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="161305096"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 16:10:23 -0700
IronPort-SDR: jzzB2ktw+5o9UilhvKjWJ6uYd6yq1BpHpPLyEHNdX0M5ASEIiNL8oqeVQlfsxn+nq4yEki9aY6
 sNlJlaGid8LQ==
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="350003184"
Received: from mdroper-desk1.fm.intel.com (HELO mdroper-desk1.amr.corp.intel.com) ([10.1.27.168])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 16:10:23 -0700
Date:   Mon, 28 Sep 2020 16:10:22 -0700
From:   Matt Roper <matthew.d.roper@intel.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ausmus, James" <james.ausmus@intel.com>,
        "Souza, Jose" <jose.souza@intel.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "Pandey, Hariom" <hariom.pandey@intel.com>
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/i915/edp/jsl: Update vswing table
 for HBR and HBR2
Message-ID: <20200928231022.GF2157395@mdroper-desk1.amr.corp.intel.com>
References: <20200928080931.246347-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <20200928080931.246347-3-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <87a6xaow40.fsf@intel.com>
 <SN6PR11MB3421725FE60CC7930FC02AB6DF350@SN6PR11MB3421.namprd11.prod.outlook.com>
 <871rilq0um.fsf@intel.com>
 <20200928230739.vpj22bwebqhtehuk@ldmartin-desk1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928230739.vpj22bwebqhtehuk@ldmartin-desk1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 04:07:39PM -0700, Lucas De Marchi wrote:
> On Mon, Sep 28, 2020 at 08:15:29PM +0300, Jani Nikula wrote:
> > On Mon, 28 Sep 2020, "Surendrakumar Upadhyay, TejaskumarX"	<tejaskumarx.surendrakumar.upadhyay@intel.com> wrote:
> > > This is a good example of a potential trap that having
> > > IS_ELKHARTLAKE() cover both ELK and JSP creates. An unsuspecting coder
> > > might change the if ladder to have IS_ELKHARTLAKE() first, and the
> > > subsequent IS_JASPERLAKE() branch would never be taken.
> > > 
> > > BR,
> > > Jani.
> > > 
> > > Tejas : In that case I will put attention note in comment about
> > > platform checks such that ladder distrubance can be avoided. What you
> > > suggest?
> 
> > The solution is to make IS_ELKHARTLAKE() mean ELK and only ELK.
> 
> Since we are talking about the TLA for JSL in the other patch, for
> elkhartlake it is EHL, not ELK. ELK is something else, but I'm not sure
> what:
> 
> $ git grep -w ELK -- drivers/gpu/drm/
> drivers/gpu/drm/i915/gem/i915_gem_stolen.c:             IS_GM45(i915) ? "CTG" : "ELK", reg_val);
> drivers/gpu/drm/i915/gem/i915_gem_stolen.c:      * Whether ILK really reuses the ELK register for this is unclear.
> drivers/gpu/drm/i915/intel_pm.c:         * Not 100% sure which way ELK should go here as the
> drivers/gpu/drm/i915/intel_pm.c:         * assume ELK doesn't need this.

Yeah, ELK = Eagle Lake, CTG = Cantiga.  Both are old gen5 platforms IIRC.


Matt

> 
> Lucas De Marchi
> 
> > 
> > BR,
> > Jani.
> > 
> > 
> > -- 
> > Jani Nikula, Intel Open Source Graphics Center

-- 
Matt Roper
Graphics Software Engineer
VTT-OSGC Platform Enablement
Intel Corporation
(916) 356-2795
