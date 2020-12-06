Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7152D0351
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 12:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgLFLYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 06:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgLFLYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 06:24:53 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653F4C0613D1;
        Sun,  6 Dec 2020 03:24:13 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n7so6521637pgg.2;
        Sun, 06 Dec 2020 03:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CdYoKLzu3dd766pS5qgLizC926YGw0zOhejthN2TSxI=;
        b=HBOkEN15GsbIeJd5qYcyivRHL9gxhB70wVoXHe0axffUak+gz37Td+4vt9XuGjsqQU
         SS8j217GqrHkGNdgNQLWMneCtqcqGHe1usD7cfYF72as85gsN+x1quFag1WoA3Wl376F
         9KhLhG7AFpM6iFe3W/jDl7cR03Wu3vy7iPZMfkE0haUQWgqCWfHhqNca1fH1UoS7M/vr
         4VMIxAesWGm5xDnVUM1Lkf+B0SfcwFhucUacZLfamQMmxzxna4uC3Cf2GPSR5MU3HK8z
         211xr4IxSbunDx8EWuSx5Le3h1XLNJG0Y7rHO3ZcUkA+/dtJxMSgyz8cUKMGwgxZEXGj
         ib/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CdYoKLzu3dd766pS5qgLizC926YGw0zOhejthN2TSxI=;
        b=ZDQnjFZq2L9xgTObnHqXriyId96MS8IMydWjli8AXzhlIe/5yeDvqknpDJxKNDohBA
         ngUB8UC6RC1qUb5bMjb4VDXV3VmjRLxUtFUr0Rzbk5BdgFCiz/kdPZDNafvS9nRKBBHE
         xuEoml2Eq79sjfNiVDRvlPIum2fMKa72Ata6IUPBEr//+drknzIW6YWhV3a8etGNfpgB
         yOI7Kw54Y0gjbcKsN0igiWowKPrmhFlw/4dxORWhHaB270NQujQpl9u4/WfnxSyzEq7z
         r049zwkvj3UwozHNCbPDEw5UdIHWRhXRiNBd6wYYler1hAabI+5b4MgUf1aZlYLa/vUs
         Kp7Q==
X-Gm-Message-State: AOAM530WeqPcTM5ac1++wLLLZFu6tfjCTh/haiV/ZVZQ0CbBj8Ohan6L
        DxliIu1gDnldraHq0QUXnc8=
X-Google-Smtp-Source: ABdhPJyO61YIFIJKckpnG4X+V1+eQjLR+Z9SgIihRXnNvx1XvLbGwoQN+UTXOLlghJI+9QXMe+ZA4A==
X-Received: by 2002:a05:6a00:848:b029:197:e659:e236 with SMTP id q8-20020a056a000848b0290197e659e236mr11728461pfk.74.1607253852896;
        Sun, 06 Dec 2020 03:24:12 -0800 (PST)
Received: from minh ([113.162.156.187])
        by smtp.gmail.com with ESMTPSA id z188sm10936552pfb.121.2020.12.06.03.24.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Dec 2020 03:24:12 -0800 (PST)
Date:   Sun, 6 Dec 2020 18:24:05 +0700
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: dummy-hcd: Fix uninitialized array use in init()
Message-ID: <20201206112405.GB3006@minh>
References: <1607063090-3426-1-git-send-email-minhquangbui99@gmail.com>
 <20201204161249.GA1141609@rowland.harvard.edu>
 <CACtPs=Gg3C0KxdFnETHujAyis4hhKnCdV4_ZWqprHkXCXahFvw@mail.gmail.com>
 <20201205151511.GA1179536@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201205151511.GA1179536@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 10:15:11AM -0500, Alan Stern wrote:
> On Sat, Dec 05, 2020 at 07:47:01PM +0700, Minh Bùi Quang wrote:
> > Vào Th 6, 4 thg 12, 2020 vào lúc 23:12 Alan Stern
> > <stern@rowland.harvard.edu> đã viết:
> > > Does this initialization end up using less memory than an explicit
> > > memset() call?
> > 
> > You mean speed?
> 
> No, I mean memory space.
> 
> A memset call requires a certain amount of instruction space (to push 
> the arguments and make the call) but no static data space.  
> Initialization requires some instruction space (to copy the data) and 
> static data space as well (to hold the data that is to be copied).
> 
> Alan Stern
> 

Thank you for your clarification, I didn't think about it before.

As I check when compiling the code, with MAX_NUM_UDC=32 the initialization
becomes

        xor    eax,eax
        mov    ecx,0x40
        rep stos DWORD PTR es:[rdi],eax

With MAX_NUM_UDC=2, the initialization becomes

        mov    QWORD PTR [rbp-0x30],0x0
        mov    QWORD PTR [rbp-0x28],0x0

As I see, initialization does not require additional static data space.
Am I right?

Thanks,
Quang Minh 
