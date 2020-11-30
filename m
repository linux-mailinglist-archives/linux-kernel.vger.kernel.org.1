Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2512C8F33
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgK3UaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:30:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728959AbgK3UaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:30:00 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A74742073C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606768160;
        bh=8p6NimbOeCayqmrZMD8vIX/ZAIUnX0r/wxjNZ1WnXaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W+iVilSO1VWZAI5uV16yR1HA16GxYYT2Dj/k6we3Iy77DnVtZTjvG5EtIPyjCtsPn
         H3pZ8VB7/poFR8T+ER5v1oogysTBrCEJfyDyJbQ645zP0FB4KNNviXO4UnhsrJsn4x
         8LMLojOTM8uAsBybQS1LJhUoyCs0K/WMfJaCnGaY=
Received: by mail-ed1-f50.google.com with SMTP id m16so18108187edr.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:29:19 -0800 (PST)
X-Gm-Message-State: AOAM5310S7i8j27eFtTUyXOiSQ8zUPvAQX+wo5DeNv8PxNwYVhbT1PDl
        TiS+YxEkOluQLzT/EyNO0MW5cy5mCP/4sA2MCQ==
X-Google-Smtp-Source: ABdhPJx253fAf5hg88WZhzFWnVy0Qrr8HJJkGqNvc+PO7FdlAlN4nMcqcJFZZwVUmJlwsPlgwbYTIlwO2QOQfdpd9TI=
X-Received: by 2002:aa7:c816:: with SMTP id a22mr7112436edt.373.1606768158104;
 Mon, 30 Nov 2020 12:29:18 -0800 (PST)
MIME-Version: 1.0
References: <1606746513-30909-1-git-send-email-kevin3.tang@gmail.com> <1606746513-30909-2-git-send-email-kevin3.tang@gmail.com>
In-Reply-To: <1606746513-30909-2-git-send-email-kevin3.tang@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Nov 2020 13:29:06 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+fC1TzygUopiwVtwBN8JtwmnGy=VMTEvkudSQUdXiMqg@mail.gmail.com>
Message-ID: <CAL_Jsq+fC1TzygUopiwVtwBN8JtwmnGy=VMTEvkudSQUdXiMqg@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: display: add Unisoc's drm master bindings
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 7:28 AM Kevin Tang <kevin3.tang@gmail.com> wrote:
>
> From: Kevin Tang <kevin.tang@unisoc.com>

Once again, DT patches must Cc the DT list if you want them reviewed.

>
> The Unisoc DRM master device is a virtual device needed to list all
> DPU devices or other display interface nodes that comprise the
> graphics subsystem
>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  .../display/sprd/sprd,display-subsystem.yaml       | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
> new file mode 100644
> index 0000000..9487a39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/sprd/sprd,display-subsystem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc DRM master device
> +
> +maintainers:
> +  - Kevin Tang <kevin.tang@unisoc.com>
> +
> +description: |
> +  The Unisoc DRM master device is a virtual device needed to list all
> +  DPU devices or other display interface nodes that comprise the
> +  graphics subsystem.
> +
> +properties:
> +  compatible:
> +    const: sprd,display-subsystem

As I said before, we try to avoid these virtual nodes. Make the DRM
driver bind to the DPU node.

The case where this might be needed is if you have h/w that's a
mixture of shared and discrete blocks. I don't see anything here
matching that.

Rob
