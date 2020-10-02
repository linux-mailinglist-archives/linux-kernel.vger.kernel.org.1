Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1B628146E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbgJBNqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgJBNqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:46:11 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B7AC0613D0;
        Fri,  2 Oct 2020 06:46:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id D682123F715;
        Fri,  2 Oct 2020 15:46:08 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.958
X-Spam-Level: 
X-Spam-Status: No, score=-2.958 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.058, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Dm_cv4MbxomO; Fri,  2 Oct 2020 15:46:07 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 2A4B223F47B;
        Fri,  2 Oct 2020 15:46:05 +0200 (CEST)
Date:   Fri, 2 Oct 2020 15:45:58 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Rob Herring <robh@kernel.org>
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
Message-ID: <20201002134558.bnovi4ti5o3kypx5@lem-wkst-02.lemonage>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
 <20200921144645.2061313-33-poeschel@lemonage.de>
 <20200922155836.GA2758392@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922155836.GA2758392@bogus>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:58:36AM -0600, Rob Herring wrote:
> On Mon, 21 Sep 2020 16:46:44 +0200, poeschel@lemonage.de wrote:
> > From: Lars Poeschel <poeschel@lemonage.de>
> > 
> > Add a binding doc for the modtronix lcd2s auxdisplay driver. It also
> > adds modtronix to the list of known vendor-prefixes.
> > 
> > Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> > --
> > Changes in v2:
> > - Adopted yaml based file format
> > ---
> >  .../bindings/auxdisplay/modtronix,lcd2s.yaml  | 55 +++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> >  2 files changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml
> > 
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Traceback (most recent call last):
>   File "/usr/local/bin/dt-extract-example", line 45, in <module>
>     binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 343, in load
>     return constructor.get_single_data()
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
>     node = self.composer.get_single_node()
>   File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
>   File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
>   File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
>   File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
>   File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
> ruamel.yaml.parser.ParserError: while parsing a block mapping
>   in "<unicode string>", line 4, column 1
> did not find expected key
>   in "<unicode string>", line 55, column 1
> make[1]: *** [Documentation/devicetree/bindings/Makefile:18: Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.example.dts] Error 1
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.example.dts'
> make[1]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml:  while parsing a block mapping
>   in "<unicode string>", line 4, column 1
> did not find expected key
>   in "<unicode string>", line 55, column 1
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml: ignoring, error parsing file
> warning: no schema found in file: ./Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml
> make: *** [Makefile:1366: dt_binding_check] Error 2
> 
> 
> See https://patchwork.ozlabs.org/patch/1368465
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.

To be honest: I have indeed problems running make dt_binding_check:

larsi@lem-wkst-02:~/projekte/linux-stable$ make dt_binding_check
ERROR: dtschema minimum version is v2020.5
make[1]: *** [Documentation/devicetree/bindings/Makefile:10: check_dtschema_version] Fehler 1
make: *** [Makefile:1366: dt_binding_check] Fehler 2

Well ok, I seem to have a problem with some version. I took a look at
the mentioned part of the Makefile and found, that a tool
dt-doc-validate is called with --version argument to find out if my
version suffices. So I tried that:

larsi@lem-wkst-02:~/projekte/linux-stable$ dt-doc-validate --version
2020.8.2.dev2+gd63b653

What is wrong ? Can you give me a hint how I can properly run these
checks ?

Thank you,
Lars
