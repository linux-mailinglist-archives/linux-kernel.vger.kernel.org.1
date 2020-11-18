Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6657A2B7832
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgKRIIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKRIIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:08:16 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4E1C061A4D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 00:08:16 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id k4so1036328edl.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 00:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYkzksRNaGbOMgyJtFrKrhjpOwtjgLuKKLI9H1meENs=;
        b=xCWG2WDkXGUHEmmvlIEXs8mX9u3sb6FB0q9LFul6OKzhcg+CIPpbHyWVJyUIcZ6U0c
         CxzCSvsRY1fmsdf7hUe3PrzVMR4XzcBUH5/oDkRiRzgCDh1l3MGg9f7qpopJPDhA/Osf
         naXIzRtC+tCcAsimW4BCW/g1+nTYFw7Px93SotOJsq6n0lSPMi1qM3+8nb320uD64Ba8
         gLMznJOGDpF+y5CXx6brPuOqhhmOYYTNKbiw7OmMCngWtim6jtwlUlja+b94KEBDE01Z
         cClj/K8TpXVCCPjufmUZeja80w0hx/6KOG/M8vvoGE9/WY1lxBvSZ/eKf0rV7Sw9spuE
         MEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYkzksRNaGbOMgyJtFrKrhjpOwtjgLuKKLI9H1meENs=;
        b=VOMwydsIcN2Hh34DlXZ1rGOOSIz15M4D5z7JCe9B8aAYO9QE4MIqdSh7meP+7f736M
         tJ899GVhGd4YS7XzjeDXjmOD30stVHI9ZDpNjOkACS04NYek4igAWtM1WE5QZw0Glw87
         DfQbC19I/5/5z1IHTPEjrlZ2SYx4aF6XMjCIx0Z08zmQ4motj7r9jGbFiPYp1Rmg1PF6
         4vHuq/R1LBd6u0Z22o/TpqgJBdfmjp+4C2ALJ/5Fbkh/Cw7Yu6FAmY9QP4KmrDaiZlvb
         XX5ghQsWmz7khulpUb6AIQkO7YxoHhHsYBwaG1bFbYmYlZIrxrYM8+nPH3l0Ifxc8hvV
         jHAA==
X-Gm-Message-State: AOAM531aF+vbx+8DhvhMbXk/01mAyuI8u7wfWih40OcZm6vaAW/8a5iu
        kO/uJHwNzY6Q2s4tigYy02KrCddJAwzpgZ7eFTMPyA==
X-Google-Smtp-Source: ABdhPJyIpjJgJazX4fTSFDsxCZTxH/xxyf4fTir1+gkSOwPp8hbM6quT/hXeCY699yN511XwzGCCUFGquOJ6Buwje7k=
X-Received: by 2002:a05:6402:144f:: with SMTP id d15mr25196770edx.300.1605686895096;
 Wed, 18 Nov 2020 00:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20201118073517.1884-1-thunder.leizhen@huawei.com>
In-Reply-To: <20201118073517.1884-1-thunder.leizhen@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Nov 2020 00:08:03 -0800
Message-ID: <CAPcyv4iECY-XoJ=jhARDDqjv-j8fnOUiKxB9Z+M5J+kMoeeWhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI/nfit: avoid accessing uninitialized memory in acpi_nfit_ctl()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:36 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> The ACPI_ALLOCATE() does not zero the "buf", so when the condition
> "integer->type != ACPI_TYPE_INTEGER" in int_to_buf() is met, the result
> is unpredictable in acpi_nfit_ctl().
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I'll pick this up.
