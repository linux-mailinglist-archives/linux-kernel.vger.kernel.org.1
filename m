Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2B928C9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390717AbgJMICy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390591AbgJMICr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:02:47 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E78C0613D0;
        Tue, 13 Oct 2020 01:02:47 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t25so26879474ejd.13;
        Tue, 13 Oct 2020 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Nlo+ICeKz+qCTf+x4IerNhRGMWRTbpLUIF6/RSAckKo=;
        b=fFXcbyA5ROqDDWnjwA2mdrpNGdVVXDmgbZtslUt9b1Er8Lgmb6GdDKv4m2RuLU9U8d
         MKUl8XffdlKiyGBaxVMMHBRQFZaLzi0t2XYcjrvencmZAXJ4RkZflp4wOXt/2A65KT2v
         sIlQH9TPwnkXo8u/UBJHiSAp0Y/UQAppjf+CaglLysf9PnM3dcVYRtpMI28BJ5d4EAoB
         72YZG+jVqgMvuF2gbtsk2TpgPR1A9u9vxbVpSaqznar9xMVMxufDPx6wmWvw9twn1PCH
         SL66tYIoLxWgFr9OxtoRvfR/L8fwPl2AC8eyGijNNq+f/CZ06qYbFZHzkkx7WAUI/nNK
         O2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Nlo+ICeKz+qCTf+x4IerNhRGMWRTbpLUIF6/RSAckKo=;
        b=cSXRHpbjblPt9IDVDdOH1hIezpaG42bhsXofG0kwesplgVvH+oS6Ag1WGRPY1uiXvX
         Dyze/ShUQFMMliFtGrj3Fh/ko7923snE0nHRAg3eqVsc3ewOzl8wEggy3LRQYvmjLrRQ
         jz8o1pDqWwJcLrVtIrct5rj/AHqH3x7oOOEGaMdPhh4H7yxw2BG5XhDvvC+z7hfXPsD8
         IbVHD8AUylxqtZ4IPM4VJzWQS4eju6ADn/TJLOebJpn7zelE6uhrzp1H3ail18prtBFd
         6PHmDVyX03XtmOew5gaGT50RXWMqhlYJ/xHQ8Gh4q4lAKFyEq5PeMB4giNj4oz+O4kUL
         QDpQ==
X-Gm-Message-State: AOAM5311OJUgUE+QZfUY9lF73MHkvr2oYccMIgKB2Bndj5ZrcP+KZchr
        vfEDej5+108L5imIfvgS7X8=
X-Google-Smtp-Source: ABdhPJyLFkBZSBBn/rB2G6MUdeWoKMj+AJ4gkZlhm7FuDYga4WD8VPHx68gUCzdFaDVqLWTGbDRsCA==
X-Received: by 2002:a17:906:453:: with SMTP id e19mr33287437eja.391.1602576166191;
        Tue, 13 Oct 2020 01:02:46 -0700 (PDT)
Received: from felia ([2001:16b8:2d05:8100:95ae:bd1a:3e4e:4242])
        by smtp.gmail.com with ESMTPSA id r11sm11970080edi.91.2020.10.13.01.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 01:02:45 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 13 Oct 2020 10:02:43 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
In-Reply-To: <20201013073524.GA1674118@kroah.com>
Message-ID: <alpine.DEB.2.21.2010130957110.14590@felia>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com> <alpine.DEB.2.21.2010121550300.6487@felia> <20201012145710.GA631710@rowland.harvard.edu> <alpine.DEB.2.21.2010121659040.6487@felia> <20201012151816.GA1559916@kroah.com> <alpine.DEB.2.21.2010122022250.17866@felia>
 <20201013052317.GB330398@kroah.com> <alpine.DEB.2.21.2010130725370.14590@felia> <20201013063636.GA1663576@kroah.com> <alpine.DEB.2.21.2010130850410.14590@felia> <20201013073524.GA1674118@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Oct 2020, Greg Kroah-Hartman wrote:

> On Tue, Oct 13, 2020 at 09:16:27AM +0200, Lukas Bulwahn wrote:
> > Some others actually believe that the use of static analysis tools 
> > increase software quality and ONLY IF a static analysis tool is used, a 
> > specific level of software quality is achieved and they want to prove 
> > that the software reaches a certain level that way. (I do not 
> > understand that argument but some have been repeating it quite often 
> > around me. This argument seems to come from a specific interpretation of 
> > safety standards that claim to have methods to predict the absense of 
> > bugs up to a certain confidence.)
> 
> So do those others also audit the static analysis tools to ensure that
> they actually work as they "think" they do?  If not, then their
> requirement is pretty pointless :)
>

Yes, they do audit the tools, but those audits and why that proves the 
absense of a bug class is yet a completely different story...

> > I am doing it for the fun and learning about tools, and I am not such a 
> > believer but those others would be forced by their beliefs until they 
> > understand what static analysis tools and their janitors really already 
> > contribute to the kernel development and where the real gaps might be.
> > 
> > I hope that helps to get a bit of the motivation. Consider us 
> > kernel newbies :)
> 
> Watch out, sending patches to subsystems to "fix" issues that really
> are not real problems is a sure way to get your patches rejected and
> make maintainers grumpy.
> 
> I recommend starting out with code that we all "know" needs help, in
> drivers/staging/ for stuff like this, so you can learn the process
> better, as well as start to understand the limitations of your tools
> better.
> 
> good luck!
>

Thanks for the advice. We will need to learn about the limitations and 
what is worth a patch and what is not and we will need luck on the way 
learning that.

Lukas
