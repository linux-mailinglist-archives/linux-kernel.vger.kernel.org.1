Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DC12745E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgIVP7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:59:13 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38044 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:59:13 -0400
Received: by mail-il1-f196.google.com with SMTP id t18so17801981ilp.5;
        Tue, 22 Sep 2020 08:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EFVKF4d/g5CR+iQuSKq+wsklSzMxkKSkhkVK2gTQu/A=;
        b=DYsWoy32xk9HNpdyOvr7iIQU60Z6HE/nkDT10YrhfXEKxE6BGSlZ2ft54Qr/7jb13a
         iN/s1UUfn0BSLQRyp/Yks90ihyjH+XDT/I9C7eRA9aBX04Axc5wD//RkId8KHMISVb57
         zEYSQpYQe3Q8AHEUxvwEkvgdDL0WY8LO4vV5SnwP/wRKBDFG32m9i96yoE2xculyNEnI
         u2H7MKVmDjsjf7y8Dq7f5iC7fwarUchp0GWfHzS39LdTj2cw62n9f3nSka5eZty0g47+
         C625PuYomKAmY4A2/V4qxcemkJM9VYYRFjJEKhNW29DhgLjtPeR3a61WsZ0NF9gHe1X5
         ELKA==
X-Gm-Message-State: AOAM533kqZ1VDQBF0WgRe9BR6bGYdRo4tOeaA0jgR2oQ/ed8NSE0tgyi
        j5c6y3IpprnHktitFZMGC/qT+ol0WtBm
X-Google-Smtp-Source: ABdhPJxHli8PSuJK8257OPkqzqv/ebWdRG6dEP5LcYibIHbtDkiD9cWhKZQxWQ0vbFxxOxBMUdtCYQ==
X-Received: by 2002:a05:6e02:1085:: with SMTP id r5mr4900199ilj.44.1600790352186;
        Tue, 22 Sep 2020 08:59:12 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z4sm7709161iol.52.2020.09.22.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 08:59:11 -0700 (PDT)
Received: (nullmailer pid 2760083 invoked by uid 1000);
        Tue, 22 Sep 2020 15:59:10 -0000
Date:   Tue, 22 Sep 2020 09:59:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v8 03/11] dt-bindings: usb: Maxim type-c controller
 device tree binding document
Message-ID: <20200922155910.GA2759479@bogus>
References: <20200921195555.1050731-1-badhri@google.com>
 <20200921195555.1050731-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921195555.1050731-3-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 12:55:47 -0700, Badhri Jagan Sridharan wrote:
> Add device tree binding document for Maxim TCPCI based Type-C chip driver
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
> 
> Changes since v6:
> - Migrated to yaml format.
> 
> Changes since v7:
> - Rebase on usb-next
>  .../devicetree/bindings/usb/maxim,tcpci.yaml  | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/maxim,tcpci.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/usb/maxim,tcpci.example.dts:38.36-37 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/usb/maxim,tcpci.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1366: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1368587

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

