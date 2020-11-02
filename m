Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65C12A2E57
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgKBPbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:31:14 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41141 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBPbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:31:10 -0500
Received: by mail-oi1-f194.google.com with SMTP id m13so5945415oih.8;
        Mon, 02 Nov 2020 07:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Z8H9l3VA/4xs8QoHtRPimGxfhX9uthSZLvCPy11UA8=;
        b=pc6EWlKutqUlV+hhIuyyKzMK5MCDD4UJZydJOP9/B7DpM0GQSpNkPiG2bB9oSxHic9
         YYPE4Ga2Iwr3qFPyXEL+C6UV/lWPKhLWeUTRIt1x5p+DLC0ozs6eoScdnA6CkrDEOSno
         W++m58HSLAWfFfeAvwEDKXx0dqosjacuWH/Oqwqii2s/StBqDV2D4arf8THqwLG46K+T
         qKHky3Sq4JzXDAcaz1OGRcZsSsQ2j7L4jVXUeholSmT8ESzYzybQCWyCfaJQuu0rPafy
         XiwE2/cYTkXz1KIv9PvinMSj9/VzHp+lGw1zNUN9pP9Ly6fSlGBm/V2gdjDqayuPUJ2D
         GSLA==
X-Gm-Message-State: AOAM530bQot6qaRVVdfPDVMn/YIdVtGUr4aoNhCzrcVyQuYJp9nv20Kg
        J69x7IQJLV5Whcx+4t7JbQ==
X-Google-Smtp-Source: ABdhPJz71oPj2TNEhEBB8ai4smaVNRs56Lw/4j9Vw2ROj2ARLOebKN75gZaxSdI4G0UHd+Bm4kLuUw==
X-Received: by 2002:aca:534b:: with SMTP id h72mr5579620oib.82.1604331070156;
        Mon, 02 Nov 2020 07:31:10 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h32sm3671367oth.2.2020.11.02.07.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 07:31:09 -0800 (PST)
Received: (nullmailer pid 3927253 invoked by uid 1000);
        Mon, 02 Nov 2020 15:31:08 -0000
Date:   Mon, 2 Nov 2020 09:31:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org
Subject: Re: [PATCH v3 26/26] dts: bindings: coresight: ETM system register
 access only units
Message-ID: <20201102153108.GA3927223@bogus>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-28-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-28-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 22:09:45 +0000, Suzuki K Poulose wrote:
> Document the bindings for ETMs with system register accesses.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
