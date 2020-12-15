Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BC72DADE8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgLONVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgLONU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:20:56 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D561BC06138C;
        Tue, 15 Dec 2020 05:20:15 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id w13so39226746lfd.5;
        Tue, 15 Dec 2020 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOTNS1adPzkjd18NAGlnFfcMu9FiOR4jPybdIj8V52A=;
        b=QzoagYajrS7uM4QhWkUMg3UPeK94F6r3Th5zNpGdydo4CaXBDGSJhKeHrNRbulKU5U
         QGMdGA1IbHo1GvDvu66sYVf9vCFWzIRMt1btwVSxH8asyuWDroPxhST2ZEPZ+/7xC8CN
         puKi6KzGAhcrVWxNPIFOOWIm8Escv6IWSr7v1+nhoed1mE+sQZcbH+1hpVFD/5ee/dDN
         ASKcf+QNR2kayArHG9qOKSNnrSqouxZL7CiX6HxRz8xYW5NrikF08r6iiQEekC1fllzs
         n6D9R3SK6kiCY4Dfe2zbBGFAF8VKthnuNwc8ubEnm4jS/J86BW2OaRUPV0AfUGF5c5Gr
         e5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOTNS1adPzkjd18NAGlnFfcMu9FiOR4jPybdIj8V52A=;
        b=SuCcKYZ92W4rvMWWQtNvWpg4n7bkUHUmEvvYvogkEQn7kILqVfTck1boawVyDYzlmv
         eD1K2r+hGDLq4y2Ci8o3kQ6rqnRsPu+4N8qF8UKA4larS0lcIIUWEsvglLDH4scTLUKz
         QDK9rIV+fJUuX+AqrzPafftM9Gx8l4xGZQaprN913S/Q8sbz450sMT76P3lnDhk4oYAQ
         cjS9Cj03b0JzbnaQDt1UZfBAirQnwD5dEqR9ZUkWEle0/ciuudKOA4gjUDQaaWV1wcym
         aD9TOozd1maa7TaGltMCN/R6fm6yY6s4HT1cgQmu4UdCrmW3stM3aighe4D+M1165P0t
         eCpg==
X-Gm-Message-State: AOAM5310Deg43YsJcDI18bYt/DbFGlhdl23KJXz8gCXJk7Qh2XTyIjI0
        xZBOZaiJJfYvdF603gEjVVrBz9oeHlrWzYt+/1E=
X-Google-Smtp-Source: ABdhPJzJp7Yq5xVPxVXkqKyZQAg2hSchnL13OBIdipOtaWfun3XG3Oodczt84lms0OlsIi0DkgpmkaPjkJlWdmXWt2I=
X-Received: by 2002:a2e:bc05:: with SMTP id b5mr13202203ljf.444.1608038414254;
 Tue, 15 Dec 2020 05:20:14 -0800 (PST)
MIME-Version: 1.0
References: <20201214225851.23342-1-adrien.grassein@gmail.com>
 <20201215130622.GD4738@sirena.org.uk> <CABkfQAEAe0XGj16CkmH7xMNxgdQ+SRq0BYzvP+V5PdDqVbyAAw@mail.gmail.com>
In-Reply-To: <CABkfQAEAe0XGj16CkmH7xMNxgdQ+SRq0BYzvP+V5PdDqVbyAAw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 15 Dec 2020 10:20:02 -0300
Message-ID: <CAOMZO5A_Gtwn=AFwJXf_wpC4k902Hg=tCMWpcFUGNWOg9me6_w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add support of nxp pf8x00 regulator
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrien,

On Tue, Dec 15, 2020 at 10:16 AM Adrien Grassein
<adrien.grassein@gmail.com> wrote:

> Could you please tell me where this driver was merged?
> I checked the main kernel Linux and I can find out this one.

It is in the linux-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers?h=next-20201215&id=d3795d6321ecaa55d94dc24c3b1e3cce608aabd6

Regards,

Fabio Estevam
