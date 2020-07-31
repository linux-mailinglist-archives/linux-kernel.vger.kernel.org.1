Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A74234DB6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 00:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGaWoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 18:44:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41326 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaWoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:44:37 -0400
Received: by mail-io1-f68.google.com with SMTP id g19so21121556ioh.8;
        Fri, 31 Jul 2020 15:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Eay8kjQnrIuhPEG9oH1+vrTaTdwhXM7e7UTfAEwOIw=;
        b=VoU4OZ1vf4BK75QhcDwJhftbOfsvYkyaZXm8XcyArmkj4ISXpIQY+u6kcDFzf8h8D6
         7761UnEtIYTXJEdSahF1I6xCUxJjuEZt/96cC26gyB+OQNlc7i2p3uE93+WipBFOiJLr
         jThExtVwJxu1QNK45oFr79weqcpLLcNzzjCkZu3ybaWZerwtrwErgApUFcOJfLvdlScg
         7mRo5PzQyEdODyMam5e159qkJ1VUxTVnhvRXyy/ttO+Bk7sECrJvyB8SC3XEyPC1vhip
         OBMA2NAQRO9uAdtC/IC6GgOGGeHTGxKc6sBVhT0/WjnnK/369aIewpoYBMraDfwOlEN+
         c9eg==
X-Gm-Message-State: AOAM531TPI0an5J6wPvEP8vZTXzhwzsHVVBEUjzpK38WDw/o5vRn96Lc
        vf++LFs2ktV/j+wEqOBSlQ==
X-Google-Smtp-Source: ABdhPJzFb2HaTHyrPqSC2d8V4U1e07M0GSWLAWyCSh5gjgFTaPc+eYhyPhPcGIT2wQW0A2xZaRXp0w==
X-Received: by 2002:a02:7815:: with SMTP id p21mr7687550jac.32.1596235476396;
        Fri, 31 Jul 2020 15:44:36 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r8sm5555496ilt.54.2020.07.31.15.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:44:35 -0700 (PDT)
Received: (nullmailer pid 945789 invoked by uid 1000);
        Fri, 31 Jul 2020 22:44:34 -0000
Date:   Fri, 31 Jul 2020 16:44:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     devicetree@vger.kernel.org, Linux-imx@nxp.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: memory-controllers: Convert mmdc to
 json-schema
Message-ID: <20200731224434.GA945685@bogus>
References: <1596161184-24266-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596161184-24266-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 10:06:24 +0800, Anson Huang wrote:
> Convert the MMDC memory controller binding to DT schema format using
> json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../bindings/memory-controllers/fsl/mmdc.txt       | 35 ----------------
>  .../bindings/memory-controllers/fsl/mmdc.yaml      | 49 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.yaml
> 

Applied, thanks!
