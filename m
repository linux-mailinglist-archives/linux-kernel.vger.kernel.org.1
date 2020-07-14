Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0D21F668
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGNPsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNPsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:48:51 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B455EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:48:50 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dm19so17702654edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geWoHm0dGyB50Rmo0gHBfcDLwCZECBkcejM8K8k30DQ=;
        b=XxgHUC2I3sDfRkOff33DVWFGlsDneOECTpImGtuyGsGtO0nGaNLhSMPKfl5P22aGeG
         TLVZGuaiHQwXMQb46pJmGUWWfzbMQb6vl0+JJBB2ZAWXonJOV180ui8YM9H54B9qO/v0
         9jbY2VQ2cueS9HveKggZsF7i7NEJPQUfQgolZuaYVXlAqRdyW1JJrAwNi3MG/8CCn7cs
         4KVww/VHimVN4gxPkQZYoYrnqLOOgDxzUTcktukP3c6IuQOShciXd+3JnsumWHJTakP1
         d4Rw0zG5CUIvzggFksUfup3hfCKWDPDlRpJXgrCPxEzkhj5NHVOif4DHRBV3VF/3yL/q
         mz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geWoHm0dGyB50Rmo0gHBfcDLwCZECBkcejM8K8k30DQ=;
        b=fMFgkl8HkKahEQksRH6ISZnKZagbPe6t95YwW73LhUdQ318eqSqMGu/CMyUmN78xDj
         lRYeTk29N7z8ZgaF8TS1oUY2KJK7KeDcZCB6dCREQh5Ws2c6RJMyK8upvUUqG0pzqcId
         hBQBEFes8L6Z5c+CFB8Jk9/O6Cr7Xl/+Pgm6/CVNgDM5cZklspK7oSTKN1XrZTCeFbGv
         8VRXLbAPBWgU/5H2QzlkKgefRG6t3s6nPh3+GWStg8MGXMes2q/7NrLoh6Kx1VyxMjOJ
         1zy/pK25xJTIhcIeJlbQBvVxtN/tfUuYCkDJNCO9ujZtkj3HKnoH4bz87zmoq5Vwcg0O
         52Eg==
X-Gm-Message-State: AOAM531p2oHb6Xxx45Zfr4UBlhKLx5EwyvB89zQ8cidg51DGcxfz5Qsx
        N17LwrUY08ulgLmUT3KaXD7F6/SydGFMXyqNbdYbtA==
X-Google-Smtp-Source: ABdhPJyfSdzSTluvaFbGmnt3BZHPPUXVEh/wqplhH7kzckPA8BqWzWVcQmFn8u+H3NMap7hAORZdKRYwRfF6ymXh6d8=
X-Received: by 2002:a50:ed15:: with SMTP id j21mr5401524eds.246.1594741729082;
 Tue, 14 Jul 2020 08:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200710002209.6757-1-apronin@chromium.org> <20200710114000.GD2614@linux.intel.com>
 <CAP7wa8LfEtEATbENjr18jTXShT+YmrAoDt4k9FK1SLpxVqViog@mail.gmail.com> <20200714113205.GA1461506@linux.intel.com>
In-Reply-To: <20200714113205.GA1461506@linux.intel.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 14 Jul 2020 08:48:38 -0700
Message-ID: <CABXOdTcAZjG8aQvs+M72CFe9rAdBKZH+6x=C1Ha2aX_w0gXiHw@mail.gmail.com>
Subject: Re: [PATCH] tpm: avoid accessing cleared ops during shutdown
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 4:32 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Jul 10, 2020 at 11:25:44AM -0700, Andrey Pronin wrote:
> > > Why does not tpm_del_char_device need this?
> >
> > "Not" is a typo in the sentence above, right? tpm_del_char_device *does*
> > need the fix. When tpm_class_shutdown is called it sets chip->ops to
> > NULL. If tpm_del_char_device is called after that, it doesn't check if
> > chip->ops is NULL (normal kernel API and char device API calls go
> > through tpm_try_get_ops, but tpm_del_char_device doesn't) and proceeds to
> > call tpm2_shutdown(), which tries sending the command and dereferences
> > chip->ops.
>
> It's a typo, yes. Sorry about that.
>
> tpm_class_shutdown() is essentially tail of tpm_del_char_device().
>
> To clean things up, I'd suggest dropping tpm_del_char_device() and
> call tpm_class_shutdown() in tpm_chip_unregisters() along, and open
> coding things that prepend it in tpm_del_char_device().
>

Personally I would have preferred two separate patches, one to fix the
immediate problem (with Cc: stable) and one for the cleanup, but I
guess merging both into one is ok as long as it is marked for stable.

Thanks,
Guenter
