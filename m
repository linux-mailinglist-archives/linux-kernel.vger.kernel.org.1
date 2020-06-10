Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B681E1F5877
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 17:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgFJP6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgFJP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:58:39 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867F6C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:58:39 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id k15so2080947otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0SN+q6mCsu4s+N1LLrzuE4p100GHqHC1FGVfTGwaqXU=;
        b=GR/SWSFRZtaURduwcW76F5Ced+0XjjVPJl7VYugof1hdZ3GifLGv4TEu8UfrA1UiYM
         clzHzyu7ZC48I6JLbtZU6Ogw2KzNTphllnI3q4M4E8ea0tiLbVRQIvUsHXcDcPBS3zub
         M3fkBYEbhvhvNeuVN2vQBTMATWzBuxTy3TfzmRDWN7skhyKMCsFtJtSrFZLE+kjkdMs0
         1bidJKfHzKD2jEmm65n98elEvz+KWRE9ZBVxeqXzFtVbNWmsicyfAQveO/Rc790guHSL
         CsVmN0h3w4TTRgGeF7NcjZ0mmpL9+UUR4I3H3w4oOMYnwG7ZEns8JbOGmoUKETe1MpvY
         nJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0SN+q6mCsu4s+N1LLrzuE4p100GHqHC1FGVfTGwaqXU=;
        b=e9SD6pRu8Aw8KyQs2kY0SfrTPqc+I+O7rausJVN8wWxUJBE6N597IFvQ/nwwtfYdMZ
         n+Y/Sk4927TFlMRpPtKLyfDS2TwR+BL8XRdm0lS2p7hHDWKynHs5+BqTGcgl6/uxDzTC
         wt/77cR7vh3AWSRjMhY9rSTFi85A9+jrlWKE3AaHQq9yV1cV/6v8a7ZcR7TiLBbmqXcM
         S+NvbZ7fbqBBDXrebcAZGoHqfSTkg+hAyjepEO621IVYhxi2VrLzh0ucSRT9VRE/BQOT
         Dc+a2cvmU5ptkVQXjBBYFVSBC4Samt2uoKa1DAJ3CbLWMEsn3n6rehIJyfbsi91GDHDQ
         OoFQ==
X-Gm-Message-State: AOAM532bh1eMtaddg78BsQDKwVWiH3Q3s/0+iL/+W1eT/Ct/mjfOroZ8
        ykFBXjw5uktDzpeiP7ZPmS0=
X-Google-Smtp-Source: ABdhPJziMwWfIGwj8ox5Zhg8kLleKrhfSCHTAXEByakroOwaXdHNmz2Hge9IXzMrImDg3u3zlBIrZg==
X-Received: by 2002:a05:6830:2151:: with SMTP id r17mr2874415otd.254.1591804718359;
        Wed, 10 Jun 2020 08:58:38 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id 126sm30622oii.39.2020.06.10.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:58:37 -0700 (PDT)
Date:   Wed, 10 Jun 2020 08:58:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] .clang-format: update column limit
Message-ID: <20200610155836.GA2360592@ubuntu-n2-xlarge-x86>
References: <20200610125147.2782142-1-christian.brauner@ubuntu.com>
 <CANiq72m_p2BRXswCGhUZi-Nta2y0uNXDQLRjPUFydB7YGV-6HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72m_p2BRXswCGhUZi-Nta2y0uNXDQLRjPUFydB7YGV-6HQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 05:55:14PM +0200, Miguel Ojeda wrote:
> Hi Christian,
> 
> On Wed, Jun 10, 2020 at 2:51 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > The provided clang-format file wraps at 80 chars. If no one minds, I'd like
> > to adjust this limit to 100 similar to what checkpatch (cf. [1]) uses now.
> 
> Thanks! Picking this up with a few changes to the commit message.
> 
> Cheers,
> Miguel
> 

If it isn't too late:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
