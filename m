Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BDE2D33D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbgLHUQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730775AbgLHUMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:12:50 -0500
X-Gm-Message-State: AOAM530sPkMBdNCcpIJPj2O6Z3V8n8cCiN+AM66lA+9KF7QkgQLVyI8b
        8Y2A26sCCqqEDs/VLHxe5D1OIy3wQM20Y7+nVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607455849;
        bh=NKy6afdZEVgJGG/GB+10Y6JTt4w4Kh5aoJvfE2Rm6e0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n7QeeXzcYATfAdNqiaMtYKV3FpjFPuwNvHk1giftnK56sCrYXKMo8Xm+KZ58zIUVX
         H4xz3RO8kZTI3nJizUW2Op264bZMOr522nPLqaj9+Bmp73jlXI1RIfc0upbIdnVbv/
         h4T0QDV56Nf/1D1Pzelfs8/0NRFcpcM5Ub35BrOk1Kl94WWxAnRlvfj2a6+AvA/0LX
         vAXCwnv59D9wgMIm2xeAgNYR2i5laRzSgKa2H3LpAxRe5NY9AiFs/kRKQzIAFI41tv
         e9KbDHCpsDURHBCHBtSCXzMtlxKh42xTsXElcMeny7nwyYnq7F23+8IM6YUitQRln1
         GA69rnmeACxrw==
X-Google-Smtp-Source: ABdhPJz+SNhGurakI+ORTatAif+hmJDgPm2BLhUSt0EUUqtnt7Z26I96XfKcNuPZILAHE+FIY1iWqGq/SnetUKd8xSg=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr24389649ejz.341.1607455847799;
 Tue, 08 Dec 2020 11:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20201204014236.1158-1-thunder.leizhen@huawei.com>
 <20201204014236.1158-2-thunder.leizhen@huawei.com> <20201207230821.GA1015860@robh.at.kernel.org>
 <9a9b01e5-6bf2-1ec5-871c-1391bd48f7a1@huawei.com>
In-Reply-To: <9a9b01e5-6bf2-1ec5-871c-1391bd48f7a1@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 8 Dec 2020 13:30:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLxYmu7OYvDDMjL1RXnu8rApJDeNODrMHkw7LHbNXiYww@mail.gmail.com>
Message-ID: <CAL_JsqLxYmu7OYvDDMjL1RXnu8rApJDeNODrMHkw7LHbNXiYww@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] reset: hisilicon: correct vendor prefix
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 8:16 PM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/12/8 7:08, Rob Herring wrote:
> > On Fri, Dec 04, 2020 at 09:42:34AM +0800, Zhen Lei wrote:
> >> The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
> >> stated in "vendor-prefixes.yaml".
> >
> > Yes, but you can't fix this as changing it breaks compability between
> > DTBs and kernels.
> >
> > hisi has to be documented and marked 'deprecated'.
>
> I searched, and this is the only place that uses the hisi prefix. Currently,
> YAML check will report warnings due to mismatch any of the regexes defined
> in Documentation/devicetree/bindings/vendor-prefixes.yaml
>
> Is it not good to add hisi prefix to clear warnings?
> "^hisi,.*":
>   description: Hisilicon Limited, deprecated.
>
>
> By the way, Hi Rob:
> The license information in some YAML files is incorrect. Can you correct it in v5.11?
> For example:
> WARNING: DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Clause)
> #26: FILE: Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml:1:
> +# SPDX-License-Identifier: GPL-2.0

No, I can't change them. I'm not the copyright holder. The ones that
are not dual licensed are most likely converted from the old text
bindings which were default GPL2.

Rob
