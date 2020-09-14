Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C84269774
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgINVLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgINVLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:11:47 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F19D4218AC;
        Mon, 14 Sep 2020 21:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600117907;
        bh=aROn/zSUcmVHeUa7RPdBtBXlg7l/7wS6mQyZeUH+vmE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R+TvKYeBJuWK3XiEJ9pwaEaa6LfDHiNyhHQKrtYKCRpjCmdNn+6cCpiCOcMA8wE/8
         R7uWzrB6exXyIXhxmSFAvJQHScYCM9Zs6kF7hBtreWfUve+9u7Lw0hYKdWxT6oKJxk
         WMGPn6/2Tf2TRPpvgzfkKXhO3MxFD+p86lenQAxs=
Received: by mail-oo1-f47.google.com with SMTP id h9so212804ooo.10;
        Mon, 14 Sep 2020 14:11:46 -0700 (PDT)
X-Gm-Message-State: AOAM532aby+ncdIhPWi5+vI+xicMsHaaQd0DPY0dmJraA/tZ9uhHiZus
        P1qMYUCpZL6/Ev32zbsIZsiu3J36TG0hIEKrFg==
X-Google-Smtp-Source: ABdhPJzxlwm9lNaA8nMCSGFjApvtHLzHVXT7vei2Tc7G6fHN2n/+MkdTLPt2LoyoIPbsGcQAfPgYd8tNJnQ4VjdMVXA=
X-Received: by 2002:a4a:9d48:: with SMTP id f8mr11349912ook.50.1600117906336;
 Mon, 14 Sep 2020 14:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599826421.git.mchehab+huawei@kernel.org> <7964c39084de5d2fd3dca30bf5abb5973eeec42b.1599826421.git.mchehab+huawei@kernel.org>
In-Reply-To: <7964c39084de5d2fd3dca30bf5abb5973eeec42b.1599826421.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 14 Sep 2020 15:11:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLjh15Gk7kuB_YhY7NL8ctMSe9oFP0ehRMNrBfZSdFbBw@mail.gmail.com>
Message-ID: <CAL_JsqLjh15Gk7kuB_YhY7NL8ctMSe9oFP0ehRMNrBfZSdFbBw@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 7/8] dt-bindings: phy: convert
 phy-kirin970-usb3.txt to yaml
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 6:16 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Use the new YAML for this physical layer.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/phy/hisilicon,hi3670-usb3.yaml   | 72 +++++++++++++++++++
>  .../bindings/phy/phy-hi3670-usb3.txt          | 25 -------
>  2 files changed, 72 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt

Reviewed-by: Rob Herring <robh@kernel.org>
