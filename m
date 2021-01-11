Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDDF2F20E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390325AbhAKUdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:33:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390052AbhAKUdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610397106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2kB21kABqOOu7gOcB3+o+ykSXSkI5oDu8DPYbkJeBA=;
        b=Q2FhOvtZmlkKqLeVc2iVxIsvQcuZQmDbk14ExwkvkSwxyCVYEU20/hNffuE9w8O9OdCOE9
        BqAQNYXJg3GHEIsOwYVGYZEyH2nn/rnMA8WVCXmmfNvsrnLsKD5ypWBK7ynjrq129XRfYo
        VY0xQHVHboY2Uwi5wI5cnxEmcSpobNw=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-TbYNnJb9OM-rTpBhKc0-pw-1; Mon, 11 Jan 2021 15:31:45 -0500
X-MC-Unique: TbYNnJb9OM-rTpBhKc0-pw-1
Received: by mail-io1-f70.google.com with SMTP id x7so43054ion.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+2kB21kABqOOu7gOcB3+o+ykSXSkI5oDu8DPYbkJeBA=;
        b=i7cSXghm5W7PDK5SQWdS+ZL4An7lzHbPJ3pTUVjR5BUKwIFXYW/NOHsEZR6ef5cAsb
         BNLX3cQn1TbHUwVH9VgnzoiCCk1u7t6Tbxh/CBfVfYUrPxwNc6QOAY471+RwW1kFKceC
         AsmXjsLXvPy9hOXxKi98B0XCXhKWfyp1uYtonrj7/4qMt2C9vaTXN3JWeN0k0VkgMkSb
         eaItHr97qeyWyUAcXJTL/OJNY7cJFB5A2mfDJ6gxUhLMYpcXv3vzpxINVMzHVa1Hniy5
         Ts3C1TOgjaOiJzlfQcsC6L6bCFI05q9mwlCRPNfT4fqkgFB1WNrVZ4dTTnk1AXhyMUpf
         kT8w==
X-Gm-Message-State: AOAM530TakJWYTq8t1BcxCvfxB9JX4Z3O8VqC8FEpl/7Ro8A75L4LytB
        RzelNlpH/bdumuekT1Bd3Gx4h13oP2EfnazMByk4uvGH266tvoQvdqWp7m3wzDHE2MewsKZTfow
        xjaUJ5PSSXG7HKKUJS/V3VN3z
X-Received: by 2002:a02:c9cc:: with SMTP id c12mr1326491jap.116.1610397104444;
        Mon, 11 Jan 2021 12:31:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKhDndwsOo2nRD5VZRaC8ko0qBQPThQauo77lSvQeu/a6IRHRXlNcv8N/azwv1N1MAovUXww==
X-Received: by 2002:a02:c9cc:: with SMTP id c12mr1326478jap.116.1610397104214;
        Mon, 11 Jan 2021 12:31:44 -0800 (PST)
Received: from xps13 ([2605:a601:a63a:4d01:c3c1:7008:ba35:96])
        by smtp.gmail.com with ESMTPSA id w3sm494775ilk.17.2021.01.11.12.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 12:31:43 -0800 (PST)
Date:   Mon, 11 Jan 2021 15:31:42 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ttm: Fix address passed to dma_mapping_error() in
 ttm_pool_map()
Message-ID: <20210111203142.GA51463@xps13>
References: <20210111164033.695968-1-jcline@redhat.com>
 <cbd76108-a7c4-119b-b045-eb857a84fcab@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbd76108-a7c4-119b-b045-eb857a84fcab@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 09:21:48PM +0100, Christian König wrote:
> Am 11.01.21 um 17:40 schrieb Jeremy Cline:
> > check_unmap() is producing a warning about a missing map error check.
> > The return value from dma_map_page() should be checked for an error, not
> > the caller-provided dma_addr.
> > 
> > Fixes: d099fc8f540a ("drm/ttm: new TT backend allocation pool v3")
> > Signed-off-by: Jeremy Cline <jcline@redhat.com>
> 
> Good catch. Reviewed and pushed to drm-misc-fixes, should be in the -rc by
> the weekend.
> 

Great, many thanks!

- Jeremy

