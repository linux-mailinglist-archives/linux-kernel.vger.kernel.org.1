Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E637F2EEF57
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbhAHJTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbhAHJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:19:42 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083C8C0612F4;
        Fri,  8 Jan 2021 01:19:02 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id t8so9094780iov.8;
        Fri, 08 Jan 2021 01:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0UzHOd3okV0qpJMc682hFBfathXKjKul5nXUx2yUFc=;
        b=F8f7tTd5RCkx2C4eh3Qvv9dClv2bZtMk3yyiFQQx74z0WQqkC3TBDn8Yf4geL8cTaF
         ndytfDet/nngjB6Wis7vk27FHZ8mNuUHlTVii2bpCDGq8MrM8Flknior7qEVgvIzlqDf
         Y96Z9QwPlV2dI16gKEMzFOdAIuS4VAkPBpj9pmYaV3/Npky3HQ5yqar+A0tDU+6lmQ88
         pYGuA6e3bTSZOEqOjEcSYwppb/8mdcTiso6KDjtlPlwSCB1hTyJTSwxNkVxprH9iO+pd
         tqNDFhjh7kpAYWRgePSKmB6YgS+v8Z8+WUNPBZk3mBBh+arxrnE77wCAwxnH63n/Y0DC
         5C7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0UzHOd3okV0qpJMc682hFBfathXKjKul5nXUx2yUFc=;
        b=jKTuXexB6CA6lFzc9OYijHwFSiP1UE/GzUeIJjLZmRWceBnCZ8/PwW0/lXO3QDUZN9
         DSYGFTT55nPfwNeD6f/j4+ae2hYIvc3++q/ORlIKOxjeIWZOK9LrHMedZFSVqj02aezC
         f1pyAl6GDvz1Gxg+qA4AMfUMxGhdXp82p7laoDirSylpT4xnut/L7bt3r+ymMGT/6LtP
         9z04UIai/b1qPgPmD+f49MshU2dbeqWGWuajIgGOFwzyp1ZbBCCxx3MvLX7cQUI+Ox5y
         CmhP8u5LVCfWGsMTGAQpfstuMWRQ4AqTGAxZFIOnmGmBzfLeHHTW9D4KKg3yVVUKBv5C
         ZgLQ==
X-Gm-Message-State: AOAM5332ED25lCByUWub96Mf2R6lJPBkJPbYJHL/KTRDfgfnlTn3lHJq
        +bomgjXz0zoc6EComz7Rtfe/VfvHAqQ0Xupxa7w=
X-Google-Smtp-Source: ABdhPJyfjLwgvHCGe6CncF0auRwlIUDRFyy4qz1UYNc+B5B0sgSfo5G7aPXzeVtJYm+wsjlb0rJtWZX+RmqLQs2yFpA=
X-Received: by 2002:a02:3f62:: with SMTP id c34mr2662497jaf.16.1610097541408;
 Fri, 08 Jan 2021 01:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20210107103417.16010-1-alexandru.ardelean@analog.com>
 <20210107103417.16010-4-alexandru.ardelean@analog.com> <20210107152538.GC13040@roeck-us.net>
 <CA+U=Dspo0aovB4M76FoUaPpfYN-ZiCkCUc1Am24Mq7VSHRStEQ@mail.gmail.com> <20210107173548.GA49383@roeck-us.net>
In-Reply-To: <20210107173548.GA49383@roeck-us.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 8 Jan 2021 11:18:49 +0200
Message-ID: <CA+U=Dsr+AZrn8MBkYbXzQqhYxph1tiU1ja5GaSeZSsy5m=55Gw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] hwmon: (ltc2945): add support for sense resistor
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, jdelvare@suse.com,
        "Thoren, Mark" <mark.thoren@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 7:35 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Jan 07, 2021 at 05:44:33PM +0200, Alexandru Ardelean wrote:
> > >
> > > Note that this patch doesn't compile on 32-bit targets.
> >
> > Yeah, my bad.
> > I only tested with  make allmodconfig, and that doesn't do a good job
> > at providing linker issues.
> >
> The problem is the 64-bit divide operation introduced with your patch.
> You'd see that if you build allmodconfig with ARCH=i386.

Oh, right.
That thought actually escaped me.

Thanks for the tip
Alex

>
> Guenter
