Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B6B2B510D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgKPTZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:25:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729489AbgKPTZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605554746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvVBGmxqrQQuwWx3xbqybvwAEYkcdIjrRUPaqDC7Ogg=;
        b=a6W+lzBObQSueOhFiccaXfSHfp+kudg8VvOXX3UPXkAWg3+WgBwSYBCeiFJQusXn8mjPU4
        QCvBzUl4AWD0MLSueOJo6Ij7fwulzzbkgn6Bplw6ulGP3Aysdpw5GvSwcWRIY8h2EXtB9a
        +UvyG10j0Xso/5t7SnyloeS/p1YngFQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-yNxdqbkMOm6RhiKMMw12LQ-1; Mon, 16 Nov 2020 14:25:42 -0500
X-MC-Unique: yNxdqbkMOm6RhiKMMw12LQ-1
Received: by mail-wr1-f69.google.com with SMTP id d8so11501446wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NvVBGmxqrQQuwWx3xbqybvwAEYkcdIjrRUPaqDC7Ogg=;
        b=APuvaX0H7C9jyFT+qrf2sVG6dPrp7eGOqVxgY5FO/7mGgJZqpM8sTldu16Ebk/QIeb
         LisW/SUQIWRR3/U37s69iDKqpoLt0SE/NIgPc4mCslBP1TYq4GzjIdfo6qYymaifvSlf
         rsjbYQeUTXvpSnGKi2nEepc5jLSU/E18bYxfJbqAVhmpRfr3ATaeQsOxXCQBevUJvSRQ
         WmxF0LFZ34yhwzys4QEi7U0GsSLN14mIypmWXxpRgksIcOxx4b6CTnBvXD3NHIMLAoxq
         zWIoyFUFbz15V1gdk7Wz8wrRRRIQNMGMAAqPTD5lh/gsJMdbaMZv5enuyTORRUvKV/I/
         7oCw==
X-Gm-Message-State: AOAM532UrFSO+ut9hEm3oQM+r2zLun9Dbn1ct9bUX/60JeJ+NZwnp/3q
        udsK+ZdDobKDf6aohansMKgetEhtrAS1sPbpWeKJS6T8WoVwNnIfv4L7P8T8BmP0woxNe2uc9pu
        Lt6hZ8X/7X3yl2eHaftnMiPza
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr20912834wrm.259.1605554741093;
        Mon, 16 Nov 2020 11:25:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/b4YoIKX8CQypRFi1xFvHZ9h3JEEhGLLN9/A6g7hCGC22w9inVABpcuR0toTOwvtdqCUX/Q==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr20912819wrm.259.1605554740953;
        Mon, 16 Nov 2020 11:25:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r8sm23858459wrq.14.2020.11.16.11.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 11:25:40 -0800 (PST)
Subject: Re: [PATCH 1/2] kvm: x86/mmu: Add existing trace points to TDP MMU
To:     Ben Gardon <bgardon@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Peter Feiner <pfeiner@google.com>
References: <20201027175944.1183301-1-bgardon@google.com>
 <CANgfPd8FkNL-05P7us6sPq8pXPJ1jedXGMPkR2OrvTtg8+WSLg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0751cea5-9f4a-1bb9-b023-f9e5eece1d01@redhat.com>
Date:   Mon, 16 Nov 2020 20:25:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd8FkNL-05P7us6sPq8pXPJ1jedXGMPkR2OrvTtg8+WSLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/20 20:15, Ben Gardon wrote:
> If anyone has time to review this short series, I'd appreciate it. I
> don't want these to get lost in the shuffle.
> Thanks!

Yup, it's on the list. :)

Paolo

