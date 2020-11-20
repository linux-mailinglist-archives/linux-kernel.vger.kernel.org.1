Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EFE2BB811
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgKTVDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:03:51 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34264 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgKTVDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:03:51 -0500
Received: by mail-ot1-f65.google.com with SMTP id j14so10060257ots.1;
        Fri, 20 Nov 2020 13:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O65YbVoUCwPPqb4vh57HQOwrA45uehfsHs7MDRTYAAU=;
        b=ROkRVT0sefAR+sXP9NrN6lamXMPeD7fritNKpYSyKcKosnX+MP+02TMF4phkfIm3T5
         l/LglMaF4BSNYHSHw9HcsOyukYyarRqHzfTtnDv+BE/1UipOhWtdHiPK/Wie9h2LydW6
         yDvCzlbveSnPJ+nMPtEjarpqKizGUvBc1dP8tApuJeFm5Xc96s3AnWTRACO+wwPHQj/s
         94Uy6fnNcpt4YJOfc8yX8sIdN9SsxiMyc2YeFubGDg6xAP/5jNH9OdkUbwO978AOspsS
         t+wzr1/zzn+c+Y3Gf04H5DFHowz8x2R2D5z6/r+tcAtpWQ5NpyySAEFIj1ovtV5v7EPC
         s9Ew==
X-Gm-Message-State: AOAM530EUbSEXoASIQwqLHQGUK4Th110Iaya2ka5QVhg5KCNtC9I6kPL
        xWeNhTEJ9RX0j7pdlNCmFMqeb5XMDQ==
X-Google-Smtp-Source: ABdhPJyyd4nJ5cBeo0GfgCatXLS1+K5s7Wdlo9Y4p10ZxC6b39GxFzKFByFu7DhX54sswaXYUOnhdA==
X-Received: by 2002:a9d:3408:: with SMTP id v8mr15548863otb.335.1605906228600;
        Fri, 20 Nov 2020 13:03:48 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a1sm1867965oti.56.2020.11.20.13.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:03:47 -0800 (PST)
Received: (nullmailer pid 1735577 invoked by uid 1000);
        Fri, 20 Nov 2020 21:03:46 -0000
Date:   Fri, 20 Nov 2020 15:03:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Marc Zyngier <maz@kernel.org>, Steen.Hegelund@microchip.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 1/6] dt-bindings: interrupt-controller: convert icpu
 intr bindings to json-schema
Message-ID: <20201120210346.GA1734708@robh.at.kernel.org>
References: <20201120164108.2096359-1-gregory.clement@bootlin.com>
 <20201120164108.2096359-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120164108.2096359-2-gregory.clement@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 17:41:03 +0100, Gregory CLEMENT wrote:
> Convert device tree bindings for Microsemi Ocelot SoC ICPU Interrupt
> Controller to YAML format
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../mscc,ocelot-icpu-intr.txt                 | 21 -------
>  .../mscc,ocelot-icpu-intr.yaml                | 60 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml:55:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
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
  in "<unicode string>", line 50, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 55, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.example.dts] Error 1
make[1]: *** Deleting file 'Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.example.dts'
make[1]: *** Waiting for unfinished jobs....
make[1]: *** [Documentation/devicetree/bindings/Makefile:59: Documentation/devicetree/bindings/processed-schema-examples.json] Error 123
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1403891

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

