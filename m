Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EB32747E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIVSAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVSAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:00:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0049EC061755;
        Tue, 22 Sep 2020 11:00:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x69so19029672lff.3;
        Tue, 22 Sep 2020 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+S+ikiHuz2HpdLIm249+t1T7WSf8kgaFrd1ScxmbIRA=;
        b=YZIjQQBQaCTguWnuWRudyJEvWdfCGsiGP4kcXSZDxXIXMl9BrgwKsNOQ5vhEwhpd42
         BB+qD14yjvJXe6MA+qJI9G0nzA/29OhohYyF62O0sXLNGEI+5ylCcPWmvqi7jjKz8o1g
         +StyCcm1ImuD7xtsED8OhSs8u7y9IPkkJWLVVIe57i80PQggTrkr+f0re42QGFLzVzu+
         96OHyMnIOWFlppIZrEScA074aNG9eUDIfmOW8J/gY8NPfhjz1T2QaoGZiX/CCEhKuEFo
         2HklH0TtjbizH/aGzbKig0VzsqzcDJG6xjsRapLfCHkg5kLh1OO94HSRweDsyfwWR95j
         eIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+S+ikiHuz2HpdLIm249+t1T7WSf8kgaFrd1ScxmbIRA=;
        b=U8NXQhP67Lh5wn27Y2eSm9vzpjb78P0JBgB+38+agij0OSc2WcgFF9WCjqLle7tK1D
         1VCf3s5oVq+rEkkG8h/L8sK9KshuubxN/nr0iD/zu3sUOdNMjRnyHuGvHYElU/Bt2XP1
         +uwMAje4CdRoqF8hNr2GDmwQ4mG+LUioxtLp97Vxx0+fmbdfWDoEqaWkFA74d6k7E9ig
         El7AaOuMqIo6mxqqT3JAB3UixeQ+ATOjJBzvXLLDAP/QPVyNT0C5UOB2HNOtZjoxcW/X
         /ZGcYdodxHBGj8Xz5ViCE3BdsGspvE1zebMWx+PJl53xY9pYQUGI77bG5qmE7IaJqC/x
         jfCQ==
X-Gm-Message-State: AOAM530vfBaFb+qbBB8LsgmonQpjhBvUcvqjpSCkzW66eWRtso6BS6Xw
        g/y2bAF8njPj4aYMlyhHLRtrk8I//kWK+Ii7eBQ=
X-Google-Smtp-Source: ABdhPJxFr6fvcuGTXCkhdw0fxH5jeW4JUrPm1uyVhIRE7All5r8ND3+dP6QkxMaEDP499RMjkx2GkD6vnB//iKZrYaQ=
X-Received: by 2002:a19:dcb:: with SMTP id 194mr2068732lfn.25.1600797628205;
 Tue, 22 Sep 2020 11:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 22 Sep 2020 15:00:16 -0300
Message-ID: <CAOMZO5BUxEF4s+0XFz8Uoos8d8Wk-rp+K8LyO7az8MKV3kHH5A@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] imx: support i.MX7ULP HSRUN mode
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Yongcai Huang <Anson.Huang@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Tue, Sep 15, 2020 at 11:55 PM <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V2:
>  Update to use pmc0/pmc1 following hardware naming
>
> This patchset is to add HSRUN mode support.
> Patch 1,2 is to add binding doc and dts node
> Patch 3 is to support HSRUN mode
> Patch 4 is to use wait mode when HSRUN working per hardware state machine requirement.
>
> Peng Fan (4):
>   dt-bindings: fsl: add i.MX7ULP PMC
>   ARM: dts: imx7ulp: add pmc node
>   ARM: imx: imx7ulp: support HSRUN mode
>   ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN

It seems that a patch adding the 720MHz HSRUN operational point in
imx7ulp.dtsi is missing.

Thanks
