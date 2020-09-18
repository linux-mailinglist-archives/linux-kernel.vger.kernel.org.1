Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666AF270367
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIRRbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:31:06 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37282 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRRbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:31:05 -0400
Received: by mail-il1-f194.google.com with SMTP id q4so6979647ils.4;
        Fri, 18 Sep 2020 10:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/dnvjIk6kRdN9RcFTnO38ZI6MysMJcAHfnKv4EKjfks=;
        b=H05V3hrHu/63Xm1EgF7c/YpZHxI1w9H8hK7y+KtxftxmjJpSi5ebwdyOJ5wEbLUUq7
         CLlQ3pX7Di5WE+VvNBMaXTre4wkYUN5w8h3/WeFbfTQ9eK6rFoSmR9cbL4COyjTf3HCj
         6OZlllHYwl/FTKYxBik0CNLWuRQozqtiEdS5R23Whf1qIYr0sbPMgOJgLAcL3Z8NTuml
         KGdNLBgJ/8mAMzsTMPSCMWWMBP6+bJGp9DPYgzGy1fPXh1mOVVSAcJn1enOUGldfiQeE
         yUgLwTo66eMejPz9P5ie8CMhYXw52+Rldbn0seFyobLwxsRf7A3h5upQktbipFLPoyUF
         D2rA==
X-Gm-Message-State: AOAM532bnYg8uy7zp4S0cY42YBlk39zenM6h+DcBFQ9QVu4o0hFDPy8F
        ynAmA9/GvDzbRn4UZPyAoA==
X-Google-Smtp-Source: ABdhPJxkH6B9G6X/6iPqMXB9irFe8HwwInqRi2YG3MjO/aEkkg5cZ4OtYHLY9D9pcWcU5yptwEZF+A==
X-Received: by 2002:a92:c146:: with SMTP id b6mr21903884ilh.244.1600450264414;
        Fri, 18 Sep 2020 10:31:04 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s1sm1941570iln.22.2020.09.18.10.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 10:31:03 -0700 (PDT)
Received: (nullmailer pid 3830090 invoked by uid 1000);
        Fri, 18 Sep 2020 17:31:01 -0000
Date:   Fri, 18 Sep 2020 11:31:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Caesar Wang <wxt@rock-chips.com>, dianders@chromium.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
        Collabora Kernel ML <kernel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: power: rockchip: Convert to json-schema
Message-ID: <20200918173101.GA3829772@bogus>
References: <20200918093229.252766-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918093229.252766-1-enric.balletbo@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 11:32:29 +0200, Enric Balletbo i Serra wrote:
> Convert the soc/rockchip/power_domain.txt binding document to json-schema
> and move to the power bindings directory.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2:
> - Fixed a warning that says that 'syscon' should not be used alone.
> - Use patternProperties to define a new level for power-domains.
> - Add const values for power-domain-cells, address-cells, etc.
> 
>  .../power/rockchip,power-controller.yaml      | 207 ++++++++++++++++++
>  .../bindings/soc/rockchip/power_domain.txt    | 136 ------------
>  2 files changed, 207 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
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
  in "<unicode string>", line 106, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 114, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:18: Documentation/devicetree/bindings/power/rockchip,power-controller.example.dts] Error 1
make[1]: *** Deleting file 'Documentation/devicetree/bindings/power/rockchip,power-controller.example.dts'
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/power/rockchip,power-controller.yaml:  while scanning a block scalar
  in "<unicode string>", line 106, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 114, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
make: *** [Makefile:1366: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1366725

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

