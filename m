Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B081A2D4A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbgLITel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:34:41 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45685 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387707AbgLITeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:34:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id h18so2517649otq.12;
        Wed, 09 Dec 2020 11:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Go79iHwz/ukwW6WA2j3dZqrE6DFHOcENDsFdA4ipHc=;
        b=VgK2uSw4/2WBmtwDlG37MoLUO1VOo0HHDbMVfMBK61a5vpKnE53Wc+tMYCxrivXDfO
         11Kmb3v4Y6OngcJO2b+11fboQ4HRcU+r1biwUEyRoQKSM2+NS1qLcNeOBvPsAWQhIxna
         SwYXC58aVXNeZgTcauuObvW5oOelzO0x82d1kjAgqQ3pBqWx3PeuGGnLe+KxBXoXJg6j
         EHSRwOGoG/YfCXUOsnGdKp6S60CrpAgEtBBJNLAfywGaT0sesksTu6uGE9GmPbr4DsHw
         IpWaHC0z1gc8Wc2XM+uti8nve7n0WVG8shs/ZazICs9/vrjRC8cYv4zuOAlJijJZq0tM
         Qnhw==
X-Gm-Message-State: AOAM531ChLHlVoX/5JRL++sz32OmR6Yvgh0KedmWS12DrX0HaSreprFX
        Y63cFBmd5OJYXQ0+W3cVcA==
X-Google-Smtp-Source: ABdhPJw/pugBB4LC8J+MPZqY+axEkmCHb7x1Htf826oVqZJ22F6F72bnt41Nbiq9ZNkxo82HvsMbqw==
X-Received: by 2002:a9d:4e84:: with SMTP id v4mr3196487otk.45.1607542418969;
        Wed, 09 Dec 2020 11:33:38 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n3sm572339otj.46.2020.12.09.11.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:33:38 -0800 (PST)
Received: (nullmailer pid 808345 invoked by uid 1000);
        Wed, 09 Dec 2020 19:33:36 -0000
Date:   Wed, 9 Dec 2020 13:33:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] dt-bindings: usb: Add new compatible string for AM64 SoC
Message-ID: <20201209193336.GA807821@robh.at.kernel.org>
References: <20201209165733.8204-1-a-govindraju@ti.com>
 <20201209165733.8204-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209165733.8204-2-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Dec 2020 22:27:32 +0530, Aswath Govindraju wrote:
> Add compatible string in j721e-usb binding file as similar USB subsystem
> is present in AM64.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Acked-by: Roger Quadros <rogerq@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml:16:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

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
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 850, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 731, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning for the next token
found character that cannot start any token
  in "<unicode string>", line 16, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/usb/ti,j721e-usb.example.dts] Error 1
make[1]: *** Deleting file 'Documentation/devicetree/bindings/usb/ti,j721e-usb.example.dts'
make[1]: *** Waiting for unfinished jobs....
make[1]: *** [Documentation/devicetree/bindings/Makefile:59: Documentation/devicetree/bindings/processed-schema-examples.json] Error 123
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1413512

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

