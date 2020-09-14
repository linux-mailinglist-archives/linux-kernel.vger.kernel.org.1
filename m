Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB8A269783
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgINVPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgINVOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:14:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F39C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:14:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l191so796368pgd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vhBJpFh7LpS6l+ihl8unlGrM5gNVdzAOXOoEIys9z0M=;
        b=XgS/+ZdxImynQIwWmSa0+yIApIdMsIityrt10mIHaPsfUV81LLX/ko9FW02rZYdER9
         zIEOxovTxJ7duvnI3GP6hwBn9VaVcChYjoiHa5oZLkFZLo4OoQ4fqeblLWlG5LOtxoUj
         JYuLk8CCbo+bgHVwZCheekr/04cWD7neXQJzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vhBJpFh7LpS6l+ihl8unlGrM5gNVdzAOXOoEIys9z0M=;
        b=GIH9nQGvnE7BnRzqKfRNPbyEzR8VrKudiH7zj0bRDWfUPRnwr6CS4+i4RqVFEmCw2k
         /oIMLfTJfoesYE36CTgRmuvWPTn2u5KHRtzcW7RN08q3/sKqf6PGBVBza8xwGs1R1JDC
         WhJNjzi5dMd+MAy+1LGKdRj5D9CYF3Nl68X+V6kcOlxil1+zpBGWmoRNePEclYdpoQcg
         5vziTFvSu1n6tPcNJ2emgQr/mg98lr0F8cwA/2HNvyGaWnu96riH8wjJZkI4SXZAtw8u
         icrRYdnldjbhiSA6cIh18k3FPA+6QVtcKtj17uwGNp0RxTq+NC6iQFjMHyJezXjxphIq
         lLmg==
X-Gm-Message-State: AOAM531IMV8RbBCjAksMbU7ocES/wmFzSR8fHwWgp4DCT8H7q6w51gTO
        z8lpO6Emyb0y1TqGDL8LalEUIA==
X-Google-Smtp-Source: ABdhPJwA/MrD7V5VcAx5rbje9K+C6ArZfV14fj2XEW4biFFvVBvAOZcISeQlMVefkxiAbVCyv0N8pA==
X-Received: by 2002:a63:2250:: with SMTP id t16mr12193817pgm.303.1600118094278;
        Mon, 14 Sep 2020 14:14:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id k6sm11444204pfh.92.2020.09.14.14.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 14:14:53 -0700 (PDT)
Date:   Mon, 14 Sep 2020 14:14:52 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@nxp.com>, linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 2/2] USB: misc: Add onboard_usb_hub driver
Message-ID: <20200914211452.GE2022397@google.com>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200914112716.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200914201403.GA977844@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200914201403.GA977844@rowland.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

thanks for your feedback!

On Mon, Sep 14, 2020 at 04:14:03PM -0400, Alan Stern wrote:
> On Mon, Sep 14, 2020 at 11:27:49AM -0700, Matthias Kaehlcke wrote:
> > The main issue this driver addresses is that a USB hub needs to be
> > powered before it can be discovered. For onboard hubs this is often
> > solved by supplying the hub with an 'always-on' regulator, which is
> > kind of a hack. Some onboard hubs may require further initialization
> > steps, like changing the state of a GPIO or enabling a clock, which
> > requires further hacks. This driver creates a platform device
> > representing the hub which performs the necessary initialization.
> > Currently it only supports switching on a single regulator, support
> > for multiple regulators or other actions can be added as needed.
> > Different initialization sequences can be supported based on the
> > compatible string.
> > 
> > Besides performing the initialization the driver can be configured
> > to power the hub off during system suspend. This can help to extend
> > battery life on battery powered devices, which have no requirements
> > to keep the hub powered during suspend. The driver can also be
> > configured to leave the hub powered when a wakeup capable USB device
> > is connected when suspending, and keeping it powered otherwise.
> > 
> > Technically the driver consists of two drivers, the platform driver
> > described above and a very thin USB driver that subclasses the
> > generic hub driver.
> 
> Actually it subclasses the generic usb device driver, not the hub 
> driver.

ok, I'll change it in the next version.

> >  The purpose of this driver is to provide the
> > platform driver with the USB devices corresponding to the hub(s)
> > (a hub controller may provide multiple 'logical' hubs, e.g. one
> > to support USB 2.0 and another for USB 3.x).
> > 
> > Co-developed-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > This is an evolution of '[RFC] USB: misc: Add usb_hub_pwr driver'
> > (https://lore.kernel.org/patchwork/patch/1299239/).
> > 
> > Changes in v1:
> > - renamed the driver to 'onboard_usb_hub'
> > - single file for platform and USB driver
> > - USB hub devices register with the platform device
> >   - the DT includes a phandle of the platform device
> > - the platform device now controls when power is turned off
> > - the USB driver became a very thin subclass of the generic hub
> >   driver
> > - enabled autosuspend support
> 
> See https://marc.info/?l=linux-usb&m=159914635920888&w=2 and the 
> accompanying submissions.  You'll probably want to include those updates 
> in your driver.

Thanks for the pointer! I'll change the driver to use pm_ptr as suggested.
