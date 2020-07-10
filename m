Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B1021BAFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 18:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgGJQb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 12:31:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41206 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgGJQb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:31:56 -0400
Received: by mail-io1-f67.google.com with SMTP id o5so6616733iow.8;
        Fri, 10 Jul 2020 09:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k6x2zODly9ZYHpv6ACDhH5er/SlGtQVdII9NFL5Jqko=;
        b=WTEO9DKG8+PgmKbLlujPtcq9LjY2YU4djHXitggrgwCe3lr18FswqXH/yrmySIz/vX
         nJVAPXjAZCbp29XCxtpUmLzV76WIKQzZe6xNpZNv2yNCprkcY2Y3DgQ9JGuxssw3pB0y
         KyobWOBizJ/LbQfUlGXOfq34pfr/msFTAbJhGkPC6mYbg9ap/f4/PykgqJKosNfFPt1c
         8hPZni6e0LTF+/3kVXYD8ScRZ8cNwzi8Vh1/6WVRUtTQdSeiVsWUAa2Z9jnMfEKJtPjD
         FwTWAYHm+i+/boc7ZLcMQHFiYr8q2ojU9cYoDglBuMSsgb6saf1bQkBb3dnDUVcc5MOd
         UEsw==
X-Gm-Message-State: AOAM532pdzgB2XZNARhL2UrgtFyf1BoCwiXDiEwxKhxtMP4K0u98mw7o
        6ljwTjoA6BfkN2LQ8T/JyA==
X-Google-Smtp-Source: ABdhPJxmfCqmpVl/CfTyQglNJOGk8o6upZI4VxpOAAKUQn90PZPu6KLSnHJXoTze3QrCQrvSol79Bw==
X-Received: by 2002:a05:6638:1187:: with SMTP id f7mr79554526jas.58.1594398715148;
        Fri, 10 Jul 2020 09:31:55 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id z9sm3680512ilb.41.2020.07.10.09.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:31:54 -0700 (PDT)
Received: (nullmailer pid 2760588 invoked by uid 1000);
        Fri, 10 Jul 2020 16:31:53 -0000
Date:   Fri, 10 Jul 2020 10:31:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Guenter Roeck <linux@roeck-us.net>, Jack Lo <jack.lo@gtsys.com.hk>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
Message-ID: <20200710163153.GA2760091@bogus>
References: <20200710021536.27544-1-chris.ruehl@gtsys.com.hk>
 <20200710021536.27544-3-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710021536.27544-3-chris.ruehl@gtsys.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 10:15:35 +0800, Chris Ruehl wrote:
> Add documentation for the newly added DTS support in the shtc1 driver.
> To align with the drivers logic to have high precision by default
> a boolean sensirion,low_precision is used to switch to low precision.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  .../bindings/hwmon/sensirion,shtc1.yaml       | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dts:25.13-14 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:315: recipe for target 'Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1326414

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

