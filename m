Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6033D2865E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgJGR2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgJGR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:28:50 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC3BC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 10:28:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u24so1814307pgi.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xZ+v2OuQAePhXqVi/kdiZzONG4PhtaojmuzF5SZ8xdQ=;
        b=jjVdZZJO2VKrU5vGwGaKENvwebjy9U4YrvQZuQh867KzqulQ5YAGG2aGsnvOJ7SNwL
         67LhMH6thzslOn+c6LItKcOFZ+dBQk9LTKjj+fPA5sW9cednh50SxaSbstDyu+8uyh/e
         jXLbDrUk/RYwNjhbeYGqQt4xxOvM7AzzXokt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xZ+v2OuQAePhXqVi/kdiZzONG4PhtaojmuzF5SZ8xdQ=;
        b=Ijsi3I+whDQ4c0oF5cW4LfDWOUMcDZ+pkTmpGb2LPu0JzSHeiVdE8+bZDs1GujS9rx
         kuC1kpRTz+EtvSU00hebRCYZMrLa5OCYDlnXpfExZSiRcagpAVuSPofmZy4w6RXbgjjG
         m/E2EezVHxturt9RySZrl2QQS4Pu2xnoIYbH1Gwk1dkh5fOJ8S4GHl2TvYCoJzlIh1n9
         R2fI+RD/b5OLE+TMVGaJ1F7+NbM4SJ6xbHBtmWND/lvAO/IsWNalq4NY1DYOXE1ApjFx
         fvanukTj/nKJB0m9YuaIvBG9muFEexKTKBC2LH1aiTU39Wpobcyz0raN05Q5Jzvlhar+
         iurg==
X-Gm-Message-State: AOAM532dbIySWd7NAgPnQJpRF/OZmJqKfagmH836DcHgWkp+UL7U9noO
        eymAwaymYVnc3L2Xp8RVUyW+vw==
X-Google-Smtp-Source: ABdhPJw9NREkTfYOdNETDhW2xqODkOGKkUImfKXew2xQ2izoRdSgSn+1QXOSornth1rL61DMyAkEJQ==
X-Received: by 2002:a63:551d:: with SMTP id j29mr3965988pgb.144.1602091729994;
        Wed, 07 Oct 2020 10:28:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id o62sm3991891pfb.172.2020.10.07.10.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 10:28:49 -0700 (PDT)
Date:   Wed, 7 Oct 2020 10:28:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete
 onboard USB hubs
Message-ID: <20201007172847.GB620323@google.com>
References: <CAL_JsqLWmBCjrbs2D-d+9naJAKkNhDAbmRtqvCDY8jv=L_q-xA@mail.gmail.com>
 <CAD=FV=XkV2eGuPhpo-v4bYy12DVNtDAtjyzpKs7r6SOUZf6-sg@mail.gmail.com>
 <20201006004510.GD4135817@google.com>
 <20201006141820.GA416765@rowland.harvard.edu>
 <20201006165957.GA191572@google.com>
 <20201006171524.GB423499@rowland.harvard.edu>
 <20201006192536.GB191572@google.com>
 <20201007010023.GA438733@rowland.harvard.edu>
 <20201007160336.GA620323@google.com>
 <20201007163838.GA457977@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007163838.GA457977@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 12:38:38PM -0400, Alan Stern wrote:
> On Wed, Oct 07, 2020 at 09:03:36AM -0700, Matthias Kaehlcke wrote:
> > On Tue, Oct 06, 2020 at 09:00:23PM -0400, Alan Stern wrote:
> > > On Tue, Oct 06, 2020 at 12:25:36PM -0700, Matthias Kaehlcke wrote:
> > > > On Tue, Oct 06, 2020 at 01:15:24PM -0400, Alan Stern wrote:
> > > > > You don't need a platform device or a new driver to do this.  The code 
> > > > > can go in the existing hub driver.
> > > > 
> > > > Maybe. IIUC currently USB drivers don't support/use suspend_late. Could that
> > > > be added? It would simplify matters, otherwise all hubs need to know their
> > > > peers and check in suspend if they are the last hub standing, only then the
> > > > power can be switched off. It would be simpler if a single instance (e.g. the
> > > > hub with the DT entries) is in control.
> > > 
> > > Adding suspend_late would be a little painful.  But you don't really 
> > > need it; you just need to make the "master" hub wait for its peer to 
> > > suspend, which is easy to do.
> > 
> > Ok, I wasn't sure if the hubs suspend asynchronously from each other. If they
> > do it should indeed not be a problem to have the "master" wait for its peers.
> 
> Well, order of suspending is selectable by the user.  It can be either 
> asynchronous or reverse order of device registration, which might pose a 
> problem.  We don't know in advance which of two peer hubs will be 
> registered first.  It might be necessary to introduce some additional 
> explicit synchronization.

I'm not sure we are understanding each other completely. I agree that
synchronization is needed to have the primary hub wait for its peers, that
was one of my initial concerns.

Lets use an example to clarify my secondary concern: a hub chip provides a
USB 3 and a USB 2 hub, lets say the USB 3 hub is the primary.

Here is some pseudo-code for the suspend function:

hub_suspend(hub)
  ...

  if (hub->primary) {
    device_pm_wait_for_dev(hub->peer)

    // check for connected devices and turn regulator off
  }

  ...
}

What I meant with 'asynchronous suspend' in this context:

Can hub_suspend() of the peer hub be executed (asynchronously) while the
primary is blocked on device_pm_wait_for_dev(), or would the primary wait
forever if the peer hub isn't suspended yet?

> > > And hubs would need to know their peers in any case, because you have to
> > > check if any devices attached to the peer have wakeup enabled.
> > 
> > My concern was about all hubs (including 'secondaries') having to know their
> > peers and check on each other, in the scenario we are now talking about only
> > the "master" hub needs to know and check on its peers, which is fine.
> 
> Not all hubs would need this.  Only ones marked in DT as having a power 
> regulator.

Sure, as long as the primary (with a power regulator) can wait for its peers
to suspend without the risk of blocking forever (my doubt above).
