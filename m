Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5666F2747EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIVSBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgIVSBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600797711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2aaSAULK36kdpoACQDdwALZmwQc4G3xRYKl1sR2GSU=;
        b=isvyS9vSmUmN9kF23zvsaL4DtLBJx3pDCpEAIPQv8pOt3J4y052MeGgN2HnE7j6j5SzhCH
        bHT2SW27y3xnrCE2W2szPeIV9/FehzrGgdq5Z1ii59W6L9GWXbzm3fCEvSOlUjiefLOFj+
        z8qxb6DqqCVcBOtIsqWT2hFImJrMM20=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-gn5GxlKmOz25EkMMdzRQrA-1; Tue, 22 Sep 2020 14:01:48 -0400
X-MC-Unique: gn5GxlKmOz25EkMMdzRQrA-1
Received: by mail-qv1-f69.google.com with SMTP id l1so12093744qvr.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=C2aaSAULK36kdpoACQDdwALZmwQc4G3xRYKl1sR2GSU=;
        b=jkmIEETlmys/YPGUf1nyrdT1ny9R7N84qAExrqvW1bO4+5zgNbgTAiZ6eQAnp9yGBK
         VUS1QY3n2PbDGdPQx3IiV32Wzhk0Kltcqds3807D7ta0cpiwaGNgDAW3KhQhG+oxxHKL
         jBYA+y3WX13kuU/qCFH5HHDyQA+o89gHCuGaS1IMya+CNagbQPh4+13n2iT4OcN9Rg8z
         vz8LPgXNqYvev40FVvjfpGXoeQ2OX0wTRFew+qk4tFWEHwfWA/GDENWfUfjaWDxgm/Ad
         UjBGprJP4pUfZfASv0cakAUjV3+4em9NuFbTDABtPqi35vSJ+gYzVUhTjyV2Q4LJKcAy
         9uhw==
X-Gm-Message-State: AOAM530K2hDRiwaim5H3617Kgqmuie3uCGNTmR5osSAJkWSx02lyU6Fr
        yXzKa9sM5L2TkAYK/UHFWR7CvArvvf8WZ1ziQ2uK59Rvr89o7bZHhCRQD4UMvcRZnHGehJY9Bfk
        JxRm/fXyeWjRG5BVIwQ4/64Dk
X-Received: by 2002:a37:3c8:: with SMTP id 191mr5909462qkd.393.1600797708430;
        Tue, 22 Sep 2020 11:01:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9TQNX37EETLlze/qf7+p/fibX9UNEpK4JViHSjRbPhqkGDdiiKwZ+YCb6FbsuWgwyay63NQ==
X-Received: by 2002:a37:3c8:: with SMTP id 191mr5909431qkd.393.1600797708144;
        Tue, 22 Sep 2020 11:01:48 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id p68sm12340991qka.78.2020.09.22.11.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 11:01:47 -0700 (PDT)
Message-ID: <7231e2199a19aa6c8ecbecf5e80725e2a1aded73.camel@redhat.com>
Subject: Re: [PATCH V4] drm/dp_mst: Retrieve extended DPCD caps for topology
 manager
From:   Lyude Paul <lyude@redhat.com>
To:     Koba Ko <koba.ko@canonical.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     anthony.wong@canonical.com
Date:   Tue, 22 Sep 2020 14:01:46 -0400
In-Reply-To: <20200922065313.4794-1-koba.ko@canonical.com>
References: <20200922065313.4794-1-koba.ko@canonical.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One last change I realized we should do is print the name of the AUX adapter
in question. I don't mind just adding that myself before I push it though so
you don't need to send a respin.

Going to go push this to drm-misc-next, thanks!

On Tue, 2020-09-22 at 14:53 +0800, Koba Ko wrote:
> As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
> If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1,read the DP_DP13_DPCD_REV to
> get the faster capability.
> If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0,read DP_DPCD_REV.
> 
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index e87542533640..63f8809b9aa4 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3686,9 +3686,9 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> drm_dp_mst_topology_mgr *mgr, bool ms
>  		WARN_ON(mgr->mst_primary);
>  
>  		/* get dpcd info */
> -		ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd,
> DP_RECEIVER_CAP_SIZE);
> -		if (ret != DP_RECEIVER_CAP_SIZE) {
> -			DRM_DEBUG_KMS("failed to read DPCD\n");
> +		ret = drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd);
> +		if (ret < 0) {
> +			drm_dbg_kms(mgr->dev, "failed to read DPCD, ret %d\n",
> ret);
>  			goto out_unlock;
>  		}
>  
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

