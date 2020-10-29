Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599D329F07A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgJ2Puo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgJ2Puo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:50:44 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03D7C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:50:43 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id b2so2695096ots.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qQFyKLs/nGSD4niQsOfeNsQ3Pr6In9AqSwy4SvVmTig=;
        b=ulX5pi7ZGyIq2Tiu0p/8ocSW0QC50ZLH9qOM4zCL2eJB3isWwF912WJi/nRHabafVB
         rZdIpvyVkg3ezZY/SCdsIuC1fhNZRkqWlkr6y4LsmNl2FtaajI3+AqInap8qitX43Y2U
         T7t7ocMxffopo+g/47AmLz78ezSkuW6aXE9dCZunFtue+/PUVsAL1jfpZHK64fbjod7A
         tQtlLR31NFHOR4LGcBXTRZbePPEBaQXe1Bha4aVGqccod7RdHN5UUg+o7TSCUtHXWfee
         mNUvl0HKP6TzBrgnuFcaMs1d33ymU3YSR26t8vV9ZsIHWY4SZyvu7SdbZC10YahYlGpG
         YsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQFyKLs/nGSD4niQsOfeNsQ3Pr6In9AqSwy4SvVmTig=;
        b=oKUIcPQgdXp79HX2nL1/iNDF2NdW/NWbWTKeTqPOrywa6Eou8h3XbWkOR3LpLBvZIJ
         54E0d9v3rKU1mnM/AXr+d9IS/2vE4SmYJJpg017WY5D+rBTO+eW11snzC4vmqP3DLfSL
         Nd3irTw75nHGPB8rxgvwBX+QyMtib766+dd9bD4lMj9gmQ0FP11Xfoi3VxXxnaXE1UTY
         c3nbxjKPwSmgQD3rMNkF+x/699o1xli+fx1Tf8nPofajGhdlAq7tcFccsu4B0xGHBN8D
         8N1i3l3VnlW85bDPYe6oc8AXepu3c58UQYr3BVUOPY2szwbZPr3NUgzqe1aJBBBmo4+d
         KmwA==
X-Gm-Message-State: AOAM530L07wqJSV8t1kmG/o6u0hGo40T2VQIdi++31nRhIyt/UVKNXmR
        0AHIu1ZjZUHzl6nCClBq2sHYTBH7b1p55zALn2k=
X-Google-Smtp-Source: ABdhPJzUqtInQ08EqDHXDx7ZekSslAagvhK0nA47WAzjcKzfYGzRWjeyl/NOBUhqGAGxePSsz/v/ES87KUdO4UCOQG0=
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr3529328oth.215.1603986642467;
 Thu, 29 Oct 2020 08:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201029143205.197ff58f@endymion> <24f8766403f881d4f56a9b721f29b6ee5d1173e2.camel@perches.com>
 <20201029161144.3c7a4fb1@endymion> <f998d7857bd6b51d2ca1d1b4f873efe95c9af11d.camel@perches.com>
In-Reply-To: <f998d7857bd6b51d2ca1d1b4f873efe95c9af11d.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 29 Oct 2020 21:20:11 +0530
Message-ID: <CABJPP5B11ucWfBc8MgqoWifTc_LMyoH8hMCVfDO2RyHL1fuzVw@mail.gmail.com>
Subject: Re: False positive from checkscript: git git://...
To:     Joe Perches <joe@perches.com>
Cc:     Jean Delvare <jdelvare@suse.de>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 9:11 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-10-29 at 16:11 +0100, Jean Delvare wrote:
> > On Thu, 29 Oct 2020 07:55:25 -0700, Joe Perches wrote:
> > > On Thu, 2020-10-29 at 14:32 +0100, Jean Delvare wrote:
> > > > WARNING: Possible repeated word: 'git'
> > > > #20: FILE: MAINTAINERS:5289:
> > > > +T:       git git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-next
> > > >
> > > > Obviously that's going to happen a lot as this is actually the proper
> > > > way to list a git tree in that file. Could you please add an exception
> > > > for that case?
> > >
> > > Already done in -next
> >
> > Perfect, thank you very much.
>
> Actually thanks to Dwaipayan Ray <dwaipayanray1@gmail.com>
>

Happy to be of help :)

Thanks & Regards,
Dwaipayan.
