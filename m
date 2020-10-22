Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09796296487
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902390AbgJVSTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506933AbgJVSTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:19:01 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACDFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 11:19:01 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 188so2569942qkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DH64Jki2b0cRGtwK2eLq82tqva3V/YIIJDOJFec/tqg=;
        b=kx4xqwnj6h5/3l+RNf43SX2STa83rjQXy3KG/a57ZTQkXBDa9URlcOtQNuoZxZ+9j8
         VH5+uCDuYnjNMzJPkQWVKMHY8/xJeN9Xrnwzflr2X5OaBEVrNldjMTOgKYeyqSYOhhaq
         wa6Spyb+lqtHxPLCUC5GqK82Fa2BOmDT2WLOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DH64Jki2b0cRGtwK2eLq82tqva3V/YIIJDOJFec/tqg=;
        b=q+Cx4IoIsdfpHI9Se1edTG0ZUFVxSsDOMJq4BAmz9pdG7W2glKckg6nARKMxF2YjK4
         iL9ukjQJ8ViJA2HYvUw9BXRSLJ59/Eiz3CvpQ8qi3BJLmbj/9iZepPwB/y7hscb4HZH8
         fjX1y1RdXMrmK/RlftYZJ1cYkYo/55wgE2rinvgVFywd54ju5QH/UIb4SM7/qCsqTTez
         kPmBun5XhCiKKtMpvStFEx+byCUFuZVV8QxdHLOCdPuSnt8yfwhIBznz4RoTt5Hec3u4
         snpKMPkDvFrdkmsKCHl6fH/+pgn4lThItjp0j8+M06vc9zZNjIjcAiWt5pacsml++dbx
         UG7Q==
X-Gm-Message-State: AOAM531Y7adIEppXC1zxaJQCjemUer8bI5VpG568qVYE17LmE7Lf6EVo
        u4PfQ9+9utBbB1Xdl9JdnMR9h9eBCeykcJwN+l4uUg==
X-Google-Smtp-Source: ABdhPJw5W1L6+mWM55SD0J8J4cwzi+kKAcsvzkV/zqpOXBZzOpkXGXfNRiyR/JmB2qgrw0akBx4ZT225n3JmCsanr70=
X-Received: by 2002:a37:a9c9:: with SMTP id s192mr2183416qke.128.1603390740776;
 Thu, 22 Oct 2020 11:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201022061554.3418060-1-pmalani@chromium.org>
 <20201022065719.GA1440360@kroah.com> <CACeCKacvhtSfQ=hGYHi3AdrTT+XY2RpKmPHuYWoxNVmRWMeBBA@mail.gmail.com>
 <20201022071753.GA1470296@kroah.com> <CACeCKafjm-T5WnQNRbpKm3OwxqYH+_MxLMg60-=RrpJFBzcKyA@mail.gmail.com>
 <20201022124248.GQ1667571@kuha.fi.intel.com>
In-Reply-To: <20201022124248.GQ1667571@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 22 Oct 2020 11:18:49 -0700
Message-ID: <CACeCKadwa4-xOrihjv-6mkxxFtR5VeFuExP48hTrmteXw=fr9w@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: Expose Product Type VDOs via sysfs
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Thanks for your feedback.

On Thu, Oct 22, 2020 at 5:43 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Oct 22, 2020 at 12:25:07AM -0700, Prashant Malani wrote:
> > Hi Greg,
> >
> > On Thu, Oct 22, 2020 at 12:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > Given that your current implementation is not acceptable, something has
> > > to change :)
> >
> > Got it. I'd like to see if Heikki has any suggestions on naming these
> > entries better.
>
> Why not have product type specific attribute files?
>
> So if the partner is UFP, then we expose ufp1 and ufp2 files that
> return the UFP1 and UFP2 VDO values and hide the other files:
>
>         % ls /sys/class/typec/port0-partner/identity/
>         id_header cert_stat product ufp1 ufp2
>
> If the partner is DFP, then you expose the dfp file and hide
> everything else:
>
>         % ls /sys/class/typec/port0-partner/identity/
>         id_header cert_stat product dfp
>
> And so on.
>

Makes sense, thanks! The only query I have here is , does the kernel
*need* to implement this logic? Userspace can read id_header VDO and
figure this on its own (parse the Product Type specific VDOs
accordingly).

Apart from that, I can work on implementing this if there are no concerns.

Best regards,

> thanks,
>
> --
> heikki
