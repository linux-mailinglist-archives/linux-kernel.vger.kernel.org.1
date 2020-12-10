Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08282D51FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbgLJDrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:47:32 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42412 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730376AbgLJDrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:47:09 -0500
Received: by mail-oi1-f194.google.com with SMTP id l200so4250286oig.9;
        Wed, 09 Dec 2020 19:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0lIoBaHOJrOY1VplMmKl27/uPfnqTjcXmVosBasviL4=;
        b=cORTGz5ip/tPAekYqOXqy0Gbwq1kBAnjjrJUkaFbKap300jjJhfa84+eNe2g+uzSVg
         E6frGtZazkVC3eHAFV2b/sFpr9HTUM1E1CiGKVRreieb8rPc+FLHuTFy0aZ5Ge1J83WO
         zlXC9ozG7QD/anD/Pp1Cpms4V/XQO7SroZy+SeBeHD7unSdON5Xj248fqLk+1NCKT8/y
         8X6vj1OOjLu6AJ6BT7j/LvGzHYqKD2OAXifHmAVN0SaCXudedhrLedyHb/tbZSNnX+kX
         mjVVt7zp1wG9lCk8uGceB41mFXNFm130nWva2V01MpGa9f4f2GnpSewqbmHHtdp8Rzsc
         YCfA==
X-Gm-Message-State: AOAM532V3m3Qjl/cH9ZEZ+xMJlEx+RejNyB4QrvqG5iDE4X+6b6i/WPU
        MsSlm4t74oQPzYkRm9DGQw==
X-Google-Smtp-Source: ABdhPJyGZlnSNvYCwiTe2l1IEwRNiLgMj7T9+rC52qQq2RqKMS/ajKGbFA2joi3/M+4z0TDO0uw2iw==
X-Received: by 2002:aca:b9c4:: with SMTP id j187mr4175918oif.157.1607571988880;
        Wed, 09 Dec 2020 19:46:28 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 100sm893058otm.27.2020.12.09.19.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 19:46:28 -0800 (PST)
Received: (nullmailer pid 1619988 invoked by uid 1000);
        Thu, 10 Dec 2020 03:46:26 -0000
Date:   Wed, 9 Dec 2020 21:46:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v7 2/8] dt-bindings: display: simple: add EDT compatibles
 already supported by the driver
Message-ID: <20201210034626.GA1619939@robh.at.kernel.org>
References: <20201207140939.31297-1-o.rempel@pengutronix.de>
 <20201207140939.31297-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207140939.31297-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 15:09:33 +0100, Oleksij Rempel wrote:
> Some EDT compatibles are already supported by the driver but will fail
> on checkpatch script. Fix it by syncing dt-bindings documentation with the
> driver.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
