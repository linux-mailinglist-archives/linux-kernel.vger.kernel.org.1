Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785AE28E757
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390743AbgJNTb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390667AbgJNTb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:31:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121E8C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:31:26 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f29so676518ljo.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/sQlbZjIbCkTXYZuFjyqLr22q7RrXyITM6aG6gZEwQM=;
        b=rNxdRPukI2aQeQhs80XN7ERXfk63ATqoDHdvm4y6fcPdYqooy40XCDG+mjGJ1quewV
         z7av/j5tnGBmHnG6b58/4GDRUNcAgs5ydoPZ9E65HRy+GSHu7NynekJ6n0UfxHO64cPP
         vpSR9bJAwVJwNKyx2CSNOfRFVfGK0NTYhHySkYSscCpeUkzlpa5aCXDOL8kPOSr3pCsv
         nuZdBCNCy3LfrfJsxa8DHTQOUKl5pgQL09i0xx1efDyg+ZdQ2v+CruYimYf1CV0V9A1J
         rCBtMBXat2nRuhcVRshcQQtmEWHiUqRPBZ4uyw/Cr/yv546I2OcqKsI36wi+SQw98Xov
         Y5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sQlbZjIbCkTXYZuFjyqLr22q7RrXyITM6aG6gZEwQM=;
        b=hcGy9PSnhEj8Awdb5YIbn0ZIH+fzZTXNq1tfdfWhUl3Ptdj+0q8mJLFy9WVHhnJjlJ
         0JCqX3dcTU0hpCnVVD3G+ELXhoRuKvuRiLZIp4GkOR0ql8KwSaTBxC7TJQOjUzulIRAD
         fO8WctWfWvTMDR1qKrbxJpLOIQP21BRkSlJ0IV374MlHxfKpGj1JD+axw2it8J5dqD6b
         RnUzdMFovFoPTaIf/qQOXM16J70BMapBJRxvesfe/tHesMpbnOo+DT6qSXSdwDlbO/kW
         /rbrZqMNwKySHpW2Jb4mE6g2A6c3EOtNUveeuLcTJW2ffy4C54Sj8emZGVIP67lo53Eg
         90hA==
X-Gm-Message-State: AOAM5303qKMATGjhnUeI9T+dftaDrziOjj7+jz2kVD4yxlZyTdO1r2yN
        42LVtoLwClpyuR0FWV6zDPqPc3xDIDRlU4SPdjo=
X-Google-Smtp-Source: ABdhPJzxtIT/fRFaxw4POtgjFD2lu3ZKUpuH6kSY1wBzaGoIgufVPV+KqKbHVmfWxJGA9ncNLpIa+gGMVDT1QoDcz2Q=
X-Received: by 2002:a2e:96d2:: with SMTP id d18mr67974ljj.407.1602703884588;
 Wed, 14 Oct 2020 12:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201014175342.152712-1-jandryuk@gmail.com> <4973553f-fad2-83b9-fa19-26370ced2c2d@citrix.com>
In-Reply-To: <4973553f-fad2-83b9-fa19-26370ced2c2d@citrix.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Wed, 14 Oct 2020 15:31:13 -0400
Message-ID: <CAKf6xpvg0sk4V_txu-RYhK8cO4kLNSm8dFjEOCm38phMSYSorg@mail.gmail.com>
Subject: Re: [SUSPECTED SPAM][PATCH 0/2] Remove Xen PVH dependency on PCI
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 2:04 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 14/10/2020 18:53, Jason Andryuk wrote:
> > A Xen PVH domain doesn't have a PCI bus or devices,
>
> [*] Yet.

:)

> > so it doesn't need PCI support built in.
>
> Untangling the dependences is a good thing, but eventually we plan to
> put an optional PCI bus back in, e.g. for SRIOV usecases.

Yes, and to be clear this change doesn't preclude including the PCI
code.  I was just looking to remove code from my VMs that aren't using
PCI devices.

Regards,
Jason
