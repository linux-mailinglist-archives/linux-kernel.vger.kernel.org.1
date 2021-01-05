Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21362EB488
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 21:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbhAEU6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 15:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbhAEU6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:58:20 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0B7C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 12:57:39 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id x13so1025402oto.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 12:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UDLH/Hs5HBNndLsDlkHeSD0b4Pq+bTJ4cNLSTBbqIr4=;
        b=UJW82L42kHNIfvja9bx4ErmYwAHUE2fbaPv6+W2A5aoWZGaz66Siq/DT3y63Ppsxt5
         35nW4Jwrqy9Ye9/mr4R1KzFUvFIT2hagniWUxtnzIRT6DfO9IA/OOeA2RCpGMs1P82Xb
         SnPB11Wh53aoOoubSzbRKoUzlqm5GiYUcHfUNaMaJtchbcvA2qQfCv77qysRW+J/Q7fv
         EJys4Rj7cKH0L9XUHOwz13/+RSPGu9R0PelXHdC+D7XPfP61yTgL+jcyUOlbWvfn1zEp
         Ja7O0nB6seC5i7Na6CMZagJtffg7pQOe89ntfDOvEG8OW/RCD+2Na8+CKJNGrivaibJV
         J1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UDLH/Hs5HBNndLsDlkHeSD0b4Pq+bTJ4cNLSTBbqIr4=;
        b=tvGHyi7zsT5Hgwdg4kq3ZZQjbO+BlPyduXof6M+enTdbZBj0bULqXJ9Tgg+fJNg3Yd
         xPug4grGCqbbM7hotAxXaKP8VIwGzKqXGBvzvVDDY/uBpUeyKwM5h+rT8b1J4cSjUBvM
         RmILZ4N3qAVJysdB0NtZX2jUSSshZJ1zeENNYfcYue2GDtmaz+DByqlVYPikyGIA8gVs
         I1KSQBEZ1qaCS45BfhugMbOXWDyV2F7O0Ir8H9YE4nP3RK7Cf/T0nodLacOSyzQDq9w1
         aBvZkvjHpIA36Hlzj4rYo63x+Fa3esghC2fL5Y+fjpBvS3gS8YGWpcR2HgSs9Ns+1jnM
         6PtA==
X-Gm-Message-State: AOAM5315Kp5zqrXU8m6+WDOpXXS7vjgB3QyDnIaveC58iMtIXxUCT/dL
        eW8RcvQsR7nz6P76X7wiWUzsDBCSyfc=
X-Google-Smtp-Source: ABdhPJwrxjTr68Y9vgu7Qz5WxDgXWPbz9+vJdK0pbB/3RkSSnnYRx4WtgIPBlMW6hwh8sw6UjvemXg==
X-Received: by 2002:a9d:67da:: with SMTP id c26mr1013641otn.321.1609880259287;
        Tue, 05 Jan 2021 12:57:39 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c18sm132084oib.31.2021.01.05.12.57.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jan 2021 12:57:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 5 Jan 2021 12:57:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc2
Message-ID: <20210105205737.GB230525@roeck-us.net>
References: <CAHk-=whS+rzNMSsU6vRoLMzrm0JPN-OVg+BxhybMet3NpqpR-Q@mail.gmail.com>
 <20210105184653.GA88051@roeck-us.net>
 <CAHk-=why7Sc=bypL-rbXevtoe8GjSv2ifSH1pVZn-ziAGKR+_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=why7Sc=bypL-rbXevtoe8GjSv2ifSH1pVZn-ziAGKR+_A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 11:55:20AM -0800, Linus Torvalds wrote:
> On Tue, Jan 5, 2021 at 10:46 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Problems are as already reported against v5.11-rc1.
> 
> Yes. Thanks for keeping on top of this, I'm expecting to get the fixes
> as people get back from vacations.
> 

NP. The test are running automatically anyway, so I figured I might
as well report the results. Does that make sense, or is it just noise ?

Thanks,
Guenter
