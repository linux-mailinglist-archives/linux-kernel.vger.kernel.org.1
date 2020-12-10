Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12512D51A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgLJDmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:42:11 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42598 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbgLJDmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:42:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id 11so3627954oty.9;
        Wed, 09 Dec 2020 19:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oHT+bpTlXmEcpnDhxLPen0vIHtK4d63RKLxr2Jz+ZqE=;
        b=MXXRF+SBaNM0wcXELbuuZvNz5VmO5t/9rWslzW8WAp54ldfyDjUGJ+o1RKg6kRpTmr
         KOakSwvBtiMnOnZ9uc5DmWxLK0f3zYkcJtkb46nJlI2SL3QUmRBu2qTXZ65vLCeFHqoP
         AG3gSAaXqXF6qAZUVJQNbXkS7bnv3YM0R7ESvrc2gJg4fVTzse/h04PwBk3DIpw41H0J
         LnMVpI/DrPQD7g/AJfSlbi3LHdtavUjuEDcNhkV39Lxjv2idutljz+aIypkbCh1tDOQj
         iw0m7ainHUXmRstblBESoVDOJnZsuOR/xK0IKI74RxtwKnIBtgbL0AuYR1ggPkbDZmUA
         UpMg==
X-Gm-Message-State: AOAM530qPlHhCy/2Go7DeanUSd9uu4Sw1N0R0H9P535RksT/vW8Bypwx
        mEHD2x+Oi6FvDsx+CO8aj0ow4bhe/Q==
X-Google-Smtp-Source: ABdhPJzpzWnBwKKImc0q9CG0zR2ZvstScdCgUPs86Y83ZnTGScsY/VaNWpQ4XF/7YdZht+RliCvBqA==
X-Received: by 2002:a9d:7851:: with SMTP id c17mr4572752otm.255.1607571690280;
        Wed, 09 Dec 2020 19:41:30 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h62sm802199oia.9.2020.12.09.19.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 19:41:29 -0800 (PST)
Received: (nullmailer pid 1613254 invoked by uid 1000);
        Thu, 10 Dec 2020 03:41:28 -0000
Date:   Wed, 9 Dec 2020 21:41:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        airlied@linux.ie, heiko@sntech.de, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, hjc@rock-chips.com,
        broonie@kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH v6 1/5] dt-bindings: display: add #sound-dai-cells
 property to rockchip rk3066 hdmi
Message-ID: <20201210034128.GA1613204@robh.at.kernel.org>
References: <20201206133355.16007-1-jbx6244@gmail.com>
 <20201206133355.16007-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206133355.16007-2-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Dec 2020 14:33:51 +0100, Johan Jonker wrote:
> '#sound-dai-cells' is required to properly interpret
> the list of DAI specified in the 'sound-dai' property.
> Add it to rockchip,rk3066-hdmi.yaml to document that the
> rk3066 HDMI TX also can be used to transmit some audio.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml    | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
