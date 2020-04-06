Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A599619FBFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgDFRqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 13:46:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36373 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgDFRqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:46:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id w145so201193lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 10:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNmBf+GRC0EIGToMk4/t6rTIUh9OjAdpy4aFeKb4Rqc=;
        b=hfU2c40KDKDREWI3c/+ZfwIxoUGC8kXZ7TPtVMQl00LsrJlpHdN1scbOc8M0YueuXz
         vQC0UqJcUs6XJVxo1sj6tZnoGwiW1ExbjzQZ41FY0L479xo0CkFn4/T04xa6mC5BTQ8Q
         g43VaoZI2VXzPbpA7qyuFqiAMi6P/SZuMDO8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNmBf+GRC0EIGToMk4/t6rTIUh9OjAdpy4aFeKb4Rqc=;
        b=SghouxzpPwyrkgMIR9PWzXZ3guKw+lfgbZHA0hDyznkQBav1BIhGhWCtmnggBSJr2Q
         yUVgCz7GJ8v44F9TkSSClYo6LZMqy2CkjtOGPHCE8Rovp6RYXgzsQaOysH5sw5mJ5JSa
         uhFugvMisZnDBSfTTP2Gasxx1xvSfo9QD3LhwL8h/8JgOlYk7nFFjRPAhnh0DGhVacnh
         ZdkdUFI5OE5wOmrMGsyQ8OpdEUjHC9qiMpxcmVnoEgyxyVvDNuCxz/tEtFT5elL5jHse
         PhCLPbMPsv8OV6Ut6AdHXB6C71QAn7zJRV16RXHJxUhCuW4TdZ9rEVPwC/2w3uxqymSh
         HSvg==
X-Gm-Message-State: AGi0PuZqIXWR2ZIjS/z+LskuZj/fzAh9DUNlPTFuZpIQZQxXqSXLWP1A
        fN0bw+A/BWnsNYCNfPvoBpSraVytkio=
X-Google-Smtp-Source: APiQypK5682obYGcJjs2W3GUtFumA4qRi0CpUbV8wHmVnoYMX/Ekwo/3QtGsD3X6gKqh6rrca0QOdw==
X-Received: by 2002:ac2:43b1:: with SMTP id t17mr3125519lfl.9.1586195191468;
        Mon, 06 Apr 2020 10:46:31 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id d27sm12057810lfq.73.2020.04.06.10.46.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 10:46:30 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id h6so220709lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 10:46:30 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr2122522lfl.125.1586195189986;
 Mon, 06 Apr 2020 10:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200406110702.GA13469@nautica> <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
 <20200406164057.GA18312@nautica> <20200406164641.GF21484@bombadil.infradead.org>
 <CAHk-=wiAiGMH=bw5N1nOVWYkE9=Pcx+mxyMwjYfGEt+14hFOVQ@mail.gmail.com> <20200406173957.GI21484@bombadil.infradead.org>
In-Reply-To: <20200406173957.GI21484@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 10:46:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjh0szm+btaHptV1_XMMih=c1zP5wU8MQmREVKmJSYUcA@mail.gmail.com>
Message-ID: <CAHk-=wjh0szm+btaHptV1_XMMih=c1zP5wU8MQmREVKmJSYUcA@mail.gmail.com>
Subject: Re: [GIT PULL] 9p update for 5.7
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Sergey Alirzaev <l29ah@cock.li>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 10:40 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > But look at anybody who ever worked more with NFS mounts, and they got
> > used to having the 'intr' mount flag set and incomplete reads and
> > -EAGAIN as a result.
>
> That's why you had me implement TASK_KILLABLE ;-)

Oh, absolutely. We can *NOT* do this in general. Applications _will_
break if you end up just randomly breaking POSIX behavior.

But network filesystems are almost never fully POSIX anyway. And yes,
they do break some apps.  'intr' may not be a thing any more, but
other differences wrt various atomicity guarantees (or file locking)
etc still exist.

So the whole "network filesystems do odd things in corner cases" isn't
exactly unusual.

I think the O_NONBLOCK difference is one of the more benign ones.

I just think it should be documented more.

             Linus
