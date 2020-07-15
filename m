Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F672216D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 23:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGOVIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 17:08:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41651 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOVIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:08:12 -0400
Received: by mail-io1-f67.google.com with SMTP id p205so3772292iod.8;
        Wed, 15 Jul 2020 14:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ce/Bq1o7yEqQQK6FgxS9uN15O5xH+F17AS3S7KI8Vg=;
        b=DO/H9JPlFOsIQIp192MKbA31f4/vLytQ3XWV6Rw18vgVsfj/SdwSKTfvlMuo7CX/Hz
         HBqRCEp8pYvVSpN1ngpayvIY4xUWLBrfj9kzAeAym+ExNoVML3I5nCifo1cJg7zIRetK
         oMM70K2iWGzG8X+eYYb0hO+J61mvPUiC04In7AZDoyn/Nde3ynEGxKiTL+3yH8vhDgOc
         5MLusGAFpDsrNGVJZMIUiEgZMYQDdhGEFUy8Jt6n8S94uxXrJFuXrFV2CHve+asIGlBr
         4oNkOCVbzDw9PkJIx1ehtOcIey8C+6WX08zspW13PuGCIigVqYn/wacuuoeZ/1ms5jZH
         Aelg==
X-Gm-Message-State: AOAM532yEKBxJ6EoRgNdNS2pe7xssSy3P1BVlfyiCOYfEaKo1BZAxXeH
        yOOSr362ebQ/G+0VuzAYlQ==
X-Google-Smtp-Source: ABdhPJwM+3L0XK9qzuogwnohPengqtYGvTuWHpQABVodDZphoyDXMBLQgcx/tGvu3sZZW/bNk2odhg==
X-Received: by 2002:a02:c785:: with SMTP id n5mr1431788jao.75.1594847291926;
        Wed, 15 Jul 2020 14:08:11 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i11sm1817513iow.19.2020.07.15.14.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:08:11 -0700 (PDT)
Received: (nullmailer pid 818449 invoked by uid 1000);
        Wed, 15 Jul 2020 21:08:10 -0000
Date:   Wed, 15 Jul 2020 15:08:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Chiras <robert.chiras@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] dt-binding: display: Allow a single port node on
 rocktech, jh057n00900
Message-ID: <20200715210810.GA818399@bogus>
References: <20200703114717.2140832-1-megous@megous.com>
 <20200703114717.2140832-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703114717.2140832-3-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020 13:47:17 +0200, Ondrej Jirman wrote:
> The display has one port. Allow it in the binding.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../devicetree/bindings/display/panel/rocktech,jh057n00900.yaml  | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
