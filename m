Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6652B533C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgKPUxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:53:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728574AbgKPUxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605560021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YR8enLi5JJFBoVjhQ3YblKf2ADCNsqZnAlnJJM2+oc4=;
        b=SBq78PMQTG+CLYcQI8NknbxGksTPFeWcWxxQ3nK8bASDMkQVBuq/y/iniwURsWYBnP/weY
        QizFb9+QohjXzgp4dEri1Y9fn13otuRxTyCzt27qFCCCvkVhzGugxnJrQ473HQAxnufDR+
        rrwAbVRFaVoPBuH+HwtgHoEPglAuO1E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-67-_yZabOc6mcNQHimp3pQ-1; Mon, 16 Nov 2020 15:53:39 -0500
X-MC-Unique: 67-_yZabOc6mcNQHimp3pQ-1
Received: by mail-qt1-f199.google.com with SMTP id w88so11072741qtd.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=YR8enLi5JJFBoVjhQ3YblKf2ADCNsqZnAlnJJM2+oc4=;
        b=QQUjgXpAMW9OD/m0Boj5BMA6J/Kzv0h5+tAPzdodlW9IYOkX+NEM7pKTzhmXFCW01G
         Ibd8QmWMEyFqMtsFIZNxc3gN8n6CyFjnSIZvPe7kyqeVMlmPti1qAkdicGa/2ih9nvhM
         nUQmGJHgDD/LFj6tSaqkDly3AyTbUp4KY4hTsCXgKkmWb1qb8JGg2xt9XaMWqgZ+FRDu
         tzP0GnJ06s/i1uPU0sUF++SXK7/5e6O0Tt0hqvQxGzHr5go/TqstlTwK53S8R+BUmmki
         otUp2BDOkFuXMe5PLu1PwRdIX5hWuqWIdQz4m1gn4llU16+1dxZmltR/PhtoQd7VeDj7
         4PXQ==
X-Gm-Message-State: AOAM530kqHxgieX1fws2HlWQoq0ZqSUFZVIxg0rrbyqTBO+aG4H32WwY
        qv1KDzxuG3ycymN3MlIu/LjjglO3X+h0TjeVP5ocs4TZlTEpkHlzNNbp/POKREmjoXFPHwehgGH
        bu8e/GUMCRSTeQ8xcMd2M9YH9
X-Received: by 2002:a0c:e24e:: with SMTP id x14mr17712001qvl.13.1605560019159;
        Mon, 16 Nov 2020 12:53:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2Ux/+NGQkATK4eCnsAGkyR7ehntTZwa+eSlhdMlVrTtRjRwsSKNuQ0I3Aj0hxq0AX9UDyzQ==
X-Received: by 2002:a0c:e24e:: with SMTP id x14mr17711978qvl.13.1605560018953;
        Mon, 16 Nov 2020 12:53:38 -0800 (PST)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id 199sm8596858qkj.61.2020.11.16.12.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 12:53:38 -0800 (PST)
Message-ID: <2dad68f011c7cd8a7c3754457c192f9dc2f504ed.camel@redhat.com>
Subject: Re: [PATCH 29/42] drm/selftests/test-drm_dp_mst_helper: Place
 'struct drm_dp_sideband_msg_req_body' onto the heap
From:   Lyude Paul <lyude@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Francis <David.Francis@amd.com>,
        dri-devel@lists.freedesktop.org
Date:   Mon, 16 Nov 2020 15:53:37 -0500
In-Reply-To: <20201116174112.1833368-30-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
         <20201116174112.1833368-30-lee.jones@linaro.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huh-could have sworn I had reviewed this one already.

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Mon, 2020-11-16 at 17:40 +0000, Lee Jones wrote:
> The stack is too full.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c: In function
> ‘sideband_msg_req_encode_decode’:
>  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c:161:1: warning: the
> frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Francis <David.Francis@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../drm/selftests/test-drm_dp_mst_helper.c    | 31 ++++++++++++-------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> index 1d696ec001cff..e00bdc557f880 100644
> --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> @@ -120,44 +120,53 @@ sideband_msg_req_equal(const struct
> drm_dp_sideband_msg_req_body *in,
>  static bool
>  sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
>  {
> -       struct drm_dp_sideband_msg_req_body out = {0};
> +       struct drm_dp_sideband_msg_req_body *out;
>         struct drm_printer p = drm_err_printer(PREFIX_STR);
>         struct drm_dp_sideband_msg_tx txmsg;
>         int i, ret;
> +       bool result = true;
> +
> +       out = kzalloc(sizeof(*out), GFP_KERNEL);
> +       if (!out)
> +               return false;
>  
>         drm_dp_encode_sideband_req(in, &txmsg);
> -       ret = drm_dp_decode_sideband_req(&txmsg, &out);
> +       ret = drm_dp_decode_sideband_req(&txmsg, out);
>         if (ret < 0) {
>                 drm_printf(&p, "Failed to decode sideband request: %d\n",
>                            ret);
> -               return false;
> +               result = false;
> +               goto out;
>         }
>  
> -       if (!sideband_msg_req_equal(in, &out)) {
> +       if (!sideband_msg_req_equal(in, out)) {
>                 drm_printf(&p, "Encode/decode failed, expected:\n");
>                 drm_dp_dump_sideband_msg_req_body(in, 1, &p);
>                 drm_printf(&p, "Got:\n");
> -               drm_dp_dump_sideband_msg_req_body(&out, 1, &p);
> -               return false;
> +               drm_dp_dump_sideband_msg_req_body(out, 1, &p);
> +               result = false;
> +               goto out;
>         }
>  
>         switch (in->req_type) {
>         case DP_REMOTE_DPCD_WRITE:
> -               kfree(out.u.dpcd_write.bytes);
> +               kfree(out->u.dpcd_write.bytes);
>                 break;
>         case DP_REMOTE_I2C_READ:
> -               for (i = 0; i < out.u.i2c_read.num_transactions; i++)
> -                       kfree(out.u.i2c_read.transactions[i].bytes);
> +               for (i = 0; i < out->u.i2c_read.num_transactions; i++)
> +                       kfree(out->u.i2c_read.transactions[i].bytes);
>                 break;
>         case DP_REMOTE_I2C_WRITE:
> -               kfree(out.u.i2c_write.bytes);
> +               kfree(out->u.i2c_write.bytes);
>                 break;
>         }
>  
>         /* Clear everything but the req_type for the input */
>         memset(&in->u, 0, sizeof(in->u));
>  
> -       return true;
> +out:
> +       kfree(out);
> +       return result;
>  }
>  
>  int igt_dp_mst_sideband_msg_req_decode(void *unused)

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

