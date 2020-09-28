Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8794527B2E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgI1RPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:15:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:13271 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgI1RPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:15:20 -0400
IronPort-SDR: HqwWAVapywKR7mw3lkEKXvlFP72pCx9542pRneHSCwP39NxIroKFti5LJ5q+lNZzqnBYz6NdtJ
 lHSmAQNDkzCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="161258609"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="161258609"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:15:17 -0700
IronPort-SDR: sdwvITrZwIodaSl3A6uuocAozDR0/EXh0gkaRVGOgxYVobRJFQGzIM/fU9bE8PaJdxtkLclvpe
 Ra48h5Rv71UA==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="338261563"
Received: from lizwalsh-mobl3.ger.corp.intel.com (HELO localhost) ([10.251.86.12])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:15:12 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Surendrakumar Upadhyay\, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        "airlied\@linux.ie" <airlied@linux.ie>,
        "daniel\@ffwll.ch" <daniel@ffwll.ch>,
        "intel-gfx\@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ausmus\, James" <james.ausmus@intel.com>,
        "Roper\, Matthew D" <matthew.d.roper@intel.com>,
        "Souza\, Jose" <jose.souza@intel.com>,
        "ville.syrjala\@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "De Marchi\, Lucas" <lucas.demarchi@intel.com>,
        "Pandey\, Hariom" <hariom.pandey@intel.com>
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/i915/edp/jsl: Update vswing table for HBR and HBR2
In-Reply-To: <SN6PR11MB3421725FE60CC7930FC02AB6DF350@SN6PR11MB3421.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200928080931.246347-1-tejaskumarx.surendrakumar.upadhyay@intel.com> <20200928080931.246347-3-tejaskumarx.surendrakumar.upadhyay@intel.com> <87a6xaow40.fsf@intel.com> <SN6PR11MB3421725FE60CC7930FC02AB6DF350@SN6PR11MB3421.namprd11.prod.outlook.com>
Date:   Mon, 28 Sep 2020 20:15:29 +0300
Message-ID: <871rilq0um.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020, "Surendrakumar Upadhyay, TejaskumarX"	<tejaskumarx.surendrakumar.upadhyay@intel.com> wrote:
> This is a good example of a potential trap that having
> IS_ELKHARTLAKE() cover both ELK and JSP creates. An unsuspecting coder
> might change the if ladder to have IS_ELKHARTLAKE() first, and the
> subsequent IS_JASPERLAKE() branch would never be taken.
>
> BR,
> Jani.
>
> Tejas : In that case I will put attention note in comment about
> platform checks such that ladder distrubance can be avoided. What you
> suggest?

The solution is to make IS_ELKHARTLAKE() mean ELK and only ELK.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
