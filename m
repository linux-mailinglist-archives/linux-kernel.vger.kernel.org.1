Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F53261F60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbgIHUCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbgIHPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:34:40 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2654EC0619E8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:56:35 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e14so9009027vsa.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4KG5CW+7TEOr9AorGHeiLF2hEUgTMjhM8Tr7m3GReM=;
        b=Pk2vE9e4uOYo8BaBgIoksZND1qYOLdRCkV7yBIAP8XFJWRheQ0psIJ5Vw6dnUYi969
         VCcu7JcAioh8LWaUvomdYIsAMA0LnwIedCxM7o2gnVMW8pIogTcnSZ7kNiWG2kStXzxk
         fhMbect2yCjP1U7hdvNrwXXOuiz5n17D3PVTTlNbe6W3qyBWU2DkGkvkh9aZVoceGnK6
         DEzMd9aDm8Fp1UYRxeSOLD40OPMxZuVSQ2kVA914hoz3lF3GeqNIBP3MK1ZcuXzmDhi+
         Ck7E0vhAuV/zT/prTPWAOtraedlqObAd2Cgj2oxb5aKopY652flfkEXcbcG8XUKzvmUq
         0GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4KG5CW+7TEOr9AorGHeiLF2hEUgTMjhM8Tr7m3GReM=;
        b=GK67Ih03pC5QXrHluWbuLHZxji/ikGTCP0766OirUR5woJ8uJ3DJOtu4SKZsQshdeW
         1bTGkchOiiNOIv1GSWHGMbuH9LaMzLZ9/V6dYvmS6PHV6z+4e4x4ZpHZ5V6JXCjemIZx
         knq9NgyvlLKdPlYxQZe1QeLiXntfWNbqjsXKomVm575ney7YR/6p1CZA30bOCblF4Ozf
         bptx7jjkfiwHBGbyUGWFbc9DeDndIh6ah3w619IMCAD1x0/nkcEJ9nuRpFSq47vYXrOW
         8TlzPNN1viuUG/Rqks+TEyXLSgCXiJya5nd4PIomVdCIg0o+UFJaIM3bvS0b2LFqPMSO
         fc9Q==
X-Gm-Message-State: AOAM5336H7k4pSjmw+7iqlx1qbWj0oCRUdyAJIALIc0OqmDNxS3cFsat
        oeYC0Yi/RVlMENp0eRWx6O5Ztln6RbvqDg==
X-Google-Smtp-Source: ABdhPJxcd5cD+JVABEbqrJVPVXQrs/aLwUxIh72fABFvVmW6MuTXwOT/vL3KJuB/OpPoqJQuqTW6Bw==
X-Received: by 2002:a67:7795:: with SMTP id s143mr14588267vsc.94.1599573393788;
        Tue, 08 Sep 2020 06:56:33 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id q8sm1603917vsj.20.2020.09.08.06.56.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 06:56:33 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id v20so5082987ual.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:56:32 -0700 (PDT)
X-Received: by 2002:a9f:2648:: with SMTP id 66mr13625593uag.37.1599573392132;
 Tue, 08 Sep 2020 06:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200906031827.16819-1-xie.he.0141@gmail.com> <CA+FuTSfOeMB7Wv1t12VCTOqPYcTLq2WKdG4AJUO=gxotVRZiQw@mail.gmail.com>
 <CAJht_EO13aYPXBV7sEgOTuUhuHFTFFfdg7NBN2cEKAo6LK0DMQ@mail.gmail.com>
 <CA+FuTSdK6qgKwgie5Bqof8V5FR__dx-HgHUcDS5sgTQmH9B9uQ@mail.gmail.com> <CAJht_ENHmL322bS4BnarXLW+GjOC4ioQ8MMtnsqwOhF_gee5Yw@mail.gmail.com>
In-Reply-To: <CAJht_ENHmL322bS4BnarXLW+GjOC4ioQ8MMtnsqwOhF_gee5Yw@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 8 Sep 2020 15:55:54 +0200
X-Gmail-Original-Message-ID: <CA+FuTSdGXF-gxEvfOxZd1dNXfBmaDKFqGTH8EzNXZpYLcrwzjA@mail.gmail.com>
Message-ID: <CA+FuTSdGXF-gxEvfOxZd1dNXfBmaDKFqGTH8EzNXZpYLcrwzjA@mail.gmail.com>
Subject: Re: [PATCH net] net/packet: Fix a comment about hard_header_len and
 headroom allocation
To:     Xie He <xie.he.0141@gmail.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Or Cohen <orcohen@paloaltonetworks.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > More about the older comment, but if reusing: it's not entirely clear
> > > > to me what "outside of the device" means. The upper layers that
> > > > receive data from the device and send data to it, including
> > > > packet_snd, I suppose? Not the lower layers, clearly. Maybe that can
> > > > be more specific.
> > >
> > > Yes, right. If a header is visible "outside of the device", it means
> > > the header is exposed to upper layers via "header_ops". If a header is
> > > not visible "outside of the device" and is only used "internally", it
> > > means the header is not exposed to upper layers via "header_ops".
> > > Maybe we can change it to "outside of the device driver"? We can
> > > borrow the idea of encapsulation in object-oriented programming - some
> > > things that happen inside a software component should not be visible
> > > outside of that software component.
> >
> > How about "above"? If sketched as a network stack diagram, the code
> > paths and devices below the (possibly tunnel) device do see packets
> > with link layer header.
>
> OK. I understand what you mean now. We need to make it clear that the
> header is only invisible to upper layers but not to "lower layers"
> that the device may rely on.
>
> I'm thinking about a way to clearly phrase this. "Above the device"
> might be confusing to people. Do you think this is good: "invisible to
> upper-layer code including the code in af_packet.c"? Or simply
> "invisible to upper-layer code"? Or just "invisible to upper layers"?
> (I don't like the last one because I feel according to the network
> stack diagram "upper layers" should already and always not care about
> the LL header.)

Upper layers is often understood to imply the network stack diagram
indeed, excluding other stacks, such as virtual devices or packet
sockets. Hence above. But either works. The commit message will
disambiguate.
