Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E35D27319C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgIUSLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 14:11:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54532 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728046AbgIUSLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600711889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hzvH6M5RSxqUJheqam9teVH+K2DUCz1tE6f6TiNbWPw=;
        b=BWcDpCedMa70cYeQPTu3Cf/bmeJPdAfFC0t4ocgO5GAv0j7Ua7T+h/BGKLtSAA36qZpFfD
        REdVyOaMNar2DypHScvuERhee7oh22Ob7ndRKZZeH32Ocn+0knxp2josYHOU+tJFH5qFU3
        Ycvtwez+usbjO48SweQ4+szZXlioXy4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-MHKmdkoTNWCZeYjXux1roA-1; Mon, 21 Sep 2020 14:11:27 -0400
X-MC-Unique: MHKmdkoTNWCZeYjXux1roA-1
Received: by mail-qk1-f199.google.com with SMTP id r128so11622579qkc.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 11:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=hzvH6M5RSxqUJheqam9teVH+K2DUCz1tE6f6TiNbWPw=;
        b=LyfXSYpYDyxGiHaEkjPwYCALFz/3C8KF9IwXo6TffMXiZTeXkuoABCSiFXLzbY2uWP
         iQ01R3rXQWM2oO3LJgsoTY4+9twoqb1xdZFz9CU40cqLprDngIniCzEXwmmVuUyd86SY
         PNFaB/V/G+LsokSriKFNgrTkdKbFWkPzMTK2exKrYVA6S5tcsV7xlMVmge1N706oc7Fr
         5HjiXpRnG/7AzKsAn5Hi+9NV60auUi6NaFkG57Cvj05gk6s7XzZKgZGXoPL3/q7Ci9oj
         +iv47gxIUOMEd/qzYYogAV8h89kE5gc5KCSoTNAQLDqaengUiGCTB5bKDdz4co6FA9nc
         1eEg==
X-Gm-Message-State: AOAM532dTUs75pGszy47RgzEImdJy1u/K5f2AwHKvabF6fSPMCm65DQ7
        qcNPldl51er/GDFYYenLgKow8CJZ07fLf0Fk7oBXS6qgSvzxeZpb95JP+rKzv793WNRGzrLqrSd
        3wVUu/SjHWQgGqkJErpgRcMWE
X-Received: by 2002:a05:620a:2082:: with SMTP id e2mr946124qka.421.1600711886913;
        Mon, 21 Sep 2020 11:11:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/oz4y6Z65wyb8f5zL7wKknzmLX9r92w2Ax5gyx/tNEa9pPfRMQdZpq/i5rbwajLKLCWY+7A==
X-Received: by 2002:a05:620a:2082:: with SMTP id e2mr946109qka.421.1600711886653;
        Mon, 21 Sep 2020 11:11:26 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id t26sm9703493qkt.29.2020.09.21.11.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 11:11:25 -0700 (PDT)
Message-ID: <5f99b65c8a092df343c68249f2bce62e4cd0abff.camel@redhat.com>
Subject: Re: [PATCH v3] drm/dp_mst: Retrieve extended DPCD caps for topology
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
Date:   Mon, 21 Sep 2020 14:11:24 -0400
In-Reply-To: <20200911034431.29059-1-koba.ko@canonical.com>
References: <20200911034431.29059-1-koba.ko@canonical.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, sorry I lost track of this until just now. Comments down below:

On Fri, 2020-09-11 at 11:44 +0800, Koba Ko wrote:
> As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
> If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1, read the DP_DP13_DPCD_REV to
> get the faster capability.
> If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0, read DP_DPCD_REV.
> 
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> ---
> Changelog:
> 1. Adjust the commit message.
> 2. use drm_dbg_kms instead and print the return code.
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 7753c718ddf9..63f8809b9aa4 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3671,8 +3671,6 @@ EXPORT_SYMBOL(drm_dp_read_mst_cap);
>  int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr,
> bool mst_state)
>  {
>  	int ret = 0;
> -	u8 dpcd_ext = 0;
> -	unsigned int dpcd_offset = 0;
>  	struct drm_dp_mst_branch *mstb = NULL;
>  
>  	mutex_lock(&mgr->payload_lock);
> @@ -3686,17 +3684,11 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> drm_dp_mst_topology_mgr *mgr, bool ms
>  		struct drm_dp_payload reset_pay;
>  
>  		WARN_ON(mgr->mst_primary);
> -		drm_dp_dpcd_read(mgr->aux,
> -				 DP_TRAINING_AUX_RD_INTERVAL,
> -				 &dpcd_ext, sizeof(dpcd_ext));
> -
> -		dpcd_offset =
> -			((dpcd_ext & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT)
> ?  DP_DP13_DPCD_REV : DP_DPCD_REV);


Uh, are you sure you formatted this patch correctly? None of these hunks are present upstream, this looks like it's a diff for the previous version of this patch that you sent out
>  
>  		/* get dpcd info */
> -		ret = drm_dp_dpcd_read(mgr->aux, dpcd_offset, mgr->dpcd,
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

