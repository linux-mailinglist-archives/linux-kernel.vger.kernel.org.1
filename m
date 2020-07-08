Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F8B218F23
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 19:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgGHRtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 13:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgGHRtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:49:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26640C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 10:49:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d17so40522790ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhowNbJuV356oFdiSTzabdZB1J+dSIh5y7YWbXkVY2Q=;
        b=Wf7knxLWk7qOaIH8aOWRD28F+E1eDaRcllXSUdNMF4E0ItMOATRQAgxeALRSgrKmkV
         Eba9/ww36+r+1KS5krZIUFljxrtm1gIf/j41574CgdgiCAlVMv1EPxnF8cLuz3h9Kdwd
         Ixpozzln58qGQjgtRoaOy3smHCkLJ247j66KN6qwo7h2lASuXyvuvWjV2PDQzbiKqe55
         fzYwNGf8ke6c5XMun507OWWsnI8xv/TFx3z0b7R9XXlmxXNbMYjQvtFZivwyTg8J+Xln
         XnChoWPsX9GXm4PEWVmPDihpwhTM9x5+ke2RFBm75fKGj1eYZUpz0EpOrFP9SWgmRByv
         4HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhowNbJuV356oFdiSTzabdZB1J+dSIh5y7YWbXkVY2Q=;
        b=Mz5YCAs5g1jMS1U9vVrOuXhWbxkT+flhXROOOqMssnPOwC1KFy0aef9u8UUpNuBCaR
         1EpU7nBkQkLkgxp7cD7957jd/059jxtY8f4qYhSdJ24VFtir/9+Ne/S9FcX66BaWCd8b
         kcFPFJoWN5McUNy1lwIfpsIbgSyEudS42VVZKRBWTje5/RfJ3RDkvKDr2iJQChrQt2yi
         a3/uEeYeo+eqfsbS26sIHnNjnXgRgvLQOV6d71l8Wdt/xDQtEbhiA1T4QDlGX/K6xMUt
         H9lNQDY0gQcWifUuMPL9JrIndqOYaytTskob5qH3BuiUDfYq9LQqRnT81YOKTkZ0+uOw
         Ekkw==
X-Gm-Message-State: AOAM530EpTN4gC9Fjm03Q4BfvT1BgxmSReh09LSwpELNg4Vcv0Y3mGLm
        RmhDdCapbZMGxv8M3+1OHpFwM1QpQmW7sQJUxnc=
X-Google-Smtp-Source: ABdhPJyK31rnONgRQ4xLjluvVcQNMLo+jfRoVczIGoEX71ohC46z3bYeEV76nRiYiTJiIemoWeswDy2kGmMBMezSRQ8=
X-Received: by 2002:a2e:808d:: with SMTP id i13mr31426488ljg.452.1594230547595;
 Wed, 08 Jul 2020 10:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <1594025081-2353-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1594025081-2353-1-git-send-email-hongxing.zhu@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 8 Jul 2020 14:48:56 -0300
Message-ID: <CAOMZO5CGDzzADq6yC1FMStc1ZcuLS5mVahf_EOe1RNfdki9+Jw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl: only enable pcie in the pcie dts file
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Mon, Jul 6, 2020 at 5:49 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Since iMX6Q/DL PCIe has the PM limitation (ERR005723 "PCIe PCIe does
> not support L2 Power Down").
> System suspend/resume would be broken by PCIe, if PCIe is enabled.
> Only enable PCIe in the xxx-pcie.dts files to avoid the brokens when
> other xxx.dtb files are used on sabresd and sabreauto boards.

We have several imx6 dts files that currently enable pcie.

Can't we have a proper software workaround for this issue instead?

Thanks
