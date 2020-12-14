Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB72DA304
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441147AbgLNWHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:07:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35997 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439062AbgLNWHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:07:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id y24so17371954otk.3;
        Mon, 14 Dec 2020 14:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7gXv4HROgVl0dhhrn9g+dOuGByfC8qbNmedPTBmNYR4=;
        b=pWT/FAwXhTmaXTnV7skRoxU4Rzg1uxUFX9JqXU7mUsY4hSQPurEgAAWcwpK4FXFhkx
         8VsfBX1hgeSVEUWrCGnDD9LEkMaQ5HqZMa8sUyQwWrvXPSopftlxK6tro+zAXwsrAMfA
         pYtKxoMWe9DW6SdqJRcRa/z4+TGzjQZuGCXioEGFokdlVi1r9R57j1Mh/OQgETa3ann4
         erbbqZ8RhhfIg6H8JUVegS6bh2LOvTd1aiTpZa8w8I+7QeZPiffYoMnctrY5+cQp3fQB
         +dGroitplVPblmQpM8Ht5zpGFUeTl53uoTChF01RZPrYvx/m1aM8c34ud+eR4F6okb1U
         NmLQ==
X-Gm-Message-State: AOAM533TXc+hLc86lB+N8mNvZuvtm20H1DrKn6eKYqawTmzsFiUtCIQy
        eobd3MDDfk/tgqynsTfWww==
X-Google-Smtp-Source: ABdhPJx1oK3i8zmC3LbXs0Tik3rezauqHLakbhVM/cgMMHuTFfWDNadaL1RC+zRxmmvGlt7BYMKuyA==
X-Received: by 2002:a9d:2043:: with SMTP id n61mr20683296ota.254.1607983596226;
        Mon, 14 Dec 2020 14:06:36 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m21sm4213726oos.28.2020.12.14.14.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:06:34 -0800 (PST)
Received: (nullmailer pid 2471293 invoked by uid 1000);
        Mon, 14 Dec 2020 22:06:34 -0000
Date:   Mon, 14 Dec 2020 16:06:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mali-midgard: Add
 dynamic-power-coefficient
Message-ID: <20201214220634.GA2471238@robh.at.kernel.org>
References: <20201209115143.15321-1-lukasz.luba@arm.com>
 <20201209115143.15321-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209115143.15321-2-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Dec 2020 11:51:42 +0000, Lukasz Luba wrote:
> Add a property dynamic-power-coefficient which allows to register Energy
> Model for the Mali Midgard devices.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  .../bindings/gpu/arm,mali-midgard.yaml          | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Applied, thanks!
