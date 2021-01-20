Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC022FDAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390005AbhATUba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388372AbhATN5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:57:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD15C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:57:10 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o10so3340414wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uPYHw73Fmba34UBZyndvbBrByJK/4y5p09JPYm1muXA=;
        b=C+zpEqhvLdsNn2ibhFJHfHzhXx2MWo9KXHJSJrEOwakVCegddGKa2WytX9x3E/aI1Y
         e4mJML6vkCwtCKNxsVEnsxgE/6KEWiUODcMfG7FIdWcwSeAnhrMcrSMufFYR+B9tXBNC
         7iVG9hNTOhABm9+k0czfIftxx3VHSYFwA1gsd+IcDec5P/+4P2EYIvmpU4NwC7Up1tJ0
         15jDaf95gyT4jJQRIxS6ypsiaIlsAD7YzvwwTC1F87DME3H4hRkgZBNO2hPMkB/YSm8h
         nSuSys3ERtAXnC4hQc5YzY1ToOdSxluhg5Yg3IxYjwYOENe/g8Mzyk1MgulXaO2+a3ov
         OC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uPYHw73Fmba34UBZyndvbBrByJK/4y5p09JPYm1muXA=;
        b=cyQCL8tcM5Bh0Vq7J7+QR/7sQnFCgPj9TJMTSoJeYknLdaBXZ/m2uFNrdfSfju54/I
         8UUjGbiACPdPLDIGgb9oSI342KXZPQV75OVhnt2P3GnvwsggeMYlkTfs3NuXSLaQr7l7
         EXDacx6mCFxi8Myqk68wX+4k1GBA7KB9xWpg1fjFRJyUJofEoRi2ptwFpbsKCvOcMqnn
         VLUNVxf30RjOLWZXaR5ODDI5DNnMBBhfM3B7eP/RvG0Ljcx4OpTt6Z/P8c5/uj5odzzW
         KGoTU/pQp+DuGIMG/iGHup/ONw7a6+av9OKFqNqoOhq58J1eVWo/8TrS7NkhAfdCBYik
         xEIg==
X-Gm-Message-State: AOAM531me3UdjaYKq91Z1qCysIZTb2Z8HSsLXhNSDanxoEQUW164h0b7
        uANdZCbGjZP0nTzbIqSmqLZIgP2aAp+1nwHarmQ=
X-Google-Smtp-Source: ABdhPJw1D3U6yfPln7nxzsNozkutnXrTHvP2HT2freIpiTdXdcmXnumRV1S8/GDFaBEFa2dMJ6GLqQ==
X-Received: by 2002:a1c:790f:: with SMTP id l15mr4560693wme.188.1611151028861;
        Wed, 20 Jan 2021 05:57:08 -0800 (PST)
Received: from ?IPv6:2a01:e0a:410:bb00:853c:3c08:918b:153? ([2a01:e0a:410:bb00:853c:3c08:918b:153])
        by smtp.gmail.com with ESMTPSA id l20sm4622759wrh.82.2021.01.20.05.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 05:57:08 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 3/3] net: core: Namespace-ify sysctl_rmem_max and
 sysctl_wmem_max
To:     Menglong Dong <menglong8.dong@gmail.com>,
        Florian Westphal <fw@strlen.de>
Cc:     Jakub Kicinski <kuba@kernel.org>, christian.brauner@ubuntu.com,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Menglong Dong <dong.menglong@zte.com.cn>, daniel@iogearbox.net,
        gnault@redhat.com, ast@kernel.org, ap420073@gmail.com,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, jakub@cloudflare.com,
        bjorn.topel@intel.com, Kees Cook <keescook@chromium.org>,
        viro@zeniv.linux.org.uk, rdna@fb.com,
        Mahesh Bandewar <maheshb@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210118143932.56069-1-dong.menglong@zte.com.cn>
 <20210118143932.56069-4-dong.menglong@zte.com.cn>
 <20210120104621.GM19605@breakpoint.cc>
 <CADxym3aV9hy3UdnVWnLeLF6BnwqqrJ1MdMKNQiSa4sCWQ2+4ng@mail.gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <2e1eaded-f9e0-0da8-4dd9-0d459470cc95@6wind.com>
Date:   Wed, 20 Jan 2021 14:57:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CADxym3aV9hy3UdnVWnLeLF6BnwqqrJ1MdMKNQiSa4sCWQ2+4ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20/01/2021 à 14:28, Menglong Dong a écrit :
[snip]
>>> For that reason, make sysctl_wmem_max and sysctl_rmem_max
>>> per-namespace.
>>
>> I think having those values be restricted by init netns is a desirable
>> property.
> 
> I just thought that having these values per-namespace can be more flexible,
> and users can have more choices. Is there any bad influence that I didn't
> realize?
You can have a look here:
https://lore.kernel.org/netdev/1501495652.1876.17.camel@edumazet-glaptop3.roam.corp.google.com/
https://patchwork.ozlabs.org/project/netdev/patch/20170726170333.24580-1-mcroce@redhat.com/


Regards,
Nicolas
