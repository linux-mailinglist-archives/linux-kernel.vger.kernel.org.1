Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4506029A637
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392391AbgJ0IJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:09:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35968 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390803AbgJ0IJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:09:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id h6so1172797lfj.3;
        Tue, 27 Oct 2020 01:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pJwTDxwSNjJyt/bUBTrRaAlA98OoF86CDhEmIYl/zTQ=;
        b=JR+fuQ1J0XNvdRGoeRMYchYpVxhPXR1VtLN0+6/D9FjD33N2E8B2x9lFKqwGgHrSgW
         juPVjI/AW8hAcGKC0GHkQs7S1aGKOaeUQ+oPwf4ZEiCsNShRC+YXMJmfGkkfsO/cViQD
         VPx1tLcYvWbTurW5HSHNtYS4YonK3xw9ZNrGodVGqFuZM9sAasIPEHybyxN0mjsgsIZ7
         zRejti8SuP5NfrY82AqF1U5ELhUgfd7933TlLuFLBjeRPXa4PK/VHwAtzG54Qtxu6rEQ
         apu38pfq02pi7NvYKkciWjEJRUo8X/sU3qHcGeGhpxly9e28gwQlgQ8PiOq1CZleJdaC
         8Ksw==
X-Gm-Message-State: AOAM530zbBCVr8+wbYh1MHMRpcTHmpWujq94K08RcMz+dBuyx3uydK+a
        wkBq+cq7D+sEYfaL28jmRzU=
X-Google-Smtp-Source: ABdhPJxmLdtVG9D8duptQFW4e1V1UplLjzVvjydQ8+tNDQYHWmPlzk1ZOyR1zfb6ellAm2R0+OBQHQ==
X-Received: by 2002:a05:6512:211:: with SMTP id a17mr390113lfo.217.1603786155326;
        Tue, 27 Oct 2020 01:09:15 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id z25sm89694lfi.132.2020.10.27.01.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 01:09:14 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kXK2a-0001Fd-OE; Tue, 27 Oct 2020 09:09:13 +0100
Date:   Tue, 27 Oct 2020 09:09:12 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] USB: serial: keyspan_pda: clean up xircom/entrega
 support
Message-ID: <20201027080912.GA4085@localhost>
References: <20201025174600.27896-1-johan@kernel.org>
 <20201025174600.27896-12-johan@kernel.org>
 <20201026120002.vl3htwmizmcvydn3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026120002.vl3htwmizmcvydn3@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 01:00:02PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-10-25 18:45:57 [+0100], Johan Hovold wrote:
> > Drop the separate Kconfig symbol for Xircom / Entrega and always include
> > support in the keyspan_pda driver.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/usb/serial/Kconfig       | 19 ++-------
> >  drivers/usb/serial/Makefile      |  1 -
> >  drivers/usb/serial/keyspan_pda.c | 68 +++++---------------------------
> >  3 files changed, 13 insertions(+), 75 deletions(-)
> > 
> > diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
> > index 4007fa25a8ff..a21ff5ab6df9 100644
> > --- a/drivers/usb/serial/Kconfig
> > +++ b/drivers/usb/serial/Kconfig
> > @@ -538,17 +538,6 @@ config USB_SERIAL_CYBERJACK
> >  
> >  	  If unsure, say N.
> >  
> > -config USB_SERIAL_XIRCOM
> 
> Should this patch remove this symbol from defconfigs or does it happen
> every now and then on its own? All of them select USB_SERIAL_KEYSPAN_PDA
> so there is no loss.

Good catch, thanks! I'll remove those config entries as part of this
patch.

Johan
