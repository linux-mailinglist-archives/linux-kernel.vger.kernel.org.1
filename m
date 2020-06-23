Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F1F205298
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 14:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbgFWMgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 08:36:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbgFWMgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:36:50 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 852B62072E;
        Tue, 23 Jun 2020 12:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592915809;
        bh=ncCDhwHGz3SwSyuNyAKZ6i/uKhm4xkq6pQFwYaYDVOM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jJqVdaRxXKjWVuwbqKdXLjVlvHTD+xCFWIRMLMpsxa/GdehMpprwbno8i4IuZBXQi
         utwXlCdEciZj9BsJmrnjZynaY7LyuWn7EfTZ/j8cWazIMu+tJKyv3uCy/JR5juJjdV
         CkHe+6W6H3v0v8q7rYohVC29WDKr5Lz8GXjt6Pf0=
Received: by mail-oi1-f171.google.com with SMTP id p70so18630990oic.12;
        Tue, 23 Jun 2020 05:36:49 -0700 (PDT)
X-Gm-Message-State: AOAM531VkarxYaGkqebeKXVmUnjbRMXgg/hGwotlauhbS1oFaC/nXVuS
        LG09yU1A1Mo8287NOT9zEKL4aqQ4I/HNcf5Ko+Q=
X-Google-Smtp-Source: ABdhPJzI9PCaEenZ9gXjSD7l7z3pli13IsJGj059pBU3A2yTyp2GloZp1fsskrx517tdO6E5XpVFOj2Sap97eU2Uvf8=
X-Received: by 2002:aca:4947:: with SMTP id w68mr15198126oia.116.1592915808917;
 Tue, 23 Jun 2020 05:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <cf810c93-297c-c02c-9bba-8c3d097b8e31@web.de> <2ab2cc9f-c720-75ca-e20c-0e4236ff45fd@huawei.com>
 <1542979d-f7f6-bcf1-53c3-22b7c076ddc7@web.de> <20200623073220.GV30139@dragon>
 <5300cb30-2243-9bfe-125c-96e720cd1f29@web.de> <20200623110222.GX30139@dragon>
 <9f429c51-0fa9-16dc-4d62-d456551c5376@web.de> <20200623120919.GE30139@dragon> <66038b6c-6691-eda2-af15-f315270d4bee@web.de>
In-Reply-To: <66038b6c-6691-eda2-af15-f315270d4bee@web.de>
From:   Shawn Guo <shawnguo@kernel.org>
Date:   Tue, 23 Jun 2020 20:36:37 +0800
X-Gmail-Original-Message-ID: <CAJBJ56J9NfYPxnqtLfbeCHkRy2-xPEUJq7r3RvM8yi434AQF2Q@mail.gmail.com>
Message-ID: <CAJBJ56J9NfYPxnqtLfbeCHkRy2-xPEUJq7r3RvM8yi434AQF2Q@mail.gmail.com>
Subject: Re: ARM: imx6: add missing put_device() call in imx6q_suspend_init()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Sascha Hauer <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Yi Zhang <yi.zhang@huawei.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 8:29 PM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
>
> >>>>>>>> ARM: imx6: Add missing put_device() call in imx6q_suspend_init()
> >>>>>>>> https://lore.kernel.org/linux-arm-kernel/5acd7308-f6e1-4b1e-c744=
-bb2e5fdca1be@web.de/
> >>>>>>>> https://lore.kernel.org/patchwork/patch/1151158/
> >>>>>>>> https://lkml.org/lkml/2019/11/9/125
> =E2=80=A6
> >>>  - The patch applies to v5.8-rc.
> >>
> >> Would you like to try it out if my proposal is still valid?
>
> Are you going to compare the published patches any further?
>
>
> >> Does the change approach by Yu Kuai supersede it?
>
> Which patch variant will be integrated finally?

Just picked up Yu Kuai's patch.

Shawn
