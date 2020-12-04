Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C732CF4FC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 20:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgLDTqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 14:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgLDTqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 14:46:20 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5975C061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 11:45:39 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id qw4so10324001ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 11:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AD0IzZHnsxcGiXN64Y6L0qkMgIS2YHimQXlXQZyApjo=;
        b=kUoDpbKxpm+YdrWJl/SlPW2GaESXSnrKM26FHNq4RpsQ8nG8oihOgGCISNJRsxiUg8
         mrlE2iZ8/l529sBJaKbxQpA1gGqW4/a0EVuT1e7p2hAk+nv5UANLtoEdTOuhLIDZcbYQ
         eemdj0fUMdpwrI/vWzWSZj2YS8Qh/oBZxTPusdsl7dVjLn+12WdBD2EHu6krOzGETuNO
         qz1+aGgf+1gJ4K/HYS6n4tB6ADE7hJDG0KiFd71kkJ4ECTwvjXXfybLFsFowsrZETEIv
         rq0anna6yKGWCcTVFitNNjnqIgPYkopLAcq6WKtcGG9d0FY7R51oS2eceCJo8CDl85J3
         tPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AD0IzZHnsxcGiXN64Y6L0qkMgIS2YHimQXlXQZyApjo=;
        b=uNZcMuyX3YfSPWGhSfMsPa1CiY5z6e9wfYqTkyBGk0XdNBtbHa+0IWBlk6LlF6JCNs
         1R3hVeWerooRi7tuCAsP+fNN4R6x9Eto/BewPPGgXC+Sc3r72n5Y3NDq0ScPnM9OQdMe
         lIBF129rzjM77RIAMbvGfTeFdu7oYz3tnUj5ZPHB7X/Qn/ZcC9vLk61IrKVBnNuRwMD0
         MAlmCM/4bmidMSYSXzcLmSoZ2/nkzI9wC+oA+9JGiPsZCJjmGB6l8Irfw6YQEO2PHFe6
         Bhqdwei1bcU82C6v/v/IiGP9uucuDhQhrFB3ACUbDKu/TuRw4m6VqT5CpLuBu5I7tNa0
         jlvA==
X-Gm-Message-State: AOAM533JsVPr3+yeFSN4AvPERpQcCmN9RxtFKKPRKllqiGHi9TqWonWQ
        3e0grzamwvJymBIxc4Lir/rB68bb0l2G6pRLRVVesghxDgQ=
X-Google-Smtp-Source: ABdhPJzqqPz+AOjJ0g3TsYDaAG13gjaFaniKh+NAJ5rtKyHI8OloVQx2oO8nO3ar2qelyR99M7S3q1+9VQiHENb5Yn4=
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr3056063ejc.418.1607111138435;
 Fri, 04 Dec 2020 11:45:38 -0800 (PST)
MIME-Version: 1.0
References: <FB00A034-7C6D-40B1-8452-318A3B052216@avery-design.com>
 <F0ACA340-5BDE-4C17-80ED-DB7F5C5B8403@avery-design.com> <20201204181217.n3cm7gqujaqlcp2h@intel.com>
 <1878cd93df75dc8c1b35eab7b7aaaed243f9129e.camel@intel.com>
In-Reply-To: <1878cd93df75dc8c1b35eab7b7aaaed243f9129e.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Dec 2020 11:45:34 -0800
Message-ID: <CAPcyv4groMFbh6bc7FV0bi_tbH1KgJe6i8cbN9te3OT3HFKhMA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] CXL 2.0 Support
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 11:26 AM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Fri, 2020-12-04 at 10:12 -0800, Ben Widawsky wrote:
> > Hi Chris.
> >
> > On 20-12-04 12:40:03, Chris Browy wrote:
> [..]
> >
> > >    acpidump indicates the CXL0 and CXLM devices but no SRAT or HMAT tables are
> > >    in the dump which is curious.
> >
> > I don't typically use HMAT, but I do have an SRAT in mine, so that's strange.
> > You should also have a CEDT.
> >
> I suspect an SRAT is only added if you have distinct numa nodes. Adding
> a few '-numa node' bits to the qemu command line should be enough to
> make that happen.

For CXL-2.0-Type-3, BIOS is responsible for retrieving CDATs and
synthesizing SRAT/SLIT/HMAT tables for the CXL.mem that is mapped by
platform firmware. For CXL.mem that is mapped by the OS, there is no
requirement to publish updated ACPI tables. CXL.mem mapped by the OS
need only support native CXL memory enumeration and leave ACPI only
for static platform resources.
