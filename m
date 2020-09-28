Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EDD27B42F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgI1SNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:13:41 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33410 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1SNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:13:41 -0400
Received: by mail-oi1-f196.google.com with SMTP id m7so2390042oie.0;
        Mon, 28 Sep 2020 11:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qIed0AZbGySyEYhihYit5M1eU2PobBaOvQ2gDiU03kg=;
        b=g4De2ayNVePHU2e43v1gPSUUu1mJKDZUytslTAIIIPWVELz0ji36IMdDtWRlP1HT+6
         0BfIaRQa2RQBswOy6XL1m3607MyJP3ebSEkwdmWSzXr91Euu+n94ZkWAD8KQqdn+HKZv
         g+bxHfeY9FYUJbP0pV/SS5c47TVHS0AYJ768yqNTkFFOXL0hcNuY5614hBNCSWGqbFJp
         KlWNra14Xzhb5q/rWOcutjrS34v5WU2wea94zILlHVtLvJylcGA1gr2V7Cwj8h9jjpRL
         nHB9OW0eMosdbsB1qaosxRc/LWZS0/dTFQsIBvzCihjESg0/ZJTTZjFk+90EznXVnXs4
         ESgg==
X-Gm-Message-State: AOAM531ZoSnoGnIKyhEZJvrCv1seHKDckWOulsRFifPkxQG4XIBjEGyW
        XKCQL4PCZFG0dLEbUbUS9f9JQGZ+GfwK
X-Google-Smtp-Source: ABdhPJyVkMss163LB0owHTCGQn6iaPg64kRmlzjT42+yiiIRMh6u7cl0KtK4rcDXmA2WPqhyQY02aQ==
X-Received: by 2002:a05:6808:1ce:: with SMTP id x14mr72084oic.133.1601316820466;
        Mon, 28 Sep 2020 11:13:40 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d22sm393023oij.0.2020.09.28.11.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:13:39 -0700 (PDT)
Received: (nullmailer pid 3013137 invoked by uid 1000);
        Mon, 28 Sep 2020 18:13:39 -0000
Date:   Mon, 28 Sep 2020 13:13:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-hwmon@vger.kernel.org, robh+dt@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, p.zabel@pengutronix.de,
        cheol.yong.kim@intel.com, linux-kernel@vger.kernel.org,
        qi-ming.wu@intel.com, andriy.shevchenko@intel.com,
        devicetree@vger.kernel.org, songjun.Wu@intel.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 1/2] Add DT bindings schema for PVT controller
Message-ID: <20200928181339.GA3012847@bogus>
References: <cover.1601285307.git.rahul.tanwar@linux.intel.com>
 <f3f977389f74f416a70b7f5276243cf722ba6fee.1601285307.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3f977389f74f416a70b7f5276243cf722ba6fee.1601285307.git.rahul.tanwar@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 17:44:18 +0800, Rahul Tanwar wrote:
> PVT controller (MR75203) is used to configure & control
> Moortec embedded analog IP which contains temprature sensor(TS),
> voltage monitor(VM) & process detector(PD) modules.
> 
> Add DT bindings schema for PVT controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/moortec,mr75203.example.dt.yaml: example-0: pvt@e0680000:reg:0: [3764912128, 128, 3764912256, 384, 3764912640, 512, 3764913152, 3072] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/moortec,mr75203.example.dt.yaml: pvt@e0680000: reg: [[3764912128, 128, 3764912256, 384, 3764912640, 512, 3764913152, 3072]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/moortec,mr75203.example.dt.yaml: pvt@e0680000: vm-map: [[3, 1, 4, 255, 255]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml


See https://patchwork.ozlabs.org/patch/1372474

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

