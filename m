Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E612904A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 14:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407161AbgJPMDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 08:03:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:39893 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407153AbgJPMDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:03:36 -0400
IronPort-SDR: PRnMcW93RnqSM3smdEImfNQUGk56W0TgARW31gleqI7TtNOeVnM+KbLWpfcBmoEVtOVNJ/+1yF
 ExZ2VUMCYrow==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="153506737"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="153506737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 05:03:34 -0700
IronPort-SDR: 5uNTqe4bYG6J69Pp1sWQmsPiQ5xfcoaWX+DglW63tlCAL5HqR1tfJFPMIUJftNDKS1cStgThvs
 1Uq2EQW1ArjQ==
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="531691673"
Received: from wpross-mobl1.ger.corp.intel.com (HELO [10.249.36.186]) ([10.249.36.186])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 05:03:32 -0700
Subject: Re: [PATCH v6 44/80] docs: gpu: i915.rst: Fix several C duplication
 warnings
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
 <52a0dd42d3730d35b3ecd00d20a0601793e443e6.1602589096.git.mchehab+huawei@kernel.org>
From:   Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. #1134945 - Pipers Way,
 Swindon SN3 1RJ
Message-ID: <da5ef3ca-e546-9d39-e033-27c3ed1b762e@intel.com>
Date:   Fri, 16 Oct 2020 15:03:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <52a0dd42d3730d35b3ecd00d20a0601793e443e6.1602589096.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2020 14:53, Mauro Carvalho Chehab wrote:
> As reported by Sphinx:
>
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:1147: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_oa_wait_unlocked'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:1169: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_oa_poll_wait'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:1189: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_oa_read'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:2669: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_oa_stream_enable'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:2734: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_oa_stream_disable'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:2820: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_oa_stream_init'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3010: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_read'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3098: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_poll_locked'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3129: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_poll'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3152: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_enable_locked'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3181: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_disable_locked'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3273: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_ioctl'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3296: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_destroy_locked'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3321: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_release'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3379: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_open_ioctl_locked'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3534: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'read_properties_unlocked'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3717: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_open_ioctl'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3760: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_register'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3789: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_unregister'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:4009: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_add_config_ioctl'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:4162: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_remove_config_ioctl'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:4260: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_init'.
> 	./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:4423: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
> 	Declaration is 'i915_perf_fini'.
>
> With Sphinx 3, C declarations can't be duplicated anymore,
> so let's exclude those from the other internals found on
> i915_perf.c file.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> ---
>   Documentation/gpu/i915.rst | 29 +++++++++++++++++++++++++----
>   1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
> index 33cc6ddf8f64..cff1f154b473 100644
> --- a/Documentation/gpu/i915.rst
> +++ b/Documentation/gpu/i915.rst
> @@ -636,15 +636,36 @@ i915 Perf Observation Architecture Stream
>   .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
>      :functions: i915_oa_poll_wait
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
>   specific details than found in the more high-level sections.
>   
>   .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
>      :internal:
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
>   Style
>   =====


