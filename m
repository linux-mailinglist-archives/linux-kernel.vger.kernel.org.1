Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650712A6CB2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgKDScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:32:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44175 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgKDScJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:32:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id m26so20198819otk.11;
        Wed, 04 Nov 2020 10:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oghSgZxFlVBv7JU4WB3s/OwRzfJOnjFiQ7TPHojsDUU=;
        b=ll7L/GjxqnrkoKqrrNBpiP6O5fNRWExaHpysMsgzUWDNSdQaqst18Smy4W8cGadCe7
         aRmZbAB2bp/hKqnc+5zAzju9wv/wqVMWpn27zzfSmMdChCUEW9AtmrdlP/OAEkePpMP/
         JLboAg4rTkvFGQrIuEBDSJLM3zMFd/42ecLFsZku8o5oS0Lb1gOrt21KnkQ3NTThedAi
         MHi4mwdvdNtk2hCEMlse0NHNTfIRqnxRm9RjWgsaBX1SvjjJe6yTLpKJlPjG0TkjV6fz
         122ouupilUPEV4BcS3dIPID05eh33funWcywSEJJ7qBkDxoqNVZqXxwi8tCWJxPhyTNn
         fqAw==
X-Gm-Message-State: AOAM531gEbQoxjp/qCXed3TjonL0/2Z+DgS/5q90QD4FxgmjsHmDDRvJ
        MCN6gxbQxcKdYSrPAvuCsFLMTwdwQg==
X-Google-Smtp-Source: ABdhPJytEnCxIKIlfBfza+NMnBCBgry1XIIkp5fTiGzOjNZ/aBg1i1I8QrMf2ufeUpbIQjxyFPOseA==
X-Received: by 2002:a9d:649:: with SMTP id 67mr20405397otn.233.1604514728036;
        Wed, 04 Nov 2020 10:32:08 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 186sm742366ooe.20.2020.11.04.10.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:32:07 -0800 (PST)
Received: (nullmailer pid 3914664 invoked by uid 1000);
        Wed, 04 Nov 2020 18:32:06 -0000
Date:   Wed, 4 Nov 2020 12:32:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 1/3] dt-bindings: display: Document the Xylon LogiCVC
 display controller
Message-ID: <20201104183206.GA3913864@bogus>
References: <20201102155308.142691-1-paul.kocialkowski@bootlin.com>
 <20201102155308.142691-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102155308.142691-2-paul.kocialkowski@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020 16:53:06 +0100, Paul Kocialkowski wrote:
> The Xylon LogiCVC is a display controller implemented as programmable
> logic in Xilinx FPGAs.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/xylon,logicvc-display.yaml        | 313 ++++++++++++++++++
>  1 file changed, 313 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml:117:6: [warning] wrong indentation: expected 4 but found 5 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/xylon,logicvc-display.example.dt.yaml: logicvc@43c00000: 'display-engine@0' does not match any of the regexes: '^gpio@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml


See https://patchwork.ozlabs.org/patch/1392340

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

