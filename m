Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF54727170F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgITSfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgITSfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:35:30 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C002AC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 11:35:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id b13so6186597qvl.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 11:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vohvexWJrrEIfV9iXfG/OBILjaeDJG0uPWQzqZ7o1Ck=;
        b=LVp6umhePpisjrOD4SkK+bUMrUxaYnUjSoTRlrNKJUAH4ZUWzcJk7a9TKUjGEDLNrj
         sx/QEujeuO+J8L3Yedx7HAJbRK6kWqVwJMwrrbgFSXtSD2Zf9OM1reWtObevriYVOukY
         O/nYgnlv3bVFcurCcio1P2teYlPjGmork/nYRds2ERVDdFU+xtHVkTmBLMKNRMrfE25e
         pHVpN6qyEaA9L2VhfpXPtCtObTpWGZlimaYgZ3OkiXZyeuq+xIXG9YHk5cENxiYabemS
         KTubjyY52iDTWkxQ3gxj0//UOWFqgUFohp3DtCABaI5ubJizSJY7CPcgRluavjo+sUQO
         LZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vohvexWJrrEIfV9iXfG/OBILjaeDJG0uPWQzqZ7o1Ck=;
        b=ab9+Ac6nCkDW0Trj7u3y5Jxbwfpbvk96tCSlE7uNOEg2fSzladIdcR2yQCJHdJbMd5
         RgQ7iO+nwlVvmET1eOFLIUUuNMiz0bL35ZixoAcYyXwyTMfj8y9Kvn/6mdMz4G1P12EJ
         6RdxK/KhR4wYg4RMP2zi0gMLLpYzXax/ziEh6wa+X+wOb3mDdh5CxOstJLWkIMM7eXsg
         27Z8bJTQ3qj67h5nskc0qoS7fvIOYmeqDfxVuvEWBls1lreJq0sI5tL1NWRcTDJtqTXt
         teCDzNajqZHpp0IiPlOaCIwcQS6QMgOlGvG9FnfuZSNT6VwGSdjxKzc5ELtKEMv7UthK
         35Ww==
X-Gm-Message-State: AOAM531PL0XrjpA9rbQYgVcEePBcdcoCDIeyvnGxsTBH6WSsQiFnSt5n
        PIgVFpikzikzdvDVYhEADj0=
X-Google-Smtp-Source: ABdhPJwjF4G9bZqIWs7yy+KINZjTS9lYpIrx7aLzqFhbxKH7vktvEez+tijUT0tF+ZbjaLuN2+Ye9A==
X-Received: by 2002:a0c:ee6a:: with SMTP id n10mr25649053qvs.45.1600626929813;
        Sun, 20 Sep 2020 11:35:29 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 201sm6974077qkf.103.2020.09.20.11.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:35:29 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 20 Sep 2020 14:35:27 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] Use feature bit names in clearcpuid=
Message-ID: <20200920183527.GA3970023@rani.riverdale.lan>
References: <20200920154228.GB7473@zn.tnic>
 <20200920161628.GA3951950@rani.riverdale.lan>
 <20200920172954.GC7473@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200920172954.GC7473@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 07:29:54PM +0200, Borislav Petkov wrote:
> On Sun, Sep 20, 2020 at 12:16:28PM -0400, Arvind Sankar wrote:
> > Allowing 13:24 as input would be icing on the cake :)
> 
> Well, I'm kinda "meh" on that. Why, you ask?
> 
> Well, whether the user multiplies two integers or the kernel does it for
> her/him, I'd prefer the user.
> 
> But that's not even the problem - whether the product of the word number
> and the bit within that word, or the two supplied as a pair - either is
> the wrong interface. It is ugly and not even close to even beginning to
> be user-friendly.
> 
> However, we can't make it fully user-friendly yet because not all bits
> have names. :-\
> 
> But you know what, that doesn't matter too because that clearcpuid=
> thing is mainly for poking at sh*t and testing, not meant for users.
> Thus the tainting...
> 
> So I guess the one who needs it, can go the minute distance and do the
> multiplication. According to that argument, adding the string parsing is
> not really needed too, but it is simple enough so WTH.
> 
> I've incorporated all your other comments, see below.
> 
> Thx!
> 

Thanks. Maybe also mention in the documentation that names can now be
used.
