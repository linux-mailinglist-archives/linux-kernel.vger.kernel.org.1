Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECD71EA741
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgFAPpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 11:45:45 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39205 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:45:44 -0400
Received: by mail-il1-f195.google.com with SMTP id p5so8712228ile.6;
        Mon, 01 Jun 2020 08:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9eAi6L1Wwr3b4WyGnwlWexYJD0hToo1UIxNvGsxBAHg=;
        b=NLZtgQlSJ4bpsBIajcRfvelOVkwnH67ApeaRZS1XCVi6hkWR6tLk+j4DidxL81+PBY
         5ovHeUFEmDwaepeB6c/Mwa7+GqzbPbUrr2iNYWTvSOxWf80Lut8iu2007fkffGfVRPa5
         FrTTzA6Whq+iRg9jecdBoyCQkFySmkslKhEm/XwCK5sHgExikAFXBXQdqwPxIlgKwe3a
         VEJr+tZt6R4qb9tOXgIPiSQzvsJattbEgYo7Wa8uxGF7vyGPDAMjPI7H7sMereXDnc+5
         Q+TcqQENQ1klBbSdkCM9DctulpBRhbi0b7Eh0b0Ix3u+//k4kLbNhK5KH2XxQsUai+Gb
         ojiw==
X-Gm-Message-State: AOAM531i85EZcUEPjrBNSJDkbNi2Zh1DirC0vwtls/QPvfJecR89bmtp
        T7iqnDiy7AQys2c2W3D21JHJysk=
X-Google-Smtp-Source: ABdhPJxjnYD2UksdFfSt5FPK33IF1kdBEIa5oPEWJ8ZUKlZkfDjA3+Vmny5r+fRBo71fa1pKF4XzEg==
X-Received: by 2002:a05:6e02:c62:: with SMTP id f2mr8170084ilj.43.1591026343897;
        Mon, 01 Jun 2020 08:45:43 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p75sm9948000ilb.23.2020.06.01.08.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:45:43 -0700 (PDT)
Received: (nullmailer pid 967107 invoked by uid 1000);
        Mon, 01 Jun 2020 15:45:42 -0000
Date:   Mon, 1 Jun 2020 09:45:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        hongxing.zhu@nxp.com, linux@rempel-privat.de,
        devicetree@vger.kernel.org, Linux-imx@nxp.com,
        aisheng.dong@nxp.com, jaswinder.singh@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: mailbox: Convert imx mu to json-schema
Message-ID: <20200601154542.GA967000@bogus>
References: <1591007864-30267-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591007864-30267-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Jun 2020 18:37:44 +0800, Anson Huang wrote:
> Convert the i.MX MU binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/mailbox/fsl,mu.txt         | 58 --------------
>  .../devicetree/bindings/mailbox/fsl,mu.yaml        | 89 ++++++++++++++++++++++
>  2 files changed, 89 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.txt
>  create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> 

Applied, thanks!
