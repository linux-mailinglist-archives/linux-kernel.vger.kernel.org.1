Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E4B242F20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 21:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgHLTX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 15:23:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35249 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLTXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:23:55 -0400
Received: by mail-io1-f65.google.com with SMTP id s189so4296449iod.2;
        Wed, 12 Aug 2020 12:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CAWF7Jt4a9XH9KYO4dcyBdn0laPconrW8GiC39C5qmk=;
        b=O59A/9vuIQ8aX09iSw2qD7fUk9fdrCA/papeWBrQg/Ut0WiQaA86nIj+iFNTaelGWs
         ESHO8lkel2Az1SO5m5qSP4PgeB3GevpPbVXUVv7nSVknW180CuztqWoY1bhq1QWf7Uzy
         6OsMDhbT3WnCqUr36okUxEpUg7gUNnymFR0iDRqt2TTgmQz1WaApG5hefntKCTMwewyo
         SzWeKBT7ujPefNDNFKW3qYhJ2eDXV2xJKMFj/tw4WxydvObDc8/zchzcdnFycL+CIhDo
         7EGqS6ltZ4Dk5fxAzWP32MNB+aZZC5AuVkCQ5hXVmiAi9aZb7oEwSy9cU7eMrwxozNnC
         ClwQ==
X-Gm-Message-State: AOAM533+InAr/xaqoTGPfCwkOCCVXwzVfYKSr6QSAozeigGaNlerlpcU
        qO/S6G9jSAL7Or24nZXeLg==
X-Google-Smtp-Source: ABdhPJy/vlGNYKad8kn1HY+zNDmhj32gPvXevOi1ZbKRT33+ddL1/5yDNmY9YEuLloWmlp3gX5Vmwg==
X-Received: by 2002:a6b:e70d:: with SMTP id b13mr1270683ioh.141.1597260234242;
        Wed, 12 Aug 2020 12:23:54 -0700 (PDT)
Received: from xps15 ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e1sm1522784ilq.40.2020.08.12.12.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:23:53 -0700 (PDT)
Received: (nullmailer pid 2560563 invoked by uid 1000);
        Wed, 12 Aug 2020 19:23:51 -0000
Date:   Wed, 12 Aug 2020 13:23:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: regulator: Convert sy8824x to json-schema
Message-ID: <20200812192351.GA2560480@bogus>
References: <20200803144436.5d2b7e54@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803144436.5d2b7e54@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Aug 2020 14:44:36 +0800, Jisheng Zhang wrote:
> Convert the sy8824x binding to DT schema format using json-schema.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
> Since v2:
>  - add $ref to regulator.yaml
>  - add unevaluatedProperties
> 
> Since v1:
>  - It seems there's something wrong with my last email, so send out a v2 with
>    another email account
> 
>  .../bindings/regulator/silergy,sy8824x.yaml   | 45 +++++++++++++++++++
>  .../devicetree/bindings/regulator/sy8824x.txt | 24 ----------
>  2 files changed, 45 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/sy8824x.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
