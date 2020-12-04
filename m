Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A62CEA7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgLDJJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:09:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39734 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLDJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:09:45 -0500
Received: by mail-lj1-f194.google.com with SMTP id o24so5767017ljj.6;
        Fri, 04 Dec 2020 01:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ZcidhlxPQUlf/XklMTlI0BO5wKjE3tN6CtUXEMvaHU=;
        b=K5kepCoebMhVRdVvNp5W7EEHZgioc8etE+T51rmcyL+d2tSww0UKZVkVdRYpM1O9sN
         Z7haV3yt6PVng7mpFp1zkQgIWe5Pm9JIMlRF0DcN/6fKk1OIJVVvp9wozWiqBh4O72KT
         yACSjgqIskQdgPgDOJeqNfRT47fy1oY+z1SzCvWjGC5Bb9U5LGBeMFfYuBDLBcqMA9ak
         /DoDNSSkQDT4v8v5Mt8XN/ufx1sF4vuLRLa0YuEXWGqC2Upsk1+y0EIk5EFa21XglYnR
         4ufFmSejrPS6x/yj372isIUUKASxV0b0UuzkmzE7S7egY8uLnY0IRMoRBRS4nB88sWKT
         tbNQ==
X-Gm-Message-State: AOAM530c41fosuDbF3cgQwZUWcwiZ5x+vy6sAEmcCh04Jj1gZ78oUC8k
        VJEHvh5V3RuH/IzsSg94sRk=
X-Google-Smtp-Source: ABdhPJw8Qm2hPmgaJcCtA/Lf0/7ZFM5i9xYR3myHPGAeTf1/JFUxjWhGaz/Kmy5/Y7dnI56JJYbQmA==
X-Received: by 2002:a2e:9c51:: with SMTP id t17mr2840849ljj.302.1607072937090;
        Fri, 04 Dec 2020 01:08:57 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id n130sm1438338lfd.213.2020.12.04.01.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:08:56 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl75l-0005J2-UX; Fri, 04 Dec 2020 10:09:30 +0100
Date:   Fri, 4 Dec 2020 10:09:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 00/15] usb: serial: avoid using usb_control_msg() directly
Message-ID: <X8n8yR5At1ptPkQ4@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Himadri,

and sorry about the late feedback on this one. I'm still trying to dig
myself out of some backlog.

On Wed, Nov 04, 2020 at 12:16:48PM +0530, Himadri Pandya wrote:
> There are many usages of usb_control_msg() that can use the new wrapper
> functions usb_contro_msg_send() & usb_control_msg_recv() for better
> error checks on short reads and writes. Hence use them whenever possible
> and avoid using usb_control_msg() directly.

Replacing working code with shiny new helpers unfortunately often ends
up introducing new bugs and I'm afraid there are a few examples of that
in this series as well.

I'll comment on the patches individually, but my impression is that we
should primarily use these helpers to replace code which allocates a
temporary buffer for each transfer as otherwise there's no clear gain
from using them.

Some of your patches contains unrelated changes which needs to go in
separate patches if they're to be included at all.

Please also try to write dedicated commit messages rater than reusing
more or less the same stock message since not everything in these
messages apply to each patch. You never mention that these helpers
nicely hides the allocation of temporary transfer buffers in some cases
for examples. In other places they instead introduce additional
allocations which at least should have been highlighted.

> Himadri Pandya (15):
>   usb: serial: ark3116: use usb_control_msg_recv() and
>     usb_control_msg_send()

Nit: please also use an uppercase "USB" prefix.

>   usb: serial: belkin_sa: use usb_control_msg_send()
>   usb: serial: ch314: use usb_control_msg_recv() and
>     usb_control_msg_send()
>   usb: serial: cp210x: use usb_control_msg_recv() and
>     usb_control_msg_send()
>   usb: serial: cypress_m8: use usb_control_msg_recv() and
>     usb_control_msg_send()
>   usb: serial: f81232: use usb_control_msg_recv() and
>     usb_control_msg_send()
>   usb: serial: f81534: use usb_control_msg_recv() and
>     usb_control_msg_send()
>   usb: serial: ftdi_sio: use usb_control_msg_recv() and
>     usb_control_msg_send()
>   usb: serial: io_edgeport: use usb_control_msg_recv() and
>     usb_control_msg_send()
>   usb: serial: io_ti: use usb_control_msg_recv() and
>     usb_control_msg_send()
>   usb: serial: ipaq: use usb_control_msg_send()
>   usb: serial: ipw: use usb_control_msg_send()
>   usb: serial: iuu_phoenix: use usb_control_msg_send()
>   usb: serial: keyspan_pda: use usb_control_msg_recv() and
>     usb_control_msg_send()
>   usb: serial: kl5kusb105: use usb_control_msg_recv() and
>     usb_control_msg_send()
> 
>  drivers/usb/serial/ark3116.c     |  29 +----
>  drivers/usb/serial/belkin_sa.c   |  35 +++---
>  drivers/usb/serial/ch341.c       |  45 +++-----
>  drivers/usb/serial/cp210x.c      | 148 +++++++------------------
>  drivers/usb/serial/cypress_m8.c  |  38 ++++---
>  drivers/usb/serial/f81232.c      |  88 +++------------
>  drivers/usb/serial/f81534.c      |  63 +++--------
>  drivers/usb/serial/ftdi_sio.c    | 182 +++++++++++++------------------
>  drivers/usb/serial/io_edgeport.c |  73 +++++--------
>  drivers/usb/serial/io_ti.c       |  28 ++---
>  drivers/usb/serial/ipaq.c        |   9 +-
>  drivers/usb/serial/ipw.c         | 107 ++++++------------
>  drivers/usb/serial/iuu_phoenix.c |   5 +-
>  drivers/usb/serial/keyspan_pda.c | 172 ++++++++++++-----------------
>  drivers/usb/serial/kl5kusb105.c  |  94 ++++++++--------
>  15 files changed, 406 insertions(+), 710 deletions(-)

Johan
