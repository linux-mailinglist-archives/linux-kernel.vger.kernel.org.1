Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0E0287729
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbgJHPaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730918AbgJHPaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:30:05 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD4AC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 08:30:05 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id y198so7464442qka.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SqRA6Yl5kFaqC7nyN7S9QqR04lj9MdeB5jpNUBqGXqM=;
        b=YdO/TXzfFIrrT/MRkO75xee8G5E6WtV/lTOy53v0S5TxjisEIvcT0zzH3A26gGkrBF
         lCfs5HRd3T+DV5BHCMuP6TymS0xTTZjfM5SouBf4QTniTNEp+UEloZ0a/p+/opelOVmG
         GtHAiJ0YP1Z+KKuRoeHr0c7WL2EhV/geynbK4tSBV9OCjoHclLSMTwLNbe+9RTT6v/4e
         ywg+vAcsB2fy7GvkRjCJSKm1tKHZGC2PsQaaXawZho2k755gasm5S5QMe6ayr7UtlAbF
         OIQDYsr3J3jvKdWy8yVRH8W+1ufDuxj79QZ8Yt3W5/7ynY3h6Tkd3iTrqZO0bKKzNiBq
         FhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SqRA6Yl5kFaqC7nyN7S9QqR04lj9MdeB5jpNUBqGXqM=;
        b=czsPjK6tHe5AJym+12LR+lAZE3/989KQ+0uIk509xEFlevglLM3Y317j38ci5F6bjo
         168evDruDnPNaNVph/et+Lp22U93+qzoZPxI8MaHsYQ9zv0+AooR+C9Aw7rdIUQAE+rX
         wVgGRbIcYJVm/KHjMl614MbG5dkZeMOZ1jeGAgEqR//C1s+hQW3CuWFdVQ6oC8bOkN1q
         s7DyYxf7W9I7xvjwMkGmg+xPJAk7OHpS4FvDTcjWJGf1WeKssTLRkUX58gw0w/2tAIrI
         CHeacUZuPE4qOs/6hXRlP9fbs9IjNeoo920iL3Hp/AF+BB1n6CkX7Aw1/dZ6wAEH+Kgt
         Kg8Q==
X-Gm-Message-State: AOAM532pZtsGwq1r0Rxbx6JlaCTSLSKbJ2vLNQXEWr5FyPhboNHbalPj
        fjHbJX430SPzat+iqm6rn5w=
X-Google-Smtp-Source: ABdhPJxrUmaCakA+f0Fzy0VGe9QFB0qQxeIU05jTo5T0N6WjR+ZUQEd7dySQ9YvWKa4KtEnFPcOufw==
X-Received: by 2002:a05:620a:7f8:: with SMTP id k24mr1509742qkk.5.1602171004828;
        Thu, 08 Oct 2020 08:30:04 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t64sm3970421qkd.69.2020.10.08.08.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 08:30:03 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 8 Oct 2020 11:30:02 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] x86/boot: Move get_cmd_line_ptr() and
 COMMAND_LINE_SIZE into misc.h
Message-ID: <20201008153002.GA2697342@rani.riverdale.lan>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-3-nivedita@alum.mit.edu>
 <20201008093042.GA6491@zn.tnic>
 <20201008134723.GB2429573@rani.riverdale.lan>
 <20201008151047.GB5505@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008151047.GB5505@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 05:10:47PM +0200, Borislav Petkov wrote:
> On Thu, Oct 08, 2020 at 09:47:23AM -0400, Arvind Sankar wrote:
> > Are you ok with the include of setup.h?
> 
> Or you could simply add cmdline.h and include that. It is high time we
> started cleaning up that include hell in compressed/ and all facilities
> there be nicely separated. Recently I started untangling it but it is a
> serious mess. And kernel proper includes leak in there, yuck.
> 

Ok, I can do that.

I'm working on a couple of separate series to clean up cmdline and the
compressed boot code a bit. I was actually planning to get rid of
boot/compressed/cmdline.c entirely, replacing it with
arch/x86/lib/cmdline.c instead: that one's better and is reusable as-is
for the decompressor stub, instead of the current hack to use the
real-mode boot stub's cmdline.c. The real mess in there is all the
includes of .c files from various places.
