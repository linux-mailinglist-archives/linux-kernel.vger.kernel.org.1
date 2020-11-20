Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3A32BA69F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgKTJyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:54:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44986 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgKTJyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:54:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id s9so9380337ljo.11;
        Fri, 20 Nov 2020 01:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C59c0mgsV+SRL0gTcx0qWRGq+USR/SFMGynSGvNxYmA=;
        b=BWu/vPP+q4YBjSK/Hf7r/Tf3VHnDLnzcIOm+FNe5SLZk/CajbFADRMob7zOILJK0xH
         3lNdcujBT0D+lHCPrbrLp0aWkYyhso8iYNDOoo4WaTX+Rcsg/3fSR+0huAiJ8PgUpB4I
         hHT+ugouVSea+mqDJk4u0l35Vekl901a40Cfx9plJ+2zCaf2c1l8A2/AeeYHIjZERtju
         IIQJvBCSdirpNBnEgNJveoosDj2MLr7LmBZNzByBzEoKjmpCx7QfQvrFrhLN8xIZG9RR
         K8/2Kh+A9Ow5/YnUkNbVgQH8dlRFoLe4uOPQC67AIPUw0k6ViXMc1rL+43ykRba+613t
         6tQg==
X-Gm-Message-State: AOAM531J7NsaRTaWZVWcE9SpQDskqGAwJbgl24gHwHLM0mu7KURNocrM
        /a/jhAJz2irBNv0YNUYRtW6EFeZObOyDrA==
X-Google-Smtp-Source: ABdhPJxSgBzw5ROqXBewpxM2xbqBDivuTciM6YpFoI3bCUF3jvXcsfIxRNmiWpBeKrc/sbdnmZmM2g==
X-Received: by 2002:a2e:93cf:: with SMTP id p15mr8423247ljh.141.1605866085852;
        Fri, 20 Nov 2020 01:54:45 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x8sm285070lff.196.2020.11.20.01.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 01:54:45 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kg37w-0007Qy-JW; Fri, 20 Nov 2020 10:54:49 +0100
Date:   Fri, 20 Nov 2020 10:54:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     vpalatin@chromium.org
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: serial: option: add Fibocom NL668 variants
Message-ID: <X7eSaCD3pqvdD4jj@localhost>
References: <20201120090107.502832-1-vpalatin@chromium.org>
 <20201120092828.665931-1-vpalatin@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120092828.665931-1-vpalatin@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:28:28AM +0100, vpalatin@chromium.org wrote:
> From: Vincent Palatin <vpalatin@chromium.org>
> 
> Update the USB serial option driver support for the Fibocom NL668 Cat.4
> LTE modules as there are actually several different variants.
> Got clarifications from Fibocom, there are distinct products:
> - VID:PID 1508:1001, NL668 for IOT (no MBIM interface)
> - VID:PID 2cb7:01a0, NL668-AM and NL652-EU are laptop M.2 cards (with
>   MBIM interfaces for Windows/Linux/Chrome OS), respectively for Americas
>   and Europe.
> 
> usb-devices output for the laptop M.2 cards:
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  4 Spd=480 MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=01a0 Rev=03.18
> S:  Manufacturer=Fibocom Wireless Inc.
> S:  Product=Fibocom NL652-EU Modem
> S:  SerialNumber=0123456789ABCDEF
> C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> 
> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>

Applied, thanks!

Johan
