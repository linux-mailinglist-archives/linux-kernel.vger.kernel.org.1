Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9512745DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIVP6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:58:41 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46518 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:58:41 -0400
Received: by mail-il1-f196.google.com with SMTP id l16so4338508ilt.13;
        Tue, 22 Sep 2020 08:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ky/g9Bh/3A2Yu8Dpac7+sFIIUN7vYeTpFG2bIN9DxY=;
        b=tm5wdH8zpW3zjFZ87d+aCgfE/u9qfuSgftM52/OUxw3ju+NpyLy2R1gaCZyZJTlTkf
         9bLs0bmBJwcLf6S2WppwyFJ2PwxWzdlcEXiNdQonoTr9q0bVQTUgxSRGisjczrk9blM5
         b8AYudt/BpS0UM/QzewMfkmZOdS5KKcqyioQFCBfRy5obD0dSGtOaG8VVwFCZEg33yhF
         SqbEzO6N49oP5jZC4hCslhrTcViciChvoz1zgO5Yi521J8+bbc5KIkq6icShbEUbK1Rp
         fJeeZsALDAEhZUfoWtucNR7ToPCi6D8cj3UuEHTmL5b08LK3C12HCR5GzjbeMHMzjQA6
         rFNg==
X-Gm-Message-State: AOAM533bKnnG0w3LS9r6bDnL81/wyQnRxCj0/tVMG1j20zFMTJvQpgph
        ZMKneqyxFjqZyqiCyFLaIhZK2i5jlxNs
X-Google-Smtp-Source: ABdhPJywLk6F1IBPQiVuwvGzdZttZx10QzDWZl2mNBEtYl7uk6fQ+qLO2PrC2BfFlir9Z17AiGw0Cg==
X-Received: by 2002:a92:5a48:: with SMTP id o69mr5026639ilb.268.1600790319990;
        Tue, 22 Sep 2020 08:58:39 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u25sm7486488iot.35.2020.09.22.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 08:58:39 -0700 (PDT)
Received: (nullmailer pid 2759069 invoked by uid 1000);
        Tue, 22 Sep 2020 15:58:36 -0000
Date:   Tue, 22 Sep 2020 09:58:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     poeschel@lemonage.de
Cc:     linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 32/32] auxdisplay: lcd2s DT binding doc
Message-ID: <20200922155836.GA2758392@bogus>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
 <20200921144645.2061313-33-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921144645.2061313-33-poeschel@lemonage.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 16:46:44 +0200, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> Add a binding doc for the modtronix lcd2s auxdisplay driver. It also
> adds modtronix to the list of known vendor-prefixes.
> 
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> --
> Changes in v2:
> - Adopted yaml based file format
> ---
>  .../bindings/auxdisplay/modtronix,lcd2s.yaml  | 55 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml
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
  File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.parser.ParserError: while parsing a block mapping
  in "<unicode string>", line 4, column 1
did not find expected key
  in "<unicode string>", line 55, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:18: Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.example.dts] Error 1
make[1]: *** Deleting file 'Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.example.dts'
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml:  while parsing a block mapping
  in "<unicode string>", line 4, column 1
did not find expected key
  in "<unicode string>", line 55, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml
make: *** [Makefile:1366: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1368465

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

