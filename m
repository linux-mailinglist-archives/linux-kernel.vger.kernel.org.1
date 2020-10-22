Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1B295902
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508485AbgJVHZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506371AbgJVHZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:25:19 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E223C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 00:25:19 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e6so386653qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DvfRuzq2t0P16AvKn55ain8yuYvafMCh1JlHhrSFzYk=;
        b=KJ8HFOnHbfrCizxBWaNMlvuGNfJdHOD3gwbsZ+VUMNGkVi+6ohc/inYKvMISepAVre
         S4UljXttqHyQc1ZoGQbZG7xEEN1zGhoLCb99sHoabsaNzi84Ra0j6dC1FtUNWrx0iHR2
         n4taQ+Wyh668FwuSnvpFoUJFH3XdeHTo0RJCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvfRuzq2t0P16AvKn55ain8yuYvafMCh1JlHhrSFzYk=;
        b=OoPIWTRLKMjbKwberG2EuWxswCV3XMz8mZKJJWeCB75xlv0Ta8emPgOsP/DKPQ0fAT
         y4ZYMEVVcoNgDBQsgKRTvPHaBOQOodLc3pnH0KDEc8uhfSQqK+96WLYuWw5CdUCMP5Ws
         jtyMdZZCVKcDf/cHtbel/XaoZTz9LZtcDZPbaOYHVUi57yy7F5Bm17ltWNgdckZURFkv
         txwoHW/z3PLW1tk9UjrWhEImRd1cG2abnB+0t1n0fNv58AV6WGDS9cZrnDE6iv5K1NZA
         FnK97UKFyo87aGVBMdHXdnc+aVeSu48UQasErULZDh8YLq78+8fnsDsqW8KR82lx53et
         XzKQ==
X-Gm-Message-State: AOAM532xXwDMkq+ThhirAvFga/599cv8Xn0S0gT4uuQ58yMMRkS+gMFh
        pizIfMCaNs2uoQ1Psux5z1J6ZdW18YhDsZdmhKyigQ==
X-Google-Smtp-Source: ABdhPJz/QZs4ybfZd55bp0vnCtUoz6WIOCxFdqbybUp44s4ZZGlfb97HohIoFIoqkNTev/Rcy/p6hPgBFqyQFALNkA0=
X-Received: by 2002:aed:22c7:: with SMTP id q7mr728888qtc.141.1603351518703;
 Thu, 22 Oct 2020 00:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201022061554.3418060-1-pmalani@chromium.org>
 <20201022065719.GA1440360@kroah.com> <CACeCKacvhtSfQ=hGYHi3AdrTT+XY2RpKmPHuYWoxNVmRWMeBBA@mail.gmail.com>
 <20201022071753.GA1470296@kroah.com>
In-Reply-To: <20201022071753.GA1470296@kroah.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 22 Oct 2020 00:25:07 -0700
Message-ID: <CACeCKafjm-T5WnQNRbpKm3OwxqYH+_MxLMg60-=RrpJFBzcKyA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: Expose Product Type VDOs via sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Oct 22, 2020 at 12:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > > > +What:                /sys/class/typec/<port>-partner/identity/product_type_vdo
> > > > +Date:                October 2020
> > > > +Contact:     Prashant Malani <pmalani@chromium.org>
> > > > +Description:
> > > > +             Product Type VDOs part of Discover Identity command result. 3 values
> > > > +             are displayed (for the 3 possible Product Type VDOs), one per line.
> > >
> > > sysfs is "one value per file", not "one value per line".  This is not
> > > ok.
> >
> > I see. Would listing these out as three separate vdos (i.e vdo0, vdo1,
> > vdo2) be better?
>
> Given that your current implementation is not acceptable, something has
> to change :)

Got it. I'd like to see if Heikki has any suggestions on naming these
entries better.

Thanks again and best regards,

-Prashant

>
> thanks,
>
> greg k-h
