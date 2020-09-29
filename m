Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27FC27D53E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgI2R5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:57:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41362 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgI2R5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:57:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id q21so5316016ota.8;
        Tue, 29 Sep 2020 10:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zPa+zT0cksSEaTLxnH5pai9R5igvMOh8ad39wKZXIuo=;
        b=eCu24VaxputpGP9RknorciWCZq3EtogpBvxPwx2bdKTj+R7H0E2bCVdxN8SixjD6Wh
         qIp4npVujAC3q4ecR1njOeF4a+fHWRa7+NnLlJYwpB5F9QPFByWI+M9xcAM9CfyOw48a
         gBr+qyHAb3gY0xK0QhRcVCUxSFS++6DesbTenJsJff6dW/w4OBzOmQEO6E1KVWMbdZlz
         9c6ZOsnvPpQV97GKypnXf1Zzg35x42ZTic5HZlCNkF7CTREuAdQazbY+GYQSyO7k9+k1
         Zco1TGOVrfGTa9MgX/5xbC7KoxsJTwnwzyVgfUSBSuqGSbJcd4h+gq/oOH4jyV144SW2
         DK9w==
X-Gm-Message-State: AOAM531T6Xq2wisKPqjISPLl1m6HAoUHEKzyQcCvmHm5yk2tw5cdOn3/
        aoPfKsjYmMb6ZoOir+vR+w==
X-Google-Smtp-Source: ABdhPJyRfLTPIBcQK5jJHx7sGVY4ZZNKNLayRqJxPShCc1BBXeK03zVwknByv8H7vc1sKqmDedBtvw==
X-Received: by 2002:a05:6830:16d1:: with SMTP id l17mr3585551otr.105.1601402223107;
        Tue, 29 Sep 2020 10:57:03 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w25sm1150828oth.22.2020.09.29.10.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:57:02 -0700 (PDT)
Received: (nullmailer pid 864990 invoked by uid 1000);
        Tue, 29 Sep 2020 17:57:01 -0000
Date:   Tue, 29 Sep 2020 12:57:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add an entry for
 Plymovent
Message-ID: <20200929175701.GA864938@bogus>
References: <20200922051454.30878-1-o.rempel@pengutronix.de>
 <20200922051454.30878-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922051454.30878-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 07:14:52 +0200, Oleksij Rempel wrote:
> Add "ply" entry for Plymovent Group BV: https://www.plymovent.com/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
