Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9E29121C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438207AbgJQNvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 09:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438199AbgJQNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 09:51:03 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2ACC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 06:51:02 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x20so4260523qkn.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=4MgdNESWv5eDl+CUOXr6F2inTCBbN7co4Pv3gwx16Wc=;
        b=EiXO03NhEk2wbgmN0avyaTVn215mJlgFIRwAZkNm4U8ohgwsX9ZY+vAuSi4wAEkgDf
         Sw9MTqnCownGn9LsP+J8b5Xx5BFRtMXmNvFxexLlVfmNZedq4QF9KyojkQmFxJucDlZz
         MXxaua1SrN6eBr+RouqCqyTySXgVnZ3uaDe9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4MgdNESWv5eDl+CUOXr6F2inTCBbN7co4Pv3gwx16Wc=;
        b=PuGuWW/i3XcvEzZ6aqOjlbn47UiPHs6ovr+VEiTlMoRRd9ybzW3VQSsjLQm16YfC2q
         xWIPEby5zamx3Ku2pRUzvXF3Q36I6xMdwOQmwfdOm1CyiK0eQynfhRDkYL47RTfiEQiU
         /pICqdWSBU8GmMNcyQtjOhZeXdkHbw9wLdOXstH2uTeyIFWMaqBq4xKEPT/pBu4PpisG
         KlvlhMOe2EYvM8ES938GrcUWtghLvIf+lBk33EwfS8HtRdiv7DXEiaOwQkeWogY7EetV
         uUZ4hTEJKYc4xOW+IlajgoJ9eHnedVUyWJCUnnnt1Nyvq1hMrVl3y5i4D4pxPUOiYMoU
         DqOw==
X-Gm-Message-State: AOAM533bI+onF0LmXtFWke/NvLBbzvY01N+rpw9iv9nNaXjAPVcN4p4/
        fepHf9pSaqlqAOSMqC6H6yJlEOqD8FkJdgEX
X-Google-Smtp-Source: ABdhPJwPgt9GwEUG+ybkb4xxn9y8igRaI2t/gURb9hFpkSJ8NgJbpMtJD+JGsolQE0HM633TfuLc3g==
X-Received: by 2002:a37:9b42:: with SMTP id d63mr8411455qke.49.1602942661073;
        Sat, 17 Oct 2020 06:51:01 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id w6sm2115321qkb.6.2020.10.17.06.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 06:51:00 -0700 (PDT)
Date:   Sat, 17 Oct 2020 09:50:58 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Backing up the PGP master key
Message-ID: <20201017135058.mxlbuxqekpvy3hqx@chatter.i7.local>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201014213406.GA7622@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201014213406.GA7622@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 12:34:06AM +0300, Jarkko Sakkinen wrote:
> Konstantin, writing to you based on 'git blame' :-)
> 
> The maintainer guide recommends using paperkey for the PGP master key,
> which is a prefectly sane method.
> 
> I was just wondering that isn't a backup to a USB stick a reasonable
> option? E.g. get a few USB sticks (new, unweared), store your master key
> to each of them and put to safe.

Sure, it's an option as well. I believe the guide recommends three 
different backups:

1. thumb drive within reach for regular access
2. another drive in case the first one goes bad
3. paperkey backup in the vault

There's no reason why #2 above can't go into the vault as well, if 
you're inclined. I wouldn't skip paperkey, since I'm generally wary of 
putting anything long-term onto electronic media due to things like 
charge decay, cosmic rays, or other weird phenomena resulting in flipped 
bits.

-K
