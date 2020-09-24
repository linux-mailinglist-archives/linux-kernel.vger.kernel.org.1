Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCAC27774B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgIXQ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgIXQ7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:59:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B49C0613CE;
        Thu, 24 Sep 2020 09:59:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bd2so44317plb.7;
        Thu, 24 Sep 2020 09:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EoPsF8kT+VOZ0TY1NiW28PV/QlfjktpBLxI4qeILRo4=;
        b=Xxj7YqZYUTyfP+NUXTtSCBseX1FoZILvOYExB17luljVEgXT6MQPrxbe2SwZePvnG7
         pjB9h1S3PEtrGDy8r+b8fOnWXogVtc/yZ0g3K8zkDRq9+4nxJhWq5NOp/E3LMxrW0dP/
         AHZn4V2FMZlJUJWGu+qPmtKly8U59JwqOL3AHVLiKB5PBX+6o7qxMuB//P+sliP2JrOk
         Lcv/6x81xSKV+nZg9LX8xr58/NVn9VcPGB6201AkKwb43AZ5QjKyW0WVj2dXutj0Fzvw
         LOuh33hAdh8QMvFioPeiFQeErKlXVUqdJQG1FFqpge0fOUr5X9s1XWXE6QYN6tG5vE7s
         KzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EoPsF8kT+VOZ0TY1NiW28PV/QlfjktpBLxI4qeILRo4=;
        b=nPURLzHaVC6a2InnO4HA7oa8tfkY0QlGI0h8H13WficpNE3PYHDqWBQYcoSglA3CDJ
         r49E938TtppqDzs+ROtsyXSbDk/T8FhDItJx5DUyAdDCLHnl6EuyESeoHtCKPl2pX7Qq
         H/OLaqYYpmOeIuBZikq9VDneAB4xppC5g/cXM89UKptomzyqGziOxgCRo3vwk9f59rYI
         Gz9pqLztyiRg25XDUy622LUym59HlpIQ5il1mjRlykvv4TtSf7eH43beNS1GjdmkCdKT
         upUGpecmoiULGlWb5UQR9PJJQYdw92uzE+pC9lTZx6gJLo7ZIlqS8l/cmKux1mlj4iE0
         qOfg==
X-Gm-Message-State: AOAM533fzs8rpgDh439IJQqlQ2U275Ibt0qHQ9ITZNWT7+K3lhx9Vwty
        bLXGOl+4ogGXtLPUjRG7Nw==
X-Google-Smtp-Source: ABdhPJy0Cetm+6slveWErW0ubf/EmjYXGJAeOS5m+z8+iSgrtaRZr6rzhyYdogiEl3WzOse4BlCKaQ==
X-Received: by 2002:a17:90b:245:: with SMTP id fz5mr100677pjb.131.1600966772308;
        Thu, 24 Sep 2020 09:59:32 -0700 (PDT)
Received: from PWN (n11212042027.netvigator.com. [112.120.42.27])
        by smtp.gmail.com with ESMTPSA id x198sm3569037pgx.28.2020.09.24.09.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 09:59:31 -0700 (PDT)
Date:   Thu, 24 Sep 2020 12:59:19 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data
 buffers
Message-ID: <20200924165919.GA880812@PWN>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <20200924140937.GA749208@kroah.com>
 <394733ab6fae47488d078cb22f22a85b@AcuMS.aculab.com>
 <20200924153035.GA879703@PWN>
 <20200924154516.GL4282@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924154516.GL4282@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 06:45:16PM +0300, Dan Carpenter wrote:
> Smatch has a tool to show where struct members are set.
> 
> `~/smatch/smatch_data/db/smdb.py where console_font height`
> 
> It's not perfect and this output comes from allmodconfig on yesterday's
> linux-next.
> 
> regards,
> dan carpenter

Wow, thank you for the really interesting information!

> drivers/video/console/vgacon.c | vgacon_init                    | (struct console_font)->height | 0-32
> drivers/video/console/vgacon.c | vgacon_adjust_height           | (struct console_font)->height | 1-32
> drivers/video/fbdev/core/fbcon.c | fbcon_startup                  | (struct console_font)->height | 6,8,10-11,14,16,18,22,32
> drivers/video/fbdev/core/fbcon.c | fbcon_init                     | (struct console_font)->height | 6,8,10-11,14,16,18,22,32
> drivers/video/fbdev/core/fbcon.c | fbcon_do_set_font              | (struct console_font)->height | 0-u32max
> drivers/video/fbdev/core/fbcon.c | fbcon_set_def_font             | (struct console_font)->height | 6,8,10-11,14,16,18,22,32
> drivers/usb/misc/sisusbvga/sisusb_con.c | sisusbcon_init                 | (struct console_font)->height | 0-u32max

In looking at this one,
	c->vc_font.height = sisusb->current_font_height;

`sisusb->current_font_height` is only set in sisusbcon_do_font_op():
		sisusb->current_font_height = fh;

and...

> drivers/usb/misc/sisusbvga/sisusb_con.c | sisusbcon_do_font_op           | (struct console_font)->height | 1-32

...sisusbcon_do_font_op() is called in four places, with an `fh` of either
16, `sisusb->font_backup_height`, or `font->height`. The latter two cases
all come from sisusbcon_font_set(), whose dispatcher, con_font_set()
gurantees that `font->height` is less than or equal to 32, as shown by
Smatch here.

> drivers/tty/vt/vt_ioctl.c      | vt_k_ioctl                     | (struct console_font)->height | ignore
> drivers/tty/vt/vt_ioctl.c      | vt_resizex                     | (struct console_font)->height | 0-u32max
> drivers/tty/vt/vt_ioctl.c      | vt_ioctl                       | (struct console_font)->height | ignore
> drivers/tty/vt/vt_ioctl.c      | vt_compat_ioctl                | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | vc_allocate                    | (struct console_font)->height | 0
> drivers/tty/vt/vt.c            | vt_resize                      | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | do_con_write                   | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | con_unthrottle                 | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | con_flush_chars                | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | con_shutdown                   | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | con_cleanup                    | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | con_init                       | (struct console_font)->height | 0
> drivers/tty/vt/vt.c            | con_font_set                   | (struct console_font)->height | 1-32
> drivers/tty/vt/vt.c            | con_font_default               | (struct console_font)->height | 0-u32max
> drivers/tty/vt/selection.c     | paste_selection                | (struct console_font)->height | ignore

I will go through the list starting from these "0-u32max" cases. Thanks
again!

Peilin Ye

