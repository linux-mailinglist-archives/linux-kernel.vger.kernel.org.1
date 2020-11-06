Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22A02A9DCE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 20:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgKFTRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 14:17:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728070AbgKFTRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604690249;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eIrgu+Zyfi99z5T1RDNmY/iinJQcbzFcfmaOeQwzR0w=;
        b=R23kxW5f1eAYygLr59mkGwNhV3aKIQs9zz8Ntb6UwolUicaPe0/3zDnGzjHkFkbmnBYcLX
        54oapzSn0MvtoFBiqoRupMnSs7wLAax0nSMlS0gM4ClRNdNN5B4DRKbTea2pY6ysF3rhp7
        9Sy2vi99cjf2NQEmblbisAuT0XWEIgU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-N7F8JmraON2jvBcdfRU-Qw-1; Fri, 06 Nov 2020 14:17:27 -0500
X-MC-Unique: N7F8JmraON2jvBcdfRU-Qw-1
Received: by mail-qt1-f198.google.com with SMTP id i20so1623018qtr.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 11:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=eIrgu+Zyfi99z5T1RDNmY/iinJQcbzFcfmaOeQwzR0w=;
        b=oQijgUUBBy0OLLJzRV8eQXbGIlOWcpI3kyYrJ9EX7Q8DCMaFKyAmMSqzRnUhZYWBsd
         JKddF54V8pDbLQnTLdX8kfAlixexnFN7y4e30cVW6vC4WVEnlD54CqdqPaCgEJuZoEym
         0RtuFdXSJcU9+oplNtD2c74RnDGztnRLat2q06oZ7fSLs0lbYRq7LbbKG+DkBwrBgpCk
         h4xOvh9Z23TWagFFinXJN+Ud0Yujn2oTqNVNJ8yRUpxomjsz1lEPtMJXKCsaSRfKnAT0
         KOd7rSCpWtO7sMGXTyVVWwii8I0Q+CsEqeaPNkz0pnWLqV/x4/sGjWwVDCF7mrOa0zSl
         97wg==
X-Gm-Message-State: AOAM5312Avuu1Nl4f5GdmXcyOGnKtm5MpNr5yrYIMlvcHN4FS8F6A9Fi
        fb+Pve+jIl1EcR8Q2Awbs4eX5yhyN9FotdNDfwFwuvdRyDHxz7brkfPL7e9vxRpDoDbb5f55F3Z
        +Zqt+Pjwppgj5kmtnOEDUeycS
X-Received: by 2002:a0c:84c1:: with SMTP id m59mr3080547qva.0.1604690247187;
        Fri, 06 Nov 2020 11:17:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0Tp1ae2fEu/BtdbdNT13KKCZ7ePgv4+WNb1yd6T2gltfK4e8cslY/HKALsQAKJ93xDWTV2Q==
X-Received: by 2002:a0c:84c1:: with SMTP id m59mr3080531qva.0.1604690246966;
        Fri, 06 Nov 2020 11:17:26 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id u24sm1163603qtb.33.2020.11.06.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:17:26 -0800 (PST)
Message-ID: <bf216efdf7eea393d6ce5244f7b7a8970c23c235.camel@redhat.com>
Subject: Re: [PATCH 14/19] gpu: drm: selftests: test-drm_dp_mst_helper:
 Place 'struct drm_dp_sideband_msg_req_body' onto the heap
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Francis <David.Francis@amd.com>,
        dri-devel@lists.freedesktop.org
Date:   Fri, 06 Nov 2020 14:17:25 -0500
In-Reply-To: <20201105144517.1826692-15-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
         <20201105144517.1826692-15-lee.jones@linaro.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-05 at 14:45 +0000, Lee Jones wrote:
> The stack is too full.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c: In function
> ‘sideband_msg_req_encode_decode’:
>  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c:161:1: warning: the frame
> size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Francis <David.Francis@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../drm/selftests/test-drm_dp_mst_helper.c    | 29 ++++++++++++-------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> index 1d696ec001cff..0a539456f6864 100644
> --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> @@ -120,44 +120,51 @@ sideband_msg_req_equal(const struct
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
> 

You're missing a NULL check here

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
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

