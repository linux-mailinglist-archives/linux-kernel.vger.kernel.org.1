Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE4F2C62F6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgK0KXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:23:34 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39283 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgK0KXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:23:32 -0500
Received: by mail-lf1-f67.google.com with SMTP id j205so6325313lfj.6;
        Fri, 27 Nov 2020 02:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mumQ7Odfbg86UBYuc0aTTU7S0G45wmDkPgeyYwAnXzg=;
        b=ZzJFtFckVcSUYKQiNQ6AEhn5MDPS295SQOJuj8eVclgXjE9qS/+iFTovNKHDKe2iaC
         /4pT6sLglFMcKWXJj0zyPmyTdHkBl7sZepHkPdx8rNULrZDg6p2XTLTSOJ1ccTdCCMVa
         AzZnjWBM7GJpREZtcTDvhWSSTh3wW9XrEMu1/aVI5j+6oBSCvW319lXc6ZqmEzSlF5A9
         5UFftJkup2PAuzNcbFli2ph2GsHg3YBZeeLXqKsnXnLA1qWJYto8ZBQ/cvYs0i925VjZ
         gBi9I/10oyBA9YEp9KxMOuR8ByKH87KzJ0ydjZpWHsIG9tIyW7+Flw1YaHjsbyArq7au
         ohNQ==
X-Gm-Message-State: AOAM5304lzGVEMXemnhZ2cQ+R9ONgmifvD4K4NaPxPyrwauS7+4x0YAi
        sSbJ5bRladqm5q0yDVpZuPs=
X-Google-Smtp-Source: ABdhPJxtoKbHxaWqHwQ0DvBt5n8YhAsWq3nmxDqiUw9AfygpwmAHdA8nk2zr2jY/+kqjrPrcUkQAsQ==
X-Received: by 2002:ac2:428d:: with SMTP id m13mr2850555lfh.137.1606472610279;
        Fri, 27 Nov 2020 02:23:30 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id c6sm908462ljj.140.2020.11.27.02.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:23:29 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kiaur-0006Qe-HY; Fri, 27 Nov 2020 11:23:50 +0100
Date:   Fri, 27 Nov 2020 11:23:49 +0100
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
Message-ID: <X8DTtVEzL4X8UJCH@localhost>
References: <20201016022428.9671-1-china_shenglong@163.com>
 <X66l44MqSlj774DL@localhost>
 <520e730958174cb39561a94d03e4727e@siemens.com>
 <X7Kq6fJ/VMnB3Nt0@localhost>
 <496f2cc77b4d4c3a9b49410ac318b927@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496f2cc77b4d4c3a9b49410ac318b927@siemens.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Again, please do not top-post. Quoting Greg:

  A: http://en.wikipedia.org/wiki/Top_post
  Q: Were do I find info about this thing called top-posting?
  A: Because it messes up the order in which people normally read text.
  Q: Why is top-posting such a bad thing?
  A: Top-posting.
  Q: What is the most annoying thing in e-mail?

  A: No.
  Q: Should I include quotations after my reply?

  http://daringfireball.net/2007/07/on_top
]

On Mon, Nov 23, 2020 at 01:11:24AM +0000, Wang, Sheng Long wrote:
> Hi,  Johan
> 
> Do I add my  software flow control  patch directly to the branch you
> gave me now ? 
> https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=cp210x-termios

Yes, please rebase your work on top of that branch. I'll merge it to my
usb-next branch before applying your patch.

> Then, I also need the cp210x_ get_ terminus()  add ixoff / iXon handling?

No, if you rebase your work on top of the above branch, you won't have
to deal with cp210x_get_termios() which has now been removed.

Just add support for software flow control to the new
cp210x_set_flow_control() function (and cp210x_termios_change()).

I think you can even drop get_special_chars() and just leave the rest
set as NUL, which appears to be the default.

Johan
