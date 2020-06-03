Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB8A1ED83A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 23:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgFCV67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 17:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgFCV66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:58:58 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B13B207D0;
        Wed,  3 Jun 2020 21:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591221538;
        bh=bG694Z1X/g0cz+3ydC7MrxJgPWTI9MNwlVNzgabAQpc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C0EqvJxRgn7C7eJE3bee+mhegLwWCqMYruNH8EFYeZEpca1dUbur8vepANEmM4D2h
         Xjfa15trH++Ax4rZS64DaIqUYDKByyESOIGISy0BT6CNSiRFo81FPMGiPXDclDvvZ2
         ThXijie937+TXbsaITUeUsp7Ere4T98m/6Oow51g=
Received: by mail-ot1-f45.google.com with SMTP id v17so3203363ote.0;
        Wed, 03 Jun 2020 14:58:58 -0700 (PDT)
X-Gm-Message-State: AOAM532l1N6ekbmW3yLyTEpt6/fNsO/21q6lzOXgvjkzKF4InNVzdPwW
        Nx9Mj4Ls2/dyr+RcWByx34Y7AQ5kTtrU1S6KQg==
X-Google-Smtp-Source: ABdhPJy4IsVGYDhLYERMjF2wCFHQWTVglTGafLNce+hvxMjpqsGUWZniKT8a62dbG+w21svvLRVjQYYO0Na2rx5zZUU=
X-Received: by 2002:a05:6830:549:: with SMTP id l9mr1513425otb.129.1591221537765;
 Wed, 03 Jun 2020 14:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200528031549.13846-1-zhouyanjie@wanyeetech.com>
 <20200528031549.13846-4-zhouyanjie@wanyeetech.com> <20200529191431.GA2779176@bogus>
 <159078668338.69627.5841582436445900180@swboyd.mtv.corp.google.com>
In-Reply-To: <159078668338.69627.5841582436445900180@swboyd.mtv.corp.google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 3 Jun 2020 15:58:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKQgSsd4ZgLrSSZifpB=1eqdgr503YyrWB1qmECd0z4VQ@mail.gmail.com>
Message-ID: <CAL_JsqKQgSsd4ZgLrSSZifpB=1eqdgr503YyrWB1qmECd0z4VQ@mail.gmail.com>
Subject: Re: [PATCH v13 3/7] dt-bindings: clock: Add documentation for X1830 bindings.
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, zhenwenjin@gmail.com,
        sernia.zhou@foxmail.com, Paul Cercueil <paul@crapouillou.net>,
        dongsheng.qiu@ingenic.com, devicetree@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 3:11 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Rob Herring (2020-05-29 12:14:31)
> >
> > Acked-by: Rob Herring <robh@kernel.org>
>
> Please apply to bindings tree Rob. The yaml conversion is in your tree.

Done.

Rob
