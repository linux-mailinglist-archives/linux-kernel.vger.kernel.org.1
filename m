Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84714247A52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 00:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgHQWN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 18:13:59 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34627 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbgHQWN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:13:58 -0400
Received: by mail-il1-f196.google.com with SMTP id t4so15924287iln.1;
        Mon, 17 Aug 2020 15:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NWcJUMjhzWxgLwSJTQ9mJf5Bg6tuJZb2pvsDhwp/p2U=;
        b=IEG8wYh9/lJ2W40PcFd4pTYoosNzIHUk/CtEsk7HOHcm2v9C4WezDWS/ng4JFB17GK
         UNOCGXIG0/Qp/cm85t26W4hBoqNj2AIr5nUrwGp/Tf9Fq01FsDWazEqZovBB8VmFE79l
         4OVM4neyAvCyDnE6VNYglExsQWuxFA25hQ52v+1U6EhjH/Y4vIc1+AhuTgG6sKHKZMSn
         GlGNlOoYlaS6sTc3F6NpR4AA8teUreB2V3SX2ujM06/O7D5bE87Y3w0860lq91Y+QbmT
         +XF9aq9jSOGWV9O2a2w6Cg6ndCXQLWD7f+q9qHZsoxGYpqDh8gOC0pD7brhVUR6w8vIj
         5UMQ==
X-Gm-Message-State: AOAM5323p++UClwntUPSlUJ+DGjAvkP5grRph8c+rQh6Y3avLt2DeoEd
        YWTT7IJfJglNh3S08vvKAQ==
X-Google-Smtp-Source: ABdhPJxaxW3yxqAMmU70zKLY3sJph2EfbeywS3/mXADToEKK/pyhlsLHUtXFfvG/OMCT5EwA6cJIGQ==
X-Received: by 2002:a92:d48f:: with SMTP id p15mr16258791ilg.45.1597702437353;
        Mon, 17 Aug 2020 15:13:57 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id y2sm9963333iow.30.2020.08.17.15.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 15:13:56 -0700 (PDT)
Received: (nullmailer pid 1669955 invoked by uid 1000);
        Mon, 17 Aug 2020 22:13:55 -0000
Date:   Mon, 17 Aug 2020 16:13:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     robh+dt@kernel.org, yamonkar@cadence.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tomi.valkeinen@ti.com, jsarha@ti.com, kishon@ti.com,
        mparab@cadence.com, nsekhar@ti.com, vkoul@kernel.org
Subject: Re: [PATCH v1 6/7] dt-bindings: phy: cadence-torrent: Add binding to
 specify SSC mode
Message-ID: <20200817221355.GA1669924@bogus>
References: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
 <1596795165-13341-7-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596795165-13341-7-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Aug 2020 12:12:44 +0200, Swapnil Jakhade wrote:
> Add binding to specify Spread Spectrum Clocking mode used.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  .../bindings/phy/phy-cadence-torrent.yaml           |  9 +++++++++
>  include/dt-bindings/phy/phy-cadence-torrent.h       | 13 +++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 include/dt-bindings/phy/phy-cadence-torrent.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
