Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAED1BFD9B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 16:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgD3OOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 10:14:02 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34943 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD3OOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:14:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id o7so5333771oif.2;
        Thu, 30 Apr 2020 07:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X1MbW9Qo4Miysa5TwjV5C+o7hh3lAoWv+hFsO/XdvDw=;
        b=LL7KgwOJmJNSonng3nWGj40PkFLVPrtAqJ3G1fxBvSKlTQ14m2D+aBGFnXUjCL0Myu
         GjAhu4dU1k3/DJIRlv6ss/yEVZ7w/3mUILraO3EU7fPqRiIonwsdCu4X854+t4TLxU4v
         1J7dxpPY421FuGr4lOGrN8hln0FBBisQjC4lZCSkoVl6mbejg9fsCHppKZGBk0RyTqEp
         u3K/LRDJ2crgRRqic4u9Cz/y44hgSJVpN6z5levlmPGbZs7jX8lKTHZ0FizaxR6ProKZ
         KMDBHEw6WX8NUmPzjqHLDKUkTuaMuJ3LA/QR4mHUmJS9n9a5E4iFJ8WecfQpBAfEPO9n
         a3AA==
X-Gm-Message-State: AGi0Pua2bu7DMDycqSpeIXI1EB+wNX3RGuY6CDzQJrWOLNdwMGa1VV7I
        kd2HHmJEvdcewoSOguU2fgolxEY=
X-Google-Smtp-Source: APiQypKqaC+5seFi5xSOnMvPXzp1mosucGBYkNhJOE7FDZIO70API6amH6QsDOIhAKDN787xUbKEdA==
X-Received: by 2002:aca:2b04:: with SMTP id i4mr1954562oik.137.1588256039885;
        Thu, 30 Apr 2020 07:13:59 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h21sm15797otr.2.2020.04.30.07.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:13:58 -0700 (PDT)
Received: (nullmailer pid 11709 invoked by uid 1000);
        Thu, 30 Apr 2020 14:13:57 -0000
Date:   Thu, 30 Apr 2020 09:13:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 09/10] dt-bindings: marvell,mmp2: Add ids for the power
 domains
Message-ID: <20200430141357.GA11669@bogus>
References: <20200419172742.674717-1-lkundrak@v3.sk>
 <20200419172742.674717-10-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419172742.674717-10-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Apr 2020 19:27:41 +0200, Lubomir Rintel wrote:
> On MMP2 the audio and GPU blocks are on separate power islands. On MMP3
> the camera block's power is also controlled separately.
> 
> Add the numbers that we could use to refer to the power domains for
> respective power islands from the device tree.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  include/dt-bindings/power/marvell,mmp2.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 include/dt-bindings/power/marvell,mmp2.h
> 

Acked-by: Rob Herring <robh@kernel.org>
