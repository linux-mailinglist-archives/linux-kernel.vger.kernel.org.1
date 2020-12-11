Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C602D7C59
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394459AbgLKRFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394119AbgLKRFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:05:03 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC5CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:04:23 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id t8so10154682iov.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ahs5t1jZns6ylc9n/wQ8MrZRCY05NSLjV+Xm6qlZmLQ=;
        b=zPUAnFNXEnwQtHYNq+I7qPfUoI8EVGgTxP0/iGLSHfDmyInG2LDbhs9r/EkIbIws8g
         +tc+4J+wYoGyhR1T3pCXIh4maa5l4C52jjlDdLbaVVHq3k4x3JekcVriET2qfzY5Ct6o
         5eudLBLQnDHdpGb6II17x7Z/TowpBxtnkBEK5NkIHTONdXo8LtzXX72g0MXkGnICc1F0
         ryqSKSST6ElCPelyX8AoSk1qKB7v0TD0VjwpEup15c+sBO6UDOxBmXUKfNNJXu0+V5Zi
         K37EIHat/mC2110jJLvc4JcZfLPBlSajSv/WFZh0KqABiOK2ZqtugGsAnF6SA8snmDtk
         eDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ahs5t1jZns6ylc9n/wQ8MrZRCY05NSLjV+Xm6qlZmLQ=;
        b=h9vlhiIUrR2Nxzm/bfn68uxKoeihwGUBKLsgdZ19ALUlWVK7yNfk/YsJ/t+W97zgin
         bhVsv28SkggESaISUz8QThU7MA4cSHMRWGzPZveKhCiOL+LUUWYF05pbpvkGr7vSu5gW
         KZ/ZmF14nZm+/S3jQ9wUvr6pBSWEXZXtPScwUReKL2v1nE/3NVoYTKf0kSQg9ftvpRAn
         n27LwMv5+3nt0pNshvEk5mHqc3nlkEw3ICsVPFpDd3bLAabzVFzjDWgQD/tSJSCnvNEW
         ShVxRUjvSF8OKsY76/PZO/oQg1ZqoIiDmMB/OFbtARsODg14wHRGInX4Thd/r95P+3j6
         HYww==
X-Gm-Message-State: AOAM531xr9ABEH8SkNLANAaLwdrdt/wYTr//uxHgngdCeW4sR6I9S4St
        dmiPS+wThaBegfqKayh3QCvD8A==
X-Google-Smtp-Source: ABdhPJwvy2YLEploQHFEOTRB0QTKfSZuVTASwHRyClJtYVNu+IyG0KHrsLyQREi4mMQkK0EoS7AyTQ==
X-Received: by 2002:a6b:920b:: with SMTP id u11mr16128922iod.191.1607706262460;
        Fri, 11 Dec 2020 09:04:22 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g6sm5597052ilc.85.2020.12.11.09.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 09:04:21 -0800 (PST)
Subject: Re: [PATCH 0/3] block: blk_interposer - Block Layer Interposer
To:     Hannes Reinecke <hare@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Sergei Shtepa <sergei.shtepa@veeam.com>, hch@lst.de
Cc:     "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>, dm-devel@redhat.com
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
 <20201209135148.GA32720@redhat.com> <20201210145814.GA31521@veeam.com>
 <20201210163222.GB10239@redhat.com> <20201211163049.GC16168@redhat.com>
 <1ee7652e-b77f-6fa4-634c-ff6639037321@kernel.dk>
 <208edf35-ecdc-2d73-4c48-0424943a78c0@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <06b4a10d-5ea5-27e1-af0d-83d5c714996f@kernel.dk>
Date:   Fri, 11 Dec 2020 10:04:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <208edf35-ecdc-2d73-4c48-0424943a78c0@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/20 9:56 AM, Hannes Reinecke wrote:
> On 12/11/20 5:33 PM, Jens Axboe wrote:
>> On 12/11/20 9:30 AM, Mike Snitzer wrote:
>>> While I still think there needs to be a proper _upstream_ consumer of
>>> blk_interposer as a condition of it going in.. I'll let others make the
>>> call.
>>
>> That's an unequivocal rule.
>>
>>> As such, I'll defer to Jens, Christoph and others on whether your
>>> minimalist blk_interposer hook is acceptable in the near-term.
>>
>> I don't think so, we don't do short term bandaids just to plan on
>> ripping that out when the real functionality is there. IMHO, the dm
>> approach is the way to go - it provides exactly the functionality that
>> is needed in an appropriate way, instead of hacking some "interposer"
>> into the core block layer.
>>
> Which is my plan, too.
> 
> I'll be working with the Veeam folks to present a joint patchset 
> (including the DM bits) for the next round.

Just to be clear, core block additions for something that dm will
consume is obviously fine. Adding this as block layer functionality than
then exposes an application API for setting it up, tearing down, etc -
that is definitely NOT

-- 
Jens Axboe

