Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC792E81FD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 21:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgLaUqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 15:46:12 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:33977 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLaUqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 15:46:11 -0500
Received: by mail-io1-f42.google.com with SMTP id i18so17981526ioa.1;
        Thu, 31 Dec 2020 12:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FWQywS5uoIESr/XV60D8DkRTnYzyMWSTsob7AgDpdWE=;
        b=mmxJVyAhaVveq+LV4fN8zIX0dCpNm1YXClcw5DeBMXqdRayYg+N31/keuBSfhU5fgV
         YthLP3Q8GwapxWMem/vxKTj2ucg2pDKvSdWOLjvsDrAeJq3npeFYhtGXrn7OBCJBye39
         o1GZhqiIs+ZX5voz+XxH0FSzQRqvXM1991quvJz8D5nWHT4GLwwIZ9y1r/iF0WhKssen
         P76dxJnvSXuk29ZAy9xV1h3RWGyFllALv1XUNXcCa4XL9ffzDNNCJainDhPv0k6bEMnD
         ENXS5MciGGQ2ubn0LdKh2dWirJBg80EuhHDyfd6ycwPYOxVqWMwCMcagDaplV5ReK8W2
         vdMA==
X-Gm-Message-State: AOAM530spwOvYUp7f4cMv22HQOFmDlLhJHlM0dYsAHu5tAUx8YAPGs8p
        T+GvdRi6KAqn+Wp2pilSGA==
X-Google-Smtp-Source: ABdhPJwDsko2aMmzjEiDs4G5n0jm1F4QAbI3OgpUAWtg23stNoRF0jfBKzr1akKTmXR5yY3RQN7NUA==
X-Received: by 2002:a05:6638:1027:: with SMTP id n7mr50116065jan.35.1609447530669;
        Thu, 31 Dec 2020 12:45:30 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o18sm10693846ioa.39.2020.12.31.12.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 12:45:29 -0800 (PST)
Received: (nullmailer pid 2333095 invoked by uid 1000);
        Thu, 31 Dec 2020 20:45:26 -0000
Date:   Thu, 31 Dec 2020 13:45:26 -0700
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: allwinner: Add V3s compatible
 description
Message-ID: <20201231204526.GA2331936@robh.at.kernel.org>
References: <20201218205436.2326872-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218205436.2326872-1-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Dec 2020 21:54:35 +0100, Paul Kocialkowski wrote:
> Introduce bindings description for the V3s PWM, which is
> register-compatible with the A20 PWM.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
