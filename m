Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6163427CDA9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgI2Mp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:45:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:64263 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbgI2Mpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:45:42 -0400
IronPort-SDR: yqnu7QATYepJ8OvXgYx1XtYC3TcdZBEbENXMSc/G8iAcuAmA+qjw7vwva4zDq/6GVe/CQrdvNL
 E07jWJrO8zbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="226326337"
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="226326337"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 05:45:39 -0700
IronPort-SDR: rZhR3i5skYFkZcM9FFfgas+U+VZ9dwCKWT248BkK49LNgGZa8irsoqJFwZlTdmerXWBtuY/y3N
 lq1j76NU3nbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="312203472"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 29 Sep 2020 05:45:34 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 29 Sep 2020 15:45:33 +0300
Date:   Tue, 29 Sep 2020 15:45:33 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     James Ausmus <james.ausmus@intel.com>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, matthew.d.roper@intel.com,
        jose.souza@intel.com, lucas.demarchi@intel.com,
        hariom.pandey@intel.com
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/i915/edp/jsl: Update vswing table
 for HBR and HBR2
Message-ID: <20200929124533.GX6112@intel.com>
References: <20200928080931.246347-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <20200928080931.246347-3-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <87a6xaow40.fsf@intel.com>
 <20200928141543.GG5197@jausmus-gentoo-dev6>
 <20200928150257.GW6112@intel.com>
 <87y2ktom10.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2ktom10.fsf@intel.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 08:20:59PM +0300, Jani Nikula wrote:
> On Mon, 28 Sep 2020, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> > On Mon, Sep 28, 2020 at 07:15:43AM -0700, James Ausmus wrote:
> >> On Mon, Sep 28, 2020 at 04:43:11PM +0300, Jani Nikula wrote:
> >> > On Mon, 28 Sep 2020, Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com> wrote:
> >> > > JSL has update in vswing table for eDP
> >> > 
> >> > I've thought the TLA for Jasper Lake is JSP, not JSL. At least we have
> >> > PCH_JSP for Jasper Lake PCH.
> >> 
> >> JSP == Point (the PCH), JSL == Lake
> >
> > .PT was "<something> Point", ..P stands just for "<something> PCH" IIRC.
> 
> Yeah, nowadays it doesn't have "Point", however bspec agrees on the JSL
> acronym for Jasper Lake.

Bspec uses ..P for "<platform> PCH", when it acknowledges the existence
of said PCH (see eg. CNP,ICP,TGP). JSP is not among that select crowd
however, neither really is MCC (although it is mentioned by name in the
JSL section).

I kinda want to nuke the JSP and MCC types entirely. I believe we should
be able to treat them as just ICP and TGP variants respectively. But
theres's still a bit of work left to do before we can get there.

-- 
Ville Syrjälä
Intel
