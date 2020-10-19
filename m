Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35353292BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgJSQ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgJSQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:56:06 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF84C0613CE;
        Mon, 19 Oct 2020 09:56:06 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a9so304201lfc.7;
        Mon, 19 Oct 2020 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7/mbzFLXEMd1q0roDFKeqzy4U2sksZwi55mbeZqiP8=;
        b=gmQmh3T8JgIDSY1hCV2x32dJsECUv/UIF03EPYYeFjwmdjVs/1Thko1nXTTqp7eq+j
         47mbJI4ae/Sjxk/sPC9c1cSxvkdF/PRw9zjFQ2LJ+kLAQSb1WqZV4wfYf9qvf9iaP8Al
         aZ2FvJpKq8eRxsUIM8Kbv49f1CmL0tMU+ZKN+RRDl+8vSYTff0qxLd9Z6fExdR1F45Hi
         3zKvhqAbMsORopPHi7DI4MxwMD4tbBvVIfsE4okDdgbZC0Ao83t2mSYe9sh4woyEaIzS
         apDM4N0OLJ37Fp7+ZGnYDHYMqudykbTOlQecgif6KE+qHc+6aPvdR0KjWmeU0XVY21xZ
         ml6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7/mbzFLXEMd1q0roDFKeqzy4U2sksZwi55mbeZqiP8=;
        b=IZvB3/+c1vj+uvM64CdpAyZJGh5dcNrjYf7Hgi6fbW96FTNerAzt6k/NlYZiCYXu1G
         uQC6Cplhby8jQoDOxlk6nB1njHzs4Qyk2GoWkZg7MD2yfk61eQsgYfbw59GZ45DHsmOO
         a8SS76mAmhdD+YHrjESxh2Gz8BClwRrpUBWutdHN5NxKp+pKBTrYgYbFl/z0s4O3aqLT
         GejkHyhrVAeK6JYZkZK4EUyhewEUY4B47auKJph8suqvbwwbKAccsAr3JQJz7x3RdPbz
         N3ZH6qPBjhUNvqPyFKDuZhoVpu5PlrSlo0TzhIAgRxEl/cx37y9qnLNSF2NJE01VAY1A
         Qfrw==
X-Gm-Message-State: AOAM530ddNNYE1vlLG270n7RJzWcsakEmQhXtMnJCVzJGSX6uBtVmYvu
        oDqYVKY3ZoUGuo8XyVtp4HQB6whQyFM0IimGOdE=
X-Google-Smtp-Source: ABdhPJwF5+7PVbLiVrAmOj0bG5dM2io2bmOfcY6nhmUCILHBnj+AyOcuO4UNtn1ClPUCYMsK0Kp83UKGF39ljPFfFHo=
X-Received: by 2002:a19:8191:: with SMTP id c139mr185182lfd.333.1603126564708;
 Mon, 19 Oct 2020 09:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201008212706.870115-1-aford173@gmail.com> <20201008212706.870115-2-aford173@gmail.com>
 <20201012170016.GA5369@kozik-lap>
In-Reply-To: <20201012170016.GA5369@kozik-lap>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 19 Oct 2020 13:55:52 -0300
Message-ID: <CAOMZO5DVxyR+h_jqDiJyx=UxYaWtYNG2iXso2CZ3EF3BRenuag@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: imx8mm: Add node for SPDIF
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Adam Ford <aford173@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Oct 12, 2020 at 2:00 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> > +                     spdif1: spdif@30090000 {
> > +                             compatible = "fsl,imx8mm-spdif", "fsl,imx35-spdif";
>
> This does not pass the dtschema validation, so only "fsl,imx35-spdif".

Shouldn't the dt schema validation be changed then to accept this format?
