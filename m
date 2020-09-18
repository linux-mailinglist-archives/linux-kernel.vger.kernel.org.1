Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48297270357
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIRR3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:29:22 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34646 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgIRR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:29:02 -0400
Received: by mail-io1-f65.google.com with SMTP id m17so7691598ioo.1;
        Fri, 18 Sep 2020 10:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cKo+hTXkHCXN9MEzBtG6n82KOIrEo4eRcYwX6t6+cgM=;
        b=DOFnKWO4ecWnGg6n5EnzQTGO/Td8NH1eIK/kO3AzyUKlcgFU5HgiXhoKRuZw9S1JOg
         G2LD+Gj+Caqai+NCUTl2KJB4qSU0vYm2ezSPT+Y0T9fNg3LJePEc2os+4JVpxvkVZkF/
         gfp0dpOhvlBHqzRQ7fFL23hMsCy82M6kzn5SdxlgP2l3g0h/mA7rZrYLOfyoy254Dj3u
         NWLuKMDO6Q7j51DRzxSTs1YtiEjgDij9sJKywysDJL/MogHgswDTuQUPqXSCWsyXgS+R
         5b2Xn1U+/T937tpKZ22s3JG4D9d+CYOGvaZu1NmU9X0lhP2FTCk/dTUwKsSZOsNMPjgN
         BLbg==
X-Gm-Message-State: AOAM532PR7BaHuWBMn6DmHEprVRzVyN+pVr9qdWOt7RN5fNha255Pb17
        Tcl1iDSs5XaMm8Oeh5M8pw==
X-Google-Smtp-Source: ABdhPJxtwWH6WpNO+NhwMvu594kog/paKNQO8JIXKkWSVWP+VxYzcLAcvSX+XtzUmlqKKam+LC1Vkg==
X-Received: by 2002:a6b:610d:: with SMTP id v13mr27869842iob.189.1600450140876;
        Fri, 18 Sep 2020 10:29:00 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w8sm1986626ilc.85.2020.09.18.10.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 10:29:00 -0700 (PDT)
Received: (nullmailer pid 3826823 invoked by uid 1000);
        Fri, 18 Sep 2020 17:28:58 -0000
Date:   Fri, 18 Sep 2020 11:28:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alban Bedel <alban.bedel@aerq.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: Convert lm75 bindings to yaml
Message-ID: <20200918172858.GA3826509@bogus>
References: <20200917101819.32045-1-alban.bedel@aerq.com>
 <20200917101819.32045-2-alban.bedel@aerq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917101819.32045-2-alban.bedel@aerq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 12:18:17 +0200, Alban Bedel wrote:
> In order to automate the verification of DT nodes convert lm75.txt to
> lm75.yaml.
> 
> Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
> ---
>  .../devicetree/bindings/hwmon/lm75.txt        | 39 -------------
>  .../devicetree/bindings/hwmon/lm75.yaml       | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/hwmon/lm75.example.dts:21.17-30: Warning (reg_format): /example-0/sensor@48:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/hwmon/lm75.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/lm75.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/lm75.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/lm75.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/lm75.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/lm75.example.dt.yaml: example-0: sensor@48:reg:0: [72] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1366031

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

