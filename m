Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F342FAA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437661AbhARTtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437367AbhARTrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:47:42 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8018C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:47:01 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id w26so19468035ljo.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVRqyuzOiLtL0kawDBjuBwJR8PHpbj109fG/2lh420E=;
        b=PfYq7iqheFs0wmFx4A+Jy6RKNvSae+hFJIGRz7qR4xHwuG8QwzNtmJujI0L8v4y0xD
         9htWAd/LcprfHDC5XYt5F9eCfM7a6xQuiFKv2R0L9IbTBovLlaxPYwxDd8/bSUFZiUEE
         iVtEisf7e/4hmrXUVt5NI8S0mYNIi1ikzmCCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVRqyuzOiLtL0kawDBjuBwJR8PHpbj109fG/2lh420E=;
        b=IWa0HVUGd1xoD7/iLxyHcPgbvQ2+/Tc7HcyBYqStITuc6sGzxCeP70Ts0Jj8JMU2fG
         n9NjLBds6aJ5Q8SjijbQ+2RsCT4IErJw4m/4SCLLlgz1vnZ0ntFBhG/wv0lgUhzR1WAW
         61Eu3OTDzmyVUx2NuH+i6lTjAMcIeh6kM/RBukyQjlyCq9I9/59+uf+hKDL4w5WfHhRV
         ChpFfd39bTZJ1OAdyPRGRRFpZGXFV6B2FTyM0VKelNsdGXsb2F4j/ZVAM84GqNyeR7ZA
         MsZVHRIXgeuwvNdJeB0z+3UI+bjx1zTrSTD9kwslD8UG/h3BnEUwmpb2cfMBFCLQC0JJ
         RZcg==
X-Gm-Message-State: AOAM530pZoyvWLNBcaFs22mUhCw9ckVIWSx/6GsLo0/bIKX4GWt0i7Fe
        DqIusUkKEQse5/ty0S47E/c1zpS+Jc0n3Q==
X-Google-Smtp-Source: ABdhPJxUmNE9h4J+3V4VGi5MJvHj88by87QexJDlvK8DPObkd11ahcC4tQ3PWKrglirZB4DjMbpQlg==
X-Received: by 2002:a2e:7803:: with SMTP id t3mr474882ljc.213.1610999220029;
        Mon, 18 Jan 2021 11:47:00 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r135sm2058576lff.240.2021.01.18.11.46.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 11:46:58 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id o17so25750472lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:46:58 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr288508lfu.40.1610999218236;
 Mon, 18 Jan 2021 11:46:58 -0800 (PST)
MIME-Version: 1.0
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de> <20210118193457.GA736435@zeniv-ca>
In-Reply-To: <20210118193457.GA736435@zeniv-ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jan 2021 11:46:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
Message-ID: <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
Subject: Re: Splicing to/from a tty
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:35 AM Al Viro <viro@zeniv-ca> wrote:
>
> I'd rather have sendfile(2) do what splice(2) does and handle pipes
> directly.  Let me take a look,,,

It's not technically just the sendfile() thing. Some things do
sendfile "internally" (ie they use do_splice_direct()).

Although maybe they always happen just on non-pipe destinations (ie
file-to-file copy). I didn't check.

But particularly if it can be handled in do_splice_direct(), that
would be a good thing.

             Linus
