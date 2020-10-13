Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233DA28CA57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403900AbgJMIgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403873AbgJMIgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:36:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB247C0613D0;
        Tue, 13 Oct 2020 01:36:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y12so17565595wrp.6;
        Tue, 13 Oct 2020 01:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NFgHTJDGAaoUGtS6KDLywzGQDD1dRCFwIz5+vO6WQ2U=;
        b=mIZ8SF7dnY0vtR9MBXo5RBEZ6QyI7QE3y51/hFdH5ii9efEibnofweDN2HOiN8DALt
         IVy3B3tRc/+5sfx2iCybcKzoh4oIUYljR+IQnFoffGSLFnXizOsp/mHVcylQRox+HNeE
         L4vYZT7t/8eQ8tqd+77nXFHbbQlO4KEKhB92igdash0iQgfTe1pxYs6kk0Kih3GSJ8Zb
         B68zEzPESYJB8UylI/wkZH5RVwONPAlrFTPPak3JDOoO0dQLU60ysGXqP6D+NwQJ5TKz
         xyASO8UDdGC0POgBgZ1BIQ/btPTwYOffVVNr/Yg52pcDt0GMUKEYcqFuOpxGQN4Ya/Me
         EIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NFgHTJDGAaoUGtS6KDLywzGQDD1dRCFwIz5+vO6WQ2U=;
        b=a/a5zhUuLOQD9HugunbejqDI6vzw1RWuBQlFoPwKxTes1ty7Oy9Y1CaQf8vhywApzI
         R7y3pMz0MI0tZiFQ9FaMVlVqkQN5bbZ2hn2q1iKCnDV6u+Oph5QjHH4boWRvDxPiNXFb
         Sxe8RM2bp+UuqTzEzESJqe6xf3qiKWus4p2id8S1xZjdyPikKj5qWo/wHQjV5FyWO8mY
         JKK1u+7n+6mf1Rl6tjLhujPsz9YMSlcsNqEvZpIXPpfXFMpdYT6l2UtHhW2gJ9l+SugK
         niIxq68S8QcpRH9ZoBvC4IVD4CHdYBK24CeaG7svo0tO24YKL2yeGcD/hBi/Z471/iOM
         dREA==
X-Gm-Message-State: AOAM532feJjZi9TWlP/iP4fdBsr6RN0WSdsSD2W7V0zSXpv8EFGt52e1
        Q6Rf/CeotJfKrpilCsW7qHU=
X-Google-Smtp-Source: ABdhPJz52riMe2yauYB3XFkSeB7dj/Z8UH/Anz69G2LNz94UvnS48HHMWfnM4Xu76SDmf5KgNcxvCw==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr25030984wrw.310.1602578207638;
        Tue, 13 Oct 2020 01:36:47 -0700 (PDT)
Received: from felia ([2001:16b8:2d05:8100:95ae:bd1a:3e4e:4242])
        by smtp.gmail.com with ESMTPSA id u63sm26631531wmb.13.2020.10.13.01.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 01:36:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 13 Oct 2020 10:36:45 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech, linux-usb@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
In-Reply-To: <CADVatmNcUzT6Df4+V7VdwO0AzZ=74Sai7X0aFpYU5SO7b2NVSg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2010131026590.14590@felia>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com> <alpine.DEB.2.21.2010121550300.6487@felia> <20201012145710.GA631710@rowland.harvard.edu> <alpine.DEB.2.21.2010121659040.6487@felia> <20201012151816.GA1559916@kroah.com> <alpine.DEB.2.21.2010122022250.17866@felia>
 <20201013052317.GB330398@kroah.com> <alpine.DEB.2.21.2010130725370.14590@felia> <CADVatmNcUzT6Df4+V7VdwO0AzZ=74Sai7X0aFpYU5SO7b2NVSg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Oct 2020, Sudip Mukherjee wrote:

> Hi Lukas,
> 
> On Tue, Oct 13, 2020 at 6:37 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> >
> >
> > On Tue, 13 Oct 2020, Greg Kroah-Hartman wrote:
> >
> > > On Mon, Oct 12, 2020 at 08:25:30PM +0200, Lukas Bulwahn wrote:
> > > >
> > > >
> > > > On Mon, 12 Oct 2020, Greg Kroah-Hartman wrote:
> > > >
> > > > > On Mon, Oct 12, 2020 at 05:10:21PM +0200, Lukas Bulwahn wrote:
> > > > > > And for the static analysis finding, we need to find a way to ignore this
> > > > > > finding without simply ignoring all findings or new findings that just
> > > > > > look very similar to the original finding, but which are valid.
> > > > >
> <snip>
> > >
> > > Why not fix the things that it finds that are actually issues?  If there
> > > are no actual issues found, then perhaps you should use a better tool?  :)
> > >
> >
> > Completely agree. That is why I was against adding comments here and
> > elsewhere just to have the "good feeling of doing something" after the
> > tool reported a warning and we spend some time understanding the code to
> > conclude that we now understand the code better than the tool.
> 
> I think you are missing the point here. I sent the comment not because
> of any tool, I sent it because the code there was not that simple like
> other drivers and at a first glance its not apparent why there are no
> error checks. And, afaik, the only purpose of comments is to make the
> source code easier to understand.
>

That is fine. I think it is good to add comments to make the code more 
understandable.

Lukas
