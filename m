Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894CB27D79F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgI2UIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:08:09 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40562 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbgI2UIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:08:06 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so6881570oif.7;
        Tue, 29 Sep 2020 13:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tEjGdyigiYq/Vew+d6aDkAbA6G15ZhYScWUVPdFWPR0=;
        b=c/RXtgVuCXdfuwPy4DJueYl1fciar6tL2ts4w9nISpc9Vy1OLrEIOVis0GvPO3sjWQ
         FuwEradr6+/hsmZSaAnGgw7FcucFk5Tc0i1YAwsVRtPIaMEbrC619eqDEwKSZee7gMvj
         tOH+fTAfuacTWflaI/t/YP1FqtMkz7fIelYlQyzxDxhPh2wLGxzH5XJWeirxFmtskpbB
         2R6uEqJLTR3clukyWNvisvb59dDd5BllIbG8kLdCUI2wg2VGNf0P8By/1IM/PuMbQZPR
         /fScd9hCPjz7ik7zuqKLsGX+D4Nb3NmMfruUk/w/IVl+kLDRQjPPOPvhD/bw0gCJ8IDt
         Jpsg==
X-Gm-Message-State: AOAM532bloPzJjxlqjJIQkhlqIYmYQkZjW4+z32wdFScxx2yGfzdo2AB
        F4PNMLFQaGmgsANHeIiJiQ==
X-Google-Smtp-Source: ABdhPJwpsmxom2RDb8/0qLp/q4YPVAI3qAHXAncJc++/sg44rh/f6H8n1wSpUocJwRGfOboKtRWJLw==
X-Received: by 2002:aca:578c:: with SMTP id l134mr3413248oib.119.1601410085416;
        Tue, 29 Sep 2020 13:08:05 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i205sm1230997oih.23.2020.09.29.13.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:08:04 -0700 (PDT)
Received: (nullmailer pid 1077618 invoked by uid 1000);
        Tue, 29 Sep 2020 20:08:04 -0000
Date:   Tue, 29 Sep 2020 15:08:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alban Bedel <alban.bedel@aerq.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: hwmon: Add the +vs supply to the
 lm75 bindings
Message-ID: <20200929200804.GA1077587@bogus>
References: <20200928153923.134151-1-alban.bedel@aerq.com>
 <20200928153923.134151-3-alban.bedel@aerq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928153923.134151-3-alban.bedel@aerq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 17:39:22 +0200, Alban Bedel wrote:
> Some boards might have a regulator that control the +VS supply, add it
> to the bindings.
> 
> Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
> ---
> v2: Removed the unneeded `maxItems` attribute
> ---
>  Documentation/devicetree/bindings/hwmon/lm75.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
