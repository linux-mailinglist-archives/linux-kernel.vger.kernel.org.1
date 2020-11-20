Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B032BA652
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKTJhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:37:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45768 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgKTJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:37:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id z21so12485270lfe.12;
        Fri, 20 Nov 2020 01:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nJSicL6e7BRcv6Ha4mdE6qST64QMHD5+uyjuop7yg9E=;
        b=D8AKTSJIF4Hp6Te1yQxa7bMDsmNhLWTZF2Zs0Ddwc1QNZEvoSRG3eC3pRM3Pn+Ukkc
         OJ1mAg5rwTce3giYTdM5KSyiheJsU9yHhsqdhkK0qbnXk39KTFwLYo6YPakSbHWAXwQN
         NR8zviOLgPHcP1vd0aVrCYKMacEKjK3b57ZLWs7uEsjqdVubRoxLS1VUR7FFplOTUpeB
         VndG0ooMIcTnUYShH9AQnDZyUwYPT0s57nb5Tdc5zQ+LcPENR+w4AKzXmesLebUPvQ4Y
         2VKDuPVArizIQVGQS47+iz/GcaoKjaVWA33Uhn0KKNdW5KKYOdXWJTbmP3QtLWLY3vXR
         fibw==
X-Gm-Message-State: AOAM533N9AJLWVoL+5SlrpekjEVvStsTXzOIyaaZjYkTMI1b7C5V7lt2
        lBd20X1QqrsZz7KI320XLcUVDJoDZV3rvg==
X-Google-Smtp-Source: ABdhPJyk7efy95w7iVpRaJ9O+XxOirZvxBgAaRljC77i4lpba5BSvyYPD1XN3ha0qFaMo7FOc9RXag==
X-Received: by 2002:a19:7e94:: with SMTP id z142mr7083911lfc.268.1605865064798;
        Fri, 20 Nov 2020 01:37:44 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id c17sm281450lfr.135.2020.11.20.01.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 01:37:44 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kg2rT-00053N-HR; Fri, 20 Nov 2020 10:37:48 +0100
Date:   Fri, 20 Nov 2020 10:37:47 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     johan@kernel.org, dbueso@suse.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: mos7720: defer state restore to a
 workqueue
Message-ID: <X7eOax2XYDMbySAa@localhost>
References: <X7TzUr+nl+P4SL6c@localhost>
 <20201120045300.28804-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120045300.28804-1-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 08:53:00PM -0800, Davidlohr Bueso wrote:
> The parallel port restore operation currently defers writes
> to a tasklet, if it sees a locked disconnect mutex. The
> driver goes to a lot of trouble to ensure writes happen
> in a non-blocking context, but things can be greatly
> simplified if it's done in regular process context and
> this is not a system performance critical path. As such,
> instead of doing the state restore writes in irq context,
> use a workqueue and just do regular synchronous writes.
> 
> In addition to the cleanup, this also imposes less on the
> overall system as tasklets have been deprecated because
> of it's softirq implications, potentially blocking a higher
> priority task from running.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Now applied, thanks!

Johan
