Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8627B3BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgI1Rzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:55:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:57229 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgI1Rzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:55:31 -0400
IronPort-SDR: QBYgob4yh483EO3DdqkSSk0RVTLItTcfiLQRKYEbc2JCTqys6UjD1AboBS21FoQrvrYA0x+pl4
 CCoTdRDd73uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="159373386"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="159373386"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:32:26 -0700
IronPort-SDR: j8xoHDJJ45rGwOwoyZZF+HllFLLJ158Zya1dckhQLHFShb8AsHRsnJgHZ0XZbKAsPILnuPhSUL
 yTL6bLE1PmoA==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="488674823"
Received: from lizwalsh-mobl3.ger.corp.intel.com (HELO localhost) ([10.251.86.12])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:32:21 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Matt Roper <matthew.d.roper@intel.com>
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
        "De Marchi\, Lucas" <lucas.demarchi@intel.com>,
        "Pandey\, Hariom" <hariom.pandey@intel.com>
Subject: Re: [PATCH 1/2] drm/i915/jsl: Split EHL/JSL platform info and PCI ids
In-Reply-To: <20200928172447.GA2157395@mdroper-desk1.amr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200928080931.246347-1-tejaskumarx.surendrakumar.upadhyay@intel.com> <20200928080931.246347-2-tejaskumarx.surendrakumar.upadhyay@intel.com> <87d026owdq.fsf@intel.com> <SN6PR11MB3421571FA9A490C67E0E9D82DF350@SN6PR11MB3421.namprd11.prod.outlook.com> <874knhq0x1.fsf@intel.com> <20200928172447.GA2157395@mdroper-desk1.amr.corp.intel.com>
Date:   Mon, 28 Sep 2020 20:32:38 +0300
Message-ID: <87sgb1olhl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020, Matt Roper <matthew.d.roper@intel.com> wrote:
> Why are we adding IS_JASPERLAKE at all?  EHL/JSL are documented as the
> same graphics IP, but are paired with different PCHs in the final SoCs,
> which is what causes the minor differences in programming.  My
> understanding is that the voltage programming differences are ultimately
> due to that difference in PCH so we should just use HAS_PCH_MCC (EHL)
> and HAS_PCH_JSP (JSL) to distinguish which type of programming is needed
> rather than using a platform test.

Good point. If the difference is in the PCH, then of course the PCH
check should be used instead. Which avoids the problem altogether.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
