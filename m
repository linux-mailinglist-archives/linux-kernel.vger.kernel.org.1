Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5612B293BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406283AbgJTMhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:37:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37013 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406166AbgJTMhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:37:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so1937268wre.4;
        Tue, 20 Oct 2020 05:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9R76Qw8aBPMRMXBKN8WGuLgFv8OIC903CNQoheFKJIU=;
        b=fIy0zPnwrPlATivt18CO6CnqtaO/PuvqmIJoaAvVwWGIh0UUnwu7WX2BLIpihNdS/M
         Iiph/y7sMSN7tECoiy+zVM+YO8IAXjoA7WlbelR/PWiZb4dxld6X/Ft5QaDd+fuztVKn
         BkJsmhooQiOoapnHDmLPGdexCCpXLU/3S3udbbON1M0/E7NDzUrEeelnDrV/Qs1ZchKv
         9iPUCfIz4VZagkjYYsnwbOqMXp4ge8W3dFFATvdSymGfiljBaI0Sa68zNBwCioVejodn
         lXnuFa9pAphAlwkiA26hOS+kIIk4ujVdt1y89sr1UPVYlWAuXPAwAspmx96+agjkzFx0
         XrLA==
X-Gm-Message-State: AOAM530XHBeclk8YsihrAX3lDHcFIK16aIklnw8HwxQiI9C0uxfTFvT3
        xilRJ4Tq7bfXM8tQSY/Y0LP7pdwcfs4rvA==
X-Google-Smtp-Source: ABdhPJwoWV4NKb5shY14Fh//oxEsfVrBkDvURXRvpG+UlBdvmcSTPSXW5DSadfV+NsyaX9bA/aLf+w==
X-Received: by 2002:adf:c3c2:: with SMTP id d2mr3362132wrg.191.1603197432009;
        Tue, 20 Oct 2020 05:37:12 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id s185sm2478527wmf.3.2020.10.20.05.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:37:11 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:37:09 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/29] arm: dts: lpc18xx: Harmonize EHCI/OHCI DT nodes
 name
Message-ID: <20201020123709.GH127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-11-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-11-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:40PM +0300, Serge Semin wrote:
> In accordance with the Generic EHCI/OHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
> nodes are correctly named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm/boot/dts/lpc18xx.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
