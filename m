Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC3D27BE04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgI2HaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:30:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:1576 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgI2HaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:30:15 -0400
IronPort-SDR: UwxE/3y0e3Y20HW5P009s5Hi/iJWNM4xWLYxopyuOVHaktvcmUMx3HngpTwjO6KUr69LkSARyl
 cHEbpXggajGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="141539332"
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="141539332"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 00:30:12 -0700
IronPort-SDR: kCpdJM79QM6ljb1NM5zqFnI2IByWgGBnuQ9BQLRacgDFF6XRelJeGoADijH5BH/wMpHOLvlL4n
 Zj5LH3ojEK3Q==
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="489216932"
Received: from dmcenean-mobl.ger.corp.intel.com (HELO localhost) ([10.252.31.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 00:30:08 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Matt Roper <matthew.d.roper@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     "Surendrakumar Upadhyay\, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        "airlied\@linux.ie" <airlied@linux.ie>,
        "daniel\@ffwll.ch" <daniel@ffwll.ch>,
        "intel-gfx\@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ausmus\, James" <james.ausmus@intel.com>,
        "Souza\, Jose" <jose.souza@intel.com>,
        "ville.syrjala\@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "Pandey\, Hariom" <hariom.pandey@intel.com>
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/i915/edp/jsl: Update vswing table for HBR and HBR2
In-Reply-To: <20200928231022.GF2157395@mdroper-desk1.amr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200928080931.246347-1-tejaskumarx.surendrakumar.upadhyay@intel.com> <20200928080931.246347-3-tejaskumarx.surendrakumar.upadhyay@intel.com> <87a6xaow40.fsf@intel.com> <SN6PR11MB3421725FE60CC7930FC02AB6DF350@SN6PR11MB3421.namprd11.prod.outlook.com> <871rilq0um.fsf@intel.com> <20200928230739.vpj22bwebqhtehuk@ldmartin-desk1> <20200928231022.GF2157395@mdroper-desk1.amr.corp.intel.com>
Date:   Tue, 29 Sep 2020 10:30:25 +0300
Message-ID: <87mu19nipa.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020, Matt Roper <matthew.d.roper@intel.com> wrote:
> On Mon, Sep 28, 2020 at 04:07:39PM -0700, Lucas De Marchi wrote:
>> On Mon, Sep 28, 2020 at 08:15:29PM +0300, Jani Nikula wrote:
>> > On Mon, 28 Sep 2020, "Surendrakumar Upadhyay, TejaskumarX"	<tejaskumarx.surendrakumar.upadhyay@intel.com> wrote:
>> > > This is a good example of a potential trap that having
>> > > IS_ELKHARTLAKE() cover both ELK and JSP creates. An unsuspecting coder
>> > > might change the if ladder to have IS_ELKHARTLAKE() first, and the
>> > > subsequent IS_JASPERLAKE() branch would never be taken.
>> > > 
>> > > BR,
>> > > Jani.
>> > > 
>> > > Tejas : In that case I will put attention note in comment about
>> > > platform checks such that ladder distrubance can be avoided. What you
>> > > suggest?
>> 
>> > The solution is to make IS_ELKHARTLAKE() mean ELK and only ELK.
>> 
>> Since we are talking about the TLA for JSL in the other patch, for
>> elkhartlake it is EHL, not ELK. ELK is something else, but I'm not sure
>> what:
>> 
>> $ git grep -w ELK -- drivers/gpu/drm/
>> drivers/gpu/drm/i915/gem/i915_gem_stolen.c:             IS_GM45(i915) ? "CTG" : "ELK", reg_val);
>> drivers/gpu/drm/i915/gem/i915_gem_stolen.c:      * Whether ILK really reuses the ELK register for this is unclear.
>> drivers/gpu/drm/i915/intel_pm.c:         * Not 100% sure which way ELK should go here as the
>> drivers/gpu/drm/i915/intel_pm.c:         * assume ELK doesn't need this.
>
> Yeah, ELK = Eagle Lake, CTG = Cantiga.  Both are old gen5 platforms IIRC.

Yeah, I know, my bad.

BR,
Jani.


>
>
> Matt
>
>> 
>> Lucas De Marchi
>> 
>> > 
>> > BR,
>> > Jani.
>> > 
>> > 
>> > -- 
>> > Jani Nikula, Intel Open Source Graphics Center

-- 
Jani Nikula, Intel Open Source Graphics Center
