Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28ED2A7B3A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 11:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKEKF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 05:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKEKF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 05:05:27 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2611C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 02:05:26 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so966719wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 02:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qWl6ab8b2FCMLB3C0d7K2GycWMBRvvI9XTZqUMWBIqo=;
        b=aPLxkbwdu+1ZH4iY1NcplqqKBxUsQHLWzzqMm068GO7F35x+x2pePE7mYwR1wY93zp
         Pjz6FEYe+Xlo1FBzumQxLFYIMxIa9WAzAj1Hll4oZ5JpNLIcFGPWe9fKvXe3Ft1F+mes
         QsQK+hhuWfMQE1CIGbaUYiWvx8KTK3KRQMBdcIfVWfPPBmI4REmpzQ8WnaRo+yq47yCy
         S+nyXk0aSyYThiemDkuT9/ULDCZYpm01kZjrVKni6ED4zdcVuM/x/L4f8slr5H/41odK
         Hfdf02tzrQcgZPV2aqSXcozpqTGJr1Kc3+fu/IUyigsih3DYMujbq8ewKMxUlbquTyvI
         Hwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qWl6ab8b2FCMLB3C0d7K2GycWMBRvvI9XTZqUMWBIqo=;
        b=Np9Gx1gV94XkmD/N94hBJmt7Xpopc1nUsZ2qg855CUlBrtSSKnkX5RNK6+IbbwUR/l
         NIvx3Sr0C0Rp20KAzV7jC+IAIIWX9h66ytTyjJByqwbAhKM2MLVOk9u4gSH+Y+A0HUiG
         MuK6VlNi8jyoacHLayr78Li59lK2mNHQNleEGPcCC3bsynvNZUYkioRg/2+bFMt8QkBc
         K9i6O3Sc2WtPgWZTbVC5Zxw1GtVMroBovc1K7pIGc+qsPEqFjFcW0/R1Kz+PvgUqJlmH
         4oMpvCKa56jLfpdpu16I7Gi0NG5Sby7gByFzPccbzsdHiaX8+7QNtz7OgVPMUqfjKnYJ
         REPw==
X-Gm-Message-State: AOAM530GhWhlnVHWWVNhu39wumWDofImGQBF9+4Xnaiqpdo/iRNwRpEd
        HO1lCsmeQJsL2AHxn+ECVIFpaw==
X-Google-Smtp-Source: ABdhPJyJOIHyw/l/Gs3+hfzGURksc3fLORFAD5IqNJbK2MRUz59DXcp1umak867eaB7z5+5ntSDLLQ==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr1916270wmg.161.1604570725455;
        Thu, 05 Nov 2020 02:05:25 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id g138sm1793677wme.39.2020.11.05.02.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 02:05:24 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:05:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paul Fulghum <paulkf@microgate.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org Mailing List" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as
 __always_unused
Message-ID: <20201105100520.GI4488@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-28-lee.jones@linaro.org>
 <0a4043ee-dad5-7691-8c67-db73d3c12f52@kernel.org>
 <20201105084341.GZ4488@dell>
 <a95f8d0d-28ef-7351-cdbb-7da5ad8aa9ad@kernel.org>
 <69E3975E-A4D0-4472-80F0-9FAB2E0024FA@microgate.com>
 <20201105095554.GA3451966@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201105095554.GA3451966@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Greg Kroah-Hartman wrote:

> On Thu, Nov 05, 2020 at 01:39:36AM -0800, Paul Fulghum wrote:
> > 
> > 
> > > On Nov 5, 2020, at 1:10 AM, Jiri Slaby <jirislaby@kernel.org> wrote:
> > > 
> > > OK, let the loop alone. I would bet a half a pig that noone is able to test this driver. But one has to write this for someone to raise and admit they are still using it. In fact, there are _4_ google replies to "Microgate Corporation" "SyncLink Multiport Adapter" "lspci".
> > 
> > 
> > 
> > The hardware used with synclink.c and synclinkmp.c has not been
> manufactured for 15 years and was low volume. The chances of either
> driver still being in use is very low. Not even Microgate (me) has
> the ability to test either anymore (no hardware). I don’t know the
> policy about driver removal, but I think both could be removed
> without upsetting anyone.
> > 
> > synclink_gt.c is still in production and the driver still actively used.
> > 
> > If there are no objections to removing the the old drivers
> > (synclink.c/synclink_mp.c) I could make a patch to do so tomorrow
> > (it is 1:30am here now). Nothing eliminates niggling warnings like
> > removing dead code. 
> 
> Great, please submit a patch to remove these, I will always take patches
> to delete lines :)

Good resolution.  I'm happy to do this.  Bear with me.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
