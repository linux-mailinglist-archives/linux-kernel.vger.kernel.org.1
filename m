Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3E021A17D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 15:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGINz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 09:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgGINzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:55:55 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985F1C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:55:55 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i4so2349067iov.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JR6b3si8iuiHzM486glJQp0ztyBMQ2W5mc62uy8hpY4=;
        b=FrdynHr9pjKl9hAUZlm8fVgPn4Ai8b2Q4txcs3ofatgWPc8rQWrCcEe1dmpZ55vo5+
         Cc+tgsu8AsxIzOJ1OgSVA8oiILuEXHyruhlgcEITgmA57VxTnlL0ZnmHlZEk1Zoogd7m
         BfiO0PMd2M5uokGEhsF+iKIW1Vam6xSEY89gWQQlPwHi/mIQL24GsYppUBuPFg8y8c+n
         gqGGREX1fZ8JSA+VleRstu9ITae8VcZ8CXMDnhFE7VSOqsSwjhb9jQPqzvsAWNhG2xtv
         MT9OO9HEKnOUrGcsIkMznCqm07DHly1j6C1pn4YTZ0SbyjV4K0TlTF6olekA/C1SApU6
         AU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JR6b3si8iuiHzM486glJQp0ztyBMQ2W5mc62uy8hpY4=;
        b=T0WTTJgmtW49mQUP9N27RmCh+YvdN5zq4o88x2sRtwkcTM6yvkAZKoPkznVEI80Dvp
         tpkO7epuYBEfjM6ZyIifFGNuVe7fJkhkysd8PSvpHl4+FSgdKTOpTdmwBoKveOYWaNvH
         kaO55tuxWTBOJgoJhsosB5+GYRlraG8NhQoGr+LJF176aSSgEdDWc3OpxtDRWY3Xse9G
         4bSnmy8M78BSYQV+5W7wYrnfNBc6nxseKpmqX2Z3lle3ST8/TCCqOlTlAa5/Z+nExJ/H
         27jSe3qzvM5v1sgr6OPzpOpgtX0uojgqCgZsqfog8KrMBqz7Xuzb8B5ebxfyP9q7/fTS
         rP2g==
X-Gm-Message-State: AOAM531RQwxIcCL8Yxl1zjIggrB6TllDaIWDAPCJefKC/P6X6FOC3U9v
        b9qJgD17161/2KLwFwel0kiaJg==
X-Google-Smtp-Source: ABdhPJwHJPcA6rl3ATFGiNEeUi0jPyneluDDT4tRJaf/3R294TAicN55lrvgGxnMLa2dbA/vFaCuVw==
X-Received: by 2002:a5d:8d12:: with SMTP id p18mr42205433ioj.148.1594302954992;
        Thu, 09 Jul 2020 06:55:54 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t5sm2387373iov.53.2020.07.09.06.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 06:55:54 -0700 (PDT)
Subject: Re: [PATCH 0/2] Remove kiocb ki_complete
To:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <20200708222637.23046-1-willy@infradead.org>
 <20200709101705.GA2095@infradead.org>
 <20200709111036.GA12769@casper.infradead.org>
 <20200709132611.GA1382@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e03b9ae9-edf7-3489-7641-8e62e51ad77b@kernel.dk>
Date:   Thu, 9 Jul 2020 07:55:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709132611.GA1382@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/20 7:26 AM, Christoph Hellwig wrote:
> On Thu, Jul 09, 2020 at 12:10:36PM +0100, Matthew Wilcox wrote:
>> On Thu, Jul 09, 2020 at 11:17:05AM +0100, Christoph Hellwig wrote:
>>> I really don't like this series at all.  If saves a single pointer
>>> but introduces a complicated machinery that just doesn't follow any
>>> natural flow.  And there doesn't seem to be any good reason for it to
>>> start with.
>>
>> Jens doesn't want the kiocb to grow beyond a single cacheline, and we
>> want the ability to set the loff_t in userspace for an appending write,
>> so the plan was to replace the ki_complete member in kiocb with an
>> loff_t __user *ki_posp.
>>
>> I don't think it's worth worrying about growing kiocb, personally,
>> but this seemed like the easiest way to make room for a new pointer.
> 
> The user offset pointer has absolutely no business in the the kiocb
> itself - it is a io_uring concept which needs to go into the io_kiocb,

Nobody disagrees on that.

> which has 14 bytes left in the last cache line in my build.  It would
> fit in very well there right next to the result and user pointer.

Per-op data should not spill into the io_kiocb itself. And I absolutely
hate arguments like "oh there's still 14 bytes in there", because then
there's 6, then there's none, and now we're going into the next
cacheline. io_kiocb is already too fat, it should be getting slimmer,
not bigger. And the append write stuff is not nearly interesting
enough to a) grow io_kiocb, b) warrant a special case for op private
data in the io_kiocb itself.


-- 
Jens Axboe

