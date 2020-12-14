Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81A92D958A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394230AbgLNJwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:52:32 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43631 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbgLNJwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:52:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id 23so28564244lfg.10;
        Mon, 14 Dec 2020 01:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QnDcQ7rxUSNwGS7SdG0HXOOQZgY9HLv3HqYaDL5CwSc=;
        b=Ev69QJj562NFzIyJgfx5FStogcpPbcV/Ju14kVI8YL0NWLBZ7RdXXmgGtjfbuJ2jCQ
         ug9z33hf/eOP0yho0qRvrkHOzgZQCt/mLU+vLO1Nz6oNRW7dYJ8giaObiWAp0RAkykoh
         bdh0uoT/lt/Hj1mpUlwMh6I9XdcCe661p2phUz7KJRuDCXLh+bh1DW5DcULwOR8zIzD/
         Jv/Lg4Civ5P0do4cfZ21tLrHB0SDRjyQ25/24yukuEbFjHfsLCB9s4oDtJOlNaWztVgg
         7s+3SPrNzhz91fE9zXb7xgA7adBoW5qs/sZrUsi56Z0daOiFTFAA993yGufQ1ScqZexh
         kyxw==
X-Gm-Message-State: AOAM531jRG0thQGA1EuOi3zhc42sFRNkh2VOBnfO4dFsWBcawQ+rsQmt
        sQStMbLedji2839tb9lJ/Rk=
X-Google-Smtp-Source: ABdhPJzmunBEAK4rehVzpxVgZN4efDu7ndRhmayYHmSfv5ApZHv37rR+Q+dhjV/jxXZ9WBfvJgb/3g==
X-Received: by 2002:a2e:a54f:: with SMTP id e15mr10358156ljn.461.1607939486417;
        Mon, 14 Dec 2020 01:51:26 -0800 (PST)
Received: from xi.terra (c-b3cbe455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.203.179])
        by smtp.gmail.com with ESMTPSA id v14sm2069808lfe.270.2020.12.14.01.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 01:51:25 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kokVl-0006gj-Hz; Mon, 14 Dec 2020 10:51:21 +0100
Date:   Mon, 14 Dec 2020 10:51:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org, angelo.dureghello@timesys.com
Subject: Re: [PATCH v5 0/3] Add support for MaxLinear/Exar USB to serial
 converters
Message-ID: <X9c1mUk7r2O7A8+U@localhost>
References: <20201122170822.21715-1-mani@kernel.org>
 <20201208105128.GA9925@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208105128.GA9925@work>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 04:21:28PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Nov 22, 2020 at 10:38:19PM +0530, Manivannan Sadhasivam wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Hello,
> > 
> > This series adds support for MaxLinear/Exar USB to serial converters.
> > This driver only supports XR21V141X series but it can easily be extended
> > to other series in future.
> > 
> > This driver is inspired from the initial one submitted by Patong Yang:
> > https://lore.kernel.org/linux-usb/20180404070634.nhspvmxcjwfgjkcv@advantechmxl-desktop
> > 
> > While the initial driver was a custom tty USB driver exposing whole
> > new serial interface ttyXRUSBn, this version is completely based on USB
> > serial core thus exposing the interfaces as ttyUSBn. This will avoid
> > the overhead of exposing a new USB serial interface which the userspace
> > tools are unaware of.
> > 
> > This series has been tested with Hikey970 board hosting XR21V141X chip.
> > 
> > NOTE: I've removed all reviews and tested-by tags as the code has gone
> > through substantial rework. Greg, Linus, Mauro please consider reviewing
> > again.
> > 
> 
> Any chance to get this series into v5.11?

No, sorry, reviewing this one again will be at the top of my list after
the merge window opens. Hopefully we'll have reached some conclusions
regarding the line names by then too.

Johan
