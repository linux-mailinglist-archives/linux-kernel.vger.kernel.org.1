Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD7F1AEA48
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 08:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgDRGrf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 18 Apr 2020 02:47:35 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:53233 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbgDRGrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 02:47:35 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20940213-1500050 
        for multiple; Sat, 18 Apr 2020 07:47:06 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200417160829.112776-1-colin.king@canonical.com>
References: <20200417160829.112776-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH][next] drm/i915: remove redundant assignment to variable test_result
To:     Colin King <colin.king@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Message-ID: <158719242529.2062.10865538071297156214@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Sat, 18 Apr 2020 07:47:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2020-04-17 17:08:29)
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable test_result is being initialized with a value that is
> never read and it is being updated later with a new value.  The
> initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index d4fcc9583869..55697c5e251a 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -5567,7 +5567,7 @@ void intel_dp_process_phy_request(struct intel_dp *intel_dp)
>  
>  static u8 intel_dp_autotest_phy_pattern(struct intel_dp *intel_dp)
>  {
> -       u8 test_result = DP_TEST_NAK;
> +       u8 test_result;
>  
>         test_result = intel_dp_prepare_phytest(intel_dp);

Yes, this is definitely being overwritten this time :)
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
