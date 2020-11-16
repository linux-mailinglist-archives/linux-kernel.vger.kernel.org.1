Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC392B4B68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbgKPQiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:38:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35978 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbgKPQiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:38:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id i17so19762658ljd.3;
        Mon, 16 Nov 2020 08:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h2Bfj7+xj4igoEgjq6r/E0rjrswFf3bHb9as6/4tQAk=;
        b=c6mMpguqQQxo7Jh2Uju5rgqTjHan/vF/S1FcMhX5IpiakrvD2fYnc9bPB4ayCNlCsd
         j5GFoMg6Wn0d2JY422hinFUZN7lWELPVKt1g9yKEdjrg/j4Zik76oalNJufbQ7gvsKDF
         JLsQ2DryGWGTHdRXbkTcZ/iE9kDGucYuP3kIg988sBycSKbwe4Tc8Zpnpfnap2+LJaYM
         8QRMVOtytIKhE2YIbq+ZUvPiQaZsH7MVygeNJGrPrTNKSs9wZzUlu7RBf6tvhJvpK0wL
         OftmnbQZWT96G2+dM7cMcA9RZ0AcEuVYizGOtW1DvY6euzIOY64Typ/rMM2sGjsnEpdW
         Lv6A==
X-Gm-Message-State: AOAM530fKO4VLE8pPi+Er6FnuJYCqfDDCcbHpEQA2gCPZzq7c3F2S8NX
        NVEUUuOqDuGpucisksDdtCU=
X-Google-Smtp-Source: ABdhPJx0pbM6pYVy1fS4wwWK5NpjMG9W8q6n0ygGYsXLASkRwW86DG04y7wHPxHEgvrpTN8xH8bB3w==
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr71982ljn.365.1605544679073;
        Mon, 16 Nov 2020 08:37:59 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f7sm2774395lja.87.2020.11.16.08.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:37:58 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kehVx-0007vT-Dw; Mon, 16 Nov 2020 17:38:01 +0100
Date:   Mon, 16 Nov 2020 17:38:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Wang, Sheng Long" <shenglong.wang.ext@siemens.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Sheng Long Wang <china_shenglong@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>
Subject: Re: [PATCH v6] usb-serial:cp210x: add support to software flow
 control
Message-ID: <X7Kq6fJ/VMnB3Nt0@localhost>
References: <20201016022428.9671-1-china_shenglong@163.com>
 <X66l44MqSlj774DL@localhost>
 <520e730958174cb39561a94d03e4727e@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <520e730958174cb39561a94d03e4727e@siemens.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please avoid top posting. ]

On Mon, Nov 16, 2020 at 07:56:10AM +0000, Wang, Sheng Long wrote:
> Hi, Johan
> 
> Thank you very much for your reply!
> 
> You mean if we call cp210x_open()  When opening the device, because
> IXON  is set by default, the cp210x_get_termios() does not process
> IXON, So it is invalid IXON at this time.

Right, with the current implementation you need to make sure that
termios reflects the device state on open or your changes will never
actually enable software flow control in the device.

> As you said, It is very strange in cp210x_get_termios()  In the "get"
> function to "set"  IXON.  In addition, the best way is to disable the
> IXON bit as you said.  If the user needs IXON, call set_ termios
> function, So I'm now in cp210x_get_termios()  Is it a temporary
> solution for terminos to handle IXON ?  I'm afraid it will need to be
> adjusted.

No, I didn't mean that IXON should be disabled by default. I meant that
the driver should make sure that the device settings matches termios on
open, not the other way round.

This unusual implementation has caused a number of issues in the past
and it's been on my list fix up for some time. I finally got around to
that today and I just CCed you on the result. That should simplify
adding software flow control and allow more code to be shared with the
hardware flow-control handling.

I've pushed a branch for you here:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=cp210x-termios

Johan
