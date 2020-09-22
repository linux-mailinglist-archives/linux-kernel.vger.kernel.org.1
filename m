Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD44727479B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIVRjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgIVRjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600796391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOvZa58bQwSg9zZxQrzzDfDSI+YPZEHlTilezlciasI=;
        b=aY/+HSJKQc1ASmuxWRmrlCWXktVI0Klb+G3T1DICRSOk50WhcdXOeCwhvBBsgjONrBlRC4
        08A4VznFXF78HYvG4SpHGnsHouFPCTwqr/IL+UXqSQG3U2TYLGwUDeekZv8C4i7yjtlkOI
        S2rr1ycLm2/BAZeP4C0jReb6feG3b1M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-fIi_Wtd-O-WfcfvSmWIqPQ-1; Tue, 22 Sep 2020 13:39:44 -0400
X-MC-Unique: fIi_Wtd-O-WfcfvSmWIqPQ-1
Received: by mail-qv1-f70.google.com with SMTP id y2so12421853qvs.14
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 10:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=EOvZa58bQwSg9zZxQrzzDfDSI+YPZEHlTilezlciasI=;
        b=ErUozt1YidWxMcMX2EVMOwWq8sPhQyGvPYSdsS2Tw9D3Yh/SIxJ5T9MVCnr7DeF9di
         iJpmZL3WvBGjqx5pz5Ev9ctzKG/DKYiiwWDmsPKBXaQfsKHK/90Z73E2X2GDDRAINmv2
         Xy5MljRSN7V5elqEVs9+F4AsyBNF2SL640siOtfKU7t+VG6IXRoVcj8JC879iLgh/C5E
         UY9sIQ5HvWgLPLs4ZHsc3w3OMX7WK1anwmIO/0g2wyA+Uo31kpXwCdJVgEyCKNZ5uAes
         6eMFIekF/OXMsKh9ZcnbnvdHj6lk9BBf7R+fqpYDrajRdtbX4ZgDC6cnugjdSVU8B2Q8
         js8w==
X-Gm-Message-State: AOAM532JfGJYHKePAPO07+872rIr8OLaZHr8B00rJ58fqqqD6K/Cwho9
        YErxWQBpNF7iU3M6dMJweC19u12Y+xIZ27dLrVsKBpJgqA8i/HQqLgiMIJd4DxGD+rneWzR+5Xy
        TefVvk8oaPz0SUliK0b1YF/1V
X-Received: by 2002:ac8:37bb:: with SMTP id d56mr5776234qtc.222.1600796383808;
        Tue, 22 Sep 2020 10:39:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZKmhFVNxcmIKWH3PdQ/839r2qc0cP5cXBSbUPc3Oje/ERMJ7b6/wgKScyuW5Qim8DezYHrQ==
X-Received: by 2002:ac8:37bb:: with SMTP id d56mr5776210qtc.222.1600796383565;
        Tue, 22 Sep 2020 10:39:43 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id v30sm13285520qtj.52.2020.09.22.10.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 10:39:42 -0700 (PDT)
Message-ID: <a2c0d1ac02fb4bef142196d837323bcde41e9427.camel@redhat.com>
Subject: Re: [PATCH 0/3] Fix Kernel-doc warnings introduced on next-20200921
From:   Lyude Paul <lyude@redhat.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Eric Dumazet <edumazet@google.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Taehee Yoo <ap420073@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Date:   Tue, 22 Sep 2020 13:39:41 -0400
In-Reply-To: <cover.1600773619.git.mchehab+huawei@kernel.org>
References: <cover.1600773619.git.mchehab+huawei@kernel.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For patches 2 and 3:

Reviewed-by: Lyude Paul <lyude@redhat.com>

I'll go ahead and push these to drm-intel-next-queued (since drm-misc-next
doesn't have these patches in yet, and the commits these fix were originally
merged through drm-intel-next-queued anyway). thanks!

On Tue, 2020-09-22 at 13:22 +0200, Mauro Carvalho Chehab wrote:
> A few new warnings were added at linux-next. Address them, in order for us
> to keep zero warnings at the docs.
> 
> The entire patchset fixing all kernel-doc warnings is at:
> 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=doc-fixes
> 
> Mauro Carvalho Chehab (3):
>   net: fix a new kernel-doc warning at dev.c
>   drm/dp: fix kernel-doc warnings at drm_dp_helper.c
>   drm/dp: fix a kernel-doc issue at drm_edid.c
> 
>  drivers/gpu/drm/drm_dp_helper.c | 5 +++++
>  drivers/gpu/drm/drm_edid.c      | 2 +-
>  net/core/dev.c                  | 4 ++--
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

