Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8E228D450
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 21:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbgJMTUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 15:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732409AbgJMTUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602616822;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+T19di/I9uzvQiC5jnq09YBsE6/ITwy4uMdjnqLO7DE=;
        b=DhWwYGh9Y880PqQnYfmzaDS/5x6FSmBLRnaYR8rKuYqfHDskJ8CQHhbMSUZYsZBQ2Wvmvu
        iQiE6a6hcP83QRF4O3lK7OWcYQeAiXHOEOe0m7DSqyixGAqq8NgGNAJ0TNFg/BlklIV3z+
        71E2+R3Xa/kSesd5N0/xTm4Suu992Uw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-H7fhuJgYOoOyak1I3iNodQ-1; Tue, 13 Oct 2020 15:20:20 -0400
X-MC-Unique: H7fhuJgYOoOyak1I3iNodQ-1
Received: by mail-il1-f198.google.com with SMTP id i14so635537ils.21
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 12:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=+T19di/I9uzvQiC5jnq09YBsE6/ITwy4uMdjnqLO7DE=;
        b=TbyYGzdCvv0GE6CafPJLLj6iPkc8n7b1itVhhNpk2t/9wCkudVpoqdIVETYp/hAtLo
         AEAYeeEhe1GHFv60TUgsXuXeNR7n+xuQfpp7MTAnMKNeGSHZOlEsfobRLIXkTJHueHjv
         cIb3JVf1Qc8uGAa6B91+9JZnjPXTlHRhAkyxaCx2YKL+D/ZT18ydkMc29P7DUn+BP8vr
         gP/vXwHKm8dAJvTbEhR9lF+2dLFrLnUuOEi6XqHSQ/nCFjObYjRPm5AP3yR1i5A+zMj6
         sxqgNTjlHCjuvih/dAe/X4GuIaFQ7e6/9e0A8grdxquqZIFYJjHzg4fK+Hty6QrA+1l2
         iu+A==
X-Gm-Message-State: AOAM533TNOedeUMilyww38nBQk8OhSgzQAcgxLt5+pcoxBxKEqdQrUd/
        qc0D6TOoyBJkEq3aGUXD/6CTEbfL2+hJd3eQYzw054OTL+onG0wkpjR+VdIaDkv5enKNPHZ1BRi
        YfPnhqVJYpJyUP8MXJC89Au5r
X-Received: by 2002:a02:7b1d:: with SMTP id q29mr326889jac.118.1602616820090;
        Tue, 13 Oct 2020 12:20:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDqsRr5yoTlmjvRFYbjz/wMBkjy0QB3gawvWZcFb092FZr6amsv0o0aDw/QxH8erz1TOqYWA==
X-Received: by 2002:a02:7b1d:: with SMTP id q29mr326875jac.118.1602616819867;
        Tue, 13 Oct 2020 12:20:19 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id p65sm764536ill.23.2020.10.13.12.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 12:20:19 -0700 (PDT)
Message-ID: <7ac5989093cc0dfed7429dc99a0983d8a3a25068.camel@redhat.com>
Subject: Re: [PATCH v2 11/24] drm/dp: fix kernel-doc warnings at
 drm_dp_helper.c
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 13 Oct 2020 15:20:17 -0400
In-Reply-To: <c7b13b7f9dae481fe552e3b8382841469bb993f0.1602590106.git.mchehab+huawei@kernel.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
         <c7b13b7f9dae481fe552e3b8382841469bb993f0.1602590106.git.mchehab+huawei@kernel.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Tue, 2020-10-13 at 14:14 +0200, Mauro Carvalho Chehab wrote:
> As warned by kernel-doc:
> 
> 	./drivers/gpu/drm/drm_dp_helper.c:385: warning: Function parameter or
> member 'type' not described in 'drm_dp_downstream_is_type'
> 	./drivers/gpu/drm/drm_dp_helper.c:886: warning: Function parameter or
> member 'dev' not described in 'drm_dp_downstream_mode'
> 
> Some function parameters weren't documented.
> 
> Fixes: 38784f6f8805 ("drm/dp: Add helpers to identify downstream facing port
> types")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index b1c71af88579..deeed73f4ed6 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -374,6 +374,10 @@ static bool is_edid_digital_input_dp(const struct edid
> *edid)
>   * drm_dp_downstream_is_type() - is the downstream facing port of certain
> type?
>   * @dpcd: DisplayPort configuration data
>   * @port_cap: port capabilities
> + * @type: port type to be checked. Can be:
> + * 	  %DP_DS_PORT_TYPE_DP, %DP_DS_PORT_TYPE_VGA, %DP_DS_PORT_TYPE_DVI,
> + * 	  %DP_DS_PORT_TYPE_HDMI, %DP_DS_PORT_TYPE_NON_EDID,
> + *	  %DP_DS_PORT_TYPE_DP_DUALMODE or %DP_DS_PORT_TYPE_WIRELESS.
>   *
>   * Caveat: Only works with DPCD 1.1+ port caps.
>   *
> @@ -870,6 +874,7 @@ EXPORT_SYMBOL(drm_dp_downstream_444_to_420_conversion);
>  
>  /**
>   * drm_dp_downstream_mode() - return a mode for downstream facing port
> + * @dev: DRM device
>   * @dpcd: DisplayPort configuration data
>   * @port_cap: port capabilities
>   *
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat

Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

