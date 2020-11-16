Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6F2B54F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgKPX0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgKPX0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:26:12 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141B9C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:26:12 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id y17so21178592ejh.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkBb3/Etnqo2OPSp3c8xTHP+F2u/HoD3pAA4mSKCZXA=;
        b=MkXccjt32+M3csr8oZkTon3QUTxPNcS2zCgrT3U3RH59CwEKRpXbdLiVfjt8CMYX6B
         Hg8D2gpEM/79AqjT0FagHooZJqUZL66EPjBukC0tykTqJcX4AkiNfJ8fmjO3E0kXNxUZ
         bewy5GVpHdHwPt+kEyESDAXIJN+EOVFJ20TtdpNWu62B01jvD2v64ONbyYiUs55Ui5q7
         hGqT4RvbtAXSYTaTb1i6Iz6VPXjD21KLAuYxd8exUmB5qG1RpSfHG6HsVApeIseRx1tA
         wVxtAKS/Qd7TMl5TGLiI9ksYUaUgIb0wKMrgy3cMo9hMQNPlmN6MDzCMqx0bht0s0bwS
         z+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkBb3/Etnqo2OPSp3c8xTHP+F2u/HoD3pAA4mSKCZXA=;
        b=oYx3qpBypWLL6bb2EEANCgFABO+HFLEzSbKn65yRvMY1XVFNXFnoGRYmxg7plqH6p/
         Tju12CiRsa0JS0XZ6rSyaxyzkVsp3nOkwmli4ndYCWnBJUlwo7gpOXfmkSrHg4mNLCpe
         d3w1HqXTobMbt8khZoOD6jrPZZ7raNlZbgdexs/2BDcTxcR1QYOpcfz8KQdrky/r2Urw
         SwIyPNmWxTRfE4FcRDWAIJBpE+aHHUAPbhj28cqZ4uOTjNCrxkVE85woTy4D7l+9dCHo
         ycz6E/5bBSAFCBNNt0K9fO9mRUsCUBObIHUuk1y9XNrMs5AnnyQ3BiPNvHS9VEdO956b
         yRrQ==
X-Gm-Message-State: AOAM530LBlqbBvf4LHEUgvrmrrp7EDSasAPOCWP/fw3Zuvlah1cpxlSM
        A05RNzi53NztwBEtf1BS0pkVC6xroEJiqV7Bx+YeBw==
X-Google-Smtp-Source: ABdhPJze5vcw+d0aAkqS1pxiX4ktCOOJiA9r/T2L2c2bAJTiEY+gl0QV32VRtqpOXijH9Zd3wJuTfU/FYl/HVP7+Yqg=
X-Received: by 2002:a17:906:d92c:: with SMTP id rn12mr16886961ejb.472.1605569170798;
 Mon, 16 Nov 2020 15:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-3-ben.widawsky@intel.com> <20201116175909.00007e53@Huawei.com>
In-Reply-To: <20201116175909.00007e53@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 16 Nov 2020 15:25:59 -0800
Message-ID: <CAPcyv4h_kSYhcGAdZshFPFbGPgZKCvUh9q7M=jMMRaEauUPzaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] cxl/acpi: add OSC support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:00 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 10 Nov 2020 21:43:49 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > From: Vishal Verma <vishal.l.verma@intel.com>
> >
> > Add support to advertise OS capabilities, and request OS control for CXL
> > features using the ACPI _OSC mechanism. Advertise support for all
> > possible CXL features, and attempt to request control too for all
> > possible features.
> >
> > Based on a patch by Sean Kelley.
> >
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> I guess unsurprisingly a lot of this is cut and paste from PCIe
> so can we share some of the code?
>

I do not see a refactoring effort for these bit being all that
fruitful. The backport pressure for this driver stack I expect will be
higher than most, so I'm sensitive to avoiding unnecessary core
entanglements.
