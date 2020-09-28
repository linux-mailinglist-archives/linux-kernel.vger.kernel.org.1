Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D5D27B7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgI1XPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:15:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:30710 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbgI1XOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:14:46 -0400
IronPort-SDR: eayjO9fC1DYqjeGB8m/ntb/tH1UZk5ZyOZErM4Q288iXryDCshcNFobk4ox07iQsoYWPULLHCb
 OG1ORKdmDmZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="180234029"
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="180234029"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 16:07:40 -0700
IronPort-SDR: 9XkV9aLbK1uAODE88byKKp4MRaliHvhMU2hA+PTmt3T8XPM+w0ywCelOZNty1UJdqIhZAm4dv8
 RTFYnpFF8n1g==
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="340597549"
Received: from pchilaka-mobl.amr.corp.intel.com (HELO ldmartin-desk1) ([10.212.247.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 16:07:39 -0700
Date:   Mon, 28 Sep 2020 16:07:39 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ausmus, James" <james.ausmus@intel.com>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        "Souza, Jose" <jose.souza@intel.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "Pandey, Hariom" <hariom.pandey@intel.com>
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/i915/edp/jsl: Update vswing table
 for HBR and HBR2
Message-ID: <20200928230739.vpj22bwebqhtehuk@ldmartin-desk1>
References: <20200928080931.246347-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <20200928080931.246347-3-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <87a6xaow40.fsf@intel.com>
 <SN6PR11MB3421725FE60CC7930FC02AB6DF350@SN6PR11MB3421.namprd11.prod.outlook.com>
 <871rilq0um.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <871rilq0um.fsf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 08:15:29PM +0300, Jani Nikula wrote:
>On Mon, 28 Sep 2020, "Surendrakumar Upadhyay, TejaskumarX"	<tejaskumarx.surendrakumar.upadhyay@intel.com> wrote:
>> This is a good example of a potential trap that having
>> IS_ELKHARTLAKE() cover both ELK and JSP creates. An unsuspecting coder
>> might change the if ladder to have IS_ELKHARTLAKE() first, and the
>> subsequent IS_JASPERLAKE() branch would never be taken.
>>
>> BR,
>> Jani.
>>
>> Tejas : In that case I will put attention note in comment about
>> platform checks such that ladder distrubance can be avoided. What you
>> suggest?

>The solution is to make IS_ELKHARTLAKE() mean ELK and only ELK.

Since we are talking about the TLA for JSL in the other patch, for
elkhartlake it is EHL, not ELK. ELK is something else, but I'm not sure
what:

$ git grep -w ELK -- drivers/gpu/drm/
drivers/gpu/drm/i915/gem/i915_gem_stolen.c:             IS_GM45(i915) ? "CTG" : "ELK", reg_val);
drivers/gpu/drm/i915/gem/i915_gem_stolen.c:      * Whether ILK really reuses the ELK register for this is unclear.
drivers/gpu/drm/i915/intel_pm.c:         * Not 100% sure which way ELK should go here as the
drivers/gpu/drm/i915/intel_pm.c:         * assume ELK doesn't need this.

Lucas De Marchi

>
>BR,
>Jani.
>
>
>-- 
>Jani Nikula, Intel Open Source Graphics Center
