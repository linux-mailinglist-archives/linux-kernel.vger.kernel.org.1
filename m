Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C332CA560
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgLAOON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgLAOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:14:12 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03F5C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:13:32 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so2807873wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 06:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ehqe7Y++cS0wt3gaymi/r3HazRaNqrXWmoutWXgkJI=;
        b=lZtqI0O05N1Z6dBLwLIaL34QXzkEGIU49CpWF5bKywPYvc+NsWlLRJB0jBInC90Mt3
         89664T8lO6L0YFi13mP2WcsaAhioSBSD4FWBbi6qqWT3STAgmu93CNaVR6LGQ3FqmcPI
         YLyBVZrr7mD1csA7NvKqYE2HQKEMxKuA8xu5QlXB/KwMoLnF+t8zYN+h4dpgHCqap7QC
         1EzNcO0dt3YFIHsnoNQBnnnjulsdkJlLYlTi0LR3pTX8ULCGm90EWmy1PEzaMwdvt9Pu
         2+ZN8BuknXL4/cDhHQ4TJaXyyKwF6IzTh0BdqogMaaBuEIYhwCzlpyXK+4Ma4CeDjgWI
         OwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ehqe7Y++cS0wt3gaymi/r3HazRaNqrXWmoutWXgkJI=;
        b=Af6YQepPbOMn2S/6A973Nx7JKOJS1oUBvM75QOZja6YMPiGR3vS+1x6TM4wX1U3EhE
         h90pDhBxHYUtzIGNyYEiMtw4TvZi89tuTTGSwdd0+4JwCtK1zY8dtH0kb1uj5qU2hTHT
         OVwSoFM3sUuncwyqqf2Y/B+hdqijR85IhvjLAqY1aKWb/RcHzx+TwYnMGppGYv3dn1a7
         8GgM0Ur0iUAiWU4LhDLZLGs31FWWyxxd8rGDuXeS4gHf6Rsa+PHYto15tryP9yByeJkn
         joXdyHQ+raRB+HkX3cXtfbBq7XxGKH+2vHYVtDzU7GlZZ8nH508MpVMdHhMWlv1itPGk
         N8mw==
X-Gm-Message-State: AOAM533cLgjw4dZ0YBmrWMHSIXKRWEx44Rfa35etQW5IG3MMR7eD7+g8
        uOGEv2kmmX0rMtQ5zc5IEN1PdA==
X-Google-Smtp-Source: ABdhPJwilnfXoPtU9DBAwnwLx6lDBU4zU3VtOOSKMiSYHW5am3EAODESWMH7shcHRj6lfYnWD3lu6g==
X-Received: by 2002:a05:6000:347:: with SMTP id e7mr4104757wre.35.1606832011144;
        Tue, 01 Dec 2020 06:13:31 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id k16sm3390851wrl.65.2020.12.01.06.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 06:13:30 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:13:27 +0000
From:   Quentin Perret <qperret@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH] modpost: Make static exports fatal
Message-ID: <20201201141327.GA1914005@google.com>
References: <20201124182420.2202514-1-qperret@google.com>
 <CAK7LNATj8C7C=dYcDD4M5Q-Zc_kUhY2+i6epH=LbiOAUaDZqiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATj8C7C=dYcDD4M5Q-Zc_kUhY2+i6epH=LbiOAUaDZqiw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 Dec 2020 at 23:00:37 (+0900), Masahiro Yamada wrote:
> I am not a big fan of (ab)using fatal() for this case.
> 
> Please consider using error() once
> the following is queued up.
> 
> https://patchwork.kernel.org/project/linux-kbuild/patch/20201201103418.675850-2-masahiroy@kernel.org/

Yes, much nicer, thanks for that series.
I'll post a v2 shortly.

Thanks,
Quentin
