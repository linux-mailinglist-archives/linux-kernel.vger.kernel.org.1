Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945882F9D32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbhARKtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390071AbhARKXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:23:34 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3EFC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:22:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h16so16930127edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVnd2dTqFgKPXCVm7NYzbiiSu1FiTEUGZr/l5h+PSFI=;
        b=NoGOY1SHqahPLz59ZT4Bd4qXVIlhKgntp3DttcdLUMKUyriKpC/Yw+WvtpDU6H44Ww
         Cr8S89pNeBDl8hWqLccduJYvOyZiCCIgE1Ds7xdAJA09s4U9HEdfOWzmi2BaLr/qK4eG
         fFPk4zDaCnl6AhtIz2gW/OuKJddLZt6D0pNWnBLs442ZlgbCfBLcgkJFdbKJiJ33hROZ
         gs1Wag1owjG4dwud8tLPas7tW+RGJJehhB6XLTvekldZCed0NefLhCed8u1v2NTH7bhx
         T8uCC42ACxhr03C3PZugyNu4VecRnBcTMEXaJXGQPCOHXOHtkGUdWIgvwZDy4TFM6PeY
         0e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVnd2dTqFgKPXCVm7NYzbiiSu1FiTEUGZr/l5h+PSFI=;
        b=QJIPkkcxyCZKLVEyo+XHv6oyIDmSDcc+CVqTyWymtdaQKMwastGD10AUYb+rbAKx4o
         +6V6WiR7xrOZ2wLwdP2ECLJ+BrmuCmbBgcMLlgXAEreUtdF9KRaDZt5qm5cSpKIKKTBn
         Cu6/gplmB7VdIgGeqIj6zYx2nn0dhtVRVKObxmvKYqVXvoay8iTeM9Yo1Xp3j6k0LZaU
         B5izL+QQlM1wS2EOIyW3vjsEriuZsHhm5UVzg+AIyByQDivI8+aPkOAxoCfKxAB++S0c
         P811VP+rRZKjGpQ/wld/i/8EtpB3MCRPF1dRekLO6IenlfiVzk9SbrD/d2LdTmvurIAj
         DnOQ==
X-Gm-Message-State: AOAM532jLPDz89bkKM79azKY6x7Nzh+X/ZzioKHRllqTutdCxNli9GGG
        WsR8jJTGEaXaL2ZRgym551EelOYO+ZctOZMwjran4g==
X-Google-Smtp-Source: ABdhPJxfwh3z0HRakrXQH67XgrGvut1ROZGmo6cd3/HfucTAMZCwkdY6vKLAQjzzmSj/SPW7MCRgpgKUutXGQEbTLZY=
X-Received: by 2002:a05:6402:1c0b:: with SMTP id ck11mr9185032edb.35.1610965372974;
 Mon, 18 Jan 2021 02:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20210118100955.1761652-1-a.darwish@linutronix.de> <20210118100955.1761652-2-a.darwish@linutronix.de>
In-Reply-To: <20210118100955.1761652-2-a.darwish@linutronix.de>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 18 Jan 2021 11:22:42 +0100
Message-ID: <CAMGffEk92QqBMCjnzm-uB_EHWU4NwarzbTa7URKYkjjrjOToPQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/19] Documentation: scsi: libsas: Remove notify_ha_event()
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        John Garry <john.garry@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Daniel Wagner <dwagner@suse.de>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:10 AM Ahmed S. Darwish
<a.darwish@linutronix.de> wrote:
>
> The ->notify_ha_event() hook has long been removed from the libsas event
> interface.
>
> Remove it from documentation.
>
> Fixes: 042ebd293b86 ("scsi: libsas: kill useless ha_event and do some cleanup")
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> Reviewed-by: John Garry <john.garry@huawei.com>
> Cc: stable@vger.kernel.org
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  Documentation/scsi/libsas.rst | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/scsi/libsas.rst b/Documentation/scsi/libsas.rst
> index 7216b5d25800..f9b77c7879db 100644
> --- a/Documentation/scsi/libsas.rst
> +++ b/Documentation/scsi/libsas.rst
> @@ -189,7 +189,6 @@ num_phys
>  The event interface::
>
>         /* LLDD calls these to notify the class of an event. */
> -       void (*notify_ha_event)(struct sas_ha_struct *, enum ha_event);
>         void (*notify_port_event)(struct sas_phy *, enum port_event);
>         void (*notify_phy_event)(struct sas_phy *, enum phy_event);
>
> --
> 2.30.0
>
