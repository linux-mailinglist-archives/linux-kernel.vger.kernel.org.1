Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC694290A82
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390349AbgJPRVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733160AbgJPRVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:21:02 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58257C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:21:01 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p16so3504175ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rgrwJpY6ESad1/QTTAmokj2VzhBLPWhnxJ7XmieuY+o=;
        b=hIZgfs6QCDvAVRYXFo+62WbiYxs0TfapOlUBEcOcFpktZGdQeRtJhuaxQW2fN/Uh/w
         nt/MqVidofka7fhVh24i3S61MKcjcIE3BL9XqNOCtwNO01QyxJ+0iq+Klsl6yjesidT6
         +8fgkT2G7MB8QE6DXDXMQBCwdEXrZ8yq3Z3VGzzecE2GWOsCq9pAVzDgFz1DQStjpkD6
         QOOjsh3HJQ3u7p7H5hicYys7rV+Wyiz1voVrSQaxqtkD2ryTZ2F+Xi0zi0I4zkb4vB9i
         iD8i71MGsWXv4CyQidYF1zy/ELl1rGTDC6t5WFlCN2te7iMhqDPcnS/uGofDWP/IYouZ
         TxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rgrwJpY6ESad1/QTTAmokj2VzhBLPWhnxJ7XmieuY+o=;
        b=hdjupNdvP5+Dj5oiMMWFi57+blNX3F9mR04BptJ7yrtTjE/c3O9RA3l9EZeQdF3NLR
         osXukl1dQGGSdgVPe0CGYsNqyr0BgSt+Bo2zjFxlOJoFZ423t8ak95QptEBzdzrScDH1
         H5mI28r8jnP6Q+AOpX4KRwaLH+CjD7XRu5fO8BCoLIJpw4JKEZ+1f+635XPro0CC0F6C
         CWWhikyXgtJDWvrFe1TBBYOf5fev8tMViRjrKkfREyDmmieDEeDNK0F7VrtUPZH9/caw
         WsAdHYq2wbJUC56hsu1JTZw8onyspemrsW8VAd6zk/vO7+P6z9qXpXubzb4tHFDMpP69
         8SBw==
X-Gm-Message-State: AOAM533IhhvYRjX1ldunDdmf20NSfvSy5bPwF/Ln6sFAjyHo1nQy3sGW
        20uW4vXRZkqmHOQKIwX1mtA=
X-Google-Smtp-Source: ABdhPJxMoAnxSBQtrGdR5wUXdWTjKN/aoIkcpxKoESTpfB2iwnEfKNj88JnyJC+79Bu5z4+aTDWzgg==
X-Received: by 2002:a05:6e02:f85:: with SMTP id v5mr3640870ilo.47.1602868860500;
        Fri, 16 Oct 2020 10:21:00 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e17sm2526319ile.60.2020.10.16.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 10:21:00 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 16 Oct 2020 13:20:58 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] x86/boot/64: Explicitly map boot_params and
 command line
Message-ID: <20201016172058.GA1246432@rani.riverdale.lan>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-5-nivedita@alum.mit.edu>
 <20201016162759.GG8483@zn.tnic>
 <20201016164755.GA1185111@rani.riverdale.lan>
 <20201016170726.GH8483@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016170726.GH8483@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 07:07:42PM +0200, Borislav Petkov wrote:
> On Fri, Oct 16, 2020 at 12:47:55PM -0400, Arvind Sankar wrote:
> > Just for clarity, by cleanups you mean patches 2 and 3? i.e. you want to
> > see 1, 4, 2, 3?
> 
> It is important for:
> 
> [PATCH v2 4/5] x86/boot/64: Explicitly map boot_params and command line
> 
> to come first so that it goes in now.

This patch depends on 1 to initialize boot_params before
initialize_identity_maps() is called. You want me to rework it to avoid
that?

> 
> The rest:
> 
> [PATCH v2 1/5] x86/boot: Initialize boot_params in startup code
> [PATCH v2 2/5] x86/boot: Split out command-line related declarations
> [PATCH v2 3/5] x86/boot/64: Show original faulting address in case of error
> 
> can come in any order and when ready.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
