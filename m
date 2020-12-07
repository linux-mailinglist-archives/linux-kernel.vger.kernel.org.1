Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BD72D19EE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgLGToY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGToX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:44:23 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B2FC061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 11:43:43 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id p5so9601073ilm.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 11:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMbdvaySsQ/4/F+vh9ynJhvabOGmwdOHgWhKJea+J5E=;
        b=nhu1pkPKF+A7xP7LWBivSxeXgwTFkm0BPjC2BpXaUFRC3OzXKlXBneybvE4NyR/V+Z
         iG55x3ZRQhXSxmYOSkuIus15TsNahgNny+LNKY8eqG9xGil6rrtTmOFpHWRxAC2r/7ax
         RxMUkqeO62Jki/xnlAEF/2bPQv729Fpy3pFzwOWYmW2MP7dkfHXlfDYOK42/VDVyYWL0
         T2BmNgs4DN/zrg8xH0/Rm+YN6EcW6JOj6NAJf9IJ5HxDqVr6/bWEyvcSEwi1pV6aZyNx
         pktTUBvKBOE7aDG51VSe1FGHHnlgxHA+HFeRnpFLUpben65ueY58i4+dBNz8V/Rk2eFb
         Zolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMbdvaySsQ/4/F+vh9ynJhvabOGmwdOHgWhKJea+J5E=;
        b=Jbet9fnju7LM4LBKgkvEbHhfSb6yvlxvLp3hzYEi5Usv2WGtv4PUhcgzlpHH66EKWF
         a5v2EalgUrva1/58WlukVJb5pZHHoYvjV8L4iyIRL6gw8I7P6dsfaE06hfZKfjrrUsIk
         OBXWVClqkuv0vo4Hz5Wf83pZ3b7CHQJswcFOMxtVktUzOh0o4CjCx/qHVZWju5/Gfc1E
         q6zKQ9HRg9EHwWPA6ccnrIboRJVX+DkE5KKVhTukqzgesRNT249waUXHPJsIYeirym4X
         UKIueiX5SOf0mQ2JSQ9Q46QKi/oeUIzHc/jkqav88xYx/S6toL/OovYMk5XGZVrg6QMs
         9sgw==
X-Gm-Message-State: AOAM532qkPPDfLHfSX3p9LOemY6HZj9HDcMq2OITGKyB7S7mFQqaSY+v
        EHnpFOifJ+ccFXd6tH9nf5Cu7cxvdhjdfvk+jKKCXg==
X-Google-Smtp-Source: ABdhPJxSzCN7dpPUwtvyAaZ683bgE/NifG7xkGeY+vGgUQUI6lSv+uA2jYlkyu3PjCOhc3G/Fci9tB7WFs+l0rCntag=
X-Received: by 2002:a92:d9cd:: with SMTP id n13mr21850683ilq.96.1607370222948;
 Mon, 07 Dec 2020 11:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20201201083408.51006-1-jean.pihet@newoldbits.com>
 <20201201184100.GN2073444@lunn.ch> <CAORVsuXv5Gw18EeHwP36EkzF4nN5PeGerBQQa-6ruWAQRX+GoQ@mail.gmail.com>
 <20201201204516.GA2324545@lunn.ch>
In-Reply-To: <20201201204516.GA2324545@lunn.ch>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Mon, 7 Dec 2020 20:43:32 +0100
Message-ID: <CAORVsuXtVYKh_nCvCdA7PUWJeJbVJWD43jtkiFwXeg2Qo1mG+A@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: ksz8795: adjust CPU link to host interface
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Hugo Cornelis <hugo.cornelis@essensium.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Dec 1, 2020 at 9:45 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Configure the host port of the switch to match the host interface
> > settings. This is useful when the switch is directly connected to the
> > host MAC interface.
>
> Why do you need this when no other board does? Why is your board
> special?
>
> As i said before, i'm guessing your board has back to back PHYs
> between the SoC and the switch and nobody else does. Is that the
> reason why? Without this, nothing is configuring the switch MAC to the
> results of the auto-neg between the two PHYs?

Yes that is the case. From here I see this patch is too specific to
our setup, and so cannot be considered for merging.

>
> Or am i completely wrong?
No, this is completely right. I will drop this patch then.

Thank you very much for reviewing and for the suggestions.

BR,
Jean

>
>    Andrew
>
