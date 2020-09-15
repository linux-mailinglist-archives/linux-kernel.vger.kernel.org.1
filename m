Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0886726B5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgIOXwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:52:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37064 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgIOOcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:32:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id w7so2057978pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mv7dyR4sjl+BVQ9RdeFPf0paoZFTYPDkq70MlZEfWDQ=;
        b=kV8jyka23dTpYYftksQCvCk7JkQN9H5R+yAhOX1McL7G4WXIjsSTRUursLQOlQRvib
         IhCcGEnLXTLNxEQOjILBWxwg5ljsGCdgCp5Wt5c3uuAydPp3zNQz/dhNqW8pYTzSCouG
         MmMq3hVYBLu+UIwcAPWRjsyDBLHTg9de7XXz3IrGHAmhw2swCZZO9es7iQyttyfcF0dt
         QlnWomN65ajrguYlqp4WYQvYMyqiZJsXWCdOxcYhwr1ngAETNsu9taJL+Js77+yvRfpM
         ASwVb5QFi8dz3LCQ4u+iyNU/c1p8F+E0ePuGQk5ikgEBVhMWpKGrKpo33o8wT+YtcOJ1
         R0uQ==
X-Gm-Message-State: AOAM530UdoOMMWKy6Iwuu+sYsoUCZattpzKBIdDG65OmQx82gaIUib9R
        C2AWSXNwG7adaTdxbhSa0JEm+ecyas6RTds=
X-Google-Smtp-Source: ABdhPJyyM19BYSpWbpH3kwRqswRw9fK5YfGImOr7xdoFoH6gheQZQGCGUsYKmRyVAw4pJCa4LotBRQ==
X-Received: by 2002:a92:4f:: with SMTP id 76mr15938072ila.11.1600179715629;
        Tue, 15 Sep 2020 07:21:55 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m19sm9007665ila.40.2020.09.15.07.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 07:21:54 -0700 (PDT)
Received: (nullmailer pid 1873453 invoked by uid 1000);
        Tue, 15 Sep 2020 14:21:53 -0000
Date:   Tue, 15 Sep 2020 08:21:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@nxp.com>,
        Douglas Anderson <dianders@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add binding for onboard USB hubs
Message-ID: <20200915142153.GB1861636@bogus>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 11:27:48 -0700, Matthias Kaehlcke wrote:
> Onboard USB hubs need to be powered and may require initiaization of
> other resources (like GPIOs or clocks) to work properly. This adds
> a device tree binding for these hubs.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>  .../bindings/usb/onboard_usb_hub.yaml         | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 848, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a block scalar
  in "<unicode string>", line 43, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 52, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:18: Documentation/devicetree/bindings/usb/onboard_usb_hub.example.dts] Error 1
make[1]: *** Deleting file 'Documentation/devicetree/bindings/usb/onboard_usb_hub.example.dts'
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml:  while scanning a block scalar
  in "<unicode string>", line 43, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 52, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
make: *** [Makefile:1366: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1363875

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

