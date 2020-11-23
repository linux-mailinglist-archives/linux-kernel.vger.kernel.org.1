Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9252C1486
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgKWTcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 14:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbgKWTcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:32:46 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9DEC061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 11:32:46 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id cq7so18328722edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 11:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idsRRDFvrWEUfaaQ200ZYJgjiqOU5xE6TXnIcThRzMQ=;
        b=Wdyrvrbq+IrLnf9+ZOGO2vv3x+WxFZt2TN+CQ7V+X/sc1SgfxFUTxMH2c873wyRSSg
         59zThKnuOc8hD7N+HFZl1x3lslngFnEKOw+2Ao8MvCSvDxnldO9FFtQjtcsOUeB5C6b/
         Xtj7n7HVpB+fPnessaIv7NA3MYqUNnTK0ZMTQROtRByevKOz5juT8oTyx+Nwtv4R1ewd
         OOgDVqpnjp+08EdQjAxPR8VrfSkArZKscR3jRL5wQYVW00iVXEH1bb0LyfTnkHVBwWdZ
         9m7G3zJ2pDqtCNgFiMw8eRldmF/zXyDcDcAlTy2/EP0GniOHMA5gCJBP2neKHA7KVkR9
         ksQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idsRRDFvrWEUfaaQ200ZYJgjiqOU5xE6TXnIcThRzMQ=;
        b=uIsOUGaWrdEjUfasVyG4paXolV4C/r4FRJK2lpoKUSBeZhMyYPjkspyfR++mO2DUVj
         C3TGsmGgHvbavULgjV/Kc+f1VDyBZb8ro8kWh63XBN0kfbSFoQ26ZjgPKiVdff3Mk1YJ
         Vto+ry6WzBEfDKJ/YeaGrAFk67lSRIa95+Zyx6xycJBJg9mugY7TmIdlrvVL+vA90cpD
         kHlLVKN9YAtVXNU4SlmajlzoQc6Mr6GfH2Ktj+F9RWBpFXd6Z+Gb5kjdirA+Y4IKa1xL
         2js2TMFw7eLygKcHNruDgf/4n4RTBs8AfIHCK0kMYlLpeJK0LrBRbs6DQq+vPSLhWdyu
         Pk6A==
X-Gm-Message-State: AOAM531Ur67lK3t9EAbXKTZeyea95EcItdpbp6KeHbPpHMo8hIYlUln0
        uJxzh/qHOpnG0CM4PJ/+LR5j4hzjZF0ydP0HATUZCA==
X-Google-Smtp-Source: ABdhPJzG6sgIo04MhiGORxtweJtY7Ith2jiGAwGdEG1XvFP+atMBFpBYF8qTDnkKNX7f8mwgWSvRhCZrpVeQDso7ILQ=
X-Received: by 2002:a50:fe02:: with SMTP id f2mr716870edt.97.1606159965112;
 Mon, 23 Nov 2020 11:32:45 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4j+zbns+WhnxWXCdoxa=QN40BFXUpmb=04q36H1sX-aBw@mail.gmail.com>
 <20201117002321.GA1344659@bjorn-Precision-5520> <20201123192029.pmmy6ygts5fclz7b@intel.com>
In-Reply-To: <20201123192029.pmmy6ygts5fclz7b@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Nov 2020 11:32:33 -0800
Message-ID: <CAPcyv4jJpvLErK8vBW-D2ZQASU0iJqFLRr7yDXB0kfGPrmi6xw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] cxl/mem: Map memory device registers
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-cxl@vger.kernel.org,
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

On Mon, Nov 23, 2020 at 11:20 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > -ENXIO is fine with me.  I just don't see it as often so I don't
> > really know what it is.
> >
> > Bjorn
>
> Dan, Bjorn, I did a fairly randomized look at various probe functions and ENODEV
> seems to be more common. My sort of historical use has been
> - ENODEV: General, couldn't establish device presence
> - ENXIO: Device was there but something is totally misconfigured
> - E*: A matching errno for exactly what went wrong
>
> My question though is, would it be useful to propagate the error up through
> probe?

The error from probe becomes the modprobe exit code, or the write to
the 'bind' attribute errno. So, it's a choice between "No such device
or address", or "No such device". The "or address" mention makes a
small bit more sense to me since the device is obviously present as it
is visible in lspci, but either error code clearly indicates a driver
problem so ENODEV is fine.

For the other error codes I think it would be confusing to return
something like EINVAL from probe as that would be mistaken as an
invalid argument to the modprobe without stracing to see that it came
from the result of a sysfs write
