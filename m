Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E762FD9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390063AbhATT2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392434AbhATT2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:28:09 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6CEC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:27:29 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id by1so28710880ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tFCMdgvZedWspt+wwjfwNdDyL/Ze+wNdJzREDBLW6Fk=;
        b=nMGspExDUuX235k2+XQanleBXymdTcxWKYQ4yt3evkAQD8sCqFjkN7MziIuY090VGl
         426mCCktSx1rp4apsLSJzVTg81exHVPASk4qRZtVT27xpal1feB4LPBtYkv3kSV2HnJM
         SwQ8F8bDk09D6EOyoMgRYxCZAV+wYxqYLv0XJ+vTif6R3fGcx8rPtz1IJsEmtc5qpC1c
         9/8F1YgUtg0WHBDmpDd8VtlZdEKGoI4RreXa2veB8HWg7kwxsOa6QJlxJnRHX+17fXqm
         AT0FYPo26h38iIqGYhB2zhE6tBg/TAuEJDeW3zYHfDgHAdMOXiAM692bclwDrkFJeT4Y
         jt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tFCMdgvZedWspt+wwjfwNdDyL/Ze+wNdJzREDBLW6Fk=;
        b=O9N5OeVcrLcMb0ylUWa4Fbsq6igmbiBXCjhmBbZG4G8QVzrn3ewokwTReWykKnKZXU
         mDqyQa0/VtEhZhdYVm0roD8uu/hqmP6kldlkH/9LwtoAcTApjOTjkQsS7rn+iqIkiuFK
         cedBNZ8rOLMblR3OHvt/f5Mujj8g+V36EuG+jPWCY1RcT9o/9oKXuFjG68Gt26GXpkrr
         4BhvjM6nqk2WUvUPizdONBVBWEluQEiiiulHgzFGC9OAEzEZpW5x0J8lWp54JCAYKM4p
         warimr1OOgjGUKsONVUsAwDWgqjHnAZhiMtXKAOLjC3udSbW8UifpHIBPjxfcKbqJYP4
         eggg==
X-Gm-Message-State: AOAM533zcq3+/r8pdfudX1mDLNgy+zNm73qN1BLIjlgZjz1bgXG3xgCs
        PY7E85Jq/Dz1oC4V1DWOdHIZd8Kuap1kU+ZzS21EzA==
X-Google-Smtp-Source: ABdhPJwM9p+beeUOnARUSMidOhUstigJfZ7qhz2P2ZIlv/8e3wdhXKdXxrWIddFKnIObRClHkNIPZbjsZjpLRCiqKJc=
X-Received: by 2002:a17:906:ce49:: with SMTP id se9mr7146939ejb.341.1611170847785;
 Wed, 20 Jan 2021 11:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-3-ben.widawsky@intel.com> <20210112184355.00007632@Huawei.com>
 <CAPcyv4hcppMZ2L8W8arUKmbCo0r=_yZggrnsj3w-Jgszjn=ZoA@mail.gmail.com> <MWHPR11MB1599E92A457AF6D103EECB06F0A90@MWHPR11MB1599.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1599E92A457AF6D103EECB06F0A90@MWHPR11MB1599.namprd11.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Jan 2021 11:27:21 -0800
Message-ID: <CAPcyv4gyuw7U1YFCSUbyY=xRe4EPVbKHqxJUUaXP1oHtEeEwtA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/16] cxl/acpi: Add an acpi_cxl module for the CXL interconnect
To:     "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "daniel.lll@alibaba-inc.com" <daniel.lll@alibaba-inc.com>,
        "Moore, Robert" <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 9:55 AM Kaneda, Erik <erik.kaneda@intel.com> wrote:
[..]
> > The supplemental tables described here:
> >
> > https://www.uefi.org/acpi
> >
> > ...do eventually make there way into ACPICA. Added Bob and Erik in
> > case they can comment on when CEDT and CDAT support will be picked up.
>
> We would be happy to add support. I think Ben has reached out to me earli=
er about something like this but I haven=E2=80=99t had a chance to implemen=
t... Sorry about the delay.. How soon is the iASL/ACPICA support needed for=
 CDAT and CDET?

CDAT and CEDT definitions in include/acpi/actbl* would be useful as
soon as v5.12. If that's too soon I don't think we're blocked, but the
driver is fast approaching the point where it needs to consult these
tables to enable higher order functionality.
