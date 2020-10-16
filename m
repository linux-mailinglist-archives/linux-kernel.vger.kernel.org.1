Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CE42903B3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 13:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406734AbgJPLBP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Oct 2020 07:01:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:53219 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404564AbgJPLBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 07:01:14 -0400
IronPort-SDR: EHKVTUe2Lvwjyb2azGc6nSvTGpCOrTf98VeW8EmVglPwUugssOjiQN0J/EjltaSvjVi1PbUtwq
 SlXSRwyQDrLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="163110826"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="163110826"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 04:01:13 -0700
IronPort-SDR: /Q+mvagjsZ8zx4IQMSorTjsfTJ3IvnFocgJAJnyNwJv7u4EZKztOx7qp0pVPiB+Wb1RdEo59rB
 sBzGbcU8OUag==
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="522195618"
Received: from ssherida-mobl.ger.corp.intel.com (HELO localhost) ([10.251.83.218])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 04:01:09 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <52a0dd42d3730d35b3ecd00d20a0601793e443e6.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org> <52a0dd42d3730d35b3ecd00d20a0601793e443e6.1602589096.git.mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 44/80] docs: gpu: i915.rst: Fix several C duplication warnings
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <160284606673.11659.11178759979047002902@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Fri, 16 Oct 2020 14:01:07 +0300
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Lionel

Can you please take a look at best resolving the below problem.

Maybe we should eliminate the duplicate declarations? Updating such
a list manually seems error prone to me.

Regards, Joonas

Quoting Mauro Carvalho Chehab (2020-10-13 14:53:59)
> As reported by Sphinx:
> 
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:1147: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_oa_wait_unlocked'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:1169: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_oa_poll_wait'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:1189: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_oa_read'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:2669: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_oa_stream_enable'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:2734: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_oa_stream_disable'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:2820: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_oa_stream_init'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3010: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_read'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3098: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_poll_locked'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3129: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_poll'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3152: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_enable_locked'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3181: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_disable_locked'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3273: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_ioctl'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3296: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_destroy_locked'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3321: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_release'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3379: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_open_ioctl_locked'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3534: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'read_properties_unlocked'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3717: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_open_ioctl'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3760: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_register'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3789: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_unregister'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:4009: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_add_config_ioctl'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:4162: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_remove_config_ioctl'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:4260: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_init'.
>         ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:4423: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>         Declaration is 'i915_perf_fini'.
> 
> With Sphinx 3, C declarations can't be duplicated anymore,
> so let's exclude those from the other internals found on
> i915_perf.c file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/gpu/i915.rst | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
> index 33cc6ddf8f64..cff1f154b473 100644
> --- a/Documentation/gpu/i915.rst
> +++ b/Documentation/gpu/i915.rst
> @@ -636,15 +636,36 @@ i915 Perf Observation Architecture Stream
>  .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
>     :functions: i915_oa_poll_wait
>  
> -All i915 Perf Internals
> ------------------------
> +Other i915 Perf Internals
> +-------------------------
>  
> -This section simply includes all currently documented i915 perf internals, in
> -no particular order, but may include some more minor utilities or platform
> +This section simply includes all other currently documented i915 perf internals,
> +in no particular order, but may include some more minor utilities or platform
>  specific details than found in the more high-level sections.
>  
>  .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
>     :internal:
> +   :no-identifiers:
> +       i915_perf_init
> +       i915_perf_fini
> +       i915_perf_register
> +       i915_perf_unregister
> +       i915_perf_open_ioctl
> +       i915_perf_release
> +       i915_perf_add_config_ioctl
> +       i915_perf_remove_config_ioctl
> +       read_properties_unlocked
> +       i915_perf_open_ioctl_locked
> +       i915_perf_destroy_locked
> +       i915_perf_read i915_perf_ioctl
> +       i915_perf_enable_locked
> +       i915_perf_disable_locked
> +       i915_perf_poll i915_perf_poll_locked
> +       i915_oa_stream_init i915_oa_read
> +       i915_oa_stream_enable
> +       i915_oa_stream_disable
> +       i915_oa_wait_unlocked
> +       i915_oa_poll_wait
>  
>  Style
>  =====
> -- 
> 2.26.2
> 
