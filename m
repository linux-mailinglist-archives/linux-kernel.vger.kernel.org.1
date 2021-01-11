Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8092F1EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390846AbhAKTJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:09:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:32692 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387783AbhAKTJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:09:41 -0500
IronPort-SDR: YaTAsiO8gtI0hx4whvW/7A8ujJhGTBN/4ccsulz9+ngJUTXFh55zZLJ5ueLMYQTca3jW0njgVp
 QgLO3zhP40Kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="178014374"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="178014374"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 11:09:00 -0800
IronPort-SDR: x8OKXI5OZ6oXbRp5kghbmzTVfHgMf41WuozxTfXnORmeWBmzptdRz7p3ipEc1UQR4ZnnrT2eiR
 Ec/TvW8G+ZWw==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352713907"
Received: from libresli-mobl1.ger.corp.intel.com (HELO localhost) ([10.213.207.39])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 11:08:51 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc:     thaytan@noraisin.net, Vasily Khoruzhick <anarsoul@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Dave Airlie <airlied@redhat.com>,
        Sean Paul <seanpaul@chromium.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        =?utf-8?Q?Jos=C3=A9?= Roberto de Souza <jose.souza@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        "open list\:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] drm/dp: Revert "drm/dp: Introduce EDID-based quirks"
In-Reply-To: <87h7nnwauw.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210107225207.28091-1-lyude@redhat.com> <20210107225207.28091-5-lyude@redhat.com> <87h7nnwauw.fsf@intel.com>
Date:   Mon, 11 Jan 2021 21:08:48 +0200
Message-ID: <87eeirwatb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021, Jani Nikula <jani.nikula@intel.com> wrote:
> On Thu, 07 Jan 2021, Lyude Paul <lyude@redhat.com> wrote:
>> This reverts commit 0883ce8146ed6074c76399f4e70dbed788582e12. Originally
>> these quirks were added because of the issues with using the eDP
>> backlight interfaces on certain laptop panels, which made it impossible
>> to properly probe for DPCD backlight support without having a whitelist
>> for panels that we know have working VESA backlight control interfaces
>> over DPCD. As well, it should be noted it was impossible to use the
>> normal sink OUI for recognizing these panels as none of them actually
>> filled out their OUIs, hence needing to resort to checking EDIDs.
>>
>> At the time we weren't really sure why certain panels had issues with
>> DPCD backlight controls, but we eventually figured out that there was a
>> second interface that these problematic laptop panels actually did work
>> with and advertise properly: Intel's proprietary backlight interface for
>> HDR panels. So far the testing we've done hasn't brought any panels to
>> light that advertise this interface and don't support it properly, which
>> means we finally have a real solution to this problem.
>>
>> As a result, we now have no need for the force DPCD backlight quirk, and
>> furthermore this also removes the need for any kind of EDID quirk
>> checking in DRM. So, let's just revert it for now since we were the only
>> driver using this.
>>
>> v3:
>> * Rebase
>> v2:
>> * Fix indenting error picked up by checkpatch in
>>   intel_edp_init_connector()
>>
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>
> Still stands.

PS. You'll still need drm or drm-misc maintainer ack if you want to
merge this through drm-intel-next.

-- 
Jani Nikula, Intel Open Source Graphics Center
