Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A0327691A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgIXGjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgIXGjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:39:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCAEC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 23:39:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn7so1071998pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 23:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0XdoGsthdP0st5oc3oiLDJoWjs7OJH+8MYDHvoMVNdQ=;
        b=Ulx1bpyG87cjZx3cGY6T63diD/f6gR/G2OLQVPojfDalMYXegtyu4DsgqrlBb5xeLQ
         8f+8vMhG5/anIvMxso1kCcHz6J4kyTw1fe2FxSwJCi8xjkn6ozkUh6N9LeUtS4JWKjXR
         18HeH5xr84wP+ObKWF48RQSr3lpxFXk4Zv01VmzdQG6X45VwlCh10b9i3o4DevTMk1IJ
         g8Rw0H6JaFaYSrXmFfzqZGEmX70DIkWuTPCOoF9BedJdMbqhzLFvfIQaKr0iGEKeABRl
         4Z7zPVJMs2lYipVoqBpiQRRWKVEP8Mi0U7k/h02ORuvsVrEtqSx8QCxdrNi5iHTHFtY9
         05VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0XdoGsthdP0st5oc3oiLDJoWjs7OJH+8MYDHvoMVNdQ=;
        b=mWL2AiBI3G2ObZsuNnCl68BK3Z0+FpYszCaiJURs+Hvlzw0nCpMX00zLkKN2EexZgJ
         qSTgczLNIXGp8zZ97UpcOO8vA6/zrgv/oFlVT/Iq2EJJ6eN3r31434dPX6B3Xm8UH7MO
         hPd9W0/ffi5NRdwE673heeKUWH2CGu4WWp4SLTHV4DLJrxYRyzVEat/dh6DeCKm7H61J
         365r18vxj97uh6mxxRUN6Aw9tT+GwvTo/6rkA0IYf61cqJxLiza3FoC32MgXOQCdoFiy
         yUQxYDhuc6Al5KnpZzm6IdVVKJeNenkA5v/SeFogH2giT+A/OGAHQ8N4BTMqCbB/9qDH
         0fjg==
X-Gm-Message-State: AOAM532Vhmv9xjJKhb1qOPb64zKDy6WAkEIbixKtGGKQKyLFrV5bJsfN
        e78ZZ051URBTbKY/Mcr6/lM=
X-Google-Smtp-Source: ABdhPJxLB/Bo759nQTWT6nB4BssNgSDgx/kfQRPH000wNkoineZBGZ8Me+y3YQlAROPB/3UeyQk8fg==
X-Received: by 2002:a17:90a:d493:: with SMTP id s19mr2617266pju.91.1600929542518;
        Wed, 23 Sep 2020 23:39:02 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id r6sm1586305pfq.11.2020.09.23.23.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 23:39:01 -0700 (PDT)
Date:   Thu, 24 Sep 2020 15:38:59 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     rostedt@goodmis.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, tkjos@google.com,
        Mohammed Khajapasha <mkhaja@codeaurora.org>
Subject: Re: [PATCH 2/2] printk: Make the console flush configurable in
 hotplug path
Message-ID: <20200924063859.GA763318@jagdpanzerIV.localdomain>
References: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
 <1600906112-126722-2-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600906112-126722-2-git-send-email-psodagud@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/23 17:08), Prasad Sodagudi wrote:
> From: Mohammed Khajapasha <mkhaja@codeaurora.org>
> 
> The thread which initiates the hot plug can get scheduled
> out, while trying to acquire the console lock,
> thus increasing the hot plug latency. This option
> allows to selectively disable the console flush and
> in turn reduce the hot plug latency.

It can schedule out or get preempted pretty much anywhere at any
time. printk->console_lock is not special in this regard. What am
I missing?

	-ss
