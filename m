Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C60302BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbhAYTuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:50:35 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41810 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731936AbhAYTga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:36:30 -0500
Received: by mail-ot1-f43.google.com with SMTP id k8so13911948otr.8;
        Mon, 25 Jan 2021 11:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OauOcSb/fHxVVdQrMG7tG8Z48E9h3ry+EbDmqm+9VYA=;
        b=jnLn+i4ImhMgyHiN2ap73FSqeN4sCdkAC5gDrYb1r0zwCkRNBadNCUjVCrOhDinzg4
         V552xvjlOukTPd5RiTDmpiynuDHRYyfAxyskYGCr3dXWsLmggqT0zBMoR6VlS5nuzedW
         SL3W9D5zH7d+DtTMnVNhNN8aqrAPKKTnU7PMWbNbZyQZ3t7sYqvMu0KPE3p+9uqd6mzE
         zGbV3N5WqrLomq2Q2WUoo/LQQSgzWrL0zRgsBQrGqXtqHyITxW8/fAx4NWmPZjzyX1Ri
         Pki+mb9ozd9ervzo+rdtnpV6EeEMOkP8SjkYgmoV4SpkqcfQKTT8JjpE+Q2BARwBFtrX
         UpNQ==
X-Gm-Message-State: AOAM530uPm+ONaKyMLUZ+fNwkfsR1KuPusdBpQEWGBKqfe0mo60DPwqZ
        sJUp4l3P8HDJSHAP7fA33sQgJAFaZw==
X-Google-Smtp-Source: ABdhPJyr/h9AMGbSIK7K4NzU9OGvK66wej0PW5UdDzKiIGjcVOBKc5aBylhcbh7sXJuoU/CjEhIHrg==
X-Received: by 2002:a05:6830:2414:: with SMTP id j20mr1513500ots.326.1611603349932;
        Mon, 25 Jan 2021 11:35:49 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r5sm2430411otd.24.2021.01.25.11.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:35:48 -0800 (PST)
Received: (nullmailer pid 829406 invoked by uid 1000);
        Mon, 25 Jan 2021 19:35:47 -0000
Date:   Mon, 25 Jan 2021 13:35:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 21/24] dt-bindings: display: mediatek: update mediatek,
 dpi.yaml reference
Message-ID: <20210125193547.GA829138@robh.at.kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
 <3bf906f39b797d18800abd387187cce71296e5eb.1610535350.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf906f39b797d18800abd387187cce71296e5eb.1610535350.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 11:59:22 +0100, Mauro Carvalho Chehab wrote:
> Changeset 9273cf7d3942 ("dt-bindings: display: mediatek: convert the dpi bindings to yaml")
> renamed: Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> to: Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml.
> 
> Update its cross-reference accordingly.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
