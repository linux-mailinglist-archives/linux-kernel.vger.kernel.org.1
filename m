Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DD0285314
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgJFU0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:26:49 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42101 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgJFU0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:26:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id 16so6408495oix.9;
        Tue, 06 Oct 2020 13:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DB0x0/dmfpTqmbKH0+qVY91nKVQu4n12ZP0ID6+Du8Q=;
        b=RdqjiVrFKfJJUKqgry00f3Gwd5dNcxMj2B5DketFyYGKon4hD4Qe5WSispl47zIJs1
         GalrEzRnoqI20OBarO0qYF1jYHm9BPQQbLKUwXOMkPlbEJlu3xf1YRa7XfsN5ieyhe6n
         J0dHSrz0MftY8X6JmaQBydTQ3LfSUrf2bgXd+K8LR6og5QcnmXifszIDHnviOha4KzMc
         01I5dDAIycu4LK/OV2/sttsOrCTN59BMOfqgXIJzyS/n+Y+7/a1IjKANpdZwpemQ2HAx
         eOLrCAro9kFN0XLTHvqb8uidNLjCABtOsyr2kA9rH0XGIYVcmtvwe6LR1h+XojEN+2rD
         fX/A==
X-Gm-Message-State: AOAM531UJYDZH0CnYQRVfrh22Lu+6XxhIPp19qsEBCgcUudYRTyRN2jN
        cNdS2VkjT9l0VQj+1ULQiA==
X-Google-Smtp-Source: ABdhPJyrW+3gr9x1StQlh78JeTO44pdGMm7KWZV8fPILGkz61BGd+IxJuslQ+caB0ZBOYW/0U/yfPw==
X-Received: by 2002:aca:53c8:: with SMTP id h191mr1295oib.173.1602016006173;
        Tue, 06 Oct 2020 13:26:46 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p8sm1703377oip.29.2020.10.06.13.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:26:45 -0700 (PDT)
Received: (nullmailer pid 2777606 invoked by uid 1000);
        Tue, 06 Oct 2020 20:26:44 -0000
Date:   Tue, 6 Oct 2020 15:26:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alban Bedel <alban.bedel@aerq.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Convert lm75 bindings to yaml
Message-ID: <20201006202644.GA2777554@bogus>
References: <20201001145738.17326-1-alban.bedel@aerq.com>
 <20201001145738.17326-2-alban.bedel@aerq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001145738.17326-2-alban.bedel@aerq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020 16:57:36 +0200, Alban Bedel wrote:
> In order to automate the verification of DT nodes convert lm75.txt to
> lm75.yaml.
> 
> Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
> ---
> v2: Fix the example to pass `make dt_binding_check`
> v4: Add the missing additionalProperties: false
> ---
>  .../devicetree/bindings/hwmon/lm75.txt        | 39 ------------
>  .../devicetree/bindings/hwmon/lm75.yaml       | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
