Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC3827070F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIRU3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgIRU3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:29:12 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA03C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:29:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v54so6230377qtj.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zA0vgj4MEhN7seo0nt8TRqqpQ53wlISAhciKlAtPvC4=;
        b=HOwkJz9c3WOAfVav8KySepB69cP4Tpb1FVnfRTQdmWHQn0jpmEpAIasccrNxf0WM+s
         CvbNcuoS1TVSlJ1b7OecnaiI4QYtqHc+db2lbrnWdafYCT+PpmbuKXgEWGi738avmBu0
         4j1O4cC5pfUD85v9O/dB48vWBZrovSrMJv+igfK6EtCT51ck0XysxKFQrm8LMUr7c6R8
         GTFKupqVbDNxWq32L3OypEM3XYw8tsTZ0OgQqmF9tbZcsoGPMIzT8JaxozzK97gzvSSB
         oaaas32cILbzEjCuvrWgl7tYsaN/+iSbD4KOvcPA1dvc4fz03hx4XH+HGCh358ZvqARi
         vT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zA0vgj4MEhN7seo0nt8TRqqpQ53wlISAhciKlAtPvC4=;
        b=XBerzidYc/2cibHvZcRdDt0aZQEJFtqxDOsiwH6CRqKiLnvBGwbwYJz6IZ180RxlGz
         YRv0kDQ5Oq3NQgeHC7E/osNQHTToyXfZknJy/aLn63B+FA7GXXJ/XiQAfP/E5SOdK4AC
         GWmQXe25JHyBNgS+TV+T/47lttRAtH1CLNxLGYP5ibS0I+/n45g5dy/l5AtCl9c6lZwx
         cBMte/wPQdUMgoOhWThxrxXEG4bEyjBNkTzz8JBBAGTR2jqfhiNefFkIFZYylMkLf0tZ
         Kkr17IQ8aUZhNE1bi2KIwqlyyiEsktwULlKok/TeM4Ixd9HTcYWWiCJCAW5uC+jeWh0F
         cQ6A==
X-Gm-Message-State: AOAM533B0rgS6tv8jCW5JNkHOlsb/o7Lc5HFAjFNrWh+K1T2BOLNQZaZ
        xOQmTgOq1zoaLwNT40NdXd4=
X-Google-Smtp-Source: ABdhPJzZJWrmdNiq23vSSEx1WKyiuXDANDMHJ1nEKgrpWX1VlxFg85RjNPR8ybTu5YzE5+qXGzBBLw==
X-Received: by 2002:ac8:6ec2:: with SMTP id f2mr35754855qtv.159.1600460951789;
        Fri, 18 Sep 2020 13:29:11 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v2sm2805612qkv.26.2020.09.18.13.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 13:29:11 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 18 Sep 2020 16:29:09 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
Message-ID: <20200918202909.GA2946008@rani.riverdale.lan>
References: <20200917204514.GA2880159@google.com>
 <CAHk-=whXpv0KJvpL153dhUaRgSjzT8H4dD85hRw-fAwXvXnKAA@mail.gmail.com>
 <20200918162305.GB25599@embeddedor>
 <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
 <20200918193426.GA15213@embeddedor>
 <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
 <20200918200252.GH32101@casper.infradead.org>
 <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 01:14:54PM -0700, Linus Torvalds wrote:
> On Fri, Sep 18, 2020 at 1:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > I suppose it's not really necessary, we could do offsetof here, right?
> 
> Yup, that would make a lot more sense.
> 
> But right now, the sizeof() obviously silently works.

In general (i.e. outside the implementation of the macro itself), what
is the preferred way of getting the size of just the header?
  1) offsetof(typeof(s),flex)
  2) struct_size(s, flex, 0)
  3) sizeof(s)
  4) new macro that's easier to read than 1 or 2, but makes it clear
     what you're doing?
