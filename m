Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB2E302E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbhAYVwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:52:13 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:36472 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732833AbhAYVtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:49:05 -0500
Received: by mail-ot1-f44.google.com with SMTP id d7so6578734otf.3;
        Mon, 25 Jan 2021 13:48:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RSDaygcYxriF3ihOyaOIjWLu3mlKCBI/VuxOhkKb1Qw=;
        b=f4vwANMRVcCCO4aG+yI2YItvQ6wbjq6qysyNWzGUpMbaZKoOU8cgL9EE8C7TgMwwzP
         xc4s8BsYjFB5bekE3wOb5ctThmXUnPpQJTkkbVrynxcH+bZ0J+gEurPTB1WLLDSgzgyU
         N0BYQ0qpwbO2gVtwjX/9JvkF8qjm2thfpv3VG9KLnfp3NjQc0tWvr/Il9X2ACOFmMII5
         IzfS1gAQdEBN9g07VnNDO/mOV3ehJeiSHBp1ZbxfIC2kXM0G2CT3kJcWBezSFDU5uv/p
         XM/ykdjluLI67wmuLvZAjuxueyFNc7HPewUAAVAhPXFxHatzQn30h39Ss9UDUF88NEOv
         Scmw==
X-Gm-Message-State: AOAM53205ajfr/tvlqTtGxfI8v86XpPq0BS6A8njI9nJOqngEu7GER3a
        NR76w/XihGWjZQ0J6NLWlA==
X-Google-Smtp-Source: ABdhPJxjA3hlrVxHgFatiiwJc3ZN5Uu8dZv2TawhUTQIW3xDlsJ8UoGo0vEjRdw4ep61MvaWXedKyw==
X-Received: by 2002:a9d:5e0f:: with SMTP id d15mr1826605oti.308.1611611303356;
        Mon, 25 Jan 2021 13:48:23 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k15sm3744565otp.10.2021.01.25.13.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:48:22 -0800 (PST)
Received: (nullmailer pid 1066934 invoked by uid 1000);
        Mon, 25 Jan 2021 21:48:21 -0000
Date:   Mon, 25 Jan 2021 15:48:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
Subject: Re: [PATCH Broadcom/stblinux 1/2] dt-bindings: power: bcm-pmb: add
 BCM63138 binding
Message-ID: <20210125214821.GA1066818@robh.at.kernel.org>
References: <20210114175339.19920-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114175339.19920-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 18:53:38 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> PMB can be also found on bcm63xx chipsets. It uses difference device
> addresses so a new binding is required.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
