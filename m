Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63A6283191
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJEIMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:12:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37985 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgJEIMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:12:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id w3so6550497ljo.5;
        Mon, 05 Oct 2020 01:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mkxWr9E/CroBQmAhb8VdlWm/fB0P2a9C/PsFZ/1djLA=;
        b=IFhYIn/YAMmh0WsBft+8uWeGDxlxekOU9E4oQoPI5N4bnzNWPl99+FNBWLx4YYdMzt
         aNXM2BX8u6PoqeI4S24f6ETMAmVV5qTMDOT2PfWkKlNdWxxH5diafRWs0NT4kFwVym2k
         MS3kZOrRifd3hPgGGEeSkgXqV3T5LNhx+YYZ2R35lwa3s1IDEXzLcZPs6ValJfsz4qe/
         sfXvS6ykfTjw3lZpPSuz5ws6ylFnYQzTG7CPMnSHT/a9lgQOGL5FVrTXq74WZd37pV4I
         QGn/m45pbtQ2Ydtf80umAAaEe8NjPo8xe1nSfslYMeHOXRgVPZSI5vkx7djgFF/uWTqD
         ECyw==
X-Gm-Message-State: AOAM532wZzzNfysi00xvsx1vJ6rl/nx49iYxbL+gcA2+u53WmepjNW3n
        LoK/TnJwoonbkQZ/my0LrdqkuXJLxt8=
X-Google-Smtp-Source: ABdhPJxHHsUhAAVWeqUziQwahT31dly1Vzl988KVvpUeJRzg6GjYi+CcPvw8rEho4mVsZFD/eMi/pA==
X-Received: by 2002:a2e:a177:: with SMTP id u23mr3948602ljl.104.1601885563332;
        Mon, 05 Oct 2020 01:12:43 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v6sm2594987lfa.295.2020.10.05.01.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:12:42 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kPLbq-0000Jk-5k; Mon, 05 Oct 2020 10:12:38 +0200
Date:   Mon, 5 Oct 2020 10:12:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Leonid Bloch <lb.workbox@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Lars Melin <larsm17@gmail.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Leonid Bloch <leonidb@asocscloud.com>
Subject: Re: [PATCH v2] USB: serial: option: Add Telit FT980-KS composition
Message-ID: <20201005081238.GJ5141@localhost>
References: <20201004155813.2342-1-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004155813.2342-1-lb.workbox@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 06:58:13PM +0300, Leonid Bloch wrote:
> This commit adds the following Telit FT980-KS composition:
> 
> 0x1054: rndis, diag, adb, nmea, modem, modem, aux
> 
> AT commands can be sent to /dev/ttyUSB2.
> 
> Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
> ---
> 
> The full composition is not tested, and it is the default one according
> to Telit support. What is tested, is that this commit makes
> /dev/ttyUSB{0..4} appear upon connecting the FT980-KS, and allows
> sending AT commands to /dev/ttyUSB2.
> 
> Changes since v1:
> 
> * Interface #3 (ADB) is blacklisted.
> * NCTRL flag is set to the diag interface.
> 
> These changes (relative to v1) also allow ModemManager to recognize the
> device.

Now applied.

And thanks for reviewing, Lars.

Johan
