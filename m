Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE1129EFD7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgJ2P2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:28:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38688 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgJ2P1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:27:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id b2so2594900ots.5;
        Thu, 29 Oct 2020 08:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YqBVpZJyYpJyhp8SRHdLNd51IEGUo51ZrRSOs/0b7TU=;
        b=QWRS33aWIBAXFK6Vj5yz97EhVQtKAsx1jUdXMgfX42NkXE1Pm5A4gnhjEVCgI3j8rZ
         fSft4XqjCcs4JMyWFpYJ+G2aORIOgRtz0IdFWK5nk152jkgvHs9Q1AEzeqXWr2uTjLhj
         M2jOUXy72ZQs9e/N15mQWhVssAmyNoCHOOLMKxrncaSCZ59EHWf6Sp3BD3hg8mXxEX9D
         jQf8YX62BInMbbFsTkGIMzpsy+8yKTSUrGvW/vrGgacQ51q0lQjwpfsMMaW46P8IBoJN
         T+1wETM5E4p4YrPFg/Noq59j+/DevNlZXSwWfoum7UAZ6J2N597oDroMFTUhjkHax0D6
         9r/Q==
X-Gm-Message-State: AOAM533UCsH1O/+R2VCzeSXld2SyGImmWjZCW5zd9tbNsptEKU9hYabw
        w2lQjbsxN8u2+D1Lhmu41Q==
X-Google-Smtp-Source: ABdhPJxBNf9vh1Y0QDtx0o5GqcNwyUkqQh3ylRhfQbv8CGPulkDRTiGrhi5y/dY64xZLdbWygxh2mw==
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr3438506otp.88.1603985242687;
        Thu, 29 Oct 2020 08:27:22 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f142sm688509oib.10.2020.10.29.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:27:21 -0700 (PDT)
Received: (nullmailer pid 1902942 invoked by uid 1000);
        Thu, 29 Oct 2020 15:27:21 -0000
Date:   Thu, 29 Oct 2020 10:27:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        timur@kernel.org, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc
 for aud2htx module
Message-ID: <20201029152721.GB1901783@bogus>
References: <1603877930-10553-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603877930-10553-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 17:38:49 +0800, Shengjiu Wang wrote:
> AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
> IP module found on i.MX8MP.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2:
> - fix indentation issue
> - remove nodename
> 
>  .../bindings/sound/fsl,aud2htx.yaml           | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml


See https://patchwork.ozlabs.org/patch/1389813

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

