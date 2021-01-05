Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161252EAA79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbhAEMLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAEMLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:11:00 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508D9C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:10:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d13so35912073wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w/LNxQYo7eFw62PeVBmCU+ZqioIR6+rqH3T9Kp8E1Rk=;
        b=GfFrgFwo7K6mL7ERerzwa9c74szmJvg5cqFdGkn0y+szm16+LdM8WCFLoGYIrqgiO3
         MZb/7MKvhdPkLT+VhIVV9bUGvJ3X8cA179Aerf0vKNwKwoDRoni76pNSvN0PyaUqcOdO
         6Prv+p9XWQNvMjrs4KG6MnLxpqbhiG4Huz1bn/K2VZATgea76N9LhF/5/kt+8MJRZlvQ
         JC7NzcaOqyU8bhAYh3LwRIH8GzHQAGdmOrNR8WRbFNG3phNAf6nEF6JuJKwsy/yAqQw7
         7rnGHmgghudMHn41tQKWhKBIRIRr0r6mrSTTFcvpiiEx2/IFzYbyFemXtd4e48mxU1oV
         S3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/LNxQYo7eFw62PeVBmCU+ZqioIR6+rqH3T9Kp8E1Rk=;
        b=qbIkiMx8JlBoqdAWwUDY4/xR2T0vO3X+BkC34FFEJvWbBLxiwtK8Gyp+eCMaLKv3E2
         /wOpfC8nOMO+H6MH3P50UosPqJC3J9dFNF3bcPGqGMMKH89SwrKuwKt8J8HZrxu9Kzvo
         moFzhLYw2Iz/JuhdOfuXWQZwt0pNJBLUWBQVLUtXEznUjwh29oIvlPV+S88LLqJ3MxFT
         1DWHWqr1GtSqAAApTfnUcOEn4xNnpyDIncO1ukWnMxu3EKnDMBxMjVWz5ioKqRZ20Ld/
         Nv1PqZFEPY6jlIPY5rVXdGCnxi0ee5Z8x+UlbiI+E1M72UA+1wLEpnNv5N1YqFuT+ShH
         4caw==
X-Gm-Message-State: AOAM531o8nS0qNNW/JnOUYZ0UudFZzIQeuaGX/Qk6HtrYf1A8NhltX0V
        NMwuGlGREmrXlA+wsp/iPfvZJ8QWUJJh6V5W
X-Google-Smtp-Source: ABdhPJyCrWMTX9GvfqIXK0HNVEPld8L5WvDTq2gC5SWGFAtZpt0uZeG++Eyxkx183tF/nRwIByzpvQ==
X-Received: by 2002:adf:8342:: with SMTP id 60mr85221779wrd.140.1609848619088;
        Tue, 05 Jan 2021 04:10:19 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id w17sm4068352wmk.12.2021.01.05.04.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:10:18 -0800 (PST)
Date:   Tue, 5 Jan 2021 12:10:16 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     bodefang <bodefang@126.com>
Cc:     jason.wessel@windriver.com, dianders@chromium.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdbts: Passing ekgdbts to command line causes panic
Message-ID: <20210105121016.ritlzseyjprh5rhg@holly.lan>
References: <1609120738-202321-1-git-send-email-bodefang@126.com>
 <20210104112854.fghr32y37mzw6fpb@holly.lan>
 <279df92c.1b26.176d0907b64.Coremail.bodefang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <279df92c.1b26.176d0907b64.Coremail.bodefang@126.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please avoid top posting. Threads on LKML are typically presented as
follows.

On Tue, Jan 05, 2021 at 11:21:38AM +0800, bodefang wrote:
> At 2021-01-04 19:28:54, "Daniel Thompson" <daniel.thompson@linaro.org>
> wrote:
> >On Mon, Dec 28, 2020 at 09:58:58AM +0800, Defang Bo wrote:
> >> Similar to commit<1bd54d851f50>("kgdboc: Passing ekgdboc to command
> >> line causes panic"), kgdbts_option_setup does not check input
> >> argument before passing it to strlen.  The argument would be a NULL
> >> pointer.
> >
> > Something seems to be missing here.
> >
> > The ekgdbts parameter mentioned in the subject line doesn't exist so
> > how can including it on the kernel command line could provoke a
> > panic.
> >
> > Please can you share the kernel boot arguments you used when you
> > tested this patch?
>
> I use static analysis tool to find these funcs are similar to the
> commit<1bd54d851f50>(kgdboc: Passing ekgdboc to command line causes
> panic), so it's just defensive, I haven't actually hitted this but
> there actually seems a problem here.

I don't see how a problem that occured when ekgdboc is parsed can occur
because this module does not parse ekgdbts! Are there really any
circumstances where kgdbts_option_setup() can be called with a NULL
argument?


Daniel.
