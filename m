Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09FD27B07B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgI1PDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:03:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:58800 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgI1PDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:03:03 -0400
IronPort-SDR: CWBFj6TfR6rvPUMxb8+6MVWfuNC56UzeJ4arOcteWFNasn8hhTtZQf2jWmoY8McM92d1xZdSXe
 goILMwu134uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="246746993"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="246746993"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 08:03:02 -0700
IronPort-SDR: aLJzel/XmAtvgyLorNuAiOgfAeS8V5xtqe2C+9LuYOGKswvM4oGlwQnzhaCVMU8jKZUvTImmbI
 FjDW0zVYfp9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="311817505"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 28 Sep 2020 08:02:58 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 28 Sep 2020 18:02:57 +0300
Date:   Mon, 28 Sep 2020 18:02:57 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     James Ausmus <james.ausmus@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, matthew.d.roper@intel.com,
        jose.souza@intel.com, lucas.demarchi@intel.com,
        hariom.pandey@intel.com
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/i915/edp/jsl: Update vswing table
 for HBR and HBR2
Message-ID: <20200928150257.GW6112@intel.com>
References: <20200928080931.246347-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <20200928080931.246347-3-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <87a6xaow40.fsf@intel.com>
 <20200928141543.GG5197@jausmus-gentoo-dev6>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200928141543.GG5197@jausmus-gentoo-dev6>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 07:15:43AM -0700, James Ausmus wrote:
> On Mon, Sep 28, 2020 at 04:43:11PM +0300, Jani Nikula wrote:
> > On Mon, 28 Sep 2020, Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com> wrote:
> > > JSL has update in vswing table for eDP
> > 
> > I've thought the TLA for Jasper Lake is JSP, not JSL. At least we have
> > PCH_JSP for Jasper Lake PCH.
> 
> JSP == Point (the PCH), JSL == Lake

.PT was "<something> Point", ..P stands just for "<something> PCH" IIRC.

-- 
Ville Syrjälä
Intel
