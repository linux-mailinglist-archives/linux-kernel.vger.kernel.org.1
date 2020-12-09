Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80452D3B07
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 06:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgLIFme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 00:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgLIFmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 00:42:33 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68725C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 21:41:53 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z9so217600qtn.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 21:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i8ZJuoDJybHp2tzVONMGuofWcZ7p2pBjclZqoID/hEc=;
        b=UOXSCoJxmnpVjuMvUpp9guycLEE9pkjcVxY9md2+onQ1/ecp1Hi+vcYRfU3bgQSiTH
         FziOD9AYxPqW2NiWirjt0PlziMyMbmRpP+pbqFB99E5rYU777pTYACGKI0RpCF2c9BRo
         NIJYT6J1DaJD+i1uxYNzqd5IK4o7lp3SjuAu41rH0pEihjr5k4oVSIyeZmSuI48S6a/4
         lf7Eg9l27J5ARK9y0vhVPx5QvCOtxV4iNf6PO4ClZ10PXsQFpszITQcubScGmUNUUZZl
         IlGCHvHktRn31X5o8iDr8mhWI0yZv9RpHMLkiGWr0vh8QMQ7JO5k+mYqw7z4f14+oXW7
         vGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i8ZJuoDJybHp2tzVONMGuofWcZ7p2pBjclZqoID/hEc=;
        b=K+m+/2ul7/45b5mX3NiQFV/swJxVFcHvrDcNZkabGybV7rkkJp+o2M7oGRvpfVgXEV
         T7t95WaoJRRQXRQDLB2j4diQgyAal/JRjwpEOFgyvtLkgr8tJDOLG9L8JuYeKiSvyN+B
         CX5jmOffIXLOXKShTtIg+nID5RTZ8QGne/0R5sPgvYTEidbGs5HgUNLnF0mxnjufysbg
         DFH+KpFYnNIwc+v9wA2YXqFg+KmzvMw6VEPilU8G2LDWB3g6pyHP6ojnjDBBilEVErW9
         BYU1QvK0I88t3c56Yr6n5ETpZl9iD2gndn+UVSA5OlQcWuOVaGtpToUK761NsZO4aWJd
         MJ4w==
X-Gm-Message-State: AOAM533gZJSdG3pL5yScdlpmOYhL/s6QWu1MT20B1vtBL+mLr5H4nu1s
        f8fYHuDDBhT1swH2iIRnao0=
X-Google-Smtp-Source: ABdhPJzZUuf2XsInUB3Fx8zqDdvZHWKQUIW5Gw5sT1OV3zktLeXI8yB9W4KtQpq/Gp48DlAV7nptBw==
X-Received: by 2002:ac8:4648:: with SMTP id f8mr1305258qto.5.1607492512637;
        Tue, 08 Dec 2020 21:41:52 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id h9sm522190qkk.33.2020.12.08.21.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 21:41:52 -0800 (PST)
Subject: Re: [SPECIFICATION RFC] The firmware and bootloader log specification
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Wim Vervoorn <wvervoorn@eltan.com>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Daniel Kiper <daniel.kiper@oracle.com>
Cc:     coreboot@coreboot.org, LKML <linux-kernel@vger.kernel.org>,
        systemd-devel@lists.freedesktop.org,
        trenchboot-devel@googlegroups.com,
        U-Boot Mailing List <u-boot@lists.denx.de>, x86@kernel.org,
        xen-devel@lists.xenproject.org, alecb@umass.edu,
        alexander.burmashev@oracle.com, allen.cryptic@gmail.com,
        andrew.cooper3@citrix.com, ard.biesheuvel@linaro.org,
        "btrotter@gmail.com" <btrotter@gmail.com>,
        dpsmith@apertussolutions.com, eric.devolder@oracle.com,
        eric.snowberg@oracle.com, hpa@zytor.com, hun@n-dimensional.de,
        javierm@redhat.com, joao.m.martins@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, leif@nuviainc.com,
        lukasz.hawrylko@intel.com, luto@amacapital.net,
        michal.zygowski@3mdeb.com, Matthew Garrett <mjg59@google.com>,
        mtottenh@akamai.com,
        Vladimir 'phcoder' Serbinenko <phcoder@gmail.com>,
        piotr.krol@3mdeb.com, pjones@redhat.com, roger.pau@citrix.com,
        ross.philipson@oracle.com, tyhicks@linux.microsoft.com,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20201113235242.k6fzlwmwm2xqhqsi@tomti.i.net-space.pl>
 <CAODwPW9dxvMfXY=92pJNGazgYqcynAk72EkzOcmF7JZXhHTwSQ@mail.gmail.com>
 <6c1e79be210549949c30253a6cfcafc1@Eltsrv03.Eltan.local>
 <9b614471-0395-88a5-1347-66417797e39d@molgen.mpg.de>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a173867b-49db-8147-de55-8d601f033036@gmail.com>
Date:   Tue, 8 Dec 2020 23:41:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9b614471-0395-88a5-1347-66417797e39d@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/20 7:23 AM, Paul Menzel wrote:
> Dear Wim, dear Daniel,
> 
> 
> First, thank you for including all parties in the discussion.
> Am 04.12.20 um 13:52 schrieb Wim Vervoorn:
> 
>> I agree with you. Using an existing standard is better than inventing
>> a new one in this case. I think using the coreboot logging is a good
>> idea as there is indeed a lot of support already available and it is
>> lightweight and simple.
> In my opinion coreboot’s format is lacking, that it does not record the timestamp, and the log level is not stored as metadata, but (in coreboot) only used to decide if to print the message or not.
> 
> I agree with you, that an existing standard should be used, and in my opinion it’s Linux message format. That is most widely supported, and existing tools could then also work with pre-Linux messages.
> 
> Sean Hudson from Mentor Graphics presented that idea at Embedded Linux Conference Europe 2016 [1]. No idea, if anything came out of that effort. (Unfortunately, I couldn’t find an email. Does somebody have contacts at Mentor to find out, how to reach him?)

I forwarded this to Sean.

-Frank

> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: http://events17.linuxfoundation.org/sites/events/files/slides/2016-10-12%20-%20ELCE%20-%20Shared%20Logging%20-%20Part%20Deux.pdf

