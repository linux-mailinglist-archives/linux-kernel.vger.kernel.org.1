Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D383286793
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgJGSmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgJGSmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:42:32 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBEEC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:42:32 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id w7so874062oow.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YDpBXnJoTerx8+T5jAMHnGbQNOboeXlSHACsmk65W7I=;
        b=jfiLkb7t0ApgrVp87Unp47OP6fC9a17SDr+nE37Ypa/GvxVr+yueHMScts1wKkBFQ7
         vQpnp2mGKv7Ab5NA6hnC/fmPvoDSGTKmCh45AjAgqmNvZh6oZCCE4+xq1WLgziT41kgG
         SoogZQ962Rm7LHW23OTUIRciVSotap8BuMCcURUkDitJYqAGM2j6Xp+FIa1IKXNketk1
         TL3wPf79DsgPKloaMtGiCUO6pPNIXVnY5D6ug+w7zI1slIrZDnVI+sAkPHWSN9Eu4Hkc
         e4qjyTbpvBDOo1clxIcBFy4N9pcvFODf76VnHx+w+4MF4MmiC67qwO251KMXTLBPvDGb
         s+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YDpBXnJoTerx8+T5jAMHnGbQNOboeXlSHACsmk65W7I=;
        b=k7PgX3YXpdRIlhiWKxCXpWdnfRAcb8KyjQuoIUrLGEXX6sdwoIN4EaQk4j5nKJmGWV
         0LDb0RFawa22FQ2YPFP5a10WFY+WOuX5micByAE2oSJqJqFaTCac9lv7V3EjEvep6cz1
         iPEsnUcGlZS2OgkSQeCPyGCNlP+Z6e6mMP+X7ZWXIQI9WppxcdkV2YCj2+0e5amiXmyT
         gi/lhKX5XoqHbC2mmM2errCchzmK38A065/49giqBoRs+xiH7CcRG7F/CDjpOCaYoY4c
         IcA1A9rITGGkTcu9LdHtYOzXd46w+PZA+Kp87ilpCE1uwrhJWJGuErQT3CAQ1074oXsS
         ErAg==
X-Gm-Message-State: AOAM530wS8b3xRkniUybn1oJjerp0HxhslTu4J+hB+sIUWreQdyujCiG
        trrVN8Y7SQoEsgcUEGynZw==
X-Google-Smtp-Source: ABdhPJwM18zBXzINVtDgaExWbXrJakXdeMycV6E2znfAWhO2S08XGD/MxzZAho7n6PwgFrLkxm9P6Q==
X-Received: by 2002:a4a:4301:: with SMTP id k1mr2906764ooj.92.1602096151671;
        Wed, 07 Oct 2020 11:42:31 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id t22sm2122070otk.24.2020.10.07.11.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:42:30 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b::80])
        by serve.minyard.net (Postfix) with ESMTPSA id 40CE518003E;
        Wed,  7 Oct 2020 18:42:29 +0000 (UTC)
Date:   Wed, 7 Oct 2020 13:42:28 -0500
From:   Corey Minyard <minyard@acm.org>
To:     "Boehme, Markus" <markubo@amazon.de>
Cc:     "Park, Seongjae" <sjpark@amazon.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nuernberger, Stefan" <snu@amazon.de>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "Shah, Amit" <aams@amazon.de>
Subject: Re: [Openipmi-developer] [PATCH 3/3] ipmi: Add timeout waiting for
 channel information
Message-ID: <20201007184228.GH3038@minyard.net>
Reply-To: minyard@acm.org
References: <1599495937-10654-1-git-send-email-markubo@amazon.com>
 <1599495937-10654-3-git-send-email-markubo@amazon.com>
 <20200908003412.GD15602@minyard.net>
 <1599736120.29234.12.camel@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1599736120.29234.12.camel@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 11:08:40AM +0000, Boehme, Markus via Openipmi-developer wrote:
> > > -                         && ipmi_version_minor(id) >= 5)) {
> > > -             unsigned int set;
> > > +     if (ipmi_version_major(id) == 1 && ipmi_version_minor(id) < 5) {
> > This is incorrect, it will not correctly handle IPMI 0.x BMCs.  Yes,
> > they exist.
> 
> Interesting! I wasn't aware of those. Searching the web doesn't turn up
> much and the spec doesn't mention them either. Are these pre-release
> implementations of the IPMI 1.0 spec or some kind of "IPMI light"?

There was an 0.9 version of the spec that some machines implemented.
It's not really a "light" version, it's just a really early version.  I
don't know how many machine out there still implement it, but I try to
keep them working if I can.

Thanks,

-corey

> 
> Markus
