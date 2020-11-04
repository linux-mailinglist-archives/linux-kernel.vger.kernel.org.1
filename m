Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539552A611D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgKDKEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:04:40 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43802 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgKDKEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:04:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id l28so26311966lfp.10;
        Wed, 04 Nov 2020 02:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Us56OjDJl3ikuiXcYymCKFvIXiGMjNRM3PaU39vhbgA=;
        b=XW1qqwqpOdMxd88OEUlcqUVfwqbt9FXe4QTPZ7CqTt1nv03AdOIqp4Y5366IJYGdI1
         U8rRils1rkEsxWVc1ye148J/cagBxMQYQICf1BkHwWyvdWZEVdT7mBNuII10zhFWqspE
         kovQyeSX8PvGMWQ+p5c+Ynwzjp19w6amqpYfpfzWcsjakDVaGQTMgDJvQcVPxnmXOmx3
         OtS4QY9IeMuTBLlTh5o2EsVoANpO30uBZmoPOiCQ+uvt62ycBSmr4OzZf3R3eSrQWQIe
         7My/JLV3DKPvo3qDjDLVFHA0OV69iFuTzCYYtqgXmNSpoloXTK5C2qW79du9K5kMBvVk
         bcEw==
X-Gm-Message-State: AOAM531SeUoZdwHzLU7byesR9XoevApUedaRqCGn6OF0B8Ca6mYhhb2/
        Z846H19ULrwRd5CvNsN2LSk=
X-Google-Smtp-Source: ABdhPJxAsUTgPYgntivfO9/Ue+OyiDmkMTximqsvwoFogZAD/kQia7gQbzc66OSA7GihlYKbm+qC0g==
X-Received: by 2002:a19:6453:: with SMTP id b19mr9989882lfj.527.1604484277512;
        Wed, 04 Nov 2020 02:04:37 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id 65sm363988lfl.68.2020.11.04.02.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 02:04:36 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kaFei-0003UG-IM; Wed, 04 Nov 2020 11:04:40 +0100
Date:   Wed, 4 Nov 2020 11:04:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] USB: serial: keyspan_pda: fix up write
 implementation
Message-ID: <20201104100440.GQ4085@localhost>
References: <20201025174600.27896-1-johan@kernel.org>
 <20201028093848.GD1953863@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028093848.GD1953863@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:38:48AM +0100, Greg Kroah-Hartman wrote:
> On Sun, Oct 25, 2020 at 06:45:46PM +0100, Johan Hovold wrote:
> > This series fixes a number of long-standing issues with the keyspan_pda
> > driver and reworks its write implementation so that it can be used with
> > any line discipline or for a system console.
> > 
> > The last few patches cleans up the xircom device support and some style
> > issues.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for reviewing. Now applied for -next.

Johan
