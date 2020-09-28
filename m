Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC0F27B2F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgI1RUu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 13:20:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:54176 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgI1RUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:20:50 -0400
IronPort-SDR: OwqeugjcitA5o68xSq0E7KGUW2TTXuS9Q5f0YCgSUWS6nDBZKTNpkj56PaYTpaFdTYsOVbNxdH
 VIjPDCVyGYbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="159371887"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="159371887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:20:46 -0700
IronPort-SDR: voJRqpdc2AfH6Aa0HSMWg0ANYk2vsOSyIXB36HXBI35k3qLOctHd1Yg3M784eaLtJq5jugJ4LO
 s0c1WaC4eh8A==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="488669860"
Received: from lizwalsh-mobl3.ger.corp.intel.com (HELO localhost) ([10.251.86.12])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:20:41 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        James Ausmus <james.ausmus@intel.com>
Cc:     Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, matthew.d.roper@intel.com,
        jose.souza@intel.com, lucas.demarchi@intel.com,
        hariom.pandey@intel.com
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/i915/edp/jsl: Update vswing table for HBR and HBR2
In-Reply-To: <20200928150257.GW6112@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200928080931.246347-1-tejaskumarx.surendrakumar.upadhyay@intel.com> <20200928080931.246347-3-tejaskumarx.surendrakumar.upadhyay@intel.com> <87a6xaow40.fsf@intel.com> <20200928141543.GG5197@jausmus-gentoo-dev6> <20200928150257.GW6112@intel.com>
Date:   Mon, 28 Sep 2020 20:20:59 +0300
Message-ID: <87y2ktom10.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> On Mon, Sep 28, 2020 at 07:15:43AM -0700, James Ausmus wrote:
>> On Mon, Sep 28, 2020 at 04:43:11PM +0300, Jani Nikula wrote:
>> > On Mon, 28 Sep 2020, Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com> wrote:
>> > > JSL has update in vswing table for eDP
>> > 
>> > I've thought the TLA for Jasper Lake is JSP, not JSL. At least we have
>> > PCH_JSP for Jasper Lake PCH.
>> 
>> JSP == Point (the PCH), JSL == Lake
>
> .PT was "<something> Point", ..P stands just for "<something> PCH" IIRC.

Yeah, nowadays it doesn't have "Point", however bspec agrees on the JSL
acronym for Jasper Lake.

Which means we should probably use PCH_JSL for Jasper Lake PCH as
well. Ugh.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
