Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F39828BFA5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgJLSZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgJLSZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:25:33 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A892FC0613D0;
        Mon, 12 Oct 2020 11:25:33 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dg9so15691925edb.12;
        Mon, 12 Oct 2020 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=C095eq86xjn+En5nSlIhEWjGDGnZyziFePy+eLxNRX0=;
        b=YHfb/KDkG7fr/WaSrCI7gR8BoesWZvhwrk0wirlJKz1GfAWuqqYiWVqGMJijLQisMm
         j0+TsetsVCQrIcyZhBj8+Sm17m6UsLk1Q/2dlK2xDxmmVfark8d+/N6WWQI/pnkj4QWl
         S3RnBhhg8xFSZ3tV2opELJH5j72/wleecNb+SvRBODmTdP+r/+LJ15XjLILITSUDaeqN
         D9R9U4eOgcZOdtm4IiwTIj21IAawxU2hGmJLXliwMKTjg0D9Tdvarjsv6LUFf3flLb2T
         hMOM7pi9xcGe/wcxX3CiPTs1NsIUKJppqMyhbRVTiHYdas6GrdoV66kP7uqMoB1WJ21z
         bZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=C095eq86xjn+En5nSlIhEWjGDGnZyziFePy+eLxNRX0=;
        b=SlNVPsqfofjDHkk/W7v4KZi1qKGuS2JYIjmEgmnpq9JCAf19EKiJPyDWvzzm/05ngS
         yckZlNo7fNyuWo0cVw40hbAZ9DVeZJvajShyQkw/vmViAbz+G2yyN0L9NAe0+qIr08Os
         HjVSjfwVIP1iCXU4FPs8u7MzhqfTnTLDB6mFOWJpDFu2qcrK1XRAwZ6K7eFmw58DftVZ
         NFT1cFSIsvgNttZ2VF3LCIuzY8jMH8GVs9PazhBS7P6LHm4KNKpay/JEm/GZ9PfkmbIC
         Txa+KeBY7xNXwYhmdOEbJDULh1OdjKUK6kV7CauoIJnaWEZAAcdL+LRmLYesd7AIZ9E4
         q4hA==
X-Gm-Message-State: AOAM531yDkU+SuQwHtzWJM8mjOGBp5aMuBv67m8sgTDfYqFcyt+ov+rF
        IdaJe1Si13cCFYEVaiQf6Nj0q/pphWCAbNTK
X-Google-Smtp-Source: ABdhPJxFqFNaPMi7ewWw/67vTlF9aiYtWM+DMAaau6bFaLOtPzmPfSQaZFEzvp+6Eajxgh+caTeITw==
X-Received: by 2002:aa7:da12:: with SMTP id r18mr15264051eds.169.1602527132374;
        Mon, 12 Oct 2020 11:25:32 -0700 (PDT)
Received: from felia ([2001:16b8:2d57:fc00:a1bd:911e:26f6:597])
        by smtp.gmail.com with ESMTPSA id y6sm1260804eds.93.2020.10.12.11.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 11:25:31 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 12 Oct 2020 20:25:30 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
In-Reply-To: <20201012151816.GA1559916@kroah.com>
Message-ID: <alpine.DEB.2.21.2010122022250.17866@felia>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com> <alpine.DEB.2.21.2010121550300.6487@felia> <20201012145710.GA631710@rowland.harvard.edu> <alpine.DEB.2.21.2010121659040.6487@felia> <20201012151816.GA1559916@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Oct 2020, Greg Kroah-Hartman wrote:

> On Mon, Oct 12, 2020 at 05:10:21PM +0200, Lukas Bulwahn wrote:
> > And for the static analysis finding, we need to find a way to ignore this 
> > finding without simply ignoring all findings or new findings that just 
> > look very similar to the original finding, but which are valid.
> 
> Then I suggest you fix the tool that "flagged" this, surely this is not
> the only thing it detected with a test like this, right?
> 
> What tool reported this?
>

Sudip and I are following on clang analyzer findings.

On linux-next, there is new build target 'make clang-analyzer' that 
outputs a bunch of warnings, just as you would expect from such static 
analysis tools.

We will fix the tool if we can.

Lukas
